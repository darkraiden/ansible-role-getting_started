require 'spec_helper'

if os[:family] == 'ubuntu'
  describe '/etc/apache2/sites-enabled/' do
    it { should_not be_empty }
  end

#Test the apache vhost
  describe file("/etc/apache2/sites-enabled/test.conf") do
    it { should contain("<VirtualHost *:80>") }
    it { should be_linked_to "../sites-available/test.conf" }
  end
end

#Check if anything is listening to port 80
describe port(80) do
  it { should be_listening }
end
describe port(8080) do
  it { should_not be_listening }
end

#Check index.html content
describe file("/var/www/test/index.html") do
  it { should contain("test") }
  it { should contain("<h1>This Is My First Role</h1>") }
end
