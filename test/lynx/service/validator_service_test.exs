# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Service.ValidatorServiceTest do
  @moduledoc """
  Validator Service Test Cases
  """
  use Lynx.DataCase
  alias Lynx.Service.ValidatorService, as: ValidatorService

  describe "validator" do
    test "is_not_empty?/2 test cases" do
      assert ValidatorService.is_not_empty?("", "err1") == {:error, "err1"}
      assert ValidatorService.is_not_empty?("hi", "err1") == {:ok, "hi"}
    end
  end
end
