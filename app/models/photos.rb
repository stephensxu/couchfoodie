# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  picture    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Photos < ActiveRecord::Base
end
