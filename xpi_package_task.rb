require "rexml/document"
include REXML
require 'rake/packagetask'

class XPIPackageTask < Rake::PackageTask
  def initialize(package_name)
    init(package_name, version)
    yield self if block_given?
    define unless name.nil?
  end
  
  def zip_file
    "#{package_name}.xpi"
  end
  
  def version
    install_rdf_xmldoc = Document.new(File.new("install.rdf","r"))
    version_number = install_rdf_xmldoc.elements.each("RDF/Description/em:version") do |element|
      break element.text
    end
  end
  
  def define
    desc "Build all the packages"
    task :package
    
    desc "Force a rebuild of the package files"
    task :repackage => [:clobber_package, :package]
    
    desc "Remove package products" 
    task :clobber_package do
      rm_r package_dir rescue nil
    end

    task :clobber => [:clobber_package]

    
  	task :package => ["#{package_dir}/#{zip_file}"]
  	
  	location = File.join(File.dirname(__FILE__), package_dir)
  	file "#{package_dir}/#{zip_file}" => [package_dir_path] + package_files do
  	  chdir(File.join(location, package_name)) do
  	    sh %{zip -r #{location}/#{zip_file} *}
  	  end
  	  rm_r package_dir_path
  	end

    directory package_dir

    file package_dir_path => @package_files do
    	mkdir_p package_dir rescue nil
    	@package_files.each do |fn|
    	  f = File.join(package_dir_path, fn)
    	  fdir = File.dirname(f)
    	  mkdir_p(fdir) if !File.exist?(fdir)
    	  if File.directory?(fn)
    	    mkdir_p(f)
    	  else
    	    rm_f f
    	    safe_ln(fn, f)
    	  end
    	end
    end
    self
  end
  
end




