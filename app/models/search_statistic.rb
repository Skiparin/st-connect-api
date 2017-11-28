class SearchStatistic < ApplicationRecord

  serialize :job_descriptions_using_search, Hash

  validates :search_string,               presence: true,
                                          length: { maximum: 100 }

  validates :target,                      presence: true,
                                          length: { maximum: 100 }

  validates :number_of_searches,          presence: true,
  																				numericality: { greater_than_or_equal_to: 0 }


  before_validation :set_number_of_searches_to_zero, if: :new_record?


  has_and_belongs_to_many :profile

  private
  	def set_number_of_searches_to_zero
  		self.number_of_searches = 0
  	end

end
