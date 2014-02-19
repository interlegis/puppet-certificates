#init.pp

class certificates ( $certificates = {},
                     $keys = {},
                    ) {
  validate_hash($certificates)
  create_resources(certificate,$certificates)
  validate_hash($keys)
  create_resources(key,$keys)
}
