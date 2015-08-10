class MainPagesController < ApplicationController
  require "will_paginate/array"

  def home
  end

  def fizzbuzztext
    result
  end

  def fizzbuzzimage
  	result
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
end
