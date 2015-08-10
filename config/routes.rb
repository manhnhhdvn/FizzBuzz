Rails.application.routes.draw do
  root "main_pages#home"
  get "fizzbuzz1" => "main_pages#fizzbuzztext"
  get "fizzbuzz2" => "main_pages#fizzbuzzimage"
end
