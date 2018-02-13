# frozen_string_literal: true

# User avatar uploader
class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*_args)
    # ActionController::Base.helpers.asset_path('fallbacks/' + [version_name, 'no-avatar.jpg'].compact.join('_'))
    ActionController::Base.helpers.asset_path('fallbacks/no-avatar.jpg')
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :xs do
    process resize_to_fill: [50, 50]
  end

  version :sm do
    process resize_to_fill: [100, 100]
  end

  version :md do
    process resize_to_fill: [150, 150]
  end

  version :lg do
    process resize_to_fill: [200, 200]
  end

  version :xl do
    process resize_to_fill: [600, 600]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    [model.email.gsub(/@[^\s]+/, ''), file.extension.downcase].compact.join('.') if original_filename
  end
end
