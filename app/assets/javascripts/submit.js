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

    $('.submit-btn').click(submit.sendToQueue);
  }

  submit.toHTML = function(item) {
    var html  = '<li>'
        html +=   '<span>'
        html +=     '<strong>' + item.trackName + '</strong>'
        html +=     '<a data-track="'+ item.trackId + '"class="submit-btn" href="javascript:void(0)"> submit </a>'
        html +=   '</span>'
        html += '</li>'

   return html
  }

  submit.sendToQueue = function() {
    var $this = $(this)
    var onSuccess = function() {
      $this.text(' Sent! Thanks :)')
    }

    var onFail = function() {
      $this.text(' Error ocurred, try again later.')
    }

    console.log($(this).text());

    var podcastID = $(this).data('track');

    var data = { podcast_id: podcastID }

    $.post('/api/podcasts/submit', data).done(onSuccess).fail(onFail)
  }

  $(document).on('ready page:load', submit.start)
})()
