require "ostruct"
require "active_support"
require "active_support/core_ext"
require "accessor_delegation"

class TestAccessorDelegation
  extend AccessorDelegation
  attr_accessor :target_object
end

describe TestAccessorDelegation do
  let(:test_instance) { TestAccessorDelegation.new }

  before do
    test_instance.target_object = OpenStruct.new(some_attr: "some val")
    TestAccessorDelegation.delegate_accessor(:some_attr, to: :target_object)
  end

  it "delegates reading to the target object" do
    expect(test_instance.some_attr).to eq "some val"
  end

  it "delegate writing to the target object" do
    test_instance.some_attr = "new val"
    expect(test_instance.target_object.some_attr).to eq "new val"
  end

  context "prefixing" do
    before do
      TestAccessorDelegation.delegate_accessor(:some_attr, to: :target_object, prefix: :a_prefix)
    end

    it "prefixes readers" do
      expect(test_instance.a_prefix_some_attr).to eq "some val"
    end

    it "prefixes writers" do
      test_instance.a_prefix_some_attr = "new val"
      expect(test_instance.target_object.some_attr).to eq "new val"
    end
  end
end
