FactoryGirl.define do
  
  factory :enquiry, :class => YmEnquiries::Enquiry do
    form_name "Test"
    name "Charles Barrett"
    email "charles@barrett.com"
  end
  
end