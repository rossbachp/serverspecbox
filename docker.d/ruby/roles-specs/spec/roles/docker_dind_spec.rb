require 'spec_helper'

##################################################
# docker
describe group('docker') do
  it { should exist }
end

describe group('saphir') do
  it { should exist }
end

describe package('lxc-docker') do
  it { should be_installed }
end

describe file('/etc/supervisor/conf.d/supervisord-docker.conf') do
  it { should be_file }
end

describe file('/usr/local/bin/wrapdocker') do
  it { should be_executable.by('owner') }
  it { should be_executable.by('group') }
  it { should be_executable.by('others') }
end

describe process("docker") do
  it { should be_running }
  its(:args) { should match /-d -H 0.0.0.0:4444/ }
end

describe port(4444) do
  it { should be_listening }
end

describe command("netstat -tulpn | grep 4444 | head -1 | awk '{ print $NF }'"), sudo => true do
  its(:stdout) { should match /docker/ }
end
