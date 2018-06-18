require 'rails_helper'

RSpec.describe Candidate, type: :model do
  it "belong to an account" do
    c = Candidate.reflect_on_association(:account)
    expect(c.macro).to eq(:belongs_to)
  end
end
