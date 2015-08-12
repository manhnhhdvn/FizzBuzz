class MainPagesController < ApplicationController
  require "will_paginate/array"
  require "json"

  def home
  end

  def fizzbuzztext
    result
  end

  def fizzbuzzimage
  	result
  end

  def directory
  end

  def getdata    
    begin
      data = showdirectory(params[:path])
      render json: {message: data.to_json},
             status: :ok
    rescue
      render json: {message: "Error"},
             status: :internal_server_error      
    end
  end

  private
  def fizz? number
    true if number%3 == 0
  end

  def buzz? number
    true if number%5 == 0
  end

  def result
    array = []
    1000.times{|number|
      if fizz? number + 1
        array << "Fizz"
        array << "Buzz" if buzz? number + 1
      elsif buzz? number + 1
        array << "Buzz"
      else
        array << number + 1
      end
    }
    @main_pages = array.paginate page: params[:page], per_page: 10
  end

  def showdirectory(path, name=nil)
    data = {:parent => (name || path)}
    data[:children] = children = []
    Dir.foreach(path) do |entry|
      next if (entry == '..' || entry == '.')
      full_path = File.join(path, entry)
      if File.directory?(full_path)
        children << showdirectory(full_path, entry)
      else
        children << entry
      end
    end
    return data
  end
end
