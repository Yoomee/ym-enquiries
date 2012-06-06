module YmEnquiries::Enquiry
  
  def self.included(base)
    base.after_initialize :load_enquiry_form_module!
    base.has_many :enquiry_fields, :class_name => "YmEnquiries::EnquiryField", :dependent => :destroy do
      def sort_by_field_order
        fields = proxy_owner.fields
        sort_by {|field| fields.index(field.name.to_s) || fields.index(field.name.to_sym)}
      end
    end
    base.send(:attr_accessor, :loaded_enquiry_form_module)
    base.validates :form_name, :presence => true
  end

  def email_address
    enquiry_fields.find_by_name("email_address").try(:value).presence || enquiry_fields.find_by_name("email").try(:value)
  end

  def form_name=(value)
    write_attribute(:form_name, value.to_s)
    load_enquiry_form_module!
    value.to_s
  end
  
  def full_name
    first_name = enquiry_fields.find_by_name("first_name").try(:value).presence || enquiry_fields.find_by_name("forename").try(:value)
    last_name = enquiry_fields.find_by_name("last_name").try(:value).presence || enquiry_fields.find_by_name("surname").try(:value)
    "#{first_name} #{last_name}".strip.presence || enquiry_fields.find_by_name("name").try(:value).presence
  end
  
  def initialize(attrs = {})
    return super if attrs.nil?
    if attrs[:form_name]
      super(:form_name => attrs.delete(:form_name))
      self.attributes = attrs
    else
      super(attrs)
    end
  end

  private
  def load_enquiry_form_module!
    if form_name.present? && !loaded_enquiry_form_module
      self.loaded_enquiry_form_module = true
      form_module = "#{form_name.camelize}Form".constantize
      extend(form_module)
    end  
  end
  
end
