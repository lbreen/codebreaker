require_relative 'dictionary'
require_relative 'controller'
require_relative 'router'

dictionary = Dictionary.new
controller = Controller.new(dictionary)
router = Router.new(controller)

router.run
