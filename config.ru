require_relative './config/environment.rb'

use Rack::MethodOverride

run ApplicationController
use UsersController
use GamesController