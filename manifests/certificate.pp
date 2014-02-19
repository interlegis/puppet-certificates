#certificate.pp

define certificate ( $ensure = present,
                     $source = false,
                     $content = '',
                     $ca_certificate = false,
                     $target = '/etc/ssl/certs'
                     ) {

  if $ca_certificate {
    $target = '/usr/share/ca-certificates'
  }

  if $source {
    file { "$target/$name.crt":
      ensure => $ensure,
      owner => root, group => root, mode => "644",
      source => $source,
    }
  } else {
    if $content != '' {
      file { "$target/$name.crt":
        ensure => $ensure,
        owner => root, group => root, mode => "644",
        content => $content,
      }
    } else {
      fail('You must define source or content variables.')
    }
  } 

  if $ca_certificate {
    line {"$name.crt":
      ensure => $ensure,
      file => "/etc/ca-certificates.conf",
      line => "$name.crt",
    }
   
    exec { "update-ca-certificate $name":
      command => "/usr/sbin/update-ca-certificates",
      subscribe => [  File["$target/$name.crt"],
                      Line["$name.crt"],
                   ],
      refreshonly => true,
    }
  }
}
