require 'spec_helper'

describe 'Who without url' do
  let(:subject) { Who.new('') }
  it { expect(subject).to respond_to(:url) }
  it { expect(subject).to respond_to(:served) }
  it { expect(subject).to respond_to(:get_pi) }
  it { expect(subject.result).to be_nil }
  it { expect(subject.is_valid_url?(subject.url)).to be_falsey }
end

describe 'Who with url', :vcr do
  before(:all) do
    @url = 'https://www.raspberrypi.org/blog/the-little-computer-that-could/'
    @server = Faker::Superhero.name
    VCR.use_cassette('get_pi', erb: {server: @server}) do
      @subject = Who.new(@url)
    end
  end

  it { expect(@subject.result.code).to eql 200 }
  it { expect(@subject.result.headers).to have_key('x-served-by') }
  it { expect(@subject.served).to be_a String }
  it { expect(@subject.served).to eql @server }
  it { expect(@subject.is_valid_url?(@url)).to be_truthy }
end