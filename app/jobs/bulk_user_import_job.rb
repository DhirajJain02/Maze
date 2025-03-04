class BulkUserImportJob < ApplicationJob
  queue_as :default
  require "roo"

  def perform(file_path)
    ext = File.extname(file_path).downcase

    if ext == ".csv"
      import_csv(file_path)
    elsif [ ".xls", ".xlsx" ].include?(ext)
      import_excel(file_path)
    else
      Rails.logger.error "Unsupported file type: #{ext}"
    end
    File.delete(file_path) if File.exist?(file_path)
  end

  private

  def import_csv(file_path)
    require "csv"
    CSV.foreach(file_path, headers: true) do |row|
      # Expecting headers: first_name, last_name, email, phone_number, password
      user_data = row.to_hash.slice("first_name", "last_name", "email", "phone_number", "password")
      user = User.new(user_data)
      unless user.save
        Rails.logger.error "Failed to import user: #{user_data.inspect}. Errors: #{user.errors.full_messages.join(', ')}"
      end
    end
  end

  def import_excel(file_path)
    spreadsheet = Roo::Spreadsheet.open(file_path)
    header = spreadsheet.row(1).map { |h| h.to_s.downcase.strip } # Normalize headers

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[ header, spreadsheet.row(i) ].transpose]
      user_data = row.slice("first_name", "last_name", "email", "phone_number", "password")

      user = User.new(user_data)
      unless user.save
        Rails.logger.error "Failed to import user: #{user_data.inspect}. Errors: #{user.errors.full_messages.join(', ')}"
      end
    end
  end
end
