cookbook-core
=============

Base cookbook used to do the initial environment setup.

### Used cookbooks

* [apt](http://community.opscode.com/cookbooks/apt)
* [vim](http://community.opscode.com/cookbooks/vim)
* [smbfs](http://community.opscode.com/cookbooks/smbfs)

### Slight setup

This cookbook require the `node[:smbfs][:install]` attribute set to `true` to install and configure `smbfs`.
