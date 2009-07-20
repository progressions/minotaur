
namespace :log do
  desc "Clear log files"
  task :clear do
    File.open("log/monitor.log", "w") do |f|
      f.write ""
    end
  end
end

desc "Copy example config files"
task :setup do
  unless Dir["./config/monitor.yml"].any?
    system "cp ./config/monitor.yml.example ./config/monitor.yml"
  end
end