class SearchStatistic < ApplicationRecord

  serialize :job_descriptions_using_search, Array

  validates :search_string,               presence: true,
                                          length: { maximum: 100 }

  validates :target,                      presence: true,
                                          length: { maximum: 100 }

  validates :number_of_searches,          presence: true,
                                          numericality: { greater_than_or_equal_to: 0 }


  has_and_belongs_to_many :profile
  
end
