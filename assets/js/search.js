(() => {
  const form = document.getElementById('article-search');
  const input = document.getElementById('query');
  const status = document.getElementById('search-status');
  const results = document.getElementById('search-results');
  let indexPromise;
  let request = 0;
  const normalize = value => String(value).normalize('NFKC').toLocaleLowerCase();
  async function search() {
    const id = ++request;
    const query = input.value.trim();
    results.replaceChildren();
    if (!query) { status.textContent = '输入关键词，搜索本站教程和测评。'; return; }
    status.textContent = '正在搜索…';
    try {
      indexPromise ||= fetch('/index.json').then(response => {
        if (!response.ok) throw new Error('index unavailable');
        return response.json();
      }).catch(error => { indexPromise = null; throw error; });
      const pages = await indexPromise;
      if (id !== request) return;
      const terms = normalize(query).split(/\s+/).filter(Boolean);
      const matches = pages.map(page => {
        const title = normalize(page.title);
        const haystack = normalize(page.title + ' ' + page.summary + ' ' + page.text);
        return {page, score: terms.every(term => haystack.includes(term)) ? terms.reduce((sum, term) => sum + (title.includes(term) ? 10 : 1), 0) : 0};
      }).filter(item => item.score > 0).sort((a,b) => b.score-a.score);
      status.textContent = matches.length ? `找到 ${matches.length} 篇相关文章${matches.length > 50 ? '，显示前 50 篇，请增加关键词缩小范围' : ''}。` : '没有找到相关文章，请尝试其他关键词。';
      for (const {page} of matches.slice(0,50)) {
        const url = new URL(page.url, location.origin);
        if (url.origin !== location.origin) continue;
        const article = document.createElement('article'); article.className = 'search-result';
        const heading = document.createElement('h2');
        const link = document.createElement('a'); link.href = url.pathname; link.textContent = page.title;
        const summary = document.createElement('p'); summary.textContent = page.summary;
        heading.append(link); article.append(heading, summary); results.append(article);
      }
    } catch { if (id === request) status.textContent = '搜索暂时无法加载，请重试，或从导航浏览文章。'; }
  }
  function fromURL() { input.value = new URLSearchParams(location.search).get('q') || ''; search(); }
  form.addEventListener('submit', event => {
    event.preventDefault();
    const url = new URL(location.href); url.search = ''; if (input.value.trim()) url.searchParams.set('q', input.value.trim());
    history.pushState(null, '', url); search();
  });
  window.addEventListener('popstate', fromURL);
  fromURL();
})();
