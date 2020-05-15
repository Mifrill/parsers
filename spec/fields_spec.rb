require 'spec_helper'

describe Parser::Fields do
  context 'Parsers::Fields' do
    let(:fields) do
      id = 1
      title = 'Truck'

      Parser::Fields.new do |field|
        field.id = id
        field.title = title
      end.fields
    end

    it 'should init object fields id: 1, title: Truck' do
      expect(fields.to_h).to eq(id: 1, title: 'Truck')

      expect(fields.id).to eq(1)
      expect(fields.title).to eq('Truck')
    end

    it 'should raised an error for any modify fields command' do
      expect do
        fields[:id] = 1
        fields[:category] = 'Equipment'
      end.to raise_error(RuntimeError, "can't modify frozen OpenStruct")
    end
  end
end
