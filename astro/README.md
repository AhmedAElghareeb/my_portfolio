# Astro portfolio candidate

This static Astro site lives alongside the Flutter implementation on `experiment/astro-portfolio`. The project index is pre-rendered. Theme selection, category filtering, and motion use a small browser script. The page, anchor links, and project details are usable without JavaScript.

## Preview the release locally

From the repository root, use Node.js 22.12 or later.

```powershell
cd astro
npm ci
npm run build
npm test
npm run preview
```

Open [the local preview](http://localhost:4321/my_portfolio/). The static output is in `astro/dist/`. Run `npm run dev` for local editing.

## Content and assets

- `src/data/portfolio.json` contains the existing Flutter portfolio's project, experience, skills, and contact records.
- `src/data/portfolio.ts` contains the professional copy and typed access to those records.
- The build uses the original screenshots under `assets/projects/` to generate responsive WebP variants. The local font is the Latin subset of the existing Manrope font and its license is in `public/licenses/`.
- The build tests validate the static markup, project links, branding, base path, image metadata, and client JavaScript budget.

## Approved migration and rollback

The current Flutter site publishes from `gh-pages`. The candidate workflow prepares an artifact. A Pages publication additionally requires a manual publish request from `astro-production` and the repository variable `ASTRO_PAGES_APPROVED=true`.

1. Keep the existing `gh-pages` branch and record the active Flutter deployment commit and Pages source before migration. Review the Astro build at the repository base path. A separate preview can serve the identical artifact at `/my_portfolio/` on a different origin.
2. After release approval, make the workflow available from the repository's default branch so it can be dispatched. Prepare the reviewed `astro-production` branch, confirm the `github-pages` environment restrictions, and authorize the publish job through the repository variable.
3. Change the Pages publishing source to GitHub Actions, then dispatch **Astro portfolio artifact** against `astro-production` with publishing enabled. Verify the deployment status and check the production URL in a fresh browser session. Include a mobile visit, theme selection, filters, image requests, and favicon.
4. For rollback, disable Astro publishing, switch the Pages source back to the existing `gh-pages` branch and root directory, and verify production after Pages finishes. The Flutter source and branch history remain available for the former release process.
