require 'rake/packagetask'
version = File.read(File.join(File.dirname(__FILE__), *%w[VERSION])).chomp

task :default => [:xpi]

class XPIPackageTask < Rake::PackageTask
  def initialize(*args)
    init(*args)
    @need_zip=true
    yield self if block_given?
    define unless name.nil?
  end
  
  def zip_file
    "#{package_name}.xpi"
  end
end

XPIPackageTask.new("choosy-osx-plugin", version) do |p|
  p.package_files.add('chrome.manifest')
  p.package_files.add('install.rdf')
  p.package_files.add('content/*.xul')
end
