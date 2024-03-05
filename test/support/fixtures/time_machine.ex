defmodule Chargebeex.Fixtures.TimeMachine do
  def time_machine_params() do
    """
    {
      "destination_time": 1585065021,
      "genesis_time": 1585065021,
      "name": "delorean",
      "object": "time_machine",
      "time_travel_status": "succeeded"
    }
    """
  end

  def retrieve() do
    """
    {
      "time_machine": #{time_machine_params()}
    }
    """
  end
end
