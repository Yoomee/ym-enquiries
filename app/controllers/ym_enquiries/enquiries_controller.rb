class YmEnquiries::EnquiriesController < ApplicationController

  helper_method :ym_enquiries_enquiries_path, :edit_ym_enquiries_enquiries_path, :new_ym_enquiries_enquiries_path

  def create
    @enquiry = YmEnquiries::Enquiry.new(params[:enquiry])
    if @enquiry.save
      Notifier.deliver_enquiry_notification @enquiry
      flash[:notice] = "#{@enquiry.response_message}"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def destroy
     @enquiry = YmEnquiries::Enquiry.find(params[:id])
     @enquiry.destroy
     flash[:notice] = "Successfully deleted enquiry."
     redirect_to enquiries_url
   end

  def index
    @enquiries = YmEnquiries::Enquiry.all(:order => "created_at DESC")
  end

  def new
    if params[:id].nil?
      render_404
    else
      begin
        @enquiry = YmEnquiries::Enquiry.new(:form_name => params[:id].to_s)  
      rescue NameError
        render_404
      end
    end
  end
  
  def show
    @enquiry = YmEnquiries::Enquiry.find(params[:id])
  end
  
  private
  
  def ym_enquiries_enquiries_path(*args)
    enquiries_path(*args)
  end
  
  def edit_ym_enquiries_enquiries_path(*args)
    edit_enquiries_path(*args)
  end
  
  def new_ym_enquiries_enquiries_path(*args)
    new_enquiries_path(*args)
  end
    
end