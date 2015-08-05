class StaticPagesController < ApplicationController
  def index
    load_featured_products
  end
end
