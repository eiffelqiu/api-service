# god 配置文件 监测 goliath 程序是否运行正常
# start => god -c config/listen.god -D

API_ENV = ENV['GOLIATH_ENV'] || 'production'
API_ROOT = "."
God.pid_file_directory = "#{API_ROOT}/config"
PROCESS_NUM = 4

(1..PROCESS_NUM).each do |port|
  God.watch do |w|

    w.dir = "#{API_ROOT}"
    w.log = "#{API_ROOT}/log/#{API_ENV}.log"
    port += 8000

    w.name = "api-#{port}"
    w.interval = 30.seconds # default
    w.start = "cd #{API_ROOT} && ruby server.rb -sv -e production -l log/production.log \
               -p #{port} -P #{API_ROOT}/tmp/pids/api.#{port}.pid -d"
    w.stop = "kill -QUIT `cat #{API_ROOT}/tmp/pids/api.#{port}.pid"
    w.restart = "#{w.stop} && #{w.start}"

    w.start_grace = 10.seconds
    w.restart_grace = 10.seconds     # 重启缓冲时间
    w.pid_file = "#{API_ROOT}/tmp/pids/api.#{port}.pid"

    w.behavior(:clean_pid_file)

    w.start_if do |start|
      start.condition(:process_running) do |c|
        c.interval = 5.seconds
        c.running = false
      end
    end

    w.restart_if do |restart|
      restart.condition(:memory_usage) do |c|
        c.above = 150.megabytes
        c.times = [3, 5] # 3 out of 5 intervals
        c.notify = 'your_name'      # 报警邮件发送对象
      end

      restart.condition(:cpu_usage) do |c|
        c.above = 50.percent
        c.times = 5
        c.notify = 'your_name'
      end
    end

    w.lifecycle do |on|
      on.condition(:flapping) do |c|
        c.to_state = [:start, :restart]
        c.times = 5
        c.within = 5.minute
        c.transition = :unmonitored
        c.retry_in = 10.minutes
        c.retry_times = 5
        c.retry_within = 2.hours
        c.notify = 'your_name'
      end
    end
  end
end