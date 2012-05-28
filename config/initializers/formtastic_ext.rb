# class Formtastic::SemanticFormBuilder
#   
#   def method_required_with_enquiry_form?(attribute)
#     required_method = "#{attribute}_required?"
#     if @object && @object.respond_to?(required_method)
#       @object.send(required_method) || method_required_without_enquiry_form?(attribute)
#     else
#       method_required_without_enquiry_form?(attribute)
#     end
#   end
#   alias_method_chain(:method_required?, :enquiry_form)
#   
# end