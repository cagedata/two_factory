defmodule TwoFactorApp.Slack do
  def post_message(text, from) do
    message = message_from(text, from)
    |> Poison.encode!
    IO.puts "Posting #{message}"

    response = HTTPotion.post(
      webhook_url(),
      [body: message, headers: ["Content-Type": "application/json"]]
    )
    IO.puts "Received (#{response.status_code}): #{response.body}"
  end

  defp message_from(text, from) do
    %{
      "text" => "New SMS",
      "attachments": [
        %{
          "title": "SMS Received from #{from}",
          "text": text
        }
      ]
    }
  end

  defp webhook_url, do: webhook_url(Application.get_env(:two_factor_app, :webhook_url))
  defp webhook_url({:system, var}), do: var |> System.get_env
  defp webhook_url(u), do: u
end
