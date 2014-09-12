module UsersHelper
  def user_photo_url(user, params = {})
    uri = Addressable::URI.parse(user.image)
    uri.query = params.to_param
    uri.to_s
  end

  def user_photo_tag(user, params = {})
    image_tag(user_photo_url(user, params))
  end
end
