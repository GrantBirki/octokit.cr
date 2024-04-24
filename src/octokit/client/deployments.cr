require "../models/repos"

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
      def deployment(repo, deployment_id, **options)
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
      def deployments(repo, **options)
        get("#{Repository.path(repo)}/deployments", options)
      end

      # Alias for `deployments`
      def list_deployments(repo, **options)
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
      def create_deployment(repo, ref, **options)
        post("#{Repository.path(repo)}/deployments", options.merge(ref: ref))
      end
    end
  end
end
