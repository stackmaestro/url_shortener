class Api::V1::LinksController < Api::V1::BaseController

  def index
    @links = Link.top_100_urls
  end

  def create
    @link = Link.create!(link_params)
    render @link
  end

  def show
    @link = Link.find(params[:id])
    @link.clicked +=1
    @link.save
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end
