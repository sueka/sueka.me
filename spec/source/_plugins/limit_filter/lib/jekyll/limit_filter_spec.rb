require 'saharspec/its'
require 'saharspec/matchers'
require 'rack/jekyll'
require 'limit_filter/lib/jekyll/limit_filter'

RSpec.describe SuekaDotMe::Jekyll::LimitFilter do
  let (:dummy_filter) { Class.new { include SuekaDotMe::Jekyll::LimitFilter }.new }

  describe '#limit' do
    subject { dummy_filter.method(:limit) }

    its_call([7, 15, 1, 292], 0) { is_expected.to ret [] }
    its_call([7, 15, 1, 292], 2) { is_expected.to ret [7, 15] }
    its_call([7, 15, 1, 292], 4) { is_expected.to ret [7, 15, 1, 292] }
    its_call([7, 15, 1, 292], 6) { is_expected.to ret [7, 15, 1, 292] }
    its_call([7, 15, 1, 292], -1) { is_expected.to raise_error ArgumentError, 'attempt to take negative size' }
  end
end
