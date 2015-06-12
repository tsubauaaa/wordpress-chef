#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'wordpress::iptables'
include_recipe 'wordpress::mysql'
include_recipe 'wordpress::php'

package 'httpd' do
  action :install
end

execute 'install_wordpress' do
  command <<-"EOH"
    cd #{node['wordpress']['documentroot']}
    curl -LO http://ja.wordpress.org/latest-ja.tar.gz
    tar xvzf latest-ja.tar.gz
  EOH
  action :run
  not_if { ::File.exists?("#{node['wordpress']['documentroot']}/#{node['wordpress']['directory']}/index.php") }
end

directory "#{node['wordpress']['documentroot']}/#{node['wordpress']['directory']}" do
  action :create
  recursive true
  owner node['wordpress']['user']
  group node['wordpress']['group']
  mode  '00755'
end

template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf.erb'
  owner node['wordpress']['user']
  group node['wordpress']['group']
  notifies :restart, 'service[httpd]'
end

template "#{node['wordpress']['documentroot']}/#{node['wordpress']['directory']}/wp-config.php" do
  source 'wp-config.php.erb'
  owner node['wordpress']['user']
  group node['wordpress']['group']
  notifies :restart, 'service[httpd]'
end

template '/etc/httpd/conf.d/wordpress.conf' do
  source 'wordpress.conf.erb'
  owner node['wordpress']['user']
  group node['wordpress']['group']
  notifies :restart, 'service[httpd]'
end

service 'httpd' do
  action [ :enable, :start ]
end
