# Name your implementation `attr_read_and_write.rb` and place it in the
# same directory as this test.
#
# Run the test like this: `ruby attr_read_and_write_test.rb`

require './attr_read_and_write'
require 'minitest'
require 'minitest/autorun'

# :nodoc:
class AttrReadAndWriteTest < Minitest::Test
  def setup
    @klass  = Class.new AttrReadAndWrite
    @object = @klass.new
    generate_input
  end

  def generate_input
    @random_input = rand
  end

  def test_initial_value_can_be_read
    @klass.class_exec {attr_read_and_write :bar }
    assert_equal(@object.bar, nil)
  end

  def test_value_can_be_set
    @klass.class_exec { attr_read_and_write :bar }
    @object.bar = @random_input
    assert_equal(@object.bar, @random_input)
  end

  def test_no_method_for_undefined_attributes
    assert_raises(NoMethodError) { @object.baz }
    assert_raises(NoMethodError) { @object.baz = @random_input }
  end

  def test_with_multiple_arguments
    attributes = %i(spam ham eggs)
    @klass.class_exec(attributes) { |attrs| attr_read_and_write(*attrs) }
    attributes.each do |e|
      generate_input
      @object.send "#{e}=", @random_input
      assert_equal(@object.send(e), @random_input)
    end
  end
end
