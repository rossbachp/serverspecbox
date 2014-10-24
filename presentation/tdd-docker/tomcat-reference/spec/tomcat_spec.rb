require 'docker'
require 'net/http'

describe "apache tomcat8 image" do
    before(:all) {
        @image = Docker::Image.all().detect{|i| i.info['RepoTags'].detect{|r| r == "bee42/tomcat8:latest"}}
    }

    it "should be availble" do
        expect(@image).to_not be_nil
    end

    it "should expose the default tomcat tcp port" do
       expect(@image.json["Config"]["ExposedPorts"]).to include("8080/tcp")
    end
end

describe "running java" do
    before(:all) {
      @container = Docker::Container.create(
         'Image' => 'bee42/tomcat8:latest',
         'Cmd' => ['java', '-version'],
         'Tty' => true)
    }

    after(:all) do
        @container.kill
        @container.delete(:force => true)
    end

    it "is java expected" do

      expect(@container.tap(&:start).attach(:tty => true)[0][0]).to include( "1.7.0_65")
    end

end

describe "check tomcat version" do
    before(:all) {
      @container = Docker::Container.create(
            'Image' => 'bee42/tomcat8:latest',
            'Cmd' => '/opt/tomcat/bin/version.sh',
            'Tty' => true)
    }

    after(:all) do
        @container.kill
        @container.delete(:force => true)
    end

    it "is tomcat expected" do

      expect(@container.tap(&:start).attach(:tty => true)[0][2]).to include( "Apache Tomcat/8.0.14")
    end

end

describe "running tomcat as a container" do

    before(:all) do
        id = `docker run -d -p 8080:8080 bee42/tomcat8 /opt/tomcat/bin/catalina.sh run`.chomp
        @container = Docker::Container.get(id)
        sleep 3
        uri = URI('http://127.0.0.1:8080/index.jsp')
        @res = Net::HTTP.get_response(uri)

    end

    after(:all) do
        @container.kill
    end

    it "should accept connection to the container tomcat port" do
        expect(@res.code).to match '200'
    end

end
