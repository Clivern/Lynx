# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Bandit.Service.SlugServiceTest do
  @moduledoc """
  Slug Service Test Cases
  """
  use Bandit.DataCase
  alias Bandit.Service.SlugService, as: SlugService

  describe "slug" do
    test "create/1 test cases" do
      assert SlugService.create("HellO") == "hello"
      assert SlugService.create("Hello World") == "hello-world"
    end
  end
end
