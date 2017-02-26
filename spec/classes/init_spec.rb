require 'spec_helper'
describe 'l2tpns' do
  context 'with default values for all parameters' do
    it { should contain_class('l2tpns') }
  end
end
