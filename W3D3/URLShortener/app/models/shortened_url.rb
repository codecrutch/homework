# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, presence: true, uniqueness: true
  validates :user_id, presence: true

  belongs_to :submitter,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  has_many :visits,
    class_name: :Visit,
    primary_key: :id,
    foreign_key: :shortened_url_id

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :submitter

  def self.random_code
    begin
      rcode = SecureRandom.urlsafe_base64
      raise SlugDuplicate.new('Slug exists') if self.exists?(['short_url LIKE ?', "%#{rcode}%"])
    rescue SlugDuplicate
      retry
    end

    rcode
  end

  def self.shorten_url(user, long_url)
    slug = ShortenedUrl.random_code
    ShortenedUrl.create!(long_url: long_url, short_url: slug, user_id: user.id)
  end

  class SlugDuplicate < StandardError; end

  def num_clicks
    visits.count
  end

  def num_uniques
    visits.distinct.count
  end

  def num_recent_uniques
    visits.where('created_at < ?', 10.minutes.ago)
  end

end
