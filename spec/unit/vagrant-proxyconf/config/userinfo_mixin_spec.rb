require 'spec_helper'
require 'vagrant-proxyconf/config/userinfo_mixin'

describe VagrantPlugins::ProxyConf::Config::UserinfoMixin do
  class TestConfig
    include VagrantPlugins::ProxyConf::Config::UserinfoMixin
    attr_accessor :http
    userinfo :http
  end

  subject do
    TestConfig.new.tap { |c| c.http = http_proxy }
  end

  context "with nil" do
    let(:http_proxy) { nil }
    its(:http_user)  { should be_nil }
    its(:http_pass)  { should be_nil }
  end

  context "with false" do
    let(:http_proxy) { false }
    its(:http_user)  { should be_nil }
    its(:http_pass)  { should be_nil }
  end

  context "with empty" do
    let(:http_proxy) { '' }
    its(:http_user)  { should be_nil }
    its(:http_pass)  { should be_nil }
  end

  context "without userinfo" do
    let(:http_proxy) { 'http://proxy.example.com:8123/' }
    its(:http_user)  { should be_nil }
    its(:http_pass)  { should be_nil }
  end

  context "with username" do
    let(:http_proxy) { 'http://foo@proxy.example.com:8123/' }
    its(:http_user)  { should eq 'foo' }
    its(:http_pass)  { should be_nil }
  end

  context "with password" do
    let(:http_proxy) { 'http://:baz@localhost' }
    its(:http_user)  { should eq '' }
    its(:http_pass)  { should eq 'baz' }
  end

  context "with userinfo" do
    let(:http_proxy) { 'http://foo:bar@proxy.example.com:8123/' }
    its(:http_user)  { should eq 'foo' }
    its(:http_pass)  { should eq 'bar' }
  end
end
