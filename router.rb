class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end

  def run
    while @running
      display_tasks
      print "> "
      action = gets.chomp.to_i
      print `clear`
      router_action(action)
    end

  end

  private

  def router_action(action)
    case action
    when 1 then @controller.unscramble_word
    when 2 then @controller.add_word
    when 3 then @controller.edit_definition
    when 4 then stop
    else
      puts "Sorry I don't understand what \"#{action}\" means."
      puts "Please press either 1, 2, 3 or 4..."
    end
  end

  def stop
    @running = false
    puts "Goodbye!"
  end

  def display_tasks
    puts ""
    puts "1 - Unscramble a word"
    puts "2 - Add a word to the dictionary"
    puts "3 - Edit a definition in the dictionary"
    puts "4 - Exit the program"
  end
end
