defmodule Mix.Tasks.Postman do
  use Mix.Task

  @schema_url "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"

  @shortdoc "Generates a Postman collection from a test suite run"
  def run(args) do
    process_name = Application.get_env(:phoenix_postman, :task_process_name)

    {:ok, bucket} = Agent.start_link(fn -> %{} end)

    Process.register(bucket, process_name)
    Mix.Tasks.Test.run(args)
    Process.unregister(process_name)

    # "info" => %{
    #   "name" => Application.get_env(:phoenix_postman, :collection)[:name],
    #   "description" => Application.get_env(:phoenix_postman, :collection)[:description],
    #   "schema" => @schema_url
    # }
  end
end
