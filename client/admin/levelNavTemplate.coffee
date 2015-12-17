Template.levelNavTemplate.helpers
	level: ->
		Session.get('level')

Template.levelNavTemplate.events
	'click .kidsLevel':->
		Session.set('level', KID)

		elem = $('.levelNav li')
		elem.removeClass('active')
		elem =$('.kidsLevel')
		elem.addClass('active')

	'click .adultLevel':->
		Session.set('level', ADULT)

		elem = $('.levelNav li')
		elem.removeClass('active')
		elem =$('.adultLevel')
		elem.addClass('active')