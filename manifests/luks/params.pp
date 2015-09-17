# == Class: sys::luks::params
#
# Platform-dependent parameters for LUKS.
#
class sys::luks::params {
  case $::osfamily {
    debian: {
      $package = 'cryptsetup'
    }
    redhat: {
      $package = 'cryptsetup'
    }
    default: {
      fail("Do not know how to install LUKS on ${::osfamily}.\n")
    }
  }
}
