class l2tpns::repo::redhat ( 
  String $yum_repo_ip = '192.168.10.216'
) inherits l2tpns {
  
  yumrepo{ 'l2tpns':
    descr    => 'L2tpns Redhat repo',
    baseurl  => "http://${yum_repo_ip}/RedHat",
    enabled  => '1',
    gpgcheck => '0',
  }
  
}
