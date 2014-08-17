# == Schema Information
#
# Table name: reservations
#
#  id           :integer          not null, primary key
#  status       :string(255)      default("pending"), not null
#  reserve_date :date             not null
#  reserve_time :time             not null
#  message      :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  kitchen_id   :integer
#

require 'rails_helper'

RSpec.describe Reservation, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
