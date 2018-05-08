require 'spec_helper'


# Set minimum length before truncation occurs in reports.
RSpec::Support::ObjectFormatter.default_instance.max_formatted_output_length =
  1024


describe vpc('vpc-elbasgrds-dev') do
  it { should exist }
  it { should be_available }
  its(:cidr_block) { should eq '10.0.0.0/16' }
  it { should have_route_table('rtb-elbasgrds-dev-public') }
  it { should have_route_table('rtb-elbasgrds-dev-app-1') }
  it { should have_route_table('rtb-elbasgrds-dev-app-2') }
  it { should have_route_table('rtb-elbasgrds-dev-data-1') }
  it { should have_route_table('rtb-elbasgrds-dev-data-2') }
#  it { should have_tag('owner').value('Personname / Teamname') }
#  it { should have_tag('project').value('Projectname') }
end


{
  '1' => '10.0.1.0/24',
  '2' => '10.0.2.0/24'
}.each do | az, cidr |
  describe subnet("sn-elbasgrds-dev-public-#{az}") do
    it { should exist }
    it { should be_available }
    it { should belong_to_vpc('vpc-elbasgrds-dev') }
    its(:cidr_block) { should eq cidr }
#    it { should have_tag('owner').value('Personname / Teamname') }
#    it { should have_tag('project').value('Projectname') }
  end
end


{
  '1' => '10.0.4.0/24',
  '2' => '10.0.5.0/24'
}.each do | az, cidr |
  describe subnet("sn-elbasgrds-dev-app-#{az}") do
    it { should exist }
    it { should be_available }
    it { should belong_to_vpc('vpc-elbasgrds-dev') }
    its(:cidr_block) { should eq cidr }
#    it { should have_tag('owner').value('Personname / Teamname') }
#    it { should have_tag('project').value('Projectname') }
  end
end


{
  '1' => '10.0.7.0/24',
  '2' => '10.0.8.0/24'
}.each do | az, cidr |
  describe subnet("sn-elbasgrds-dev-data-#{az}") do
    it { should exist }
    it { should be_available }
    it { should belong_to_vpc('vpc-elbasgrds-dev') }
    its(:cidr_block) { should eq cidr }
#    it { should have_tag('owner').value('Personname / Teamname') }
#    it { should have_tag('project').value('Projectname') }
  end
end


describe internet_gateway('igw-elbasgrds-dev') do
  it { should exist }
  it { should be_attached_to('vpc-elbasgrds-dev') }
#  it { should have_tag('owner').value('Personname / Teamname') }
#  it { should have_tag('project').value('Projectname') }
end


describe route_table('rtb-elbasgrds-dev-public') do
  it { should exist }
  it { should belong_to_vpc('vpc-elbasgrds-dev') }
  it { should have_route('10.0.0.0/16').target(gateway: 'local') }
  it { should have_subnet('sn-elbasgrds-dev-public-1') }
  it { should have_subnet('sn-elbasgrds-dev-public-2') }
  its('routes.last.gateway_id') { should match /^igw-/ }
#  it { should have_tag('owner').value('Personname / Teamname') }
#  it { should have_tag('project').value('Projectname') }
end


describe route_table('rtb-elbasgrds-dev-app-1') do
  it { should exist }
  it { should belong_to_vpc('vpc-elbasgrds-dev') }
  it { should have_route('10.0.0.0/16').target(gateway: 'local') }
  it { should have_subnet('sn-elbasgrds-dev-app-1') }
  its('routes.last.nat_gateway_id') { should match /^nat-/ }
#  it { should have_tag('owner').value('Personname / Teamname') }
#  it { should have_tag('project').value('Projectname') }
end


describe route_table('rtb-elbasgrds-dev-app-2') do
  it { should exist }
  it { should belong_to_vpc('vpc-elbasgrds-dev') }
  it { should have_route('10.0.0.0/16').target(gateway: 'local') }
  it { should have_subnet('sn-elbasgrds-dev-app-2') }
  its('routes.last.nat_gateway_id') { should match /^nat-/ }
#  it { should have_tag('owner').value('Personname / Teamname') }
#  it { should have_tag('project').value('Projectname') }
end


describe route_table('rtb-elbasgrds-dev-data-1') do
  it { should exist }
  it { should belong_to_vpc('vpc-elbasgrds-dev') }
  it { should have_route('10.0.0.0/16').target(gateway: 'local') }
  it { should have_subnet('sn-elbasgrds-dev-data-1') }
  its('routes.last.nat_gateway_id') { should match /^nat-/ }
#  it { should have_tag('owner').value('Personname / Teamname') }
#  it { should have_tag('project').value('Projectname') }
end


describe route_table('rtb-elbasgrds-dev-data-2') do
  it { should exist }
  it { should belong_to_vpc('vpc-elbasgrds-dev') }
  it { should have_route('10.0.0.0/16').target(gateway: 'local') }
  it { should have_subnet('sn-elbasgrds-dev-data-2') }
  its('routes.last.nat_gateway_id') { should match /^nat-/ }
#  it { should have_tag('owner').value('Personname / Teamname') }
#  it { should have_tag('project').value('Projectname') }
end
