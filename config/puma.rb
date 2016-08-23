# Default to production
rails_env = ENV['RAILS_ENV'] || "production"
environment rails_env

if ENV['RAILS_ENV'] == 'production'

  app_root = '/var/www/r5test'
  pidfile "#{app_root}/tmp/puma.pid"
  state_path "#{app_root}/tmp/puma.state"
  bind "unix://#{app_root}/tmp/puma.sock"
  # activate_control_app "unix://#{app_root}/tmp/pumactl.sock"
  daemonize true
  workers 0
  threads 2, 4
  preload_app!

  on_worker_boot do
    ActiveSupport.on_load(:active_record) do
      ActiveRecord::Base.establish_connection
    end
  end

  before_fork do
    ActiveRecord::Base.connection_pool.disconnect!
  end

else
  plugin :tmp_restart
end
