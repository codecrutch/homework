# == Schema Information
#
# Table name: visits
#
#  id               :integer          not null, primary key
#  submitter_id     :integer          not null
#  shortened_url_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Visit < ActiveRecord::Base
  validates :submitter_id, :shortened_url_id, presence: true

  belongs_to :shortened_url,
    class_name: :ShortenedUrl,
    primary_key: :id,
    foreign_key: :shortened_url_id

  belongs_to :submitter,
    class_name: :User,
    primary_key: :id,
    foreign_key: :submitter_id

  def self.record_visit!(user, shortened_url)
    Visit.create(submitter_id: user.id, shortened_url_id: shortened_url.id)
  end
end
