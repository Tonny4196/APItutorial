# config/puma.rb

app_path = File.expand_path('..', __dir__)

max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

if ENV.fetch("RAILS_ENV") { ENV['RACK_ENV'] || "development" } == "development"
  # 開発環境の場合のみlocalhost:3000でバインドする
  port ENV.fetch("PORT") { 3000 }
else
  # 本番環境の場合はUNIXドメインソケットでバインドする
  bind "unix://#{app_path}/tmp/sockets/puma.sock"
end

# Pumaの挙動を制御する設定を記述する
pidfile "#{app_path}/tmp/pids/server.pid"

# アプリケーションを事前に読み込む
preload_app!

# Workerが起動したときに実行されるブロックを記述する
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

# ワーカープロセスを再起動するための設定
plugin :tmp_restart
