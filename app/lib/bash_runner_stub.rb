# frozen_string_literal: true

class BashRunnerStub
  class << self
    def run(_command)
      ['', '0']
    end

    def success?(_status)
      true
    end
  end
end
