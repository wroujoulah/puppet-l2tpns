class l2tpns::service inherits l2tpns {

  service { $l2tpns::service_name:
    ensure => $l2tpns::service_ensure,
    enable => $l2tpns::service_enable,
    require => File[$l2tpns::init_script_file]
  }

}
