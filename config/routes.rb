Rails.application.routes.draw do
  
  match "enquiries/new/:id" => "enquiries#new", :as => "new_enquiry"
  resources :enquiries
  
end
