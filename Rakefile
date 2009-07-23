
require File.join(File.dirname(__FILE__), *%w[xpi_package_task])

task :default => [:package]

XPIPackageTask.new("choosy-osx-plugin") do |p|
  p.package_files.add('chrome.manifest')
  p.package_files.add('install.rdf')
  p.package_files.add('content/*.*')
end
