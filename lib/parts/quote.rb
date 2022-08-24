# frozen_string_literal: true

require 'minitest/autorun'


module Shq
  def self.q(*args) (args.map {|v| self.q1 v}).join " " end
  def self.q1(arg) "'#{ arg.gsub(/'/) {%<'"'"'>} }'" end
end

# class QuoteTests < Minitest::Test
#   def test_q1
#     assert_equal `echo #{Quote.q1 %<'>}`, %<'\n>
#     assert_equal `echo #{Quote.q1 %<\\'>}`, %<\\'\n>
#     assert_equal `echo #{Quote.q1 %<>}'george'`, %<george\n>
#     assert_equal `echo "george"#{Quote.q1 %<">}"george"`, %<george"george\n>
#     assert_equal `echo #{Quote.q1 %< !  '"&^ @*&^ $*@& #)!(&(>}`, %< !  '"&^ @*&^ $*@& #)!(&(\n>
#   end
# 
#   def test_q
#     assert_equal `printf 'Q%sQ' #{Quote.q %<hello>, %<'>, %<>, %<'"OIJWEF ~#%^&*()_+>}`, %<QhelloQQ'QQQQ'"OIJWEF ~#%^&*()_+Q>
#   end
# end
