require 'bundler/gem_tasks'
require 'yaml'

SECRET_FILE = "#{Dir.home}/.rundock/chatwork.yml"

task :default => [:spec]

desc 'Run all tests.'
task :spec => ['setup', 'rundock']

desc 'Setup environments'

task :setup do
  Bundler.with_clean_env do
    unless FileTest.exist?(SECRET_FILE)
      puts "#{SECRET_FILE} not found."
      exit
    end
    options = YAML.load_file(SECRET_FILE)

    token = options['token'].to_s
    room_id = options['room_id'].to_s
    src = File.read('./spec/integration/hooks.yml')

    File.write(
      "#{Dir.home}/.rundock/rundock-plugin-hook-chatwork-hooks.yml",
      src.gsub(/<TOKEN>/, token).gsub(/<ROOM_ID>/, room_id))
  end
end

desc "Run rundock-chatwork plugin"

task :rundock do
  cmd = "bundle exec rundock do ./spec/integration/scenario.yml -k #{Dir.home}/.rundock/rundock-plugin-hook-chatwork-hooks.yml -l debug"
  puts "[EXEC: ] #{cmd}"
  system cmd
end
