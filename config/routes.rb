Rails.application.routes.draw do
 
  devise_for :users, controllers: { registrations: 'registrations'}, path_names: {sign_in: 'login', sign: 'logout'}

	concern :export_csv do  	
  		get :export_csv, on: :collection 
	end
  
  resources :students  do
		collection do
			get :courses_popup
			get :pie_chart
			get :line_chart
		end
  end

  resources :courses, concerns: [:export_csv], except:  [:show] do
		collection do
			get :active_deactive
			get :sorting_list
			get :export_pdf
			get :clear_fliter
			get :populate_courses
		end
  end

  resources :invoices do
	collection do
		get :show_pending_bills
		get :show_collected_bills
		get :add_collection
		get :invoice_details
		post :save_collection
	end
  end

	#root to: "devise/sessions#new"

	#root :to => redirect("/users/login")
	root :to => "courses#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
