puts "Starting up..."
require_relative 'dictionary'
require_relative 'controller'
require_relative 'router'

puts "Loading dictionary..."
dictionary = Dictionary.new
controller = Controller.new(dictionary)
router = Router.new(controller)

router.run
