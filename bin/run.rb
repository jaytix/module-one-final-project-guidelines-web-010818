require_relative '../config/environment'
ActiveRecord::Base.logger.level = 1

new_cli = CLI.new
# Pry.start
new_cli.run
