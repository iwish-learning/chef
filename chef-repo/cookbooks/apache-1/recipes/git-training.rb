#
# Cookbook:: apache
# Recipe:: git-training
#
# Copyright:: 2020, The Authors, All Rights Reserved.
apt_update

git_client 'install it'

user 'lsg' do
  manage_home true
  home '/home/lsg'
end

group 'lsg_group' do
  members 'lsg'
  action :create
end

directory '/home/lsg/.ssh' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# id_rsa file need to speical privileges 600
cookbook_file '/home/lsg/.ssh/id_rsa' do
  source 'id_rsa'
  owner 'lsg'
  group 'lsg_group'
  mode '600'
  action :create
end

# for git ssh
template '/home/lsg/ssh_wrapper' do
  source 'ssh_wrapper.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

git_config 'add lsg to git' do
  user 'lsg'
  scope 'global'
  key 'user.name'
  value 'lsg'
end

git_config 'add lsg to git' do
  user 'lsg'
  scope 'global'
  key 'user.email'
  value 'lsg@merkleinc.com'
end

if node['branch'].nil?
  branch_name = 'br-a'
else
  branch_name = node['branch']
end

puts "------------------- using branch: #{branch_name} -------------------"

git '/home/lsg/training' do
  repository 'git@github.com:iwish-learning/chef.git'
  ssh_wrapper '/home/lsg/ssh_wrapper'
  revision branch_name
  user 'lsg'
  group 'lsg_group'
  action :sync
end