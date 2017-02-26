class l2tpns::config inherits l2tpns{

  file { $l2tpns::config_file:
    ensure  => file,
    content => epp($l2tpns::config_file_template),
  }

}
