defmodule CodebeamCamp.Mailer do
  use Bamboo.Mailer, otp_app: :codebeam_camp
  alias Bamboo.Email

  def send(email, hash) do
    Email.new_email(
      to: email,
      from: "contact@codebeam.camp",
      subject: "Welcome to the CodeBeam.Camp",
      html_body:
        "<h1>Thanks for joining!</hr><br><br>You can <a href=\"https://www.codebeam.camp/active_sub?email=#{
          email
        }&hash=#{hash}\">activate</a> it now.",
      text_body:
        "Thanks for joining!, follow this link to activate the subscription: https://www.codebeam.camp/active_sub?email=#{
          email
        }&hash=#{hash}"
    )
    |> deliver_later()
  end
end
