class Event < ApplicationRecord
  has_many :posts, -> { order(created_at: :desc) }
  belongs_to :user
  
  has_many :event_follows
  has_many :users, :through => :event_follows

  validates :title, { presence: true, length: { in: 3..255 } }
  validates :theme, length: { maximum: 255 }
  validates :start_date, presence: true
  validate :start_date_is_valid_datetime
  validate :end_date_is_valid_datetime
  validate :end_after_start
  validates :place, length: { maximum: 255 }
  validates :short_desc, length: { maximum: 255 }
  validates :full_desc, length: { maximum: 500 }

  private
    def start_date_is_valid_datetime
      if (DateTime.parse(start_date.to_s) rescue ArgumentError) == ArgumentError
        errors.add(:start_date, 'must be a valid datetime')
      end
    end 

    def end_date_is_valid_datetime
      if (DateTime.parse(end_date.to_s) rescue ArgumentError) == ArgumentError
        errors.add(:end_date, 'must be a valid datetime')
      end
    end 

    def end_after_start
      return if end_date.blank? || start_date.blank?
    
      if end_date < start_date
        errors.add(:end_date, "must be after the start date") 
      end 
    end
end
