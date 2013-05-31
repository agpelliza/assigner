class Assigner
  
  def self.assign_each_other!(items, &block)
    
    # Wrap Items to add assignation behavior
    wrap(items, &block)

    # Random assignation between items
    items_copy = items.dup
    items.each do |item|
      item.assignation = items_copy.delete_at(rand(items_copy.size))
    end

    # Switch assignation if it's not allowed
    items.each do |item|
       unless item.assignation.can_be_assigned_to? item
         candidates = items.select {|i| i.assignation.can_be_assigned_to?(item) && item.assignation.can_be_assigned_to?(i)}
         raise if candidates.empty?
         other = candidates[rand(candidates.size)]
         temp = item.assignation
         item.assignation = other.assignation
         other.assignation = temp
         finished = false
       end
    end
  end

  # Wrap items to be assignable
  def self.wrap(items, &block)
    items.each do |item|
      item.extend(Assigner::Assignable)
      item.assign_conditions(&block) if block_given?
    end
  end
  private_class_method :wrap
end

require 'assigner/assignable'