class BannersController < ApplicationController
  def show
    @banner = Advertisement.random_banner
    render partial: 'ad_banner/banner', layout: false
  end
end
