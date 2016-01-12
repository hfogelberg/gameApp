Template.levelNavTemplate.onRendered ->
	elem = $('.levelNav li')
	elem.removeClass('active')
	if Session.get('level') is KID
		elem =$('.kidsLevel')
		elem.addClass('active')
	else
		elem =$('.adultLevel')
		elem.addClass('active')

Template.levelNavTemplate.helpers
	level: ->
		Session.get('level')

Template.levelNavTemplate.events
	'click .kidsLevel':->
		Session.set('level', KID)

	'click .adultLevel':->
		Session.set('level', ADULT)