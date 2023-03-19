# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
#
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
# port ENV.fetch("PORT") { 3000 }
bind "unix://#{Dir.pwd}/tmp/sockets/puma.sock?reuseport=true"

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

#アプリケーションサーバの性能を決定する
workers 2

#アプリケーションの設置されているディレクトリを指定
app_path = File.expand_path('../../', __FILE__)
directory app_path

#ポート番号を指定
# listen 3000
bind "unix://#{app_path}/tmp/sockets/puma.sock"

#エラーのログを記録するファイルを指定
state_path "#{app_path}/log/puma.state"

#通常のログを記録するファイルを指定
stdout_redirect "#{app_path}/log/puma.stdout.log", "#{app_path}/log/puma.stderr.log", true

#Railsアプリケーションの応答を待つ上限時間を設定
worker_timeout 3600

#以下は応用的な設定なので説明は割愛
preload_app! true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true
check_client_connection false
run_once = true

before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
