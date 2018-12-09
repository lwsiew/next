require 'rails_helper'

RSpec.describe Place, :type => :model do
  subject { described_class.new }

  it "is valid with valid attributes" do
  subject.name = "Anything"
  subject.address = "there"
  expect(subject).to be_valid
end

  it "is not valid without a name" do
  expect(subject).to_not be_valid
end

  it "is not valid without a address" do
  expect(subject).to_not be_valid
end

end