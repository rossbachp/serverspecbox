require 'spec_helper'
require 'net/ssh'

##################################################
# sshd
describe package('openssh-server') do
  it { should be_installed }
end

describe file('/etc/supervisor/conf.d/supervisord-sshd.conf') do
  it { should be_file }
end

describe process("sshd") do
  it { should be_running }
  its(:args) { should match /-D/ }
end

describe port(22) do
  it { should be_listening }
end

describe command("netstat -tulpn | grep 22 | head -1 | awk '{ print $NF }'"), sudo => true do
  its(:stdout) { should match /sshd/ }
end

describe "running ssh" do
  before(:all) do
    @ssh = Net::SSH.start(
      '127.0.0.1', 'root',
      :password => "screencast",
      :port => 22,
      :paranoid => false )
  end

  after(:all) do
    @ssh.close
  end

  it "should accept connection to the container sshd port" do
    expect(@ssh.closed?).to be_falsey
  end

  it "should start successfully simple hello" do
    expect(@ssh.exec!("echo -n hello")).to match /hello/
  end
end
