# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Lynx.Service.ValidatorService do
  @moduledoc """
  Validator Service
  """
  alias Lynx.Context.UserContext
  alias Lynx.Context.TeamContext
  alias Lynx.Context.ProjectContext
  alias Lynx.Context.EnvironmentContext
  alias Lynx.Exception.InvalidRequest

  def is_number?(value, err) do
    case Validate.validate(value, type: :number) do
      {:ok, value} ->
        {:ok, value}

      {:error, _} ->
        {:error, err}
    end
  end

  def is_integer?(value, err) do
    case Validate.validate(value, type: :integer) do
      {:ok, value} ->
        {:ok, value}

      {:error, _} ->
        {:error, err}
    end
  end

  def is_float?(value, err) do
    case Validate.validate(value, type: :float) do
      {:ok, value} ->
        {:ok, value}

      {:error, _} ->
        {:error, err}
    end
  end

  def is_string?(value, err) do
    case Validate.validate(value, type: :string) do
      {:ok, value} ->
        {:ok, value}

      {:error, _} ->
        {:error, err}
    end
  end

  def is_list?(value, err) do
    case Validate.validate(value, type: :list) do
      {:ok, value} ->
        {:ok, value}

      {:error, _} ->
        {:error, err}
    end
  end

  def is_not_empty_list?(value, err) do
    case length(value) > 0 do
      true ->
        {:ok, value}

      false ->
        {:error, err}
    end
  end

  def not_in?(value, list, err) do
    case Validate.validate(value, type: :string, not_in: list) do
      {:ok, value} ->
        {:ok, value}

      {:error, _} ->
        {:error, err}
    end
  end

  def in?(value, list, err) do
    case Validate.validate(value, type: :string, in: list) do
      {:ok, value} ->
        {:ok, value}

      {:error, _} ->
        {:error, err}
    end
  end

  def is_not_empty?(value, err) do
    case Validate.validate(value, required: true) do
      {:ok, value} ->
        {:ok, value}

      {:error, _} ->
        {:error, err}
    end
  end

  def is_uuid?(value, err) do
    case Validate.validate(value, type: :string, uuid: true) do
      {:ok, value} ->
        {:ok, value}

      {:error, _} ->
        {:error, err}
    end
  end

  def is_url?(value, err) do
    case Validate.validate(value, type: :string, url: true) do
      {:ok, value} ->
        {:ok, value}

      {:error, _} ->
        {:error, err}
    end
  end

  def is_email?(value, err) do
    case Validate.validate(value,
           type: :string,
           regex: ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/
         ) do
      {:ok, value} ->
        {:ok, value}

      {:error, _} ->
        {:error, err}
    end
  end

  def is_password?(value, err) do
    case Validate.validate(value, type: :string, regex: ~r/^(?=.*\D)[^\s]{6,32}$/) do
      {:ok, value} ->
        {:ok, value}

      {:error, _} ->
        {:error, err}
    end
  end

  def is_length_between?(value, min, max, err) do
    if String.length(value) >= min and String.length(value) <= max do
      {:ok, value}
    else
      {:error, err}
    end
  end

  def is_email_used?(email, user_uuid, err) do
    case UserContext.get_user_by_email(email) do
      nil ->
        {:ok, email}

      user ->
        case {user_uuid, user.id == user_uuid} do
          {nil, _} ->
            {:error, err}

          {_, false} ->
            {:error, err}

          {_, true} ->
            {:ok, email}
        end
    end
  end

  def is_team_slug_used?(slug, team_uuid, err) do
    case TeamContext.get_team_by_slug(slug) do
      nil ->
        {:ok, slug}

      team ->
        case {team_uuid, team.uuid == team_uuid} do
          {nil, _} ->
            {:error, err}

          {_, false} ->
            {:error, err}

          {_, true} ->
            {:ok, slug}
        end
    end
  end

  def is_project_slug_used?(slug, team_uuid, project_uuid, err) do
    case TeamContext.get_team_id_with_uuid(team_uuid) do
      nil ->
        raise InvalidRequest, message: "Team with id #{team_uuid} not found"

      team_id ->
        case ProjectContext.get_project_by_slug_team_id(slug, team_id) do
          nil ->
            {:ok, slug}

          project ->
            case {project_uuid, project.uuid == project_uuid} do
              {nil, _} ->
                {:error, err}

              {_, false} ->
                {:error, err}

              {_, true} ->
                {:ok, slug}
            end
        end
    end
  end

  def is_environment_slug_used?(slug, project_uuid, environment_uuid, err) do
    case ProjectContext.get_project_id_with_uuid(project_uuid) do
      nil ->
        raise InvalidRequest, message: "Project with id #{project_uuid} not found"

      project_id ->
        case EnvironmentContext.get_env_by_slug_project(project_id, slug) do
          nil ->
            {:ok, slug}

          env ->
            case {environment_uuid, env.uuid == environment_uuid} do
              {nil, _} ->
                {:error, err}

              {_, false} ->
                {:error, err}

              {_, true} ->
                {:ok, slug}
            end
        end
    end
  end
end
