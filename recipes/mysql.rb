#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
node['wordpress']['mysql']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

case node['platform']
when 'centos'
  template '/etc/my.cnf' do
    source 'my.cnf_5.1.erb'
    owner 'root'
    group 'root'
    mode '0644'
  end
when 'amazon'
  template '/etc/my.cnf' do
    source 'my.cnf_5.5.erb'
    owner 'root'
    group 'root'
    mode '0644'
  end
end

service 'mysqld' do
  action [ :enable, :start ]
end

include_recipe 'wordpress::mysql_setup'
