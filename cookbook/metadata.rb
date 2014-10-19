name             'chef-metadata'
maintainer       'Sander Botman'
maintainer_email 'sander.botman@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures chef-metadata service for client download link creation'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.4'

%w(redhat centos ubuntu).each do |os|
  supports os
end
