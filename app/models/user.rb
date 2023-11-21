class User < ApplicationRecord
  mount_uploader :excel_file, ExcelFileUploader

  def excel_file_data
    return unless excel_file.present?

    workbook = Roo::Excelx.new(excel_file.path)
    workbook.default_sheet = workbook.sheets.first
    headers = workbook.row(1)

    (2..workbook.last_row).map do |i|
      Hash[headers.zip(workbook.row(i))]
    end
  end

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
end
