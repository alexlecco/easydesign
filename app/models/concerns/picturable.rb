# Este modulo será compartido por attachment.rb y posts.rb para la subida de imagenes

module Picturable
  extend ActiveSupport::Concern
  included do
    after_save :save_image
  end

  PATH_FILES = File.join Rails.root, "public", "files"

=begin
  if self.respond_to?(:name)
    PATH_FILES = File.join Rails.root, "public", "files"
  else
    PATH_FILES = File.join Rails.root, "public", "posts"
  end
=end

  def file=(file)
    unless file.blank?
      @file = file
      if self.respond_to?(:name)
        self.name = file.original_filename
      end
      self.extension = file.original_filename.split(".").last.downcase
    end
  end

  def path_file
    File.join PATH_FILES, "#{self.id}.#{self.extension}"
  end

  def has_file?
    File.exists? file_path
  end

  private
  def save_image
    if @file
      FileUtils.mkdir_p PATH_FILES
      File.open(path_file, "wb") do |f|
        f.write(@file.read)
      end
      @file = nil
    end
  end

end
