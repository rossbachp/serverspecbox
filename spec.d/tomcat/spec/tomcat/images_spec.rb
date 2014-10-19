require 'docker'
describe "apache tomcat8 image" do
    before(:all) {
        @image = Docker::Image.all().
        detect{|i| i.info['RepoTags'].
        detect{|r| r == "rossbachp/tomcat:8"}}
    }
    it "should be available" do
        expect(@image).to_not be_nil
    end
end
