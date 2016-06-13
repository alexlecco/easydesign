class Post < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :attachments
  validates :title, presence: true, uniqueness: true
  include Picturable
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  before_save :set_default_value

  def set_default_value
    self.cost ||= 0
  end
end
