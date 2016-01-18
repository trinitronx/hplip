name             'hplip'
maintainer       'James Cuzella'
maintainer_email 'james.cuzella@lyraphase.com'
license          'gplv3'
description      'Installs/Configures hplip'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

provides 'hplip::default'
recipe 'hplip::default', 'Installs HP Linux Imaging and Printing drivers'
attribute 'hplip/version',
  :display_name => 'HPLIP Version',
  :description => 'The version of HPLIP drivers to install.  For full list of available versions, see: http://sourceforge.net/projects/hplip/files/hplip/',
  :type => 'string',
  :required => 'optional',
  :recipes => [ 'hplip::default' ],
  :default => "3.14.6"
attribute 'hplip/download_url',
  :display_name => 'HPLIP Download URL',
  :description => 'The URL for HPLIP drivers to install.',
  :type => 'string',
  :required => 'optional',
  :recipes => [ 'hplip::default' ],
  :default => "http://prdownloads.sourceforge.net/hplip/hplip-#{node['hplip']['version']}.run"
attribute 'hplip/digital_certificate_url',
  :display_name => 'HPLIP Digital Certificate URL',
  :description => 'The URL for the GPG signature of the HPLIP drivers to install. Used to cryptographically validate the downloaded drivers.',
  :type => 'string',
  :required => 'optional',
  :recipes => [ 'hplip::default' ],
  :default => "http://prdownloads.sourceforge.net/hplip/hplip-#{node['hplip']['version']}.run.asc"
