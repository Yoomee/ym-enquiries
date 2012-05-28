module TestForm
  
  include YmEnquiries::EnquiryForm
  
  title "This is a test form"
  email_from "info@yoomee.com"
  email_subject 'New Test form submission'
  email_to "developers@yoomee.com"
  response_message 'Thank you for getting in touch'

  fields :name, :email
  
  validates :name, :presence => true
  validates :email, :email => true, :allow_blank => true
  
end
