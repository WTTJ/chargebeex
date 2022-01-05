defmodule ChargebeeElixir.Fixtures.APIReturns do
  def not_found(params \\ %{}) do
    %{
      "message" => "Plan is not present",
      "type" => "invalid_request",
      "api_error_code" => "resource_not_found",
      "param" => "plan_id"
    }
    |> Map.merge(params)
  end

  def unauthorized(params \\ %{}) do
    %{
      "message" => "Sorry, authentication failed. Invalid API Key.",
      "api_error_code" => "api_authentication_failed"
    }
    |> Map.merge(params)
  end

  def bad_request(params \\ %{}) do
    %{
      "message" => "The plan's billing period and addon's billing period are incompatible.",
      "type" => "invalid_request"
    }
    |> Map.merge(params)
  end
end
