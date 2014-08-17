# == Schema Information
#
# Table name: kitchens
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  description    :string(255)      not null
#  street_address :string(255)      not null
#  city           :string(255)      not null
#  state          :string(255)      not null
#  zipcode        :string(255)      not null
#  latitude       :float
#  longtitude     :float
#  created_at     :datetime
#  updated_at     :datetime
#  user_id        :integer
#

require 'rails_helper'

RSpec.describe Kitchen, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
