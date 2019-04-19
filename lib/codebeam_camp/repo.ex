defmodule CodebeamCamp.Repo do
  use Ecto.Repo,
    otp_app: :codebeam_camp,
    adapter: Ecto.Adapters.Postgres
end
