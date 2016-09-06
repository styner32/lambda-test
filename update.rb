require 'rubygems'
require 'aws-sdk'
require './zip.rb'

fns = %w(Sunjin-Test sunjin-todo-create)

cli = Aws::Lambda::Client.new(region: 'ap-southeast-1')
tmpfile = '/tmp/code.zip'
FileUtils.rm_f tmpfile

code_path = Pathname.new("code")
fns.each do |fn|
  z = ZipFileGenerator.new(code_path + fn, tmpfile)
  z.write()

  f = open('/tmp/code.zip')
  resp = cli.update_function_code({
    function_name: fn,
    zip_file: f,
    publish: true,
  })

  p resp
  f.close

  FileUtils.rm_f tmpfile
end

