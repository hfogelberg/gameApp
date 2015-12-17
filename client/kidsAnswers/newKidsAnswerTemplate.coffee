$.cloudinary.config
	cloud_name: Meteor.settings.public.cloud_name

images = new Array()
answerImage = ''

Template.newKidsAnswerTemplate.rendered = ->
	Session.set 'answerImageId', ''	
	answerImages = null
	answerImage = ''

Template.newKidsAnswerTemplate.helpers
	thumbRoot: ->
		Session.get 'thumbRoot'
		
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
		files = e.currentTarget.files
		$('.btnSaveAnswer').attr('disabled', 'disabled')

		Cloudinary.upload files,
			folder: Meteor.settings.public.folder
			(err,res) ->
				if err 
					console.log err
				else
					Session.set('answerImageId', res.public_id)
					images.push res.public_id
					$('.btnSaveAnswer').removeAttr('disabled')

	'click .btnSaveAnswer': (event) ->
		event.preventDefault

		isCorrectAnswer = 'NO'
		if $('#isCorrectAnswer').is(":checked") then isCorrectAnswer = 'YES'

		params = {
			answers:{
				answerTitle: $('#answerTitle').val()
				isCorrectAnswer: isCorrectAnswer
				image: Session.get('answerImageId')
				answerId : Random.id()
			}
		}


		Meteor.call 'addAnswerToQuestion', this._id, params, (err) ->
			if err
				console.log err

		$('#answerForm')[0].reset()