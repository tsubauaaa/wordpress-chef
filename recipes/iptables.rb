#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
service 'iptables' do
  action [ :disable,  :stop ]
  supports :status => true, :start => true, :stop => true, :restart => true
end

service 'ip6tables' do
  action [ :disable,  :stop ]
  supports :status => true, :start => true, :stop => true, :restart => true
end
