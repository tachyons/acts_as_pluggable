require 'spec_helper'

describe ActsAsPluggable do
  it 'has a version number' do
    expect(ActsAsPluggable::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(true).to eq(true)
  end
  it "should raise exception for duplicate plugins" do
    ActsAsPluggable::Plugin.register :id, {}
    expect { ActsAsPluggable::Plugin.register :id, {} }.to raise_error(ActsAsPluggable::DuplicatePlugin)
  end
end
