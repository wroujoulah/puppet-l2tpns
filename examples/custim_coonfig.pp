l2tpns::custom_config { '/tmp/l2tpns1':
  bind_address      => '127.0.0.1',
  config_file       => '/tmp/l2tpns1',
  l2tp_port         => 1750,
  log_file          => '/tmp/logfile',
  nsctl_port        => 1751,
  pid_file          => '/var/run/l2tpns2',
  radius_nas_offset => 10000,
}
