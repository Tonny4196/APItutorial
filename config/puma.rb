app_path = File.expand_path('..', __dir__)

max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
# スレッドプールの設定。
# 最小と最大を同じにすることで、トラフィック増加時にスレッド起動時の負荷をなくす。
threads min_threads_count, max_threads_count

environment ENV.fetch("RAILS_ENV") { ENV['RACK_ENV'] || "production" }

pidfile "#{app_path}/tmp/pids/server.pid"

# workerの数。CPUのコア数と同じする。
workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# アプリの事前ロード。Workerの起動時間を短くすることが可能。
preload_app!

# Workerが起動されリクエスト受諾前に行う処理を記載する。
on_worker_boot do
  # config/database.yml に記載のpoolサイズのコネクションを張る。
  ActiveRecord::Base.establish_connection
end

bind "unix://#{app_path}/tmp/sockets/puma.sock"

# tmp_restart: Pumaの再起動を可能にするプラグイン。
plugin :tmp_restart