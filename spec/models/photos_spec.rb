# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  picture    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  kitchen_id :integer          not null
#
# Indexes
#
#  index_photos_on_kitchen_id  (kitchen_id)
#

require 'rails_helper'

RSpec.describe Photos, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
