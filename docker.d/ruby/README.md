
## Vorgehen
  * serverspec spec Screiben

Gemfile
```ruby
source 'https://rubygems.org'
ruby '2.1.2'

gem 'serverspec', '~> 2'
```

```/bin/bash
$ bundle install --path
$ bundle exec serverspec-init
Select OS type:

  1) UN*X
  2) Windows

Select number: 1

Select a backend type:

  1) SSH
  2) Exec (local)

Select number: 2

 + spec/
 + spec/localhost/
 + spec/localhost/sample_spec.rb
 + spec/spec_helper.rb
 + Rakefile
 + .rspec

$ rm spec/localhost/sample_spec.rb
$ vi spec/localhost/service_spec.rb
$ bundle exec rake spec
/usr/local/bin/ruby -I/home/saphir/specs/vendor/ruby/2.1.0/gems/rspec-core-3.1.5/lib:/home/saphir/specs/vendor/ruby/2.1.0/gems/rspec-support-3.1.1/lib /home/saphir/specs/vendor/ruby/2.1.0/gems/rspec-core-3.1.5/exe/rspec --pattern spec/localhost/\*_spec.rb

Port "4444"
  should be listening

Port "22"
  should be listening

Port "9001"
  should be listening

Finished in 0.26438 seconds (files took 0.24736 seconds to load)
3 examples, 0 failures
```

**service_spec.rb**
```ruby
require 'spec_helper'

describe port(9001) do
	it { should be_listening }
end
describe port(22) do
	it { should be_listening }
end
describe port(4444) do
  it { should be_listening }
end

describe file('/etc/supervisor/conf.d/supervisord-base.conf') do
  it { should be_file }
end

describe file('/etc/supervisor/conf.d/supervisord-sshd.conf') do
  it { should be_file }
end

describe file('/etc/supervisor/conf.d/supervisord-docker.conf') do
  it { should be_file }
end
```



More docker tests
```ruby
	it "should expose the default port" do
		expect(@image.json["config"]["ExposedPorts"].has_key?("80/tcp")).to be_true
	end

	it "should have CMD" do
		expect(@image.json["config"]["Cmd"]).to include("/bin/bash")
	end

	it "should have working directory" do
		expect(@image.json["config"]["WorkingDir"]).to eq("/home/saphir")
	end

	it "should have environmental variable" do
		expect(@image.json["config"]["Env"]).to include("PORT=test")
	end
```

## ToDo
  * Anlage eines neuen ruby dev user (FIXET)
	* Neuer User muss docker commands ausführen können.
		export DOCKER_HOST=tcp://127.0.0.1:4444
	* Teste den neuen Build

## Interessante Checks

Prüfe ob den richtige Prozess einen Port nutzt

```bash
$ sudo netstat -tulpn | grep 22 | head -1 | awk '{ print $NF }'`
11/sshd
```

```
$ sudo fuser -v -n tcp 22
                     USER        PID ACCESS COMMAND
22/tcp:              root         11 F.... sshd
                     root        282 F.... sshd

```

[Find Out Which Process Is Listening Upon a Port](http://www.cyberciti.biz/faq/what-process-has-open-linux-port/)
[fuser](https://www.digitalocean.com/community/tutorials/how-to-use-the-linux-fuser-command)

Setup correct vi keybinding
`echo ":set term=ansi" >>~saphir/.vimrc`

Find linux packages for commands like fuser [atp-find](http://bitflop.com/tutorials/what-package-does-that-file-belong-to.html)

Viel Spaß
Peter


## Links

  * [Andreas Schmidt nsenter/serverspec 1.x ](https://gist.github.com/aschmidt75/bb38d971e4f47172e2de)
  * [serverspec nsenter infrabricks Blog](http://www.infrabricks.de/blog/2014/09/10/docker-container-mit-serverspec-testen/)
