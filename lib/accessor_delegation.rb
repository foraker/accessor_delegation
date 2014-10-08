require "accessor_delegation/version"

module AccessorDelegation
  def delegate_accessor(*attributes)
    options = attributes.extract_options!
    target, prefix = options[:to], options[:prefix]

    attributes.each do |attribute|
      delegate_reader(target, attribute, prefix)
      delegate_writer(target, attribute, prefix)
    end
  end

  def delegate_reader(target, attribute, prefix)
    define_method [prefix, attribute].compact.join("_") do
      send(target).send(attribute)
    end
  end

  def delegate_writer(target, attribute, prefix)
    define_method [prefix, :"#{attribute}="].compact.join("_") do |value|
      send(target).send(:"#{attribute}=", value)
    end
  end
end
