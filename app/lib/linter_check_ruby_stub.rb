# frozen_string_literal: true

class LinterCheckRubyStub
  class << self
    def check(_repo_name)
      JSON.generate({
                      metadata: {
                        rubocop_version: '1.12.0'
                      },
                      files: [{
                        path: 'lib/bar.rb',
                        offenses: [{
                          severity: 'convention',
                          message: 'Line is too long. [81/80]',
                          cop_name: 'LineLength',
                          corrected: true,
                          location: {
                            line: 546,
                            column: 80,
                            length: 4
                          }
                        }]
                      }]
                    })
    end
  end
end
