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
      def deployments(repo, **options)
        get("#{Repository.path(repo)}/deployments", options)
      end
    end
  end
end
