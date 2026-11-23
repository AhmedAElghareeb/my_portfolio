import assert from 'node:assert/strict';
import { readFileSync, existsSync } from 'node:fs';
import { resolve } from 'node:path';
import { test } from 'node:test';

const dist = new URL('../dist/', import.meta.url);
const html = readFileSync(new URL('index.html', dist), 'utf8');
const data = JSON.parse(readFileSync(new URL('../src/data/portfolio.json', import.meta.url), 'utf8'));
const base = '/my_portfolio/';
const canonical = `https://ahmedaelghareeb.github.io${base}`;
const escape = (value) => value.replaceAll('&', '&amp;').replaceAll('"', '&quot;').replaceAll('<', '&lt;').replaceAll('>', '&gt;');

test('portfolio is statically prerendered with every section and project', () => {
  assert.equal((html.match(/<h1\b/g) ?? []).length, 1);
  for (const id of ['hero-title', 'work', 'experience', 'expertise', 'projects', 'about', 'education', 'contact']) {
    assert.ok(html.includes(`id="${id}"`), id);
  }
  assert.equal((html.match(/data-project="/g) ?? []).length, data.projects.length);
  assert.equal(data.projects.length, 15);
  assert.equal(data.featured.length, 6);
  for (const project of data.projects) {
    assert.ok(html.includes(escape(project.title)), project.title);
    assert.ok(html.includes(escape(project.description)), project.title);
    if (project.contribution) assert.ok(html.includes(escape(project.contribution)), project.title);
    for (const feature of project.features) assert.ok(html.includes(escape(feature)), feature);
  }
  for (const item of [...data.experiences, ...data.skills]) {
    for (const text of [item.company ?? item.title, ...(Array.isArray(item.description) ? item.description : [item.description])]) {
      assert.ok(html.includes(escape(text)), text);
    }
  }
});

test('every verified project and contact destination is present', () => {
  const links = [...data.projects.flatMap((project) => project.links.map((link) => link.url)),
    `mailto:${data.email}`, data.github, data.linkedin];
  for (const link of new Set(links)) assert.ok(html.includes(`href="${escape(link)}"`), link);
});

test('SEO, branding, and local resources use the Pages base path', () => {
  assert.ok(html.includes(`rel="canonical" href="${canonical}"`));
  assert.ok(html.includes(`${canonical}icons/ae-v3-512.png`));
  assert.ok(readFileSync(new URL('sitemap.xml', dist), 'utf8').includes(`<loc>${canonical}</loc>`));
  const root = decodeURIComponent(dist.pathname).replace(/^\/(?=[A-Z]:\/)/i, '');
  const resources = [...html.matchAll(/(?:src|href)="([^"#]+)"/g)].map((entry) => entry[1]);
  for (const url of resources.filter((url) => url.startsWith('/'))) {
    assert.ok(url.startsWith(base), url);
    assert.ok(existsSync(resolve(root, url.slice(base.length))), url);
  }
  const images = [...html.matchAll(/<img\b[^>]*>/g)].map((entry) => entry[0]);
  assert.equal(images.filter((image) => /loading="lazy"/.test(image)).length, 8);
  for (const image of images) {
    assert.match(image, /\balt="/);
    assert.match(image, /\bwidth="\d+"/);
    assert.match(image, /\bheight="\d+"/);
    if (image.includes('loading="lazy"')) assert.match(image, /\bsrcset="/);
  }
});

test('client enhancement is small and the document has no hydrated UI', () => {
  assert.doesNotMatch(html, /<astro-island\b|<flutter-view\b|flutter_bootstrap\.js|\.wasm["?]/);
  const scripts = [...html.matchAll(/<script\b([^>]*)>([\s\S]*?)<\/script>/g)];
  let bytes = 0;
  for (const [, attributes, code] of scripts) {
    const source = attributes.match(/src="([^"#]+)"/)?.[1];
    bytes += source ? readFileSync(new URL(source.slice(base.length), dist)).byteLength : Buffer.byteLength(code);
  }
  assert.ok(bytes > 0 && bytes <= 6_000, `${bytes} client JavaScript bytes`);
});
