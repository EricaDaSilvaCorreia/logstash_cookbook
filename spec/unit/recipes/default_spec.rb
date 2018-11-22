#
# Cookbook:: logstash
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'logstash::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it "runs apt get update" do
      expect(chef_run).to update_apt_update 'update_sources'
    end

    it "should install defaul-jre" do
      expect(chef_run).to install_package 'default-jre'
    end

    it "should install logstash" do
      expect(chef_run).to install_package 'logstash'
    end

    it "should create template jvm.options in etc/logstash/" do
      expect(chef_run).to create_template('/etc/logstash/jvm.options')
    end

    it "should create template syslog.conf in etc/logstash/conf.d/" do
      expect(chef_run).to create_template('/etc/logstash/conf.d/syslog.conf')
    end
  end
end
