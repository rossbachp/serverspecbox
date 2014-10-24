require "spec_helper"

describe "openjdk_jre image" do

  before(:all) do
    @image = Docker::Image.all().detect{
      |image| image.info['RepoTags'].detect{
        |tag| tag == "bee42/openjdk-jre7:latest"
      }
    }
  end

  it "should exist" do
    expect(@image).not_to be_nil
  end

  it "should have CMD" do
    expect(@image.json["Config"]["Cmd"]).to match_array ["/bin/bash"]
  end

  it "should have working directory" do
    expect(@image.json["Config"]["WorkingDir"]).to eq("/home/javadev")
  end

  it "should have environmental variable" do
    expect(@image.json["Config"]["Env"]).to      include("JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64")
  end


# next step
#it "should expose the default tcp port" do
#		expect(@image.json["Config"]["ExposedPorts"]).to include("8080/tcp")
#end

end

describe "running java" do

  before(:all) do
    @container = Docker::Container.create(
      'Image' => 'bee42/openjdk-jre7:latest',
      'Cmd' => ['java', '-version'],
      'Tty' => true)
  end

  after(:all) do
    @container.kill
    @container.delete(:force => true)
  end

  # java version "1.7.0_65"
  # OpenJDK Runtime Environment (IcedTea 2.5.2) (7u65-2.5.2-3~14.04)
  # OpenJDK 64-Bit Server VM (build 24.65-b04, mixed mode)
  it "is right java version expected" do
    arr = Array.new
    @container.tap(&:start).attach(:tty => true){|line|
      line.gsub!(/\r\n?/, "\n")
      line.each_line do |value|
        if value.end_with?("\n")
          value = value.chop
        end
        if ! value.empty?
          arr << value
        end
      end
    }
    expect(arr[0]).to include("1.7.0_65")
    expect(arr[1]).to include("OpenJDK")
    expect(arr[2]).to include("64-Bit")
  end

end
