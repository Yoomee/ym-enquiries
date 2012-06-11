class YmEnquiries::EnquiryMailer < ActionMailer::Base
  
  def new_enquiry(enquiry)
    @enquiry = enquiry
    mail(:to => enquiry.email_to,
         :bcc => ["developers@yoomee.com", "andy@yoomee.com"],
         :from => enquiry.email_from, 
         :subject => enquiry.email_subject,
         :template_path => "enquiry_mailer")
  end
  
end