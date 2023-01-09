defmodule Chargebeex.HostedPage do
  use TypedStruct

  use Chargebeex.Resource,
    resource: "hosted_page",
    only: [:retrieve, :list]

  alias Chargebeex.Client
  alias Chargebeex.Builder

  typedstruct do
    field :id, String.t()
    field :type, String.t()
    field :url, String.t()
    field :state, String.t()
    field :pass_thru_content, String.t()
    field :created_at, integer()
    field :expires_at, integer()
    field :content, map
    field :updated_at, integer()
    field :resource_version, integer()
    field :checkout_info, map()
    field :business_entity_id, String.t()
    # FIXME:"embed" field is present in the returned API fields example, but
    # not as a hosted page attribute definition
    field :embed, String.t()
    field :object, map()
  end

  def build(raw_data) do
    attrs = %{
      id: raw_data["id"],
      type: raw_data["type"],
      url: raw_data["url"],
      state: raw_data["state"],
      pass_thru_content: raw_data["pass_thru_content"],
      created_at: raw_data["created_at"],
      expires_at: raw_data["expires_at"],
      content: raw_data["content"],
      updated_at: raw_data["updated_at"],
      resource_version: raw_data["resource_version"],
      checkout_info: raw_data["checkout_info"],
      business_entity_id: raw_data["business_entity_id"],
      embed: raw_data["embed"],
      object: raw_data["object"]
    }

    struct(__MODULE__, attrs)
  end

  def collect_now(params) do
    with path <- Chargebeex.Action.resource_path_generic_without_id("hosted_page", "collect_now"),
         {:ok, _status_code, _headers, content} <- Client.post(path, params),
         builded <- Builder.build(content) do
      {:ok, Map.get(builded, "hosted_page")}
    end
  end
end
