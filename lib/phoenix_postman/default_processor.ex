defmodule PhoenixPostman.DefaultProcessor do
    def process_docs(docs) do
        regex = Application.get_env(:phoenix_postman, :docs_regex)
        result = Regex.named_captures(regex, docs)

        {result["title"], result["description"]}
    end

    def process_test_name(atom, _context) do
        test_name = Atom.to_string(atom)
        regex = Application.get_env(:phoenix_postman, :test_name_regex)
        result = Regex.named_captures(regex, test_name)

        result["name"]
    end
end
