require 'spec_helper'

describe YmEnquiries::Enquiry do
  
  it { should have_many(:enquiry_fields) }

  describe do  
    
    it "is valid" do
      enquiry = FactoryGirl.build(:enquiry)
      enquiry.should be_valid
    end
    
    it "builds enquiry_field setting name field" do
      enquiry = FactoryGirl.build(:enquiry, :name => "Charles Barrett", :email => "charles@barrett.com")
      enquiry.enquiry_fields.collect {|ef| [ef.name, ef.value]}.flatten.should == ['name', 'Charles Barrett', 'email', 'charles@barrett.com']
    end
    
  end
  
  describe 'validations' do

    it "validates presence of name" do
      enquiry = FactoryGirl.build(:enquiry, :name => nil)
      enquiry.valid?
      enquiry.errors[:name].should == ["can't be blank"]
    end
    
    it "validates email format of email" do
      enquiry = FactoryGirl.build(:enquiry, :email => "invalid-email")
      enquiry.valid?
      enquiry.errors[:email].should == ["is invalid"]
    end
    
  end
  
end