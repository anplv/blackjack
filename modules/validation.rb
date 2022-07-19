# frozen_string_literal: true

module Validation
  def self.included(base)
    # base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  # module ClassMethods
  module InstanceMethods
    def valid_name?(name)
      raise 'Имя не может быть меньше двух символов!' if name.length < 2
    end
  end
  # end
end
