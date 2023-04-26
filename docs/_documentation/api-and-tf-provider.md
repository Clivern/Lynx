---
# Page settings
layout: documentation-single
title: RESTful API and Terraform Provider
description: In this section you will learn how to use Lynx RESTful API and the terraform provider to automate the boring stuff.
keywords: terraform-backend, lynx, terraform, clivern
comments: false
order: 4
hero:
    title: RESTful API and Terraform Provider
    text: In this section you will learn how to use Lynx RESTful API and the terraform provider to automate the boring stuff.
---

## Lynx RESTful API

We provide a [Swagger/OpenAPI Specification](https://raw.githubusercontent.com/Clivern/Lynx/main/api.yml) that defines the structure and behavior of a RESTful API. You can use [the swagger editor](https://editor.swagger.io/) to render the API documentation.

Here's a brief documentation on how to use this API:

#### Authentication

The API requires authentication using an API key. The key should be included in the Authorization header with the value `Bearer <api_key>`.

#### Endpoints

Users

- `GET /api/v1/user` - Get a list of users
- `POST /api/v1/user` - Create a new user
- `GET /api/v1/user/{id}` - Get a user
- `PUT /api/v1/user/{id}` - Update a user
- `DELETE /api/v1/user/{id}` - Delete a user

Teams

- `POST /api/v1/team` - Create a new team
- `GET /api/v1/team` - Get a list of teams
- `GET /api/v1/team/{id}` - Get a team
- `PUT /api/v1/team/{id}` - Update a team
- `DELETE /api/v1/team/{id}` - Delete a team

Projects

- `POST /api/v1/project` - Create a new project
- `GET /api/v1/project` - Get a list of projects
- `GET /api/v1/project/{id}` - Get a project
- `PUT /api/v1/project/{id}` - Update a project
- `DELETE /api/v1/project/{id}` - Delete a project

Environments

- `POST /api/v1/project/{projectId}/environment` - Create a new environment
- `GET /api/v1/project/{projectId}/environment` - Get a list of environments
- `GET /api/v1/project/{projectId}/environment/{environmentId}` - Get an environment
- `PUT /api/v1/project/{projectId}/environment/{environmentId}` - Update an environment
- `DELETE /api/v1/project/{projectId}/environment/{environmentId}` - Delete an environment

Snapshots

- `POST /api/v1/snapshot` - Create a new snapshot
- `GET /api/v1/snapshot` - Get a list of snapshots
- `GET /api/v1/snapshot/{id}` - Get a snapshot
- `PUT /api/v1/snapshot/{id}` - Update a snapshot
- `DELETE /api/v1/snapshot/{id}` - Delete a snapshot


The API expects JSON request bodies for creating/updating resources like users, teams, projects, environments, and snapshots. The request schemas are defined under `#/components/schemas`, for example:

- `UserCreate` for creating a new user
- `TeamUpdate` for updating an existing team
- `ProjectCreate` for creating a new project
- `EnvironmentUpdate` for updating an environment
- `SnapshotCreate` for creating a new snapshot

#### Responses

The API returns JSON responses with data and metadata. Successful responses include:

- `201 Created` when a new resource is created, returning the new resource object
- `200 OK` when getting or updating an existing resource, returning the resource object
- `204 No Content` when deleting a resource successfully

Error responses include:

- `404 Not Found` if the requested resource does not exist
- `500 Internal Server Error` for any other errors, with an ErrorResponse object providing details

The response schemas are defined under `#/components/schemas` as well, such as:

- `User` for user objects
- `Team` for team objects
- `Project` for project objects
- `Environment` for environment objects
- `Snapshot` for snapshot objects

For list endpoints that return multiple resources, the response contains:

- An array of resource objects under the resources property
- Metadata like `limit`, `offset`, and `totalCount`

So in summary, the requests accept JSON for creating/updating, and the responses return JSON data or error objects and standard HTTP status codes.


## Lynx Terraform Provider

Here is an example to setup team, team users, project, project environment and a snapshot using our terraform provider.

```
terraform {
  required_providers {
    lynx = {
      source = "Clivern/lynx"
      version = "0.3.0"
    }
  }
}

provider "lynx" {
  api_url = "http://localhost:4000/api/v1"
  api_key = "~api key here~"
}

resource "lynx_user" "stella" {
  name     = "Stella"
  email    = "stella@example.com"
  role     = "regular"
  password = "~password-here~"
}

resource "lynx_user" "skylar" {
  name     = "Skylar"
  email    = "skylar@example.com"
  role     = "regular"
  password = "~password-here~"
}

resource "lynx_user" "erika" {
  name     = "Erika"
  email    = "erika@example.com"
  role     = "regular"
  password = "~password-here~"
}

resource "lynx_user" "adriana" {
  name     = "Adriana"
  email    = "adriana@example.com"
  role     = "regular"
  password = "~password-here~"
}

resource "lynx_team" "monitoring" {
  name        = "Monitoring"
  slug        = "monitoring"
  description = "System Monitoring Team"

  members = [
    lynx_user.stella.id,
    lynx_user.skylar.id,
    lynx_user.erika.id,
    lynx_user.adriana.id
  ]
}

resource "lynx_project" "grafana" {
  name        = "Grafana"
  slug        = "grafana"
  description = "Grafana Project"

  team = {
    id = lynx_team.monitoring.id
  }
}

resource "lynx_environment" "prod" {
  name     = "Development"
  slug     = "dev"
  username = "~username-here~"
  secret   = "~secret-here~"

  project = {
    id = lynx_project.grafana.id
  }
}

resource "lynx_snapshot" "my_snapshot" {
  title       = "Grafana Project Snapshot"
  description = "Grafana Project Snapshot"
  record_type = "project"
  record_id   = lynx_project.grafana.id

  team = {
    id = lynx_team.monitoring.id
  }
}
```

The provided code is a Terraform configuration that uses the "lynx" provider to manage resources in a hypothetical API. Here's a brief explanation:


#### Providers

The `required_providers` block specifies that the `lynx provider` (version 0.3.0) should be used. The provider block configures the `lynx provider` with the `API URL` and `API key`.


#### Resources

- Users: The `lynx_user` resources create four users (Stella, Skylar, Erika, and Adriana) with regular roles and specified email addresses and passwords.
- Team: The `lynx_team` resource creates a team named "Monitoring" with the four users as members.
- Project: The `lynx_project` resource creates a project named "Grafana" and associates it with the "Monitoring" team.
- Environment: The `lynx_environment` resource creates an environment named "Development" with a specified username and secret, associated with the "Grafana" project.
- Snapshot: The `lynx_snapshot` resource creates a snapshot titled "Grafana Project Snapshot" of type "project" for the "Grafana" project, associated with the "Monitoring" team
