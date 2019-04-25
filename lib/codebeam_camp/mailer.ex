defmodule CodebeamCamp.Mailer do
  use Bamboo.Mailer, otp_app: :codebeam_camp
  alias Bamboo.Email

  def send(email, hash) do
    email_host = Application.get_env(:codebeam_camp, :email_host)
    link = "#{email_host}/active_sub?email=#{email}&hash=#{hash}"

    Email.new_email(
      to: email,
      from: "contact@codebeam.camp",
      subject: "Welcome to the CodeBeam.Camp",
      html_body:
        [
          "<img src=\"https://www.codebeam.camp/images/logo_web.png\" /><br>",
          "<h1>Thanks for joining!</h1>",
          "<br><br>",
          "You can <a href=\"#{link}\">Activate</a> it now.",
        ] |> Enum.join(),
      text_body:
        "Thanks for joining!, follow this link to activate the subscription: #{link}"
    )
    |> deliver_later()
  end
end
