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

default['chef-metadata']['version']     = '0.1.2'
default['chef-metadata']['install_dir'] = '/opt/chef-metadata'

if kernel['machine'] =~ /x86_64/
  default['chef-metadata']['url'] = "https://github.com/sbotman/chef-metadata/releases/download/#{node['chef-metadata']['version']}/chef-metadata-linux-amd64.tar.gz"
  default['chef-metadata']['md5'] = '3f7cbaf6db45a7d5c2399c413a0e6387'
  default['chef-metadata']['sha'] = '3b3fa5071a0cc7396cab24f97d40047d28f890d4'
else
  default['chef-metadata']['url'] = "https://github.com/sbotman/chef-metadata/releases/download/#{node['chef-metadata']['version']}/chef-metadata-linux-386.tar.gz"
  default['chef-metadata']['md5'] = '5829b6281e3c63f955c53966e04acfd2'
  default['chef-metadata']['sha'] = '10da63cd4e5c528d82abb06bda2152a4576858d8'
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
