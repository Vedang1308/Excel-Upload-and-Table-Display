class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    if current_user
      @excel_data = current_user.excel_file_data if current_user.excel_file.present?
    else
      redirect_to new_user_session_path
    end
  end

  def upload_excel
    if params[:user] && params[:user][:excel_file].present?
      current_user.update(excel_file: params[:user][:excel_file])
      redirect_to root_path, notice: 'Excel file uploaded successfully!'
    else
      redirect_to root_path, alert: 'Please select a file to upload.'
    end
  end

end
