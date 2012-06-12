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
        @enquiry = Enquiry.new(:form_name => params[:id].to_s)  
      rescue NameError
        render_404
      end
    end
  end
  
  def show
    @enquiry = Enquiry.find(params[:id])
  end
    
end