require 'rails_helper'

RSpec.describe Account, type: :model do
  it "should have many candidates" do
    a = Account.reflect_on_association(:candidates)
    expect(a.macro).to eq(:has_many)
  end
end
