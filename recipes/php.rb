#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
node['wordpress']['php']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

template '/etc/php.ini' do
  source 'php.ini.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
