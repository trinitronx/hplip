#
# Cookbook Name:: hplip
# Recipe:: default
#
# Copyright (C) 2014 
#
# 
#
# Source: http://hplipopensource.com/node/327
#         http://hplipopensource.com/node/186
#         http://hplipopensource.com/hplip-web/install/install/index.html
#
#  /usr/bin/gpg --keyserver pgp.mit.edu --recv-keys 0xA59047B9
#  gpg --verify hplip-version.run.asc hplip-<version>.run
hplip_installer_filename = "hplip-#{node['hplip']['version']}.run"

remote_file "#{Chef::Config[:file_cache_path]}/#{hplip_installer_filename}" do
  source node['hplip']['download_url']
  owner 'root'
  group 'root'
  mode 0755
end

remote_file "#{Chef::Config[:file_cache_path]}/#{hplip_installer_filename}.asc" do
  source node['hplip']['digital_certificate_url']
  owner 'root'
  group 'root'
  mode '0644'
  notifies :run, 'execute[verify hplip gpg signature]'
end

execute 'verify hplip gpg signature' do
  environment( { 'GNUPGHOME' => '$(mktemp -d $HOME/.gnupgXXXXXX)' } )
  command <<-EOC
    /usr/bin/gpg --keyserver pgp.mit.edu --recv-keys 0xA59047B9
    /usr/bin/gpg --verify #{Chef::Config[:file_cache_path]}/#{hplip_installer_filename}.asc #{Chef::Config[:file_cache_path]}/#{hplip_installer_filename}
  EOC
  action :nothing
#export GNUPGHOME
end
