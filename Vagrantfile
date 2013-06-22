# -*- mode: ruby -*-
# vi: set ft=ruby :

class Vagrant::Config::V2::Root
    def has_key?(name)
        @config_map.has_key?(name.to_sym)
    end
end

Vagrant.configure("2") do |config|
    config.vm.box = "debian"
    config.vm.box_url = "https://www.dropbox.com/s/7kxy8ads9pebfmk/debian.box"

    if config.has_key?(:hostmanager)
        config.hostmanager.enabled = true
        config.hostmanager.aliases = %w(stage1)
    end

    config.vm.network :private_network, ip: "192.168.56.101"

    config.vm.network :forwarded_port, guest: 80, host: 8000
    config.vm.network :forwarded_port, guest: 3737, host: 3737
    config.vm.synced_folder '.', '/vagrant/www', :nfs => (RUBY_PLATFORM =~ /linux|darwin/)

    config.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = ['app/Resources/cookbooks', 'app/Resources/site-cookbooks']
        chef.add_recipe "stage1"
    end
end
