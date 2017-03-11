# l2tpns

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with l2tpns](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with l2tpns](#beginning-with-l2tpns)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)

## Description

This is a Puppet module that manage the installation and the configuration of the L2tpns service for Centos 6. The module will install l2tpns and libcli library if you don't have them, as well as creating startup file and configuration file.

## Setup

### Setup Requirements

L2tpns and libcli packages are not in common repositories so You must have a local repository that contain the require l2tpns version and the libcli library.

### Beginning with l2tpns

`include '::l2tpns'` is enough to get you up and running. To pass in parameters specifying which servers to use:

	class { '::l2tpns':
  	  l2tp_port => 1701,
	}

## Usage

All parameters for the l2tpns module are contained within the main ::l2tpns class, so for any function of the module, set the options you want. See the common usages below for examples.

#### install and enable L2tpns

	include '::l2tpns'

#### Change the l2tp and the nsctl port

	class { '::l2tpns':
	  l2tp_port  => 1800,
	  nsctl_port => 1802,
	}

#### Setting the primary radius ipaddress, port and secret key
	
	class { '::l2tpns':
	  primary_radius      => 127.0.0.1,
	  primary_radius_port => 1812,
	  radius_secret       => "secret",  
	}

#### Setting the authentications types

        class { '::l2tpns':
          radius_authtypes => "pap, chap",
        }

## Reference

### Classes

#### Public classes

    l2tpns: Main class, includes all other classes.

#### Private classes

    l2tpns::install: Handles the packages.
    l2tpns::config: Handles the configuration file.
    l2tpns::service: Handles the service.

### Parameters

The following parameters are available in the `::l2tpns` class:

##### `debug` (int)

Sets the level of messages that will be written to the log file. The value should be between 0 and 5, with 0 being no debugging, and 5 being the highest. A rough description of the levels is:

0: Critical Errors
Things are probably broken
    
1: Errors
Things might have gone wrong, but probably will recover

2: Warnings
Just in case you care what is not quite perfect 

3: Information
Parameters of control packets

4: Calls
For tracing the execution of the code

5: Packets
Everything, including a hex dump of all packets processed... probably twice 

Note that the higher you set the debugging level, the slower the program will run. Also, at level 5 a lot of information will be logged. This should only ever be used for working out why it doesn't work at all. 

##### `log_file` (string)

This will be where all logging and debugging information is written to. This may be either a filename, such as /var/log/l2tpns, or the special magic string syslog:facility, where facility is any one of the syslog logging facilities, such as local5. 

##### `pid_file` (string)

If set, the process id will be written to the specified file. The value must be an absolute path. 

##### `random_device` (string)

Path to random data source (default /dev/urandom). Use "" to use the rand() library function. 

##### `l2tp_secret` (string)

The secret used by l2tpns for authenticating tunnel request. Must be the same as the LAC, or authentication will fail. Only actually be used if the LAC requests authentication. 

##### `l2tp_mtu` (int)

MTU of interface for L2TP traffic (default: 1500). Used to set link MRU and adjust TCP MSS. 

##### `ppp_restart_time` (int), `ppp_max_configure` (int), `ppp_max_failure` (int)

PPP counter and timer values, as described in §4.1 of RFC1661. 

##### `primary_dns` (ip address), `secondary_dns` (ip address)

Whenever a PPP connection is established, DNS servers will be sent to the user, both a primary and a secondary. If either is set to 0.0.0.0, then that one will not be sent. 

##### `primary_radius` (ip address), `secondary_radius` (ip address)

Sets the RADIUS servers used for both authentication and accounting. If the primary server does not respond, then the secondary RADIUS server will be tried.
Note:
In addition to the source IP address and identifier, the RADIUS server must include the source port when detecting duplicates to supress (in order to cope with a large number of sessions comming on-line simultaneously l2tpns uses a set of udp sockets, each with a seperate identifier).

##### `primary_radius_port` (short), `secondary_radius_port` (short)

Sets the authentication ports for the primary and secondary RADIUS servers. The accounting port is one more than the authentication port. If no RADIUS ports are given, the authentication port defaults to 1645, and the accounting port to 1646. 

##### `radius_accounting` (boolean)

If set to true, then RADIUS accounting packets will be sent. This means that a Start record will be sent when the session is successfully authenticated, and a Stop record will be sent when the session is closed. 

##### `radius_interim` (int)

If radius_accounting is on, defines the interval between sending of RADIUS interim accounting records (in seconds). 

##### `radius_secret` (string)

This secret will be used in all RADIUS queries. If this is not set then RADIUS queries will fail. 

##### `radius_authtypes` (string)

A comma separated list of supported RADIUS authentication methods (pap or chap), in order of preference (default pap). 

##### `radius_bind_min` (short), `radius_bind_max` (short)

Define a port range in which to bind sockets used to send and receive RADIUS packets. Must be at least RADIUS_FDS (64) wide. Simplifies firewalling of RADIUS ports (default: dynamically assigned). 

##### `radius_dae_port` (short)

Port for DAE RADIUS (Packet of Death/Disconnect, Change of Authorization) requests (default: 3799). 

##### `allow_duplicate_users` (boolean)

Allow multiple logins with the same username. If false (the default), any prior session with the same username will be dropped when a new session is established. 

##### `guest_account` (string)

Allow multiple logins matching this specific username. 

##### `bind_address` (ip address)

When the tun interface is created, it is assigned the address specified here. If no address is given, 1.1.1.1 is used. Packets containing user traffic should be routed via this address if given, otherwise the primary address of the machine. 

##### `peer_address` (ip address)

Address to send to clients as the default gateway.

##### `send_garp` (boolean)

Determines whether or not to send a gratuitous ARP for the bind_address when the server is ready to handle traffic (default: true). This value is ignored if BGP is configured. 

##### `throttle_speed` (int)

Sets the default speed (in kbits/s) which sessions will be limited to. If this is set to 0, then throttling will not be used at all. Note: You can set this by the CLI, but changes will not affect currently connected users. 

##### `throttle_buckets` (int)

Number of token buckets to allocate for throttling. Each throttled session requires two buckets (in and out). 

##### `accounting_dir` (string)

If set to a directory, then every 5 minutes the current usage for every connected use will be dumped to a file in this directory. Each file dumped begins with a header, where each line is prefixed by #. Following the header is a single line for every connected user, fields separated by a space.

The fields are username, ip, qos, uptxoctets, downrxoctets. The qos field is 1 if a standard user, and 2 if the user is throttled. 

##### `dump_speed` (boolean)

If set to true, then the current bandwidth utilization will be logged every second. Even if this is disabled, you can see this information by running the uptime command on the CLI. 

##### `multi_read_count` (int)

Number of packets to read off each of the UDP and TUN fds when returned as readable by select (default: 10). Avoids incurring the unnecessary system call overhead of select on busy servers. 

##### `scheduler_fifo` (boolean)

Sets the scheduling policy for the l2tpns process to SCHED_FIFO. This causes the kernel to immediately preempt any currently running SCHED_OTHER (normal) process in favour of l2tpns when it becomes runnable. Ignored on uniprocessor systems. 

##### `lock_pages` (boolean)

Keep all pages mapped by the l2tpns process in memory. 

##### `icmp_rate` (int)

Maximum number of host unreachable ICMP packets to send per second. 

##### `packet_limit` (int)

Maximum number of packets of downstream traffic to be handled each tenth of a second per session. If zero, no limit is applied (default: 0). Intended as a DoS prevention mechanism and not a general throttling control (packets are dropped, not queued). 

##### `cluster_address` (ip address)

Multicast cluster address (default: 239.192.13.13). See the section called “Clustering” for more information. 

##### `cluster_interface` (string)

Interface for cluster packets (default: eth0)

##### `cluster_mcast_ttl` (int)

TTL for multicast packets (default: 1).

##### `cluster_hb_interval` (int)

Interval in tenths of a second between cluster heartbeat/pings. 

##### `cluster_hb_timeout` (int)

Cluster heartbeat timeout in tenths of a second. A new master will be elected when this interval has been passed without seeing a heartbeat from the master. 

##### `cluster_master_min_adv` (int)

Determines the minumum number of up to date slaves required before the master will drop routes (default: 1). 

##### `ipv6_prefix` (ipv6 address)

Enable negotiation of IPv6. This forms the the first 64 bits of the client allocated address. The remaining 64 come from the allocated IPv4 address and 4 bytes of 0s. 


## Limitations

This module is only support CentOS 6.x right now, and You need to have the right packages for l2tpns and libcli in a private repository because this packages are not in common repositories.


## Release Notes/Contributors/Etc. **Optional**

This is a beat version
