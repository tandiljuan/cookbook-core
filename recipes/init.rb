#
# Cookbook Name:: cookbook-core
# Recipe:: init
#
# Author:: Juan Manuel Lopez
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

# Update and Autoremove without being prompted
# Make sure it does execute at compile time
# @see http://stackoverflow.com/a/22424084
# @see http://stackoverflow.com/a/9250482
execute "apt-get update & autoremove" do
  command <<-SHELL
    DEBIAN_FRONTEND=noninteractive apt-get --force-yes update --fix-missing
    DEBIAN_FRONTEND=noninteractive apt-get --force-yes autoremove
  SHELL
  ignore_failure true
  action :nothing
  only_if do
    not ::File.exists?('/var/lib/apt/periodic/update-success-stamp') or
    ::File.mtime('/var/lib/apt/periodic/update-success-stamp') < ::Time.now - 86400
  end
end.run_action(:run)

# Upgrade without being prompted
# Make sure it does execute at compile time
# @see http://serverfault.com/a/482740
execute "apt-get upgrade" do
  command <<-SHELL
    DEBIAN_FRONTEND=noninteractive apt-get --force-yes -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade
  SHELL
  ignore_failure true
  action :nothing
  only_if "if [ `/usr/lib/update-notifier/apt-check 2>&1 | cut -d ';' -f 1` -gt 0 -o `/usr/lib/update-notifier/apt-check 2>&1 | cut -d ';' -f 2` -gt 0 ]; then exit 0; else exit 1; fi"
end.run_action(:run)

# Ensure that the build-essential recipe is the first one to be executed.
include_recipe 'build-essential::default'

include_recipe "apt"
include_recipe "vim"

