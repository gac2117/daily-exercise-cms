require_relative './config/environment'

use Rack::MethodOverride
use UsersController
use ExercisesController
run ApplicationController
