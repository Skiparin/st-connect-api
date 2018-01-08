class Notification < ApplicationRecord

  enum e_type: { 
                  new_comment: 0
               }

  validates :profile_id,                  presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }

  validates :message,                     presence: true,
                                          length: { maximum: 50 }

  validates :n_type,                      presence: true

  validates :is_read,                     presence: true, unless: :new_record?,
                                          inclusion: { in: [ true, false ] }

  validates :resource,                    presence: true,
                                          length: { maximum: 100 }
                                  
  belongs_to :profile
end
