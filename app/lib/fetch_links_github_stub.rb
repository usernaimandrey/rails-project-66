# frozen_string_literal: true

class FetchLinksGithubStub
  class << self
    def fetch(_user)
      ['octocat/Hello-World']
    end
  end
end
