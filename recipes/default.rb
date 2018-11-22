#
# Cookbook:: logstash
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_update 'update_sources' do
  action :update
end

package 'default-jre'

execute 'elasticsearch key' do
  command 'wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -'
end

execute 'place url in sources list' do
  command 'echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list'
end

execute "update" do
  command 'sudo apt-get update'
end

execute "install logstash" do
  command 'apt-get install logstash -y'
end


service "logstash" do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

template '/etc/logstash/jvm.options' do
  source 'jvm.options.erb'
  notifies :restart, 'service[logstash]'
end

template '/etc/logstash/conf.d/syslog.conf' do
  source 'syslog.conf.erb'
  notifies :restart, 'service[logstash]'
end
