Template.levelNavTemplate.helpers
	level: ->
		Session.get('level')

Template.levelNavTemplate.events
	'click .kidsLevel':->
		console.log 'kidsLevel'
		Session.set('level', KID)

		elem = $('.levelNav li')
		elem.removeClass('active')
		elem =$('.kidsLevel')
		elem.addClass('active')

	'click .adultLevel':->
		console.log 'adultLevel'
		Session.set('level', ADULT)

		elem = $('.levelNav li')
		elem.removeClass('active')
		elem =$('.adultLevel')
		elem.addClass('active')