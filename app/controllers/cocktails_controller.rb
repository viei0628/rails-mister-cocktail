require 'open-uri'
require 'nokogiri'

class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'new'
    end
  end

  def get_image(something)
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{something}"

    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('._2zEKz').each do |element|
      return element
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end
end
