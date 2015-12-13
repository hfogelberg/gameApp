Router.configure
  layoutTemplate: 'layout'
  notFoundTemplate: 'not-found'

Router.map ->
  @route 'home',
    template: 'homeTemplate',
    path: '/'

  @route 'admin',
    template: 'adminTemplate',
    path: '/admin'

  # @route 'adminQuestions',
  #   template: 'adminQuestionsTemplate',
  #   path: '/admin/questions/:level'
  #   onBeforeAction: ->
  #     Session.set('level', @params.level)
  #     this.next()
  #   waitOn: ->
  #     console.log @params.level
  #     @subscribe 'getQuestionsOverview', @params.level
  #   data: ->
  #     questions:
  #       Questions.find()

  # @route 'adminAnswers',
  #   template: 'adminAnswersTemplate',
  #   path: '/adminAnswers/:questionId'
  #   onBeforeAction: ->
  #     console.log 'adminAnswers ' +  @params.questionId
  #     Session.set('questionId', @params.questionId)
  #     this.next()
  #   waitOn: ->
  #     @subscribe 'getQuestionWithId', Session.get('questionId')
  #   data: question: ->
  #     Questions.findOne({_id: Session.get('questionId')})


  # @route 'newQuestion',
  #   template: 'newQuestionTemplate',
  #   path: '/newQuestion/:level'
  #   onBeforeAction: ->
  #     Session.set('level', @params.level)
  #     this.next()
