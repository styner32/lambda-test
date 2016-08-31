require 'rubygems'
require 'aws-sdk'
require './zip.rb'

cli = Aws::Lambda::Client.new(region: 'ap-southeast-1')
tmpfile = '/tmp/code.zip'
FileUtils.rm_f tmpfile

z = ZipFileGenerator.new('code', tmpfile)
z.write()

f = open('/tmp/code.zip')
resp = cli.update_function_code({
  function_name: "Sunjin-Test",
  zip_file: f,
  publish: true,
})

p resp
f.close

FileUtils.rm_f tmpfile
