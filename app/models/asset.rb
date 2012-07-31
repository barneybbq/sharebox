class Asset < ActiveRecord::Base
  attr_accessible :user_id, :uploaded_file  

  belongs_to :user 

#set up "uploaded_file" field as attached_file (using Paperclip)
# Use the following information when uploading from a local machine
# has_attached_file :uploaded_file,  
#                :url => "/assets/get/:id",  
#                :path => ":Rails_root/assets/:id/:basename.:extension"  

has_attached_file :uploaded_file,  
              :path => "assets/:id/:basename.:extension",  
              :storage => :s3,
              # amazon_s3.yml is added to .gitignore, create you own file
              :s3_credentials => S3_CREDENTIALS


  validates_attachment_size :uploaded_file, :less_than => 10.megabytes    
  validates_attachment_presence :uploaded_file 

  def file_name  
    uploaded_file_file_name 
  end

  def file_size  
    uploaded_file_file_size  
  end 
end
