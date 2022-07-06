defmodule Chargebeex.Fixtures.HostedPage do
  def hosted_page_params() do
    """
    {
      "created_at": 1517464663,
      "embed": false,
      "expires_at": 1517468263,
      "id": "__one_time_checkout___test__cdqM9MLUubELMycut0Cr9sHq8gOTKEZSdcu",
      "object": "hosted_page",
      "resource_version": 1517444863979,
      "state": "created",
      "type": "checkout_one_time",
      "updated_at": 1517444863,
      "url": "https://yourapp.chargebee.com/pages/v3/__one_time_checkout___test__cdqM9MLUubELMycut0Cr9sHq8gOTKEZSdcu/"
    }
    """
  end

  def retrieve() do
    """
    {
      "hosted_page": #{hosted_page_params()}
    }
    """
  end

  def list() do
    """
    {
      "list": [
        #{retrieve()},
        #{retrieve()}
      ],
      "next_offset": "1612890918000"
    }
    """
  end
end
