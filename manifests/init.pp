# = Class: nginx
#
# This is the main nginx class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, nginx main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $nginx_source
#
# [*source_dir*]
#   If defined, the whole nginx configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $nginx_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true, force => true)
#   Can be defined also by the (top scope) variable $nginx_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, nginx main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $nginx_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $nginx_options
#
# [*service_autorestart*]
#   Automatically restarts the nginx service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $nginx_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $nginx_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $nginx_disableboot
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $nginx_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for nginx port(s)
#   Can be defined also by the (top scope) variables $nginx_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling nginx. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $nginx_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $nginx_firewall_dst
#   and $firewall_dst
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $nginx_audit_only
#   and $audit_only
#
# Default class params - As defined in nginx::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of nginx package
#
# [*service*]
#   The name of nginx service
#
# [*gzip*]
#   Specified the gzip function of nginx 'on' or 'off'. Deault is 'on',
#
# [*worker_connections*]
#   Specified worker connections number. Default is 1024.
#
# [*multi_accept*]
#   Activate or deactivate the usage of multi_accept.
#   Default is on but it is then commented out in the default nginx template.
#
# [*keepalive_timeout*]
#   Specified keepalive timeout. Default is 65(ms).
#
# [*server_names_hash_max_size*]
#   Specified the server_names_hash_max_size. Default is 512
#   Increase this to powers of 2 if you are getting related errors
#
# [*server_names_hash_bucket_size*]
#   Specified the server_names_hash_bucket_size. Default is 64
#   Increase this to powers of 2 if you are getting related errors
#
# [*client_max_body_size*]
#   Specified the max body size of client. Default is 10mb.
#   Increase this param if your nginx is an upload server.
#
# [*sendfile*]
#   Activate or deactivate the usage of sendfile. Default is on.
#
# [*service_status*]
#   If the nginx service init script supports status argument
#
# [*service_restart*]
#   If the nginx service init script supports restart argument. Default is true
#
# [*process*]
#   The name of nginx process
#
# [*process_user*]
#   The name of the user nginx runs with.
#
# [*config_dir*]
#   Main configuration directory.
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*config_file_default_purge*]
#   Set to 'true' to purge the default configuration file
#
# [*pid_file*]
#   Path of pid file.
#
# [*data_dir*]
#   Path of application data directory.
#
# [*log_dir*]
#   Base logs directory.
#
# [*log_file*]
#   Log file(s)
#
# [*port*]
#   The listening port, if any, of the service.
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $nginx_port
#
# [*protocol*]
#   The protocol used by the the service.
#   Can be defined also by the (top scope) variable $nginx_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include nginx"
# - Call nginx as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class nginx (
  $gzip                          = $nginx::params::gzip,
  $worker_connections            = $nginx::params::worker_connections,
  $multi_accept                  = $nginx::params::multi_accept,
  $keepalive_timeout             = $nginx::params::keepalive_timeout,
  $server_names_hash_max_size    = $nginx::params::server_names_hash_max_size,
  $server_names_hash_bucket_size = $nginx::params::server_names_hash_bucket_size,
  $client_max_body_size          = $nginx::params::client_max_body_size,
  $types_hash_max_size           = $nginx::params::types_hash_max_size,
  $sendfile                      = $nginx::params::sendfile,
  $source                        = $nginx::params::source,
  $source_dir                    = $nginx::params::source_dir,
  $source_dir_purge              = $nginx::params::source_dir_purge,
  $template                      = $nginx::params::template,
  $service_autorestart           = $nginx::params::service_autorestart,
  $options                       = $nginx::params::options,
  $version                       = $nginx::params::version,
  $absent                        = $nginx::params::absent,
  $disable                       = $nginx::params::disable,
  $disableboot                   = $nginx::params::disableboot,
  $firewall                      = $nginx::params::firewall,
  $firewall_tool                 = $nginx::params::firewall_tool,
  $firewall_src                  = $nginx::params::firewall_src,
  $firewall_dst                  = $nginx::params::firewall_dst,
  $audit_only                    = $nginx::params::audit_only,
  $package                       = $nginx::params::package,
  $service                       = $nginx::params::service,
  $service_status                = $nginx::params::service_status,
  $service_restart               = $nginx::params::service_restart,
  $process                       = $nginx::params::process,
  $process_user                  = $nginx::params::process_user,
  $config_dir                    = $nginx::params::config_dir,
  $config_file                   = $nginx::params::config_file,
  $config_file_mode              = $nginx::params::config_file_mode,
  $config_file_owner             = $nginx::params::config_file_owner,
  $config_file_group             = $nginx::params::config_file_group,
  $config_file_init              = $nginx::params::config_file_init,
  $config_file_default_purge     = $nginx::params::config_file_default_purg,
  $pid_file                      = $nginx::params::pid_file,
  $data_dir                      = $nginx::params::data_dir,
  $log_dir                       = $nginx::params::log_dir,
  $log_file                      = $nginx::params::log_file,
  $port                          = $nginx::params::port,
  $protocol                      = $nginx::params::protocol,
  ) inherits nginx::params {

  $real_gzip = $gzip ? {
    'off'     => 'off',
    'OFF'     => 'off',
    'ON'      => 'on',
    default   => 'on',
  }

  ### Calculation of variables that dependes on arguments
  # Debian uses TWO configs dirs separatedly
  $cdir = $::operatingsystem ? {
    default => "${config_dir}/conf.d",
  }

  $vdir = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => "${config_dir}/sites-available",
    default                   => "${config_dir}/conf.d",
  }

  $vdir_enable = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => "${config_dir}/sites-enabled",
    default                   => undef,
  }

  ### Definition of some variables used in the module
  $manage_package = $absent ? {
    true  => 'absent',
    false => $version,
  }

  $manage_service_enable = $disableboot ? {
    true    => false,
    default => $disable ? {
      true    => false,
      default => $absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $disable ? {
    true    => 'stopped',
    default =>  $absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $service_autorestart ? {
    true    => "Service[${service}]",
    false   => undef,
  }

  $manage_file = $absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $absent == true or $disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $source ? {
    ''        => undef,
    default   => $source,
  }

  $manage_file_content = $template ? {
    ''        => undef,
    default   => template($template),
  }

  ### Managed resources
  package { "${package}":
    ensure => $manage_package,
  }

  service { $service:
    ensure     => $manage_service_ensure,
    enable     => $manage_service_enable,
    hasstatus  => $service_status,
    hasrestart => $service_restart,
    pattern    => $process,
    require    => Package[$package],
  }

  file { 'nginx.conf':
    ensure  => $manage_file,
    path    => $config_file,
    mode    => $config_file_mode,
    owner   => $config_file_owner,
    group   => $config_file_group,
    require => Package[$package],
    notify  => $manage_service_autorestart,
    source  => $manage_file_source,
    content => $manage_file_content,
    replace => $manage_file_replace,
    audit   => $manage_audit,
  }

  # The whole nginx configuration directory can be recursively overriden
  if $source_dir != '' {
    file { 'nginx.dir':
      ensure  => directory,
      path    => $config_dir,
      require => Package[$package],
      notify  => $manage_service_autorestart,
      source  => $source_dir,
      recurse => true,
      purge   => $source_dir_purge,
      force   => $source_dir_purge,
      replace => $manage_file_replace,
      audit   => $manage_audit,
    }
  }

  # Purge default vhost configuration
  if $config_file_default_purge {
    $default_site = $::operatingsystem ? {
      /(?i:Debian|Ubuntu|Mint)/              => [ 'default' ],
      /(?i:Redhat|Centos|Scientific|Fedora)/ => 'default.conf',
    }

    file { "${vdir}/${default_site}":
      ensure  => absent,
      require => Package[$package],
      notify  => Service[$service],
    }

    if $vdir_enable {
      file { "${vdir_enable}/${default_site}":
        ensure  => absent,
        require => Package[$package],
        notify  => Service[$service],
      }
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $firewall == true {
    firewall { "nginx_${protocol}_${port}":
      source      => $firewall_src,
      destination => $firewall_dst,
      protocol    => $protocol,
      port        => $port,
      action      => 'allow',
      direction   => 'input',
      tool        => $firewall_tool,
      enable      => $manage_firewall,
    }
  }

}
