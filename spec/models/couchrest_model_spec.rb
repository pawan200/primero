require 'rails_helper'

describe "couchrest_model" do

  describe "non-nested dynamic assignment monkeypatch" do
    before :each do
      Child.any_instance.stub(:field_definitions).and_return([])
    end

    it "marks attributes set via set_attributes as changed" do
      child = Child.create('foo_attribute' => 'Value A', 'created_by' => 'me')
      child.set_attributes({'foo_attribute' => 'Value B'})

      expect(child.changed?).to be_truthy
      expect(child.changed_attributes.keys.include?('foo_attribute')).to be_truthy
      expect(child.changed_attributes['foo_attribute']).to eql('Value A')
    end

    it "marks nested attributes set via set_attributes as changed" do
      child = Child.create('foo_attribute' => {'bar_attribute' => 'Value A'}, 'created_by' => 'me')
      child.set_attributes({'foo_attribute' => {'bar_attribute' => 'Value B'}})

      expect(child.changed?).to be_truthy
      expect(child.changed_attributes.keys.include?('foo_attribute')).to be_truthy
      expect(child.changed_attributes['foo_attribute']).to eql({'bar_attribute' => 'Value A'})
    end

  end

end
