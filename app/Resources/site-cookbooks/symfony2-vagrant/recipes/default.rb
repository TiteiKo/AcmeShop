#
# Author::  Geoffrey Bachelet (<geoffrey.bachelet@gmail.com>)
# Cookbook Name:: rainforest
# Recipe:: rainforest
#
# Copyright 2013, Geoffrey Bachelet
#

include_recipe "dotdeb"
include_recipe "nginx"
include_recipe "php::package"
include_recipe "mysql::server"
include_recipe "database::mysql"
include_recipe "rabbitmq"
include_recipe "git"
include_recipe "vim"
include_recipe "redis"

['fpm', 'cli'].each do |sapi|
  cookbook_file "/etc/php5/#{sapi}/php.ini" do
    source "php.ini"
    owner "root"
    group "root"
    mode 00644
  end
end

service 'php5-fpm' do
  supports :status => true, :restart => true, :reload => true
  action :restart
end

cookbook_file "#{node['nginx']['dir']}/sites-available/symfony2" do
  source "nginx-symfony2"
  owner "root"
  group "root"
  mode 00644
end

nginx_site 'symfony2' do
  enable true
end

mysql_database 'symfony2' do
    connection ({ :host => 'localhost', :username => 'root', :password => node['mysql']['server_root_password'] })
    action :create
end

execute "installing composer" do
  command 'curl -sS https://getcomposer.org/installer | sudo php && sudo mv composer.phar composer'
  cwd '/usr/local/bin'
  creates '/usr/local/bin/composer'
end

cookbook_file "/vagrant/www/app/config/parameters.yml" do
  source 'parameters.yml'
end

execute "composer install" do
  command 'composer install'
  cwd '/vagrant/www'
  creates '/vagrant/www/vendor/autoload.php'
end

execute "doctrine:schema:update" do
  command "/vagrant/www/app/console doctrine:schema:update --force"
end

execute "cache:clear" do
    command "/vagrant/www/app/console cache:clear"
end

execute "assetic:dump" do
  command "/vagrant/www/app/console assetic:dump"
end
