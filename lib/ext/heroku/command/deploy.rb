# perform a deploy
#
class Heroku::Command::Deploy < Heroku::Command::Base
  # deploy
  #
  # deploy a ref (usually, the current HEAD)
  #
  # -m, --migrate  # run migrations after deploy
  #
  def index
    push && pushed
  end

  private

  # Push

  def push
    system(%{git push -f #{app} master})
  end

  def pushed
    migrate
  end

  # Migrations

  def migrate
    with_maintenance {
      run_command 'run', %w(rake db:migrate)
      run_command 'restart'
    } if migrate?
  end

  def migrate?
    options[:migrate]
  end

  # Utils

  def run_command(name, args = [])
    Heroku::Command.run name, %W(--app #{app}).concat(args)
  end

  def with_maintenance
    run_command 'maintenance:on'

    yield

    run_command 'maintenance:off'
  end
end
