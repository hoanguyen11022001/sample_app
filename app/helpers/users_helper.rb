module UsersHelper
  include SessionsHelper
  def gravatar_for user
    gravatar_id = Digest::MD5.hexdigest user.email
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def should_show_delete? user
    current_user.admin && current_user != user
  end
end
