Rails.application.routes.draw do
  get'/blogs', to: 'blogs#index'
end
