# For RubyGems that include native C extensions it is needed to do
# the following.
default['build-essential']['compile_time'] = true

# Vagrant Settings
default[:vagrant][:workspace_path] = '/opt/vboxsf/workspace'
default[:vagrant][:workspace_nfs_path] = '/opt/nfs/workspace'

# Core settings
default[:core][:user]           = "vagrant"
default[:core][:group]          = "vagrant"
default[:core][:workspace_path] = '/opt/workspace'
default[:core][:project_path]   = node[:core][:workspace_path]
default[:core][:project_name]   = "Core"

# SAMBA Settings
default[:smbfs][:install] = false
