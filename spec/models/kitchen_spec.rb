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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer          not null
#  data_status    :string(255)      default("active"), not null
#
# Indexes
#
#  index_kitchens_on_user_id  (user_id)
#


require 'rails_helper'

RSpec.describe Kitchen, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
