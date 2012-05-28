class YmEnquiries::Enquiry < ActiveRecord::Base
  
  has_many :enquiry_fields, :dependent => :destroy do
    def sort_by_field_order
      fields = proxy_owner.fields
      sort_by {|field| fields.index(field.name.to_s) || fields.index(field.name.to_sym)}
    end
  end
  
  validates :form_name, :presence => true

  def form_name=(value)
    write_attribute(:form_name, value)
    form_module = "#{value.camelize}Form".constantize
    extend(form_module)
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
  
end
