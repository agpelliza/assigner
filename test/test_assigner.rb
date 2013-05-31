require 'test/unit'
require 'assigner'

class AssignerTest < Test::Unit::TestCase
  
  class Item
    
    def initialize(attributes = {})
      attributes.each do |key, value|
        instance_variable_set "@#{key}".to_sym, value 
      end
    end
  end

  def test_assign_each_other!
    items = [
      Item.new(name: "Item Name0", condition: "Condition0"),
      Item.new(name: "Item Name1", condition: "Condition1")
    ]

    Assigner.assign_each_other!(items)

    assert_not_nil items[0].assignation
    assert_not_nil items[1].assignation
  end

  def test_assign_each_other_cant_be_self!
    items = [
      Item.new(name: "Item Name0", condition: "Condition0"),
      Item.new(name: "Item Name1", condition: "Condition1")
    ]

    Assigner.assign_each_other!(items) do
      can_not_be_self
    end

    assert_equal items[0].assignation, items[1]
    assert_equal items[1].assignation, items[0]
  end

  def test_assign_each_other_with_different_condition!
    items = [
      Item.new(name: "Item Name0", condition: "Condition0"),
      Item.new(name: "Item Name1", condition: "Condition1"),
      Item.new(name: "Item Name2", condition: "Condition2"),
      Item.new(name: "Item Name3", condition: "Condition0"),
      Item.new(name: "Item Name4", condition: "Condition1")
    ]

    Assigner.assign_each_other!(items) do
      can_not_be_self
      different 'condition'
    end

    items.each do |item|
      assert_not_equal item.instance_variable_get('@condition'), item.assignation.instance_variable_get('@condition')
    end
  end

  def test_assign_each_other_with_multiple_different_conditions!
    items = [
      Item.new(name: "Item Name0", condition1: "Condition0", condition2: "Condition0"),
      Item.new(name: "Item Name1", condition1: "Condition1", condition2: "Condition1"),
      Item.new(name: "Item Name2", condition1: "Condition2", condition2: "Condition2"),
      Item.new(name: "Item Name3", condition1: "Condition0", condition2: "Condition0"),
      Item.new(name: "Item Name4", condition1: "Condition1", condition2: "Condition1")
    ]

    Assigner.assign_each_other!(items) do
      can_not_be_self
      different 'condition1', 'condition2'
    end

    items.each do |item|
      assert_not_equal item.instance_variable_get('@condition1'), item.assignation.instance_variable_get('@condition1')
      assert_not_equal item.instance_variable_get('@condition2'), item.assignation.instance_variable_get('@condition2')
    end
  end
end