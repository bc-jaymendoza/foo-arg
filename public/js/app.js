/* global instantsearch */

app({
  appId: 'FP9WZYG9KK',
  apiKey: '987bdd9558561da935683e87c907137a',
  indexName: 'index_BC'
});



function app(opts) {
  var search = instantsearch({
    appId: opts.appId,
    apiKey: opts.apiKey,
    indexName: opts.indexName,
    urlSync: true
  });

  search.addWidget(
    instantsearch.widgets.searchBox({
      container: '#search-input',
      placeholder: 'Site search'
    })
  );

  search.addWidget(
    instantsearch.widgets.hits({
      container: '#hits',
      hitsPerPage: 15,
      templates: {
        item: getTemplate('hit'),
        empty: getTemplate('no-results')
      } 
   })
);

  search.addWidget(
  instantsearch.widgets.refinementList({
    container: '#industry',
    attributeName: 'industry',
    operator: 'or',
    limit: 41,
    templates: {
      header: 'Industry'
    }
  })
);

search.addWidget(
  instantsearch.widgets.refinementList({
    container: '#themeframework',
    attributeName: 'themeframework',
    operator: 'or',
    limit: 10,
    templates: {
      header: 'Framework'
    }
  })
);

search.addWidget(
  instantsearch.widgets.refinementList({
    container: '#blueprint-theme',
    attributeName: 'blueprint_template',
    operator: 'or',
    limit: 15,
    templates: {
      header: 'Blueprint Theme'
    }
  })
);

  search.addWidget(
  instantsearch.widgets.refinementList({
    container: '#plan',
    attributeName: 'subscription_plan_group',
    operator: 'or',
    limit: 10,
    templates: {
      header: 'Plan'
    }
  })
);

search.addWidget(
  instantsearch.widgets.refinementList({
    container: '#tags-facet',
    attributeName: 'tags',
    operator: 'or',
    limit: 50,
    templates: {
      header: 'Tags'
    }
  })
);
  search.addWidget(
    instantsearch.widgets.pagination({
      container: '#pagination',
      scrollTo: '#search-input'
    })
  );


  search.start();
}

function getTemplate(templateName) {
  return document.querySelector('#' + templateName + '-template').innerHTML;
}

function getHeader(title) {
  return '<h5>' + title + '</h5>';
}
