# == Schema Information
#
# Table name: kitchens
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  description    :text             not null
#  street_address :string(255)      not null
#  city           :string(255)      not null
#  state          :string(255)      not null
#  zipcode        :string(255)      not null
#  latitude       :float
#  longtitude     :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer          not null
#  data_status    :string(255)      default("active"), not null
#
# Indexes
#
#  index_kitchens_on_user_id  (user_id)




require 'rails_helper'

RSpec.describe Kitchen, :type => :model do
  it { should have_many(:reservations) }
  it { should belong_to(:user) }

  describe "#valid?" do
    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_least(6) }
    it { should ensure_length_of(:name).is_at_most(50)}
    it { should allow_value("myktichen123", "someone's kitchen").for(:name) }
    it { should_not allow_value("@123").for(:name) }
    it { should_not allow_value("1234t").for(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_presence_of(:data_status) }
  end
end
