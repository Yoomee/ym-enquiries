Rails.application.routes.draw do
  
  match "enquiries/new/:id" => "YmEnquiries::Enquiries#new", :as => "new_enquiry"  
  resources :enquiries, :controller => 'YmEnquiries::Enquiries'
  
end
