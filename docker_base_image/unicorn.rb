app_dir = "/app"

working_directory app_dir

pid "#{app_dir}/unicorn.pid"

stderr_path "#{app_dir}/unicorn.stderr.log"
stdout_path "#{app_dir}/unicorn.stdout.log"

worker_processes 4
listen "#{app_dir}/unicorn.sock", :backlog => 64
listen 8080, :tcp_nopush => true

timeout 30