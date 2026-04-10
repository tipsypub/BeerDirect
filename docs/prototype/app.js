const viewMeta = {
  dashboard: {
    title: 'Dashboard',
    desc: 'A calm, research-first workspace for beer sources, documents, digests, and watchlists.'
  },
  sources: {
    title: 'Sources',
    desc: 'Manage source definitions, priority, access type, and their relationship to the BeerDirect knowledge system.'
  },
  documents: {
    title: 'Documents',
    desc: 'Track original PDFs, books, whitepapers, reports, and their processing state before they become reusable knowledge assets.'
  },
  digests: {
    title: 'Digests',
    desc: 'Read and manage condensed Markdown knowledge assets extracted from documents, papers, and technical materials.'
  },
  watchlists: {
    title: 'Watchlists',
    desc: 'Monitor platform accounts, brand pools, and observation targets across Xiaohongshu, WeChat, Untappd, X, and more.'
  },
  entries: {
    title: 'Entries',
    desc: 'Capture daily research notes, market signals, technical observations, and platform-derived findings.'
  },
  tags: {
    title: 'Tags',
    desc: 'Maintain the shared topic taxonomy that connects sources, documents, digests, and entries.'
  }
};

const navItems = document.querySelectorAll('.nav-item');
const views = document.querySelectorAll('.view');
const pageTitle = document.getElementById('page-title');
const pageDesc = document.getElementById('page-desc');

function setView(viewName) {
  navItems.forEach((item) => {
    item.classList.toggle('active', item.dataset.view === viewName);
  });

  views.forEach((view) => {
    view.classList.toggle('active', view.id === `view-${viewName}`);
  });

  if (viewMeta[viewName]) {
    pageTitle.textContent = viewMeta[viewName].title;
    pageDesc.textContent = viewMeta[viewName].desc;
  }
}

navItems.forEach((item) => {
  item.addEventListener('click', () => {
    setView(item.dataset.view);
  });
});

setView('dashboard');
