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

  @route 'newQuestion',
    template: 'newQuestionTemplate',
    path: '/newQuestion/:level'
      

