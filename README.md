# Network Device Standard Library

[![Build Status][buildstatus]][travis]

# Overview

This module implements the type specification for the network device support
program.  The goal of this module is to provide the Puppet types for writing
provider implementations of these types for a specific network device model.

# Reference Information

The following reference material is useful when developing providers for the
types implemented in this module.

 * [Puppet Types and Providers by Dan Bode & Nan Liu][book]
 * [Custom Types Documentation][types doc]
 * [Seriously, What is this Provider Doing?][gary provider] Useful for an
   in-depth explanation of the instances class method for each provider.

# Getting Started for Development

This section describes how to get started developing providers for the types
implemented in this module.

First, configure a Ruby development environment.  There are multiple ways to
accomplish this task including [rvm][rvm], [rbenv][rbenv], and
[crossfader][crossfader].  This module has been developed using
[crossfader][crossfader], a pre-packaged build of multiple Ruby versions
specifically designed for developing and extending Puppet.

## Install Crossfader

Please follow the [Crossfader Quick Start][crossfader quick start] instructions
to get started with crossfader on Mac OS X.

## Set the ruby environment

Once crossfader is installed, select the version of Ruby currently shipping
with Puppet Enterprise.  At the time of writing this is currently Ruby
1.9.3-p484.  Information on the current version of Ruby shipping with Puppet
Enterprise is available at [Puppet Enterprise Software Components][pe
components].

    $ eval "$(crossfader --ruby 1.9.3-p484 --gemset netdev shellinit)"

Once initialized, verify the environment is using the specified version of ruby
with the `gem env` command.

    $ gem env
    RubyGems Environment:
      - RUBYGEMS VERSION: 1.8.23
      - RUBY VERSION: 1.9.3 (2013-11-22 patchlevel 484) [x86_64-darwin13.0.0]
      - INSTALLATION DIRECTORY: /opt/crossfader/versions/ruby/1.9.3-p484/gemsets/netdev/ruby/1.9.1
      - RUBY EXECUTABLE: /opt/crossfader/versions/ruby/1.9.3-p484/bin/ruby
      - EXECUTABLE DIRECTORY: /opt/crossfader/versions/ruby/1.9.3-p484/gemsets/netdev/ruby/1.9.1/bin
      - RUBYGEMS PLATFORMS:
        - ruby
        - x86_64-darwin-13
      - GEM PATHS:
         - /opt/crossfader/versions/ruby/1.9.3-p484/gemsets/netdev/ruby/1.9.1
         - /opt/crossfader/versions/ruby/1.9.3-p484/gemsets/global/ruby/1.9.1
         - /opt/crossfader/versions/ruby/1.9.3-p484/lib/ruby/gems/1.9.1
         - /Users/jeff/.gem/ruby/1.9.1
      - GEM CONFIGURATION:
         - :update_sources => true
         - :verbose => true
         - :benchmark => false
         - :backtrace => false
         - :bulk_threshold => 1000
      - REMOTE SOURCES:
         - http://rubygems.org/

## Clone the Repository

Clone this repository into your local development workspace.

    $ git clone https://github.com/puppetlabs/netdev_stdlib
    Cloning into 'netdev_stdlib'...
    remote: Counting objects: 595, done.
    remote: Compressing objects: 100% (172/172), done.
    remote: Total 595 (delta 264), reused 587 (delta 261)
    Receiving objects: 100% (595/595), 76.83 KiB | 0 bytes/s, done.
    Resolving deltas: 100% (264/264), done.
    Checking connectivity... done.

## Install dependencies

The types depend primarily on Puppet which itself has a set of dependencies.
All of these additional software components should be installed using bundler
when developing the types and providers.

    $ cd netdev_stdlib/
    $ bundle install --path .bundle/gems/
    Fetching gem metadata from https://rubygems.org/.........
    Resolving dependencies...
    Installing rake (10.1.1)
    Installing CFPropertyList (2.2.8)
    Installing ast (2.0.0)
    Installing slop (3.6.0)
    Installing parser (2.2.0.pre.4)
    Installing astrolabe (1.3.0)
    Installing timers (1.1.0)
    Installing celluloid (0.15.2)
    Installing coderay (1.1.0)
    Installing diff-lcs (1.2.5)
    Installing docile (1.1.5)
    Installing facter (2.2.0)
    Installing ffi (1.9.3)
    Installing formatador (0.2.5)
    Installing rb-fsevent (0.9.4)
    Installing rb-inotify (0.9.5)
    Installing listen (2.7.9)
    Installing lumberjack (1.0.9)
    Installing method_source (0.8.2)
    Installing pry (0.10.1)
    Installing thor (0.19.1)
    Installing guard (2.6.1)
    Installing rspec-core (2.13.1)
    Installing rspec-expectations (2.13.0)
    Installing rspec-mocks (2.13.1)
    Installing rspec (2.13.0)
    Installing guard-rspec (3.1.0)
    Installing powerpack (0.0.9)
    Installing rainbow (2.0.0)
    Installing ruby-progressbar (1.5.1)
    Installing rubocop (0.26.0)
    Installing guard-rubocop (1.1.0)
    Installing json_pure (1.8.1)
    Installing hiera (1.3.4)
    Installing metaclass (0.0.4)
    Installing mocha (1.1.0)
    Installing multi_json (1.10.1)
    Installing yard (0.8.7.4)
    Installing pry-doc (0.6.0)
    Installing rgen (0.6.6)
    Installing puppet (3.6.2)
    Installing puppet-lint (1.0.1)
    Installing puppet-syntax (1.3.0)
    Installing rspec-puppet (1.0.1)
    Installing puppetlabs_spec_helper (0.8.1)
    Installing simplecov-html (0.8.0)
    Installing simplecov (0.9.0)
    Using bundler (1.3.6)
    Your bundle is complete!
    It was installed into ./.bundle/gems
    bundle install --path .bundle/gems/  7.74s user 1.99s system 45% cpu 21.569 total

## Run the spec tests

Before starting development of the types or providers, make sure the current
branch is known-good by automatically validating expected behavior against
actual behavior.

    $ bundle exec rspec spec/
    .........................................
    Finished in 2.43 seconds
    1213 examples, 0 failures
    Coverage report generated for Unit Tests to /netdev_stdlib/coverage/. 512 / 519 LOC (98.65%) covered.
    bundle exec rspec spec  3.59s user 0.27s system 99% cpu 3.896 total

## Test Driven Development

If the types are being changed, the spec tests may be automatically run in
response to file system change events using guard.

    $ bundle exec guard
    16:52:13 - INFO - Guard is using Tmux to send notifications.
    16:52:13 - INFO - Guard is using TerminalTitle to send notifications.
    16:52:13 - INFO - Guard::RSpec is running
    16:52:13 - INFO - Inspecting Ruby code style of all files
    16:52:16 - INFO - Guard is now watching at '/netdev_stdlib'
    [1] guard(main)>

# Implementing a provider

For a platform named `foo`, the following section describes how to implement a
module containing providers for the `netdev_stdlib` types.

The basic process for implementing providers for these types are as follows.
First, create a parent directory for use as the module directory.  This parent
directory will contain the `netdev_stdlib` module and the `netdev_stdlib_foo`
module.  For example, `/workspace/netdev/`.

Clone the `netdev_stdlib` into the module directory, for example
`/workspace/netdev/netdev_stdlib` and install dependencies using bundler as
described in Getting Started for Development.

## Generate the Provider Module

With a current working directory of the type module, generate the provider
module using `puppet module generate`:

    $ cd /workspace/netdev/netdev_stdlib/
    $ bundle exec puppet module generate acme-netdev_stdlib_foo
    We need to create a metadata.json file for this module.  Please answer the
    following questions; if the question is not applicable to this module, feel free
    to leave it blank.

    Puppet uses Semantic Versioning (semver.org) to version modules.
    What version is this module?  [0.1.0]
    --> 0.1.0

    Who wrote this module?  [acme]
    --> acme

    What license does this module code fall under?  [Apache 2.0]
    -->

    How would you describe this module in a single sentence?
    --> Acme Foo platform providers for the Network Device Standard Library types

    Where is this module's source code repository?
    --> https://github.com/acme/netdev_stdlib_foo

    Where can others go to learn more about this module?  [https://github.com/acme/netdev_stdlib_foo]
    -->

    Where can others go to file issues about this module?  [https://github.com/acme/netdev_stdlib_foo/issues]
    -->

    ----------------------------------------
    {
      "name": "acme-netdev_stdlib_foo",
      "version": "0.1.0",
      "author": "acme",
      "summary": "Acme Foo platform providers for the Network Device Standard Library types",
      "license": "Apache 2.0",
      "source": "https://github.com/acme/netdev_stdlib_foo",
      "project_page": "https://github.com/acme/netdev_stdlib_foo",
      "issues_url": "https://github.com/acme/netdev_stdlib_foo/issues",
      "dependencies": [
        {
          "name": "puppetlabs-stdlib",
          "version_range": ">= 1.0.0"
        }
      ]
    }
    ----------------------------------------

    About to generate this metadata; continue? [n/Y]

    Notice: Generating module at /workspace/serious/src/modules/netdev/test/netdev_stdlib/acme-netdev_stdlib_foo...
    Notice: Populating ERB templates...
    Finished; module generated in acme-netdev_stdlib_foo.
    acme-netdev_stdlib_foo/manifests
    acme-netdev_stdlib_foo/manifests/init.pp
    acme-netdev_stdlib_foo/metadata.json
    acme-netdev_stdlib_foo/Rakefile
    acme-netdev_stdlib_foo/README.md
    acme-netdev_stdlib_foo/spec
    acme-netdev_stdlib_foo/spec/classes
    acme-netdev_stdlib_foo/spec/classes/init_spec.rb
    acme-netdev_stdlib_foo/spec/spec_helper.rb
    acme-netdev_stdlib_foo/tests
    acme-netdev_stdlib_foo/tests/init.pp

Move the skeleton into the module directory:

    $ mv acme-netdev_stdlib_foo ../netdev_stdlib_foo
    $ cd ../netdev_stdlib_foo

## Express the dependencies

The provider module has the same dependencies as the type module and so it is
easiest to simply copy the dependency information from the `netdev_stdlib`
type.

    $ cp ../netdev_stdlib/{Gem,Guard}file .

Install the dependencies:

    $ bundle install --path .bundle/gems/

## Configure RSpec

Puppet Providers are generally tested with RSpec.  Copy the spec helper, which
initializes RSpec for module testing.

    $ cp ../netdev_stdlib/spec/spec_helper.rb spec/

Remove the rspec-puppet generated example for a puppet class.

    $ rm ./spec/classes/init_spec.rb

Test that rspec runs:

    $ bundle exec rspec spec/
    No examples found.
    Finished in 0.00004 seconds
    0 examples, 0 failures

## Mocking

The device API used by the provider should be modeled as a utility class in
`PuppetX::NetDev::FooApi` class, located at `lib/puppet_x/net_dev/foo_api.rb`.
Instance methods of this API class are suitable for mocking network based API
calls in the spec tests.  For REST API's the response data from the resource
request should be serialized into a fixtures directory.  These fixtures are
therefore able to be updated as API responses are changed or added over time.

For more information on rspec, please see https://github.com/rspec/rspec

# License

Copyright 2014 [Puppet Labs][puppetlabs]

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License.  You may obtain a copy of the
License at

[http://www.apache.org/licenses/LICENSE-2.0][license]

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied.  See the License for the
specific language governing permissions and limitations under the License.

[book]: http://shop.oreilly.com/product/0636920026860.do
[license]: http://www.apache.org/licenses/LICENSE-2.0
[travis]: https://travis-ci.org/puppetlabs/netdev_stdlib/builds
[puppetlabs]: http://puppetlabs.com
[types doc]: https://docs.puppetlabs.com/guides/custom_types.html
[gary provider]: http://garylarizza.com/blog/2013/12/15/seriously-what-is-this-provider-doing/
[crossfader]: http://github.com/puppetlabs/crossfader
[crossfader quick start]: https://github.com/puppetlabs/crossfader#quick-start-install
[rvm]: http://rvm.io/
[rbenv]: https://github.com/sstephenson/rbenv
[pe components]: https://docs.puppetlabs.com/pe/latest/install_what_and_where.html#puppet-enterprise-software-components
[buildstatus]: https://travis-ci.org/puppetlabs/netdev_stdlib.svg?branch=master
