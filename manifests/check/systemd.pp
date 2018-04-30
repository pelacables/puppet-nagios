define nagios::check::systemd (
  $ensure                   = getvar('::nagios_check_systemctl_ensure'),
  $args                     = $name,
  $check_period             = $::nagios::client::service_check_period,
  $contact_groups           = $::nagios::client::service_contact_groups,
  $first_notification_delay = $::nagios::client::service_first_notification_delay,
  $max_check_attempts       = $::nagios::client::service_max_check_attempts,
  $notification_period      = $::nagios::client::service_notification_period,
  $use                      = $::nagios::client::service_use,
) {

  # Service specific script, taken from:
  file { "${nagios::client::plugin_dir}/check_systemd":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/plugins/check_systemd"),
  }

  nagios::client::nrpe_file { "check_systemd_${title}":
    ensure => $ensure,
    plugin => 'check_systemd',
    args   => $args,
  }

  nagios::service { "check_systemd_${title}_${::nagios::client::host_name}":
    ensure                   => $ensure,
    check_command            => "check_nrpe_systemctl_${title}",
    service_description      => "systemctl_${title}",
    servicegroups            => $servicegroups,
    check_period             => $check_period,
    contact_groups           => $contact_groups,
    first_notification_delay => $first_notification_delay,
    max_check_attempts       => $max_check_attempts,
    notification_period      => $notification_period,
    use                      => $use,
  }

}
