# Copyright 2022 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Civet.Service.LocationServiceTest do
  @moduledoc """
  Location Service Test Cases
  """
  use Civet.DataCase
  alias Civet.Service.LocationService, as: LocationService

  describe "location" do
    test "validate_country_by_id/1 test cases" do
      assert LocationService.validate_country_by_id("luxembourg") == true
      assert LocationService.validate_country_by_id("norway") == true
      assert LocationService.validate_country_by_id("romania") == true
      assert LocationService.validate_country_by_id("romani") == false
    end

    test "validate_country_by_name/1 test cases" do
      assert LocationService.validate_country_by_name("Afghanistan") == true
      assert LocationService.validate_country_by_name("Jamaica") == true
      assert LocationService.validate_country_by_name("Nigeria") == true
      assert LocationService.validate_country_by_name("Nigeri") == false
    end

    test "get_countries_ids/0 test cases" do
      assert length(LocationService.get_countries_ids()) == 195
    end

    test "get_countries_name/0 test cases" do
      assert length(LocationService.get_countries_name()) == 195
    end
  end
end
