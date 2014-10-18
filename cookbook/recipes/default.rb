#
# Cookbook Name:: chef-metadata
# Attribute:: default
#
# Copyright 2014, Sander Botman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

directory node['chef-metadata']['install_dir'] do
  recursive true
end

remote_file "#{Chef::Config[:file_cache_path]}/#{File.basename(node['chef-metadata']['url'])}" do
  source node['chef-metadata']['url']
  backup false
  checksum node['chef-metadata']['md5']
  notifies :stop, 'service[chef-metadata]', :immediately
  notifies :run, 'execute[extract_download]', :immediately
end

execute 'extract_download' do
  cwd node['chef-metadata']['install_dir']
  command "tar zxof #{Chef::Config[:file_cache_path]}/#{File.basename(node['chef-metadata']['url'])}"
  action :nothing
end

template '/etc/init/chef-metadata.conf' do
  source 'chef-metadata.upstart.erb'
  backup false
  variables(
    :recipe_file => (__FILE__).to_s.split("cookbooks/")[1],
    :template_file => source.to_s,
    :basedir => node['chef-metadata']['install_dir'],
    :params  => node['chef-metadata']['params'].join(' ')
  )
  notifies :restart, 'service[chef-metadata]'
end

service 'chef-metadata' do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :reload => true, :status => true
  action :start
  only_if { File.exists?("#{node['chef-metadata']['install_dir']}/chef-metadata") }
end
