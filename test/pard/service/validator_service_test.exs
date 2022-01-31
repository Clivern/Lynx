# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Pard.Service.ValidatorServiceTest do
  @moduledoc """
  Validator Service Test Cases
  """
  use Pard.DataCase
  alias Pard.Service.ValidatorService, as: ValidatorService

  describe "validator" do
    test "validate_int/1 test cases" do
      assert ValidatorService.validate_int(1) == true
      assert ValidatorService.validate_int(10000) == true
      assert ValidatorService.validate_int(01) == true
      assert ValidatorService.validate_int(6781) == true
      assert ValidatorService.validate_int("oran") == false
      assert ValidatorService.validate_int(2.2) == false
    end

    test "parse_int/1 test cases" do
      assert ValidatorService.parse_int("20") == 20
      assert ValidatorService.parse_int(2) == 2
      assert ValidatorService.parse_int(07) == 7
    end

    test "is_empty/1 test cases" do
      assert ValidatorService.is_empty("") == true
      assert ValidatorService.is_empty("  ") == true
      assert ValidatorService.is_empty("hi") == false
    end
  end
end
