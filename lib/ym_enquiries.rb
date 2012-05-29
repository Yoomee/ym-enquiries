require "ym_enquiries/engine"

module YmEnquiries
end

require 'ym_enquiries/enquiry_form'
Dir[File.dirname(__FILE__) + '/ym_enquiries/models/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/ym_enquiries/controllers/*.rb'].each {|file| require file }