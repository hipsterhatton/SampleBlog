class Blog < ApplicationRecord
  validates :title, :content, presence: true

  before_save :sanitize_attributes

  private

  def sanitize_attributes
    # Create a Rails scrubber to remove any unwanted HTML attributes
    _scrubber = Rails::Html::TargetScrubber.new
    _scrubber.tags = ["script", "css", "style", "img"]

    # Iterate, scrub, reassign
    [:title, :content].each do |_a|
      _attr = Loofah.fragment(self.attributes[_a.to_s])
      _attr.scrub!(_scrubber)
      self.assign_attributes(_a => _attr.to_s)
    end

    # Scrub tags
    (0..self.tags.size).each do |_i|
      self.tags[_i] = _attr.scrub(self.tags[_i])
    end
  end
end
