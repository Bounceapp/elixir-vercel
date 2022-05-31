defmodule VercelTest do
  use ExUnit.Case
  doctest Vercel

  def call do
    Vercel.Domains.status(%{name: "teste"})
end
