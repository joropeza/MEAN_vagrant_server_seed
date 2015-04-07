import 'clone.pp'

class apt_update {
    exec { "aptGetUpdate":
        command => "sudo apt-get update",
        path => ["/bin", "/usr/bin"]
    }
}

class othertools { 
	package { "git": 
	ensure => latest, 
	require => Exec["aptGetUpdate"] 
	} 
	package { "vim-common": 
	ensure => latest, 
	require => Exec["aptGetUpdate"] 
	} 
	package { "curl": 
	ensure => present, 
	require => Exec["aptGetUpdate"] 
	} 
	package { "htop": 
	ensure => present, 
	require => Exec["aptGetUpdate"] 
	} 
	package { "g++": 
	ensure => present, 
	require => Exec["aptGetUpdate"] 
	} 
} 

class mongodb { 
	class {'::mongodb::globals': 
		manage_package_repo => true, 
		bind_ip => ["127.0.0.1"], 
		}-> 
	class {'::mongodb::server': 
		port => 27017, 
		verbose => true, 
		ensure => "present"
		}-> 
	class {'::mongodb::client': } 
} 

class { 'nodejs':
  version => 'v0.12.2',
}

package { 'nodemon':
  provider => 'npm',
  require  => Class['nodejs']
}

# class git {
#         class { git::clone: 
# 			repo => 'MEAN_seed_with_passport_auth'
#  		}
# }

vcsrepo { "/home/testing":
  ensure => present,
  provider => git,
  source => 'https://github.com/joropeza/startupOrDieWeb.git',
  user => 'joropeza'
  revision => 'master',
  identity => '/home/vagrant/.ssh/id_rsa',
}


include apt_update
include othertools
include mongodb
