l2tpns::custom_init_script {'l2tpns5':
  init_script_file => '/etc/init.d/l2tpns5',
  telnet_port      => 2010,
  config_file      => '/tmp/l2tpns1',
  subsys_file      => '/var/lock/subsys/l2tpns2',
}
