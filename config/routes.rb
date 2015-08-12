Rails.application.routes.draw do
  root "main_pages#home"
  get "fizzbuzz1" => "main_pages#fizzbuzztext"
  get "fizzbuzz2" => "main_pages#fizzbuzzimage"
  get "directory" => "main_pages#directory"
  post "getdata" => "main_pages#getdata"
end
