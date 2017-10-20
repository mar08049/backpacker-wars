class Traveler < ActiveRecord::Base
  has_many :countries
  has_secure_password

  def slug
    username.downcase.split.join("-")
  end

  def self.find_by_slug(slug)
    self.all.detect {|s| s.slug == slug}
  end
end
