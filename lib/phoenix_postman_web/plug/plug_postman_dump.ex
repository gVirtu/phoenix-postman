defmodule Plug.PostmanDump do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    #File.write(@dump_file, "\n----------------------------------------------\n", [:append])
    #File.write(@dump_file, "PATH: #{conn.method} #{conn.request_path}\n", [:append])
    #File.write(@dump_file, "REQUEST:\n#{Poison.encode!(conn.body_params, pretty: true)}\n", [:append])
    register_before_send(conn, fn(conn) ->
      process_name = Application.get_env(:phoenix_postman, :task_process_name)
      process_pid = Process.whereis(process_name)

      if process_pid do
        IO.inspect conn
        module = Phoenix.Controller.controller_module(conn)
        action = Phoenix.Controller.action_name(conn)

        IO.inspect module
        IO.inspect action

        {title, description} = extract_docs(module, action)

        IO.inspect extract_test_data([title: title, description: description])

        response = conn.resp_body
        |> Poison.decode!()

        IO.inspect extract_route(conn), label: "ROUTE: "

        # File.write(@dump_file, "RESPONSE:\n#{Poison.encode!(response, pretty: true)}\n", [:append])
      end

      conn
    end)
  end

  defp extract_docs(module, function, arity \\ 2) do
    {_, _, _, _, doc} = module
    |> Code.get_docs(:docs)
    |> Enum.find(fn {{^function, ^arity}, _line, _type, _args, _doc} -> true
                                     _ -> false end)

    processor = Application.get_env(:phoenix_postman, :docs_processor)

    case doc do
      x when x in [nil, false] -> {Atom.to_string(function) |> Macro.camelize(), ""}
                             _ -> processor.(doc)
    end
  end

  defp extract_test_data(opts) do
    {module, function, arity, _} =
      self()
      |> Process.info(:current_stacktrace)
      |> extract_stacktrace_data()
      |> Enum.find(fn {_module, function, 1, _opts} -> function
                                                    |> Atom.to_string()
                                                    |> String.starts_with?("test ")

                                                  _ -> false end)

    processor = Application.get_env(:phoenix_postman, :test_name_processor)

    function |> processor.(opts ++ [module: module])
  end

  defp extract_route(conn) do
    endpoint = conn.private.phoenix_endpoint
    action = conn.private.phoenix_action
    escaped_params = conn.path_params
                   |> Enum.map(fn {k, _v} -> {k, "{{#{String.upcase(k)}}}"} end)
                   |> Map.new()

    router_helpers = conn.private.phoenix_router
                   |> Module.concat(Helpers)

    path_function = conn.private.phoenix_pipelines
                    |> Enum.join("_")
                    |> Kernel.<>("_path")

    IO.inspect [action, escaped_params], label: "args"

    apply(router_helpers ,String.to_atom(path_function), [endpoint, action, escaped_params])
  end

  defp extract_stacktrace_data({:current_stacktrace, data}), do: data
end
