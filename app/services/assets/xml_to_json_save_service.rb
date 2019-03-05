module Assets
  class XmlToJsonSaveService
    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def call
      raise 'Invalid Format' unless valid_file_format?
      return if Asset.where(file_name: file_name).exists? || json.blank?

      Asset.create(file_name: file_name, file_body: json)
    end

    private

    def file_body
      @file_body ||= File.read(file_path)
    end

    def json
      @json ||= Crack::XML.parse(file_body)
    end

    def file_name
      @file_name ||= File.basename(file_path)
    end

    def valid_file_format?
      @valid_file_format ||= file_name.to_s.downcase.split('.').last == 'xml'
    end
  end
end
