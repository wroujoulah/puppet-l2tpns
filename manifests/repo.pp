class l2tpns::repo {
  
   $msg_no_repo = "No repo available for ${::osfamily}/${::operatingsystem}"
   case $::osfamily {
    'RedHat': {
      contain '::l2tpns::repo::redhat'
    }
    default: {
      fail($msg_no_repo)
    }
  }
}
