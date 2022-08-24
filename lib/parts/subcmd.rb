# frozen_string_literal: true

require 'minitest/autorun'

module Shq
  def subcmd_error_handler(what_you_were_trying_to_do, indentation=2, raize=true)
    -> (subcmd_output) do
      if $? != 0 then
        nam = "failed to perform action: #{what_you_were_trying_to_do}"
        indent = "%*s"%[indentation,""]
        innermsg = subcmd_output.chomp.gsub(/\n/){"\n#{indent}"}.gsub(/^/){indent}
        STDERR.puts "#{nam}\n#{innermsg}\nend"
        raise nam if raize
      end
    end
  end
  module_function :subcmd_error_handler
end

# class SubcmdTests < Minitest::Test
#   def test_subcmd_error_handler
#     exc = nil
#     out, err = capture_subprocess_io do
#       exc = assert_raises RuntimeError do
#         `echo I am sad;exit 1`                    .tap(&Subcmd.subcmd_error_handler("be happy"))
#       end
#     end
#     assert_equal exc.message, "failed to perform action: be happy"
#     assert_equal out, ""
#     assert_equal "failed to perform action: be happy\n  I am sad\nend\n", err
#   end
# 
#   def test_subcmd_error_handler_stdout_stderr_mix
#     exc = nil
#     out, err = capture_subprocess_io do
#       exc = assert_raises RuntimeError do
#         `echo -n "I am ";1>&2 echo sad;exit 1`    .tap(&Subcmd.subcmd_error_handler("be happy"))
#       end
#     end
#     assert_equal exc.message, "failed to perform action: be happy"
#     assert_equal out, ""
#     # this looks weird because the sad is printed immediately and then I am is printed
#     # when the subcmd error handler prints stdout to stderr.
#     # this is _correct_.
#     # sad first, newline, then the error, then the stdout, then end.
#     assert_equal "sad\nfailed to perform action: be happy\n  I am \nend\n", err
#   end
# end
