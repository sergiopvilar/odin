# config valid only for current version of Capistrano
lock "3.10.0"

server '138.197.41.12', user: 'rails', port: 22, roles: [:web, :app, :db], primary: true
set :application, "odindb"
set :repo_url, "git@github.com:sergiovilar/odin-db.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/rails"
set :current_path, '/home/rails/rails_project'
set :user,            'rails'
set :tmp_dir, '/home/rails/tmp'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, ".env"
append :linked_files, ".unicorn.sh"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc 'Restart unicorn'
  task :restart_unicorn do
    on roles(:app) do
      execute :service, "unicorn restart"
    end
  end

  desc 'Seed no banco'
  task :seed do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env)  do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  desc 'Cria funções no banco'
  task :functions do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env)  do
          execute :rake, 'db:functions'
        end
      end
    end
  end

  desc 'Seta permissões para pastas de assets'
  task :set_permissions do
    on roles(:app) do
      execute "chmod -R 777 /home/rails/current/public/icons"
    end
  end
end

# after "deploy:published", "restart_unicorn"
after "deploy:published", "set_permissions"
after "deploy:published", "functions"
