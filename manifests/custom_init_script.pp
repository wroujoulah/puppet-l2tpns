define l2tpns::custom_init_script (

  String $package_name = $::l2tpns::package_name,
  String $init_script_template = 'l2tpns/l2tpns.erb',
  Stdlib::Absolutepath $init_script_file = $title,
  Integer $telnet_port,
  Stdlib::Absolutepath $config_file,
  Stdlib::Absolutepath $subsys_file,
  $core_id = undef,

) {
      
  if ! defined(Class['l2tpns']) {
    fail('You must include the l2tpns base class before using any l2tpns defined resources')
  }
  file { $init_script_file:
      ensure  => 'file',
      require => [ Package[$package_name] , L2tpns::Custom_config[$config_file]],
      mode    => '0755',
      content => template($init_script_template),
    }

}
