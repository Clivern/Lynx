# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule LeopardWeb.StateView do
  use LeopardWeb, :view

  @doc """
  Lock Render
  """
  def render("lock_data.json", %{lock: lock}) do
    %{
      ID: lock.tf_uuid,
      Path: lock.tf_path,
      Operation: lock.tf_operation,
      Who: lock.tf_who,
      Version: lock.tf_version,
      Created: lock.updated_at,
      Info: lock.tf_info
    }
  end

  @doc """
  Error Render
  """
  def render("error.json", %{message: msg}) do
    %{message: msg}
  end
end
