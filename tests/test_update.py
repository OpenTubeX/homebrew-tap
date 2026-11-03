import copy
import importlib.util
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location("update", ROOT / "scripts/update.py")
updater = importlib.util.module_from_spec(spec)
spec.loader.exec_module(updater)


def release(version="99.0.0-beta"):
    return {
        "tagName": f"v{version}", "isDraft": False, "isPrerelease": "-nightly-" in version,
        "assets": [{
            "name": f"opentubex-{version}-mac-{arch}.zip",
            "url": f"https://github.com/OpenTubeX/OpenTubeX/releases/download/v{version}/opentubex-{version}-mac-{arch}.zip",
            "state": "uploaded", "digest": f"sha256:{digest * 64}",
        } for arch, digest in (("arm64", "a"), ("x64", "b"))],
    }


class UpdateTests(unittest.TestCase):
    def setUp(self):
        self.source = (ROOT / "Casks/opentubex.rb").read_text()

    def test_updates_version_and_both_architectures(self):
        result = updater.update(self.source, release())
        self.assertIn('version "99.0.0-beta"', result)
        self.assertIn(f'sha256 arm:   "{"a" * 64}"', result)
        self.assertIn(f'intel: "{"b" * 64}"', result)
        self.assertEqual(updater.update(result, release()), result)

    def test_rejects_unpublished_and_nightly_releases(self):
        for field in ("isDraft", "isPrerelease"):
            data = release()
            data[field] = True
            with self.subTest(field=field), self.assertRaises(ValueError):
                updater.update(self.source, data)
        with self.assertRaises(ValueError):
            updater.update(self.source, release("99.0.0-nightly-123"))
        data = release("99.0.0-nightly-123")
        data["isPrerelease"] = False
        with self.assertRaises(ValueError):
            updater.update(self.source, data, nightly=True)

    def test_rejects_downgrade(self):
        with self.assertRaisesRegex(ValueError, "downgrade"):
            updater.update(self.source, release("0.0.1-beta"))

    def test_accepts_final_release_after_beta(self):
        beta = updater.update(self.source, release())
        final = updater.update(beta, release("99.0.0"))
        self.assertIn('version "99.0.0"', final)
        with self.assertRaisesRegex(ValueError, "downgrade"):
            updater.update(final, release())

    def test_requires_both_unique_assets(self):
        for assets in (release()["assets"][:1], release()["assets"] * 2):
            data = release()
            data["assets"] = assets
            with self.assertRaises(ValueError):
                updater.update(self.source, data)

    def test_rejects_bad_asset_metadata(self):
        for field, value in (("digest", None), ("digest", "sha256:bad"),
                             ("state", "new"), ("url", "https://example.com/app.zip")):
            for index in (0, 1):
                data = copy.deepcopy(release())
                data["assets"][index][field] = value
                with self.subTest(field=field, index=index), self.assertRaises(ValueError):
                    updater.update(self.source, data)

    def test_rejects_changed_cask_structure(self):
        with self.assertRaises(ValueError):
            updater.update(self.source.replace("sha256 arm:", "sha256 other:"), release())


class NightlyUpdateTests(unittest.TestCase):
    def setUp(self):
        self.source = (ROOT / "Casks/opentubex@nightly.rb").read_text()

    def update(self, version, source=None):
        return updater.update(source or self.source, release(version), nightly=True)

    def test_follows_nightly_and_stable_releases(self):
        result = self.update("99.0.0-nightly-123")
        self.assertIn('version "99.0.0-nightly-123"', result)
        self.assertIn(f'sha256 arm:   "{"a" * 64}"', result)
        self.assertIn(f'intel: "{"b" * 64}"', result)
        self.assertIn('version "99.0.1-beta"', self.update("99.0.1-beta", result))

    def test_keeps_newer_build(self):
        result = self.update("99.0.0-nightly-123")
        for version in ("99.0.0-beta", "99.0.0-nightly-122", "98.9.9-nightly-999"):
            with self.subTest(version=version):
                self.assertEqual(self.update(version, result), result)
        self.assertIn('version "99.0.0-nightly-124"', self.update("99.0.0-nightly-124", result))


if __name__ == "__main__":
    unittest.main()
