(() => {
  const normalize = value => String(value).normalize('NFKC').toLocaleLowerCase();
  function rank(pages, query, section, reviewedOnly) {
    const terms = normalize(query).trim().split(/\s+/).filter(Boolean);
    if (!terms.length) return [];
    return pages.filter(({page}) => (!section || page.section === section) && (!reviewedOnly || page.reviewed === true))
      .map(({page, title, haystack}) => ({page, score: terms.every(term => haystack.includes(term))
        ? terms.reduce((sum, term) => sum + (title.includes(term) ? 10 : 1), 0) + (page.reviewed === true ? 2 : 0) : 0}))
      .filter(item => item.score > 0).sort((a,b) => b.score-a.score || a.page.url.localeCompare(b.page.url));
  }
  function prepare(pages) {
    return pages.map(page => ({page, title:normalize(page.title), haystack:normalize(page.title+' '+page.summary+' '+page.text)}));
  }
  if (typeof module !== 'undefined' && module.exports) { module.exports = {rank, prepare}; return; }
  const form = document.getElementById('article-search');
  const input = document.getElementById('query');
  const status = document.getElementById('search-status');
  const results = document.getElementById('search-results');
  const sectionInput = document.getElementById('search-section');
  const reviewedInput = document.getElementById('search-reviewed');
  let indexPromise;
  let request = 0;
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
      }).then(prepare)
      .catch(error => { indexPromise = null; throw error; });
      const pages = await indexPromise;
      if (id !== request) return;
      const matches = rank(pages, query, sectionInput.value, reviewedInput.checked);
      status.textContent = matches.length ? `找到 ${matches.length} 篇相关文章${matches.length > 50 ? '，显示前 50 篇，请增加关键词缩小范围' : ''}。` : '没有找到相关文章，请尝试其他关键词。';
      for (const {page} of matches.slice(0,50)) {
        const url = new URL(page.url, location.origin);
        if (url.origin !== location.origin) continue;
        const article = document.createElement('article'); article.className = 'search-result';
        const heading = document.createElement('h2');
        const link = document.createElement('a'); link.href = url.pathname; link.textContent = page.title;
        const summary = document.createElement('p'); summary.textContent = page.summary;
        const review = document.createElement('p'); review.className = 'search-review-status';
        review.textContent = page.reviewed ? `资料核对 ${page.reviewedAt}，范围见正文` : page.contentStatus === 'pending' ? '来源待核查：历史资料，请先核对官方依据' : '尚未标记资料核查日期';
        if (page.contentStatus === 'pending') review.classList.add('search-review-pending');
        heading.append(link); article.append(heading, review, summary); results.append(article);
      }
    } catch { if (id === request) status.textContent = '搜索暂时无法加载，请重试，或从导航浏览文章。'; }
  }
  function fromURL() {
    const parameters = new URLSearchParams(location.search);
    input.value = parameters.get('q') || '';
    const section = parameters.get('section') || '';
    sectionInput.value = ['', 'hardware', 'nas', 'ai', 'openclaw', 'calculator'].includes(section) ? section : '';
    reviewedInput.checked = parameters.get('reviewed') === '1';
    search();
  }
  function updateURL() {
    const url = new URL(location.href); url.search = '';
    if (input.value.trim()) url.searchParams.set('q', input.value.trim());
    if (sectionInput.value) url.searchParams.set('section', sectionInput.value);
    if (reviewedInput.checked) url.searchParams.set('reviewed','1');
    history.pushState(null,'',url); search();
  }
  form.addEventListener('submit', event => {
    event.preventDefault();
    updateURL();
  });
  sectionInput.addEventListener('change', updateURL);
  reviewedInput.addEventListener('change', updateURL);
  window.addEventListener('popstate', fromURL);
  fromURL();
})();
