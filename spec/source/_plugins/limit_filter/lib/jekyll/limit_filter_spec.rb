require 'rack/jekyll'
require 'limit_filter/lib/jekyll/limit_filter'

RSpec.describe SuekaDotMe::Jekyll::LimitFilter do
  let (:dummy_filter) { Class.new { include SuekaDotMe::Jekyll::LimitFilter }.new }

  describe '#limit' do
    it { expect(dummy_filter.limit([7, 15, 1, 292], 0)).to match [] }
    it { expect(dummy_filter.limit([7, 15, 1, 292], 2)).to match [7, 15] }
    it { expect(dummy_filter.limit([7, 15, 1, 292], 4)).to match [7, 15, 1, 292] }
    it { expect(dummy_filter.limit([7, 15, 1, 292], 6)).to match [7, 15, 1, 292] }
    it { expect { dummy_filter.limit([7, 15, 1, 292], -1) }.to raise_error ArgumentError }
  end
end
