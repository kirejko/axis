require 'redcarpet'

# Article model
class Article < ApplicationRecord
  mount_uploaders :attachments, AttachmentUploader
  serialize :attachments, JSON

  # Relations
  belongs_to :user

  # Pagination
  paginates_per 6

  def parsed_body
    markdown.render(body)
  end

  private

  def markdown
    Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      markdown_settings
    )
  end

  def markdown_settings
    {
      autolink:                     true,
      tables:                       true,
      strikethrough:                true,
      underline:                    true,
      highlight:                    true,
      quote:                        true,
      fenced_code_blocks:           true,
      disable_indented_code_blocks: true
    }
  end
end
