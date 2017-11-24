function Autocomplete(namespace, attribute, useImage) {
  var self = this
    , template
    , objects
    , form

  this.namespace = namespace
  this.attribute = typeof attribute === 'undefined' ? 'uid' : attribute
  this.useImage = typeof useImage === 'undefined' ? true : useImage

  if(this.useImage) {
    template = '<div><img style="max-width:32px; max-height:32px; margin-right:5px" src={{image}} /> <strong>{{name}}</strong></div>'
  } else {
    template = '<div><strong>{{desc}} ({{name}})</strong></div>'
  }

  form = $('#' + this.namespace + '-form')
  window['selected_' + this.namespace] = false

  form.on('submit', function(e) {
    if(window['selected_' + self.namespace]) {
      e.preventDefault()
      location.href = '/' + self.namespace + '/' + window['selected_' + self.namespace][self.attribute];
    }
  })

  objects = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/' + this.namespace + '/autocomplete/%QUERY',
      wildcard: '%QUERY'
    }
  });

  $('#'+ this.namespace + '-search').typeahead(null, {
    name: this.namespace,
    display: 'name',
    hint: true,
    highlight: true,
    source: objects,
    templates: { suggestion: Handlebars.compile(template) }
  }).on('change', function() {
    if(window['selected_' + self.namespace] && $(this).val() !== window['selected_' + self.namespace].name)
      window['selected_' + self.namespace] = false
  }).on('keypress', function(e) {
    if(e.which == 13) form.submit();
  }).bind('typeahead:selected', function(obj, datum, name) {
    window['selected_' + self.namespace] = datum
    location.href = '/' + self.namespace +'/' + window['selected_' + self.namespace][self.attribute]
  });

}

new Autocomplete('items')
new Autocomplete('mobs')
new Autocomplete('maps', 'name', false)
