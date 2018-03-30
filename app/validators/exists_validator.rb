# Check is model presents in database
# Attribute name convert to CamelCase and uses as model name
class ExistsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    class_name = attribute.to_s.camelize

    unless Kernel.const_get(class_name).exists?(value)
      record.errors[attribute] << (options[:message] || "The selected #{class_name} is invalid.")
    end
  end
end
