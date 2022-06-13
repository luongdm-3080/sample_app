class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  delegate :name, to: :user
  validates :content, presence: true,
            length: {maximum: Settings.digits.length_content_max_140}

  validates :image,
            content_type: {in: Settings.image.accept_format,
                           message: I18n.t(".invalid_img_type")},
            size: {less_than: Settings.image.max_size.megabytes,
                   message: I18n.t(".invalid_img_size")}

  scope :newest, ->{order created_at: :desc}

  def display_image
    image.variant(resize_to_limit: Settings.range_500)
  end
end
