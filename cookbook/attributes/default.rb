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

default['chef-metadata']['version']     = '0.1.0'
default['chef-metadata']['install_dir'] = '/opt/chef-metadata'

if kernel['machine'] =~ /x86_64/
  default['chef-metadata']['url'] = "https://github.com/sbotman/metadata-go/releases/download/#{node['chef-metadata']['version']}/chef-metadata-linux-amd64.tar.gz"
  default['chef-metadata']['md5'] = '5babafe809eb0c08b7bb88c87e29a1bc'
  default['chef-metadata']['sha'] = 'ad02d6c8e57d5b273b9b3d2391449ce62de630ad'
else
  default['chef-metadata']['url'] = "https://github.com/sbotman/metadata-go/releases/download/#{node['chef-metadata']['version']}/chef-metadata-linux-386.tar.gz"
  default['chef-metadata']['md5'] = 'be6cfbb9ca9fa8aaff6b59013d6a4045'
  default['chef-metadata']['sha'] = '7633b185b5dcf1a372be0cc8f8a1e4d558e69e2e'
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
