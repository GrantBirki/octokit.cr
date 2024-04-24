require "../models/repos"
require "../models/repo_deployments"

module Octokit
  class Client
    # Methods for the Deployments API
    #
    # **See Also:**
    # - [https://developer.github.com/v3/repos/commits/deployments/](https://developer.github.com/v3/repos/commits/deployments/)

    module Deployments
      # :nodoc:
      alias Repository = Models::Repository

      # Fetch a single deployment for a repository
      #
      # **See Also:**
      # - [https://developer.github.com/v3/repos/deployments/#get-a-single-deployment](https://developer.github.com/v3/repos/deployments/#get-a-single-deployment)
      #
      # **Examples:**
      #
      # Fetch a single deployment for a repository
      #
      # ```
      # Octokit.deployment("monsalisa/app", 123456)
      # ```
      def deployment(repo : String, deployment_id : Int32, **options)
        get("#{Repository.path(repo)}/deployments/#{deployment_id}", options)
      end

      # List deployments for a repository
      #
      # **See Also:**
      # - [https://developer.github.com/v3/repos/deployments/#list-deployments](https://developer.github.com/v3/repos/deployments/#list-deployments)
      #
      # **Examples:**
      # List deployments for a repository
      #
      # ```
      # Octokit.deployments("monalisa/app")
      # ```
      #
      # An alias method exists for `deployments` called `list_deployments` which can be used interchangeably
      def deployments(repo : String, **options)
        get("#{Repository.path(repo)}/deployments", options)
      end

      # Alias for `deployments`
      def list_deployments(repo : String, **options)
        deployments(repo, **options)
      end

      # Create a deployment for a ref
      # The ref parameter can be any named branch, tag, or SHA
      #
      # **See Also:**
      # - [https://developer.github.com/v3/repos/deployments/#create-a-deployment](https://developer.github.com/v3/repos/deployments/#create-a-deployment)
      #
      # **Examples:**
      # Create a deployment for a ref
      #
      # ```
      # Octokit.create_deployment("monalisa/app", "main")
      # ```
      def create_deployment(repo : String, ref : String, **options)
        post("#{Repository.path(repo)}/deployments", options.merge(ref: ref))
      end

      # Delete a Deployment
      #
      # If the repository only has one deployment, you can delete the deployment regardless of its status. If the repository has more than one deployment, you can only delete inactive deployments. This ensures that repositories with multiple deployments will always have an active deployment.
      #
      # To set a deployment as inactive, you must:
      #
      # Create a new deployment that is active so that the system has a record of the current state, then delete the previously active deployment.
      # Mark the active deployment as inactive by adding any non-successful deployment status.
      #
      # **See Also:**
      # - [https://developer.github.com/v3/repos/deployments/#delete-a-deployment](https://developer.github.com/v3/repos/deployments/#delete-a-deployment)
      # **Examples:**
      #
      # ```
      # Octokit.delete_deployment("monalisa/app", 123456)
      # ```
      def delete_deployment(repo : String, deployment_id : Int32, **options)
        delete("#{Repository.path(repo)}/deployments/#{deployment_id}", options)
      end

      # List all statuses for a Deployment
      #
      # **See Also:**
      # - [https://developer.github.com/v3/repos/deployments/#list-deployment-statuses](https://developer.github.com/v3/repos/deployments/#list-deployment-statuses)
      #
      # **Examples:**
      #
      # ```
      # Octokit.deployment_statuses("https://api.github.com/repos/monalisa/app/deployments/123456")
      # ```
      #
      # You should use a paginated octokit instance to fetch all statuses:
      #
      # ```
      # client = Octokit.client
      # client.auto_paginate = true
      # client.per_page = 100
      #
      # data = client.deployment_statuses("https://api.github.com/repos/<org>/<repo>/deployments/<deployment_id>")
      # puts data.records.to_pretty_json
      # ```
      #
      # Returns an array of deployment statuses
      def deployment_statuses(deployment_url : String, **options) : Paginator(Octokit::Models::DeploymentStatus)
        paginate(
          Octokit::Models::DeploymentStatus,
          deployment_url + "/statuses",
          start_page: options[:page]?,
          per_page: options[:per_page]?
        )
      end

      # alias for `deployment_statuses`
      def list_deployment_statuses(deployment_url : String, **options) : Paginator(Octokit::Models::DeploymentStatus)
        deployment_statuses(deployment_url, **options)
      end
    end
  end
end
