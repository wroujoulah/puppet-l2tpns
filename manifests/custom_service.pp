define l2tpns::custom_service (

  $service_name   = $title,
  $service_ensure = running,
  $service_enable = true,

) {

  if ! defined(Class['l2tpns']) {
    fail('You must include the l2tpns base class before using any l2tpns defined resources')
  }

  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
  }

}
