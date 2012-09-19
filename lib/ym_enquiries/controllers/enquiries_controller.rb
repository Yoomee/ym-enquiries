module YmEnquiries::EnquiriesController

  def create
    @enquiry = Enquiry.new(params[:enquiry].merge(:form_name => params[:id]))
    if @enquiry.save
      YmEnquiries::EnquiryMailer.new_enquiry(@enquiry).deliver
      flash[:notice] = "#{@enquiry.response_message}"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def destroy
     @enquiry = Enquiry.find(params[:id])
     @enquiry.destroy
     flash[:notice] = "Successfully deleted enquiry."
     redirect_to enquiries_url
   end

  def index
    @enquiries = Enquiry.order("created_at DESC")
    if params[:form_name]
      @enquiries.where(:form_name => params[:form_name])
    end
  end

  def new
    if params[:id].nil?
      render_404
    else
      begin
        form_name = params[:id].to_s
        attrs = {:form_name => form_name}
        if defined?(current_user) && current_user
          enquiry_standard_fields = %w[first_name last_name email]
          enquiry_standard_fields.each do |standard_field|
            if Enquiry.new(:form_name => form_name).respond_to?(standard_field.to_sym)
              attrs.merge!(current_user.attributes.slice(standard_field))
            end
          end
        end
        @enquiry = Enquiry.new(attrs)
      rescue NameError
        render_404
      end
    end
  end
  
  def show
    @enquiry = Enquiry.find(params[:id])
  end
    
end