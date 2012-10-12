# perform a deploy
#
class Heroku::Command::Deploy < Heroku::Command::Base
  # deploy
  #
  # deploy a ref (usually, the current HEAD)
  #
  # -m, --migrate  # run migrations after deploy
  # -b, --backup   # perform a backup before migrating
  # -v, --verbose  # be verbose
  #
  def index
    push && pushed
  end

  # migrate
  #
  # run rails migrations
  #
  # -b, --backup   # perform a backup before migrating
  #
  def migrate
    with_maintenance do
      backup if backup?
      run_migration
      restart
    end
  end

  # backup
  #
  # capture new backup
  #
  def backup
    run_command 'pgbackups:capture', %W(--expire #{database})
  end

  private

  # Push

  def push
    system(%{git push -f #{verbose} #{app} #{branch}:master})
  end

  def pushed
    migrate if migrate?
  end

  # Migrations

  def database
    "SHARED_DATABASE" # this should probably not be hard-coded
  end

  def migrate?
    options[:migrate]
  end

  def run_migration
    run_command 'run', %w(rake db:migrate)
  end

  def restart
    run_command 'restart'
  end

  # Backup

  def backup?
    options[:backup]
  end

  # Verbose

  def verbose
    "--verbose" if verbose?
  end

  def verbose?
    options[:verbose]
  end

  # Utils

  def branch
    `git symbolic-ref HEAD`.strip.tap do
      raise 'Failed to get current branch name' unless $?.success?
    end
  end

  def run_command(name, args = [])
    Heroku::Command.run name, %W(--app #{app}).concat(args)
  end

  def with_maintenance
    run_command 'maintenance:on'

    yield

    run_command 'maintenance:off'
  end
end
