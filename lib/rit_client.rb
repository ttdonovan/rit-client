require 'pathname'

dir = Pathname(__FILE__).dirname.expand_path

require dir + 'rit_client/errors'
require dir + 'rit_client/configuration'
require dir + 'rit_client/plate'
require dir + 'rit_client/rit_plate'

module RitClient
end