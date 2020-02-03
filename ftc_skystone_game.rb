require "cyberarm_engine"

GAME_ROOT_PATH = File.expand_path(__dir__)

require_relative "lib/window"
require_relative "lib/game_objects/field"
require_relative "lib/game_objects/stone"
require_relative "lib/game_objects/bridges"
require_relative "lib/game_objects/foundation"
require_relative "lib/game_objects/robot"

require_relative "lib/states/main_menu"
require_relative "lib/states/game_state"

Game::Window.new.show