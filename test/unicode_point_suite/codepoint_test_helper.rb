# 100% shorthand
module CodepointTestHelper
  def assert_equal_encoded(expected, encode_mes)
    # Killing a duck because Ruby 1.9 doesn't mix Enumerable into String
    encode_mes = [encode_mes] if encode_mes.is_a?(String)
    encode_mes.each do |encode_me|
      encoded = encode(encode_me)
      actual = encoded.to_ascii
      if expected == actual
        # Let's not retest it
        assert true
      else
        message = "<#{expected.inspect}> expected but was\n<#{actual.inspect}>\n"
        message << "  defined in #{Unidecoder.in_yaml_file(encoded)}"
        fail message
      end
    end
  end

private
  def encode(codepoint)
    Unidecoder.encode(codepoint)
  end

  def which_yaml(codepoint)
    Unidecoder.in_yaml_file(encode(codepoint))
  end
end
