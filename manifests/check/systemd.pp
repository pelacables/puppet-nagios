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



  nagios::service { "check_systemd_${title}_${::nagios::client::host_name}":
    ensure                   => $ensure,
    check_command            => "check_systemd_service!${args}",
    service_description      => "${title}_systemctl",
    servicegroups            => $servicegroups,
    check_period             => $check_period,
    contact_groups           => $contact_groups,
    first_notification_delay => $first_notification_delay,
    max_check_attempts       => $max_check_attempts,
    notification_period      => $notification_period,
    use                      => $use,
  }

}
