(function() {
  var submit = {}

  submit.start = function() {
    $('.search-trigger').click(function() {
      var term = $('#submit-select').val()
      submit.loadPodcasts(term, submit.render)
    })
  }

  submit.loadPodcasts = function(term, callback) {
    var endpoint = 'https://itunes.apple.com/search?callback=?'
    var fields = {
      entity: 'podcast',
      term: term
    }

    $.getJSON(endpoint, fields).done(callback)
  }

  submit.render = function(data) {
    var results = data['results']
    var element = $('.submit-results')
    var html

    //clear
    element.html('')

    $.each(results, function(_k, v) {
      html = submit.toHTML(v)
      element.append(html)
    })
  }

  submit.toHTML = function(item) {
    var html  = '<li>'
        html +=   '<span>'
        html +=     '<strong>' + item.trackName + '</strong>'
        html +=     '<a href="javascript:void(0)"> submit </a>'
        html +=   '</span>'
        html += '</li>'

   return html
  }

  $(document).on('ready page:load', submit.start)
})()
