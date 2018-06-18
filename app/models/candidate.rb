class Candidate < ApplicationRecord
  belongs_to :account

  def self.create_new_candidates(account, candidates)
    candidates.each do |candidate|
      image = "#{candidate["thumbnail"]["path"]}/portrait_xlarge.#{candidate["thumbnail"]["extension"]}"
      create(name: candidate["name"], description: candidate["description"],
          image: image, account_id: account )
    end
  end
end
