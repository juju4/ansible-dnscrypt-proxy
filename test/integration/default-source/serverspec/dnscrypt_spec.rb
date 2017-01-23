require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('dnscrypt-proxy'), :if => os[:family] == 'ubuntu' do  
  it { should be_enabled   }
  it { should be_running   }
end  

describe process("dnscrypt-proxy") do

#  its(:user) { should eq "root" }
  its(:user) { should eq "_dnscrypt-proxy" }

  it "is listening on port 53" do
    expect(port(53)).to be_listening
  end

end

#describe port(53), :if => os[:family] == 'ubuntu' && os[:release] != '16.04' do
describe port(53) do
  it { should be_listening.on('127.0.0.2') }
end

## https://github.com/jedisct1/dnscrypt-proxy/issues/174    'Unable to get server certificates'
## https://github.com/jedisct1/dnscrypt-proxy/issues/316
#dnscrypt-proxy -R okturtles
#drill -p 443 txt 2.dnscrypt-cert.fr.dnscrypt.org @212.47.228.136
#dig -p 443 txt 2.dnscrypt-cert.fr.dnscrypt.org @212.47.228.136
