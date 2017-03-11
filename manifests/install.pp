class l2tpns::install inherits l2tpns {

if $l2tpns::package_manage {

    package { $l2tpns::package_name:
      ensure  => $l2tpns::package_ensure,
    }
  }
  
}
