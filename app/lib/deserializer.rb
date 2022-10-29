# frozen_string_literal: true

module Deserializer
  def javascript_deserialize(json)
    return [] if json.empty?

    JSON.parse(json).map do |data_check|
      file_path = data_check['filePath']
      errors = data_check['messages'].map do |message|
        {
          message: message['message'],
          rule: message['ruleId'],
          line_column: "#{message['line']} : #{message['column']}"
        }
      end
      { file_path: file_path, errors: errors }
    end
  end

  def ruby_deserialize(json)
    return [] if json.empty?

    JSON.parse(json)['files']
        .filter { |data_check| data_check['offenses'].any? }
        .map do |data_check|
      file_path = data_check['path']
      errors = data_check['offenses'].map do |message|
        {
          message: message['message'],
          rule: message['cop_name'],
          line_column: "#{message['location']['line']} : #{message['location']['column']}"
        }
      end
      { file_path: file_path, errors: errors }
    end
  end
end
