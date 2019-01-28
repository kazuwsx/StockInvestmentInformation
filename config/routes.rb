Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'stocks#index'
  resources :stocks, only: [:show]
  resources :business, only: [:index]
  resources :search, only: [:index]
  resources :stock_favorites, only: [:index, :create, :destroy]
  get :show_all_businesses, to: 'business#show_all_businesses'

  rankings = [
    :market_capitalization_ranking,
    :per_ranking,
    :pbr_ranking,
    :roe_ranking,
    :roa_ranking,
    :masic_formula,
    :masic_formula_ranking,
    :masic_formula_ranking_under_one_hundred_yen,
    :the_highest_dividend_yields,
    :cheep_stocks,
  ]

  scope controller: 'ranking' do
    rankings.each {|r| get r, action: r}
  end
end
