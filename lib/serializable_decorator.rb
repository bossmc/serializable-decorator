require 'serializable_decorator/version'
require 'delegate'
require 'json' unless Object.method_defined?(:to_json)

class SerializableDecorator < Delegator

  @@decorator_objects = {}
  
  def self.change_obj(decorator, obj)
    @@decorator_objects[decorator.object_id] = obj
  end

  def self.get_obj(decorator)
    @@decorator_objects[decorator.object_id]
  end

  def self.clear_obj(object_id)
    proc { @@decorator_objects.delete(object_id) }
  end

  def initialize(obj)
    super
    SerializableDecorator.change_obj(self, obj)
    ObjectSpace.define_finalizer( self, self.class.clear_obj(object_id) )
  end 

  def __getobj__
    SerializableDecorator.get_obj(self)
  end

  def __setobj__(obj)
    SerializableDecorator.change_obj(self, obj)
  end

  def instance_variables
    super + __getobj__.instance_variables
  end

  def instance_values
    Hash[instance_variables.map { | name | [ name.to_s[1..-1], instance_variable_get(name) ] } ]
  end

  def instance_variable_get(name)
    __getobj__.instance_variable_get(name) || super
  end

  def as_json
    if __getobj__.respond_to?(:as_json) then
      delegator_instance_vars = Delegator.instance_method(:instance_variables).bind(self).call
      json_hash = Hash[delegator_instance_vars.map { | name | [name.to_s[1..-1], instance_variable_get(name) ] } ]
      json_hash.merge!(__getobj__.as_json)
    else
      instance_values
    end
  end

  def to_json
    as_json.to_json
  end
end
