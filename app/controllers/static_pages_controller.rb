class StaticPagesController < ApplicationController
  def show
    if page_exists?(params[:page_name])
      render "static_pages/#{params[:page_name]}"
    else
      render :text => '<h1>Not Found</h1>', :status => :not_found
    end
  end

  private

  def page_exists?(page_name)
    lookup_context.template_exists?(page_name, ['static_pages'])
  end
end
