defmodule Smaug.PatternMatchTest do
  use Smaug.ConnCase

  def this_is(x) when is_nil(x), do: "This is nil"
  def this_is(x) when is_atom(x), do: "This is Atom"
  def this_is(x) when is_binary(x), do: "This is Binary"
  def this_is(x) when is_bitstring(x), do: "This is Bitstring"
  def this_is(x) when is_boolean(x), do: "This is Boolean"
  def this_is(x) when is_integer(x), do: "This is Integer"
  def this_is(x) when is_float(x), do: "This is Float"
  def this_is(x) when is_list(x), do: "This is List"
  def this_is(x) when is_tuple(x) and tuple_size(x) == 2, do: "This is Tuple with two elements"
  def this_is(x) when is_tuple(x), do: "This is Tuple"
  def this_is(x) when is_map(x), do: "This is Map"
  def this_is(x) when is_function(x, 2), do: "This is Function with two arguments"
  def this_is(x) when is_function(x), do: "This is Function"

  def this_is_number(x) when is_number(x), do: "This is Number; can be both Integer/Float"
  def this_is_actually_boolean(x) when is_boolean(x), do: "This is Actually Boolean"

  def they_are(x, y) when is_atom(x) and is_binary(y), do: "They are Atom and Binary"

  test "nil in guards", _ do
    assert this_is(nil) == "This is nil"
  end

  test "Atoms in guards", _ do
    assert this_is(:foobar) == "This is Atom"
    assert this_is(false) == "This is Atom"
  end

  test "Strings in guards", _ do
    assert this_is("foobar") == "This is Binary"
    assert this_is(<<102>>) == "This is Binary"
    assert this_is(<< 1 :: size(1)>>) == "This is Bitstring"
    assert this_is('foobar') == "This is List"
  end

  test "Booleans in guards", _ do
    assert this_is(true) != "This is Boolean" # this matches is_atom so the function returns "This is Atom"
    assert this_is_actually_boolean(true) == "This is Actually Boolean"
    assert this_is_actually_boolean(:true) == "This is Actually Boolean" # this matches is_boolean too because true/false are technically atom
  end

  test "Numbers in guards", _ do
    assert this_is(1) == "This is Integer"
    assert this_is(0b10) == "This is Integer" # Binary
    assert this_is(0o77) == "This is Integer" # Octal
    assert this_is(0x1F) == "This is Integer" # Hexadecimal
    assert this_is(0.1) == "This is Float"
    assert this_is_number(101) == "This is Number; can be both Integer/Float"
    assert this_is_number(1.1) == "This is Number; can be both Integer/Float"
  end

  test "Lists in guards", _ do
    assert this_is([:ok, "foo", 0]) == "This is List"
    assert this_is('foobar') == "This is List"
    assert this_is([foo: 1, bar: 2]) == "This is List"
  end

  test "Tuples in guards", _ do
    assert this_is({:error}) == "This is Tuple"
    assert this_is({:ok, "foo"}) == "This is Tuple with two elements"
  end

  test "Maps in guards", _ do
    assert this_is(%{:foo => "foo", "bar" => "bar"}) == "This is Map"
  end

  test "Functions in guards", _ do
    double = fn(x) -> x * 2 end
    remainder = &rem/2

    assert this_is(double) == "This is Function"
    assert this_is(remainder) == "This is Function with two arguments"
  end

  test "Multiple arguments in guards", _ do
    assert they_are(:ok, "foobar") == "They are Atom and Binary"
  end

end
