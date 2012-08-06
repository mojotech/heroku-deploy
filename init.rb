require 'ext/heroku/command/deploy'

Heroku::Command::Help.group('Deploy') do |g|
  g.command 'deploy', 'deploy app'
end
