module YmEnquiries::EnquiryForm
  
  def self.included(base)
    base.extend(ClassMethods)
    base.singleton_class.class_eval do
      
      attr_accessor :validation_args
      def validates(*args)
        self.validation_args ||= []
        field_names = args.dup
        options = field_names.extract_options!
        self.validation_args << ([[*field_names]] + [options])
      end
    
      private
      def define_field(enquiry, field)
        if enquiry.respond_to?(field)
          # Method already exists
          raise NameError.new("#{field} is not allowed as a field name - #{enquiry} already has a #{field} method")
        else
          # Add getter
          enquiry.singleton_class.send(:define_method, field) do
            enquiry_fields.detect {|ef| ef.name.to_s == field.to_s}.try(:value)
          end
          # Add setter
          enquiry.singleton_class.send(:define_method, "#{field}=") do |value|
            enquiry_field = enquiry_fields.detect {|ef| ef.name == field.to_s} || enquiry_fields.build(:name => field.to_s)
            enquiry_field.value = value
          end
        end
      end
    
      # This method gets called when the enquiry object extends the appropriate form
      define_method(:extended) do |enquiry|
        
        # Create getters and setters for the fields of the form 
        enquiry.fields.each do |field|
          define_field(enquiry, field)
        end

        (validation_args || []).each do |field_names, options|
          enquiry.singleton_class.validates(*([*field_names].dup), options.dup)
        end
              
      end
    end
  end  

  module ClassMethods

    # These declaration methods and (validates_presence_of etc.) should provide all the configuration for a form module
    # Eg.
    # module GubbinsForm
    #  include EnquiryForm
    #  <...configure away...>
    # end

    def email_from(email)
      define_method(:email_from) {email}
    end
  
    def email_subject(subject)
      define_method(:email_subject) {subject}
    end
  
    def email_to(email)
      define_method(:email_to) {email}
    end
  
    def fields(*args)
      define_method(:fields) {[*args]}
    end
  
    def response_message(msg)
      define_method(:response_message) {msg}
    end
  
    def title(title)
      define_method(:form_title) {title}
    end
    
    def intro(intro)
      define_method(:form_intro) {intro.html_safe}
    end
    
  end
  
end
