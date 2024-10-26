class ProjectSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id,
    :title,
    :body,
    :date_created,
    :participants,
    :moderation_status,
    :updated_at,
    :images

  attribute :keywords

  def keywords
    return nil if object.keywords.empty?  # Return nil if no keywords are present

    object.keywords.map { |keyword| keyword.slice(:id, :description) }
  end

  def images
    # Check if images are attached, then map each image to its path
    if object.images.attached?
      object.images.map { |image| rails_blob_path(image, only_path: true) }
    end
  end
end
