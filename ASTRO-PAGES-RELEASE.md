# Portfolio Pages release and rollback

GitHub Pages serves `https://ahmedaelghareeb.github.io/my_portfolio/`. The approved Astro source is `a04e7700358e1e0e86c8a4acd2f385b8089b8eca`. The `astro-production` release branch starts at that exact commit. The workflow file on the default branch registers the manual dispatch.

## Publish Astro

1. Keep **Settings → Pages → Source** set to **GitHub Actions** for Astro. This makes changes to the old `gh-pages` branch independent of production.
2. Allow the `astro-production` branch in the `github-pages` environment and set the repository Actions variable `ASTRO_PAGES_APPROVED` to `true` for the approved release.
3. In **Actions → Astro portfolio artifact → Run workflow**, select `astro-production` and enable **Publish**. Verify the run checks out the approved commit, passes its build and tests, and finishes the publish job.
4. In a fresh browser, check the deployed landing page, navigation, projects, images, and AE icon under `/my_portfolio/`.

## Restore Flutter

The exact prior published Flutter build is `a6f1590f5ad3a23c81c60197ef68dff71f5008a6`, available as both `rollback/flutter-pages-a6f1590` and the tag `flutter-pages-before-astro`. The original `gh-pages` branch is also preserved.

1. Set `ASTRO_PAGES_APPROVED` to `false` and cancel any queued or in-progress Astro publish run.
2. Check that `gh-pages` still points to `a6f1590`. If it does, choose **Deploy from a branch → gh-pages → /(root)** in **Settings → Pages**. If it has advanced, allow `rollback/flutter-pages-a6f1590` in the Pages environment and select that branch's root instead.
3. Wait for the branch deployment to succeed. In a fresh browser, verify the production URL serves Flutter, the Hero renders, and `/my_portfolio/main.dart.js` returns HTTP 200.

No history rewrite or rebuild of the archived Flutter release is needed.
