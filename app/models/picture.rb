class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :picture_comments
  attr_accessible :description, :name, :path

	def self.picture_upload(params)
		uploadedFile = params[:picture][:path]
		if uploadedFile
			File.open(Rails.root.join('public', 'uploads', uploadedFile.original_filename), 'wb') do |file|
				file.write(uploadedFile.read)
			end
		params[:picture][:path] = uploadedFile.original_filename
		end
		params
	end

	def picture_url
		return "/uploads/#{self.path}"
	end
	
end