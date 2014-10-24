##################################################
# supervisor
describe package('supervisor') do
  it { should be_installed }
end

describe file('/etc/supervisor/conf.d/supervisord-base.conf') do
  it { should be_file }
end

describe process("supervisord") do
  it { should be_running }
  its(:args) { should match /\/usr\/bin\/supervisord/ }
end

describe port(9001) do
  it { should be_listening }
end

describe command("netstat -tulpn | grep 9001 | head -1 | awk '{ print $NF }'"), sudo => true do
  its(:stdout) { should match /supervisord/ }
end
