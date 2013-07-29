# == Class: youcompleteme
#
# This class is responsible for installing the vim plugin YouCompleteMe.
#
# == Parameters
#
# [*pluginpath*]
#   Path to the plugin.
#   Defaults to "/home/${id}/.vim/bundle/YouCompleteMe"
#
# === Examples
#
#  vcsrepo { "/home/jivago/code/YouCompleteMe":
#    ensure   => present,
#    provider => git,
#    source   => 'https://github.com/Valloric/YouCompleteMe.git',
#    revision => 'master'
#  }
#
#  class { 'youcompleteme':
#    pluginpath => "/home/jivago/code/YouCompleteMe"
#  }
#
class youcompleteme ($pluginpath = "/home/${id}/.vim/bundle/YouCompleteMe") {
  $homedir  = "/home/${id}"

  file { $pluginpath:
    ensure => directory
  }

  file { "${homedir}/ycm_build":
    ensure  => directory,
    require => File[$pluginpath]
  }

  exec { 'makefiles-ycm':
    path    => '/usr/bin:/usr/sbin:/bin',
    command => "cd ${homedir}/ycm_build && cmake -G \"Unix Makefiles\" . $pluginpath/cpp",
    require => File["${homedir}/ycm_build"]
  }

  exec { 'make-ycm_core':
    path    => '/usr/bin:/usr/sbin:/bin',
    command => 'make ycm_core',
    require => Exec['makefiles-ycm']
  }
}
