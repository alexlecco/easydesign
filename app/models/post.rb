class Post < ActiveRecord::Base
  belongs_to :user
  has_many :attachments
  validates :title, presence: true, uniqueness: true
  include Picturable
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
end
