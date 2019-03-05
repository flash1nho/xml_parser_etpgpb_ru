require 'rails_helper'

RSpec.describe Assets::XmlToJsonSaveService, type: :service do
  let(:file_path) { 'test.xml' }
  let(:service) { described_class.new(file_path) }
  let(:service_call) { service.call }

  describe '#initialize' do
    it { expect(service.file_path).to eq file_path }
  end

  describe '#call' do
    context 'when invalid format' do
      before { allow(File).to receive(:basename).and_return('test.jpg') }

      it { expect { service_call }.to raise_error(RuntimeError) }
    end

    context 'when file does not exist' do
      it { expect { service_call }.to raise_error(Errno::ENOENT) }
    end

    context 'when json is blank' do
      before { allow(File).to receive(:read).and_return('file content') }
      before { allow(Crack::XML).to receive(:parse).and_return({}) }

      it { expect(service_call).to be_nil }
    end

    context 'when record exist' do
      let!(:asset) { create(:asset) }

      before { allow(File).to receive(:basename).and_return(asset.file_name) }

      it { expect(service_call).to be_nil }
    end

    context 'when all is ok' do
      let(:file_body) { {'file_body' => 'file_body'} }

      before { allow(File).to receive(:read).and_return('file content') }
      before { allow(Crack::XML).to receive(:parse).and_return(file_body) }

      it { expect { service_call }.to change { Asset.count }.from(0).to(1) }

      it do
        service_call
        expect(Asset.first.file_body).to eq(file_body)
      end
    end
  end
end
