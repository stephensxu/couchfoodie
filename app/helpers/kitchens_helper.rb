module KitchensHelper
  def kitchen_location(kitchen)
    "%s, %s, %s, %s" % [kitchen.street_address, kitchen.city, kitchen.state, kitchen.zipcode]
  end

  def kitchen_location_no_street(kitchen)
    "%s, %s, %s" % [kitchen.city, kitchen.state, kitchen.zipcode]
  end
end
