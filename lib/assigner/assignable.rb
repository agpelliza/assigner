module Assigner::Assignable

  attr_accessor :assignation

  def assign_conditions(&block)
    instance_eval(&block)
  end

  def can_be_assigned_to?(other)
    if have_conditions?
      @assign_conditions.each do |condition|
        return false unless send condition.to_sym, other
      end
    end

    return true
  end

  def can_not_be_self
    condition_name = 'different_object?'
    self.class.send :define_method, condition_name do |data|
      self != data
    end
    @assign_conditions ||= []
    @assign_conditions << condition_name
  end

  def different(*method_names)
    @assign_conditions ||= []
    method_names.each do |name|
      condition_name = "different_#{name}?"
      self.class.send :define_method, condition_name do |data|
        instance_variable_get("@#{name}") != data.instance_variable_get("@#{name}")
      end
      @assign_conditions << condition_name
    end
  end

  def have_conditions?
    !@assign_conditions.nil? && !@assign_conditions.empty?
  end
end