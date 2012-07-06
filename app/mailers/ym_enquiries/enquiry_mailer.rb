class YmEnquiries::EnquiryMailer < ActionMailer::Base
  
  def new_enquiry(enquiry)
    @enquiry = enquiry
    mail(:to => enquiry.email_to,
         :bcc => ["developers@yoomee.com", "andy@yoomee.com"],
         :from => enquiry.email_from,
         :subject => enquiry.email_subject,
         :template_path => "enquiry_mailer",
         :template_name => enquiry_template_name(enquiry))
  end
  
  private
  def enquiry_template_name(enquiry)
    if ApplicationController.view_paths.any? {|path| Dir["#{path}/enquiry_mailer/#{enquiry.form_name}.*"].present?}
      enquiry.form_name
    else
      "new_enquiry"
    end
  end
  
end