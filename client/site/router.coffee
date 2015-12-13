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
    waitOn: ->
      @subscribe 'getQuestionsTitleByLevel', Session.get('level')
    data: questions: ->
      Questions.find()

  @route 'newQuestion',
    template: 'newQuestionTemplate',
    path: '/newQuestion/:level'
      

  @route 'question',
    template: 'questionTemplate',
    path: '/question/:questionId'
    onBeforeAction: ->
      console.log @params.questionId
      Session.set('questionId', @params.questionId)
      this.next()
    waitOn: ->
      @subscribe 'getQuestionById', Session.get('questionId')
    data: question: ->
      Questions.findOne({_id: Session.get('questionId')})