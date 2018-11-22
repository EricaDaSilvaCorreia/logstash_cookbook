# # encoding: utf-8

# Inspec test for recipe logstash::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe service 'logstash' do
  it {should be_installed}
  it {should be_running}
  it {should be_enabled}
end

describe port(5044) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
  its('processes') { should cmp 'syslog' }
end
