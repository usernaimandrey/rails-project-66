# frozen_string_literal: true

class FetchLastCommitRefStub
  class << self
    def fetch(_token, _repo_link)
      { last_commit_sha: '5fgrt', last_commit_url: 'https://github.com/commits/5fgrt' }
    end
  end
end
