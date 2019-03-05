namespace :xml_to_json do
  desc 'Считываем xml, переводим его в json и записываем в БД'
  task :parse_and_create, [:file_path] => :environment do |_, args|
    raise 'File path must be specified as first argument' unless args.file_path.present?

    Assets::XmlToJsonSaveService.new(args.file_path).call
  end
end
