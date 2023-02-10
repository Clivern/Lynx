# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.ProfileView do
  use LynxWeb, :view

  def render("success.json", %{message: message}) do
    %{successMessage: message}
  end

  def render("error.json", %{message: message}) do
    %{errorMessage: message}
  end
end
