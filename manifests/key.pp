#key.pp

define key ( $ensure = present,
             $source = false,
             $content = '',
	     $owner = 'root',
             $target = '/etc/ssl/private'
           ) {

  if $source {
    file { "$target/$name.key":
      ensure => $ensure,
      owner => $owner, 
      group => root, 
      mode => "440",
      source => $source,
    }
  } else {
    if $content != '' {
      file { "$target/$name.key":
        ensure => $ensure,
        owner => $owner, 
        group => root, 
        mode => "440",
        content => $content,
      }
    } else {
      fail('You must define source or content variables.')
    }
  } 

}
