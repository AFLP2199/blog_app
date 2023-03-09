class Comment < ApplicationRecord
  include Visible
  belongs_to :article

  VALID_STATUSES = ['public', 'private', 'archived']
  
  validates :commenter, presence: true, length: { minimum: 4, maximum: 20 }
  validates :body, presence: true, length: { minimum: 10, maximum: 300 }
  validates :status, inclusion: { in: VALID_STATUSES }

  def archived?
    status == 'archived'
  end
end
