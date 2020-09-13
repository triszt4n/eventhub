class Event < ApplicationRecord
    validates :title, length: { in: 3..255 }
    validates :theme, length: { maximum: 255 }
    # validates :start_date, ???
    # validates :end_date, ???
    validates :place, length: { in: 3..255 }
    validates :short_desc, length: { maximum: 255 }
    validates :full_desc, length: { maximum: 500 }
end
