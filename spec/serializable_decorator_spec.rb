require 'spec_helper'

class Test
  attr_accessor :foo
end

class TestDecorator < SerializableDecorator
  attr_accessor :bar
end

describe SerializableDecorator do
  before(:each) do
    @td = TestDecorator.new(Test.new)
  end

  it "Original attributes are still available" do
    @td.foo.should be_nil
    @td.foo = 12
    @td.foo.should == 12
  end

  it "Decoration attributes should be available" do
    @td.bar.should be_nil
    @td.bar = 13
    @td.bar.should == 13
  end

  it "Supports changing the decorated object" do
    @td.foo = 12
    @td.bar = 13
    @td.__setobj__(Test.new)
    @td.foo.should be_nil
    @td.bar.should == 13
  end

  it "Can get list of attributes" do
    @td.foo = 12
    @td.bar = 13
    @td.instance_variables.should include(:@foo)
    @td.instance_variables.should include(:@bar)
  end

  it "Can retrieve original attributes by name" do
    @td.foo = 12
    @td.instance_variable_get("@foo").should == 12
  end

  it "Can retrieve decoration attributes by name" do
    @td.bar = 13
    @td.instance_variable_get("@bar").should == 13
  end

  it "Can retrieve all local variables with values" do
    @td.foo = 12
    @td.bar = 13
    @td.instance_values.should include("foo" => 12)
    @td.instance_values.should include("bar" => 13)
  end

  it "Can serialize original attributes to JSON" do
    @td.foo = 12
    @td.to_json.should include('"foo":12')
  end

  it "Can serialize decorated attributes to JSON" do
    @td.bar = 13
    @td.to_json.should include('"bar":13')
  end

  it "Should not report any extraneous variables" do
    @td.instance_variables.should be_empty
    @td.instance_values.should be_empty
  end

  it "Should not include any extraneous entries in the JSON output" do
    @td.to_json.should == "{}"
  end
end
