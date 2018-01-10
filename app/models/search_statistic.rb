class SearchStatistic < ApplicationRecord

  serialize :job_descriptions_using_search, Hash

  validates :search_string,               presence: true,
                                          length: { maximum: 100 }

  validates :target,                      presence: true,
                                          length: { maximum: 100 }

  validates :number_of_searches,          presence: true,
  																				numericality: { greater_than_or_equal_to: 0 }


  before_validation :set_number_of_searches_to_one, if: :new_record?


  has_and_belongs_to_many :profile

  def get_max_ten_pairs
    job_desc_hash = self.job_descriptions_using_search
    if job_desc_hash.length <= 5
      return job_desc_hash
    end
    sorted_hash = job_desc_hash.sort.reverse
    return_hash = {}
    sorted_hash.each do |s_h| 
      if return_hash.length == 5
        break
      end
      return_hash[s_h[0]] = s_h[1]
    end
    return return_hash
  end

  private
  	def set_number_of_searches_to_one
  		self.number_of_searches = 1
  	end
end
