$.cloudinary.config
	cloud_name: Meteor.settings.public.cloud_name

images = new Array()
@answers = new Array()

Template.changeAnswerTemplate.helpers
	thumbRoot: ->
		Session.get 'thumbRoot'
		
	questionId: ->
		Session.get 'questionId'

	id: ->
		Session.get 'answerId'

	files: ->
		Cloudinary.collection.find()

	answerImage: ->
		Session.get 'answerImageId'

	complete: ->
		@status is "complete"

Template.changeAnswerTemplate.events
	'change input.answers_file_bag': (e) ->
		files = e.currentTarget.files
		$('.btnChangeAnswer').attr('disabled', 'disabled')

		Cloudinary.upload files,
			folder: Meteor.settings.public.folder
			(err,res) ->
				if err 
					console.log err
				else
					Session.set('answerImageId', res.public_id)
					images.push res.public_id
					$('.btnChangeAnswer').removeAttr('disabled')


	'click .btnDeleteImage': (event) ->
		event.preventDefault

		Cloudinary.delete this.image, (err,res) ->

		Meteor.call 'deleteImageFromAnswer', Session.get('questionId'), Session.get('answerId'), (err) ->
			if err
				console.log err

	'click .btnChangeAnswer': (event) ->
		event.preventDefault
		
		isCorrectAnswer = 'NO'
		if $('#isCorrectAnswer').is(":checked") then isCorrectAnswer = 'YES'

		params = {
			answers:{
				answerId: Session.get('answerId')
				answerTitle: $('#answerTitle').val()
				isCorrectAnswer: isCorrectAnswer
				image: Session.get('answerImageId')
			}
		}

		Meteor.call 'changeAnswerToQuestion', Session.get('questionId'), Session.get('answerId'), params, (err) ->
			if err
				console.log err