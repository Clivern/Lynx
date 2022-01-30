# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule PardWeb.InstallView do
  use PardWeb, :view

  def render("error.json", %{error: error}) do
    %{errorMessage: error}
  end

  def render("success.json", %{message: message}) do
    %{successMessage: message}
  end
end
