class ErrorsController < ApplicationController
  layout 'errors_layout'
  def error404
    render status: :not_found
  end
end
