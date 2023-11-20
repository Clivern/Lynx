# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LynxWeb.MiscView do
  use LynxWeb, :view

  def render("error.json", %{message: message}) do
    %{errorMessage: message}
  end

  def render("success.json", %{message: message}) do
    %{successMessage: message}
  end

  def render("token_success.json", %{message: message}) do
    %{
      successMessage: message
    }
  end
end
