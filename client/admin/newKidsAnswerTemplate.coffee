$.cloudinary.config
	cloud_name: Meteor.settings.public.cloud_name

images = new Array()
answerImage = ''

Template.newKidsAnswerTemplate.rendered = ->
	Session.set 'answerImageId', ''	
	answerImages = null
	answerImage = ''

Template.newKidsAnswerTemplate.helpers
	answerImage: ->
		Session.get 'answerImageId'

	answerImages: ->
		Cloudinary.collection.find()

	files: ->
		Cloudinary.collection.find()

	complete: ->
		@status is "complete"

Template.newKidsAnswerTemplate.events
	'change input.answers_file_bag': (e) ->
		console.log 'Files added'
		files = e.currentTarget.files
		console.log files
		$('.btnSaveAnswer').attr('disabled', 'disabled')

		Cloudinary.upload files,
			folder: Meteor.settings.public.folder
			(err,res) ->
				if err 
					console.log err
				else
					console.log 'OK!'
					console.log res.public_id
					Session.set('answerImageId', res.public_id)
					images.push res.public_id
					$('.btnSaveAnswer').removeAttr('disabled')

	'click .btnSaveAnswer': (event) ->
		event.preventDefault

		isCorrectAnswer = false
		if $('#isCorrectAnswer').checked then isCorrectAnswer = true

		params = {
			answers:{
				answerTitle: $('#answerTitle').val()
				isCorrectAnswer: isCorrectAnswer
				image: Session.get('answerImageId')
			}
		}

		console.log params

		Meteor.call 'addAnswerToQuestion', this._id, params, (err) ->
			if err
				console.log err
			else
				console.log 'OK!'

		$('#answerForm')[0].reset()