class RemindersController < ApplicationController
  def dropdown
    @user = current_user
    render layout: false
  end
end
