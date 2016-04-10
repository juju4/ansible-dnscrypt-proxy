require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('dnscrypt-proxy'), :if => os[:family] == 'ubuntu' do  
  it { should be_enabled   }
  it { should be_running   }
end  

describe process("dnscrypt-proxy") do

  its(:user) { should eq "root" }
  its(:user) { should eq "dnscrypt" }

  it "is listening on port 53" do
    expect(port(53)).to be_listening
  end

end

describe port(53) do
  it { should be_listening.on('127.0.0.2') }
end

