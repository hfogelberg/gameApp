Meteor.startup ->
	if Stats.find().count() == 0
		console.log 'Seedings stats'
		i = 0
		while i < 48
			Stats.insert
			correctAnswers: 3
			wrongAnswers: 2
			level: KID
			createdDate: new Date()
			i++

		j = 0
		while j < 24
			Stats.insert
			correctAnswers: 3
			wrongAnswers: 2
			level: ADULT
			createdDate: new Date()
			j++
	else
		console.log 'No need to seed stats'
