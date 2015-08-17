class MainPagesController < ApplicationController
  require "will_paginate/array"
  require "json"

  def home
  end

  def fizzbuzztext
    result_fizzbuzz_1
  end

  def fizzbuzzimage
  	result_fizzbuzz_2
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
  def fizz1? number
    true if number%3 == 0
  end

  def fizz2? number
    array_of_number = number.to_s.split(//)
    check_fizz2 = false;
    array_of_number.each do |item|
      if item == "3"
        check_fizz2 = true
        break
      end
    end
    return check_fizz2
  end

  def buzz? number
    true if number%5 == 0
  end

  def result_fizzbuzz_1
    array = []
    1000.times{|number|
      if fizz1? number + 1
        array << "Fizz"
        array[number] += "Buzz" if buzz? number + 1
      elsif buzz? number + 1
        array << "Buzz"
      else
        array << number + 1
      end
    }
    @main_pages = array
  end

  def result_fizzbuzz_2
    array = []
    1000.times{|number|
      if fizz1? number + 1
        array << "Fizz"
        array[number] += "Buzz" if buzz? number + 1
      elsif fizz2? number + 1
        array << "Fizz"
        array[number] += "Buzz" if buzz? number + 1
      elsif buzz? number + 1
        array << "Buzz"
      else
        array << number + 1
      end
    }
    @main_pages = array
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
