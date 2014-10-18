chef-metadata
===========
Server side metadata module to determine client downloads based on URL targeting.

Requirements
------------

### Platform:

* Linux

Usage
-----

Add the default recipe to the runlist of your artifact server from where you want to distribute your chef clients

Attributes
----------

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['chef-metadata']['version']</tt></td>
    <td>String</td>
    <td>Package version</td>
    <td><tt>0.3.0</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-metadata']['install_dir']</tt></td>
    <td>String</td>
    <td>Installation path</td>
    <td><tt>/opt/chef-metadata</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-metadata']['url']</tt></td>
    <td>String</td>
    <td>Download URL</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-metadata']['md5']</tt></td>
    <td>String</td>
    <td>Download md5</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-metadata']['sha']</tt></td>
    <td>String</td>
    <td>Download sha</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-metadata']['config']['listen']</tt></td>
    <td>String</td>
    <td>IP to listen on</td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-metadata']['config']['port']</tt></td>
    <td>String</td>
    <td>Port to listen on</td>
    <td><tt>8090</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-metadata']['config']['path']</tt></td>
    <td>String</td>
    <td>Path to the chef client sources</td>
    <td><tt>/path/to/your/sources</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-metadata']['config']['url']</tt></td>
    <td>String</td>
    <td>URL where to download the chef clients</td>
    <td><tt>http://your.server.com/artifacts/chef</tt></td>
  </tr>
  <tr>
    <td><tt>['chef-metadata']['params']</tt></td>
    <td>Array</td>
    <td>Program parameters</td>
    <td><tt>computed</tt></td>
  </tr>
</table>

Recipes
-------

### chef-metadata::default

Installs the chef-metadata service and configuration

Versioning
----------
This cookbook uses [Semantic Versioning 2.0.0](http://semver.org/)  

    Given a version number MAJOR.MINOR.PATCH, increment the:  
    MAJOR version when you make functional cookbook changes,
    MINOR version when you add functionality in a backwards-compatible manner,
    PATCH version when you make backwards-compatible bug fixes.

Testing
-------

[![Build Status](https://travis-ci.org/mlafeldt/skeleton-cookbook.png?branch=master)](https://travis-ci.org/mlafeldt/skeleton-cookbook)

The cookbook provides the following Rake tasks for testing:

    rake foodcritic                   # Lint Chef cookbooks
    rake integration                  # Alias for kitchen:all
    rake kitchen:all                  # Run all test instances
    rake kitchen:default-centos-64    # Run default-centos-64 test instance
    rake kitchen:default-ubuntu-1204  # Run default-ubuntu-1204 test instance
    rake rubocop                      # Run RuboCop style and lint checks
    rake spec                         # Run ChefSpec examples
    rake test                         # Run all tests

License and Author
------------------

Author: Sander Botman (sander.botman@gmail.com)

Copyright (c) 2014, Sander Botman All Rights Reserved.

Contributing
------------

We welcome contributed improvements and bug fixes via the usual workflow:

1. Fork this repository
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new pull request
