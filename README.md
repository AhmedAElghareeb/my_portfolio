# Ahmed Elghareeb — Developer Portfolio

A portfolio of Ahmed Ashraf Elghareeb’s Flutter and mobile development work. It includes published Android and iOS apps, project case studies, professional experience, and technical expertise.

[Live Portfolio](https://ahmedaelghareeb.github.io/my_portfolio/) · [GitHub Profile](https://github.com/AhmedAElghareeb) · [LinkedIn](https://www.linkedin.com/in/ahmed-elghareeb8/)

## Website technology

The production website uses **Astro static site generation**, semantic HTML, modern CSS, and TypeScript for browser interactions. GitHub Actions builds and publishes the site to GitHub Pages.

- Responsive layouts, light and dark themes, and frosted-glass project cards
- Featured case studies and a filterable project catalog
- Entrance and scroll animations that respect reduced-motion preferences
- Keyboard navigation, visible focus, descriptive image text, and native disclosure controls
- Prerendered HTML, page metadata, and a sitemap

The Hero and project content are included in the initial HTML. Responsive WebP images and native lazy loading limit image downloads during the first visit.

## Repository layout

- [`astro/`](https://github.com/AhmedAElghareeb/my_portfolio/tree/astro-production/astro) on `astro-production` contains the production site.
- [`assets/projects/`](https://github.com/AhmedAElghareeb/my_portfolio/tree/astro-production/assets/projects) contains project artwork used by the Astro build.
- [`lib/`](lib/) and [`web/`](web/) preserve the original Flutter Web implementation for reference.

## Run locally

Use Node.js **22.12 or later**. Clone this repository, then run the following from the repository root.

```sh
git switch astro-production
cd astro
npm ci
npm run dev
```

Open [the local portfolio](http://localhost:4321/my_portfolio/).

From `astro/`, build the static site and run the tests against the generated output.

```sh
npm run build
npm test
```

The build writes to `astro/dist/`. Preview it locally with `npm run preview` and open the same local URL.

## Deployment

GitHub Actions publishes the Astro build from `astro-production` to GitHub Pages under **`/my_portfolio/`**. The repository retains the previous Flutter release for rollback. See the [Pages workflow](.github/workflows/astro-pages.yml), [workflow runs](https://github.com/AhmedAElghareeb/my_portfolio/actions/workflows/astro-pages.yml), and [release and rollback runbook](ASTRO-PAGES-RELEASE.md).
