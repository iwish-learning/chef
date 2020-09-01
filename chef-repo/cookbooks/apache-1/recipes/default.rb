#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

# Set welcome message 
cookbook_file '/etc/motd' do
  source 'motd'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Set hostname
cookbook_file '/etc/hostname' do
  source 'hostname'
  mode '0644'
  owner 'root'
  group 'root'
end

hostname 'lsg' do
  action :set
end

# change source
template '/etc/apt/sources.list' do
  source 'source.list.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

include_recipe 'apache::git-training'
include_recipe 'apache::nginx'