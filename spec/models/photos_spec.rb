# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  picture    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Photos, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
