require 'spec_helper'

describe Parser::Fields do
  context 'Parsers::Fields' do
    let(:fields) do
      id    = 1
      title = 'Truck'

      fields = begin
        Parser::Fields.new do |field|
          field.id    = id
          field.title = title
        end
      end.fields
    end

    it 'should init object fields id: 1, title: Truck' do
      expect(fields.to_h).to  eq(id: 1, title: 'Truck')

      expect(fields.id).to    eq(1)
      expect(fields.title).to eq('Truck')
    end

    it 'should not can modify existed fields' do
      expect { fields[:id] = 1 }.to raise_error(RuntimeError, "can't modify frozen OpenStruct")
    end
  end
end
