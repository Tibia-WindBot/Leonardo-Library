require 'fileutils'
require 'json'
require 'yaml'

Dir.foreach("#{Dir.pwd}/docs") do |file|
  unless file.start_with?('.', '_')
    function_name = file.scan(/^(.+)\.json$/i).first.first
    content = JSON.parse(File.open("#{Dir.pwd}/docs/#{file}").read)

    new_dir = "src/#{function_name}"

    FileUtils.mkdir(new_dir) unless File.directory?(new_dir)

    begin
      fl = File.open("#{new_dir}/_docfile.yml", 'w+')
      fl.write(content.to_yaml)
      fl.flush
      fl.close

      fl = File.open("#{new_dir}/_code.lua", 'w+')
      fl.close

      fl = File.open("#{new_dir}/_example.lua", 'w+')
      fl.close
    ensure
      fl.close unless fl.nil?
    end
  end
end
