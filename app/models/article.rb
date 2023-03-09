class Article < ApplicationRecord
    include Visible
    has_many :comments, dependent: :destroy
    has_rich_text :body

    has_one_attached :thumbnail

    attribute :remove_thumbnail, :boolean, default: false

    after_save :purge_thumbnail, if: :remove_thumbnail
    private def purge_thumbnail
        thumbnail.purge_later
    end

    validates :description, presence: true, length: { minimum: 5 }
    validates :title, presence: true, length: { minimum: 5 }
    validates :body, presence: true, length: { minimum: 10 }

    VALID_STATUSES = ['public', 'private', 'archived']

    validates :status, inclusion: { in: VALID_STATUSES }
end
