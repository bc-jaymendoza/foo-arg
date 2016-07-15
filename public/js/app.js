/* global instantsearch */

app({
  appId: 'Y8Q3VSESJ3',
  apiKey: '2413f402b681457b0e0d659573e64bb7',
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
      hitsPerPage: 10,
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
    limit: 10,
    templates: {
      header: 'Filter by Industry'
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
      header: 'Filter by Blueprint theme'
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
      header: 'Filter by Plan'
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
