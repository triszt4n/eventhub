class Event < ApplicationRecord
  has_many :posts
  belongs_to :user

  validates :title, length: { in: 3..255 }
  validates :theme, length: { maximum: 255 }
  validate :start_date_is_valid_datetime
  validate :end_date_is_valid_datetime
  validate :end_after_start
  validates :place, length: { in: 3..255 }
  validates :short_desc, length: { maximum: 255 }
  validates :full_desc, length: { maximum: 500 }

  private
    def start_date_is_valid_datetime
      errors.add(:start_date, 'must be a valid datetime') if ((DateTime.parse(start_date) rescue ArgumentError) == ArgumentError)
    end 

    def end_date_is_valid_datetime
      errors.add(:end_date, 'must be a valid datetime') if ((DateTime.parse(end_date) rescue ArgumentError) == ArgumentError)
    end 

    def end_after_start
      return if end_date.blank? || start_date.blank?
    
      if end_date < start_date
        errors.add(:end_date, "must be after the start date") 
      end 
    end
end
