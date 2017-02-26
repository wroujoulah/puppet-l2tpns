class l2tpns::install inherits l2tpns {

if $l2tpns::package_manage {

    package { $l2tpns::package_name:
      ensure  => $l2tpns::package_ensure,
    }
    file { $l2tpns::init_script_file:
      ensure  => 'file',
      require => [ Package[$l2tpns::package_name] ],
      mode    => '0755',
      content => epp($l2tpns::init_script_template),
    }
  }
  
}
