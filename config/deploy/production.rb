server '13.112.226.220', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/osuke/.ssh/id_rsa'
