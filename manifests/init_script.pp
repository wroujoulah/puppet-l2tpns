class l2tpns::init_script inherits l2tpns {

  file { $l2tpns::init_script_file:
    ensure  => 'file',
    require => [ Package[$l2tpns::package_name] ],
    mode    => '0755',
    content => epp($l2tpns::init_script_template),
  }


}
