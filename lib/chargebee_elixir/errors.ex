defmodule ChargebeeElixir.UnauthorizedError do
  defexception message: "Unauthorized"
end

defmodule ChargebeeElixir.InvalidRequestError do
  defexception message: "Invalid request"
end

defmodule ChargebeeElixir.NotFoundError do
  defexception message: "Not found"
end

defmodule ChargebeeElixir.UnknownError do
  defexception message: "Unknown"
end
