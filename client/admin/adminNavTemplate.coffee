Template.adminNavTemplate.events
	'click .admin': (event) ->
		event.preventDefault
		elem = $('.adminNav li')
		elem.removeClass('active')
		elem = $('.manage')
		elem.addClass('active')

	'click .stats': (event) ->
		event.preventDefault
		elem = $('.adminNav li')
		elem.removeClass('active')
		elem = $('.stats')
		elem.addClass('active')