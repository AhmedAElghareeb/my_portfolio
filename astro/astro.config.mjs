import { fileURLToPath } from 'node:url';
import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://ahmedaelghareeb.github.io',
  base: '/my_portfolio',
  output: 'static',
  trailingSlash: 'always',
  build: { inlineStylesheets: 'always' },
  vite: {
    server: { fs: { allow: [fileURLToPath(new URL('..', import.meta.url))] } },
  },
});
