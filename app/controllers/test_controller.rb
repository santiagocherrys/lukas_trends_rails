class TestController < ApplicationController
  def index; end

  def random_banner
    @banner = Advertisement.random_banner
    render json: { image_url: banner.image_url, title: banner.title, link: banner.link }
  end
end
