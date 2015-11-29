class AttrReadAndWrite

  def self.attr_read_and_write *args
    args.each do |name|
      define_method(name) { instance_variable_get "@#{name}" }
      define_method("#{name}=") { |value| instance_variable_set("@#{name}", value) }
    end
  end

end
