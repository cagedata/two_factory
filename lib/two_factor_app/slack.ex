defmodule TwoFactorApp.Slack do
  def post_message(text, from) do
    message = message_from(text, from)
    |> Poison.encode!
    IO.puts "Posting #{message}"

    response = HTTPotion.post(
      Application.get_env(:two_factor_app, :webhook_url),
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
end
