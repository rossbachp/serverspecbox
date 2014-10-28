require 'serverspec'
set :backend, :exec
describe docker_image("rossbachp/tomcat:8") do
  it { should exist }
end
describe docker_image("rossbachp/tomcat:8") do
  its(['Config.Cmd']) { should include '/opt/tomcat/bin/catalina.sh' }
end
