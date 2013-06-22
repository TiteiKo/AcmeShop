default['mysql']['server_debian_password'] = 'passroot'
default['mysql']['server_root_password'] = 'passroot'
default['mysql']['server_repl_password'] = 'passroot'

default['nginx']['default_site_enabled'] = false;

default['php']['packages'] = ['php5-fpm', 'php5-cli', 'php5-mysqlnd', 'php5-redis']

default['vim']['extra_packages'] = []