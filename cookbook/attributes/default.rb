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

default['chef-metadata']['version']     = '0.1.4'
default['chef-metadata']['install_dir'] = '/opt/chef-metadata'

if kernel['machine'] =~ /x86_64/
  default['chef-metadata']['url'] = "https://github.com/sbotman/chef-metadata/releases/download/#{node['chef-metadata']['version']}/chef-metadata-linux-amd64.tar.gz"
  default['chef-metadata']['md5'] = '2929931e44f6a8c45187e69fba645035'
  default['chef-metadata']['sha'] = 'fe00d0bb2cbee8f2a172e9aa1c9ce491bb3fbfc1'
else
  default['chef-metadata']['url'] = "https://github.com/sbotman/chef-metadata/releases/download/#{node['chef-metadata']['version']}/chef-metadata-linux-386.tar.gz"
  default['chef-metadata']['md5'] = '1f134b0ee391a8b438a41698407788e1'
  default['chef-metadata']['sha'] = 'f3cece742f38386b3f074d1f9aa018ac3e500e3f'
end

# These options are used for the 'Default' section
default['chef-metadata']['config']['listen']  = '127.0.0.1'
default['chef-metadata']['config']['port']    = '8090'
default['chef-metadata']['config']['url']     = 'http://your.server.com/chef'
default['chef-metadata']['config']['path']    = ''

default['chef-metadata']['params'] = [ "-address=\"#{node['chef-metadata']['config']['listen']}\" ",
                                       "-port=\"#{node['chef-metadata']['config']['port']}\" ", 
                                       "-path=\"#{node['chef-metadata']['config']['path']}\" ",
                                       "-url=\"#{node['chef-metadata']['config']['url']}\" "
                                     ]
