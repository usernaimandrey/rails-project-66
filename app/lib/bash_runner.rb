# frozen_string_literal: true

class BashRunner
  class << self
    def run(command)
      stdout_str, status = Open3.capture2(command)
      [stdout_str, status]
    end

    def success?(status)
      status.to_i.zero?
    end
  end
end
