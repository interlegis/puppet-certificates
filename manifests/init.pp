#init.pp

class certificates ( $certificates = {},
                     $keys = {},
                    ) {
  validate_hash($certificates)
  create_resources(certificates::certificate,$certificates)
  validate_hash($keys)
  create_resources(certificates::key,$keys)
}
