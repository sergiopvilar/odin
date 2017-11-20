var items = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  remote: {
    url: '/items/autocomplete/%QUERY',
    wildcard: '%QUERY'
  }
});

var mobs = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  remote: {
    url: '/mobs/autocomplete/%QUERY',
    wildcard: '%QUERY'
  }
});

window.selectedItem = false
window.selectedMob = false

$('#item-search').typeahead(null, {
  name: 'items',
  display: 'name',
  hint: true,
  highlight: true,
  source: items,
  templates: {
    suggestion: Handlebars.compile('<div><img style="max-width:32px; max-height:32px; margin-right:5px" src={{image}} /> <strong>{{name}}</strong></div>')
  }
}).on('change', function() {
  if(window.selectedItem && $(this).val() !== window.selectedItem.name)
    window.selectedItem = false
}).on('keypress', function(e) {
  if(e.which == 13 && window.selectedItem !== false) location.href = '/items/' + window.selectedItem.uid
}).bind('typeahead:selected', function(obj, datum, name) {
  window.selectedItem = datum
  location.href = '/items/' + window.selectedItem.uid
});

$('#mob-search').typeahead(null, {
  name: 'mobs',
  display: 'name',
  hint: true,
  highlight: true,
  source: mobs,
  templates: {
    suggestion: Handlebars.compile('<div><img style="max-width:32px; max-height:32px; margin-right:5px" src={{image}} /> <strong>{{name}}</strong></div>')
  }
}).on('change', function() {
  if(window.selectedMob && $(this).val() !== window.selectedMob.name)
    window.selectedMob = false
}).on('keypress', function(e) {
  if(e.which == 13 && window.selectedMob !== false) location.href = '/mobs/' + window.selectedMob.uid
}).bind('typeahead:selected', function(obj, datum, name) {
  window.selectedMob = datum
  location.href = '/mobs/' + window.selectedMob.uid
});
