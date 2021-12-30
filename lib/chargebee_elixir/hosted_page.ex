defmodule ChargebeeElixir.HostedPage do
  use ChargebeeElixir.Resource, "hosted_page"

  def checkout_new(params) do
    create(params, "/checkout_new")
  end

  def checkout_existing(params) do
    create(params, "/checkout_existing")
  end
end
