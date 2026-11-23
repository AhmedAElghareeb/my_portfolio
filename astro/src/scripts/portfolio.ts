const root = document.documentElement;
const motion = matchMedia('(prefers-reduced-motion: reduce)');
const animations = new Map<HTMLElement, Animation>();
const ease = 'cubic-bezier(.22,.75,.24,1)';

function reveal(element: HTMLElement, travel: number, duration: number, delay = 0) {
  if (motion.matches || typeof element.animate !== 'function') return;
  animations.get(element)?.cancel();
  const animation = element.animate(
    [{ opacity: .65, transform: `translateY(${travel}px)` }, { opacity: 1, transform: 'translateY(0)' }],
    { duration, delay, easing: ease },
  );
  animations.set(element, animation);
  const forget = () => { if (animations.get(element) === animation) animations.delete(element); };
  animation.finished.then(forget, forget);
}

const elements = document.querySelectorAll<HTMLElement>('[data-reveal]');
if ('IntersectionObserver' in window && !motion.matches) {
  const observer = new IntersectionObserver((entries) => {
    let order = 0;
    for (const entry of entries) {
      if (!entry.isIntersecting) continue;
      observer.unobserve(entry.target);
      reveal(entry.target as HTMLElement, 16, 530, Math.min(order++, 3) * 42);
    }
  }, { threshold: .11 });
  for (const element of elements) observer.observe(element);
}

motion.addEventListener('change', () => {
  if (motion.matches) for (const animation of animations.values()) animation.cancel();
});

const themeButton = document.querySelector<HTMLButtonElement>('[data-theme-button]');
if (themeButton) {
  const themeColor = document.querySelector<HTMLMetaElement>('meta[name="theme-color"]');
  const syncTheme = () => {
    const isLight = root.dataset.theme === 'light';
    themeButton.setAttribute('aria-label', isLight ? 'Switch to dark theme' : 'Switch to light theme');
    if (themeColor) themeColor.content = isLight ? '#eef3fa' : '#0b111b';
  };
  let reset = 0;
  themeButton.addEventListener('click', () => {
    if (!motion.matches) {
      root.classList.add('theme-changing');
      clearTimeout(reset);
      reset = window.setTimeout(() => root.classList.remove('theme-changing'), 310);
    }
    root.dataset.theme = root.dataset.theme === 'light' ? 'dark' : 'light';
    try { localStorage.setItem('ae-portfolio-theme', root.dataset.theme); } catch {}
    syncTheme();
  });
  syncTheme();
  themeButton.hidden = false;
}

const menu = document.querySelector<HTMLDetailsElement>('[data-menu]');
menu?.addEventListener('click', (event) => {
  if ((event.target as Element).closest('a')) menu.open = false;
});
document.addEventListener('keydown', (event) => {
  if (event.key !== 'Escape' || !menu?.open) return;
  menu.open = false;
  menu.querySelector('summary')?.focus();
});
const navigation = document.querySelectorAll<HTMLAnchorElement>('header nav a');
const syncNavigation = () => {
  for (const link of navigation) {
    if (link.hash === location.hash) link.setAttribute('aria-current', 'location');
    else link.removeAttribute('aria-current');
  }
};
window.addEventListener('hashchange', syncNavigation);
syncNavigation();

const filters = document.querySelector<HTMLElement>('[data-filters]');
const count = document.querySelector<HTMLElement>('[data-project-count]');
const cards = document.querySelectorAll<HTMLElement>('[data-project]');
if (filters && count && cards.length) {
  const buttons = filters.querySelectorAll<HTMLButtonElement>('[data-category]');
  filters.addEventListener('click', (event) => {
    const target = (event.target as Element).closest<HTMLButtonElement>('[data-category]');
    if (!target || target.getAttribute('aria-pressed') === 'true') return;
    const category = target.dataset.category;
    for (const button of buttons) button.setAttribute('aria-pressed', String(button === target));
    let shown = 0;
    for (const card of cards) {
      const visible = category === 'All' || card.dataset.project === category;
      animations.get(card)?.cancel();
      card.hidden = !visible;
      if (visible) reveal(card, 7, 290, Math.min(shown++, 3) * 24);
    }
    count.textContent = `${shown} ${shown === 1 ? 'project' : 'projects'}`;
  });
  filters.hidden = false;
}
