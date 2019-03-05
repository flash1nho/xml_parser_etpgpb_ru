FactoryBot.define do
  factory :asset do
    file_name {'test.xml'}
    file_body {{'file_body' => 'file_body'}}
  end
end
