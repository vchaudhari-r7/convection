require 'spec_helper'

class Convection::Model::Template
  describe self do
    let(:template) do
      Convection.template do
        description 'Test Template'

        ec2_instance 'TestInstance1' do
          availability_zone 'us-east-1'
          image_id 'ami-asdf83'
        end

        ec2_instance 'TestInstance2' do
          availability_zone 'us-west-1'
          image_id 'ami-lda34f'
          depends_on 'TestInstance1'
        end
      end
    end

    describe '#resource' do
      context 'when defining a predefined resource' do
        subject do
          Convection.template do
            resource 'FooInstance' do
              type 'AWS::EC2::Instance'
            end
          end
        end

        it 'warns the user when they are using a predefined resource.' do
          expect { subject.render }.to output(/.*already defined.*/).to_stderr
        end
      end

      context 'when defining a undefined resource' do
        subject do
          Convection.template do
            resource 'FooInstance' do
              type 'FakeResource'
            end
          end
        end

        it 'warns the user when they are using a undefined resource.' do
          expect { subject.render }.to_not output.to_stderr
        end
      end
    end

    subject do
      template_json
    end

    it 'template format version is 2010-09-09 ' do
      expect(subject['AWSTemplateFormatVersion']).to eq('2010-09-09')
    end

    it 'Template descriptions are set correctly' do
      expect(subject['Description']).to eq('Test Template')
    end

    it 'template TestInstance1 has properties' do
      expect(subject['Resources']['TestInstance1']['Properties']).to_not eq(nil)
    end

    it 'TestInstance1 Type is AWS::EC2::Instance' do
      expect(subject['Resources']['TestInstance1']['Type']).to eq('AWS::EC2::Instance')
    end

    it 'DependsOn values are set correctly' do
      expect(subject['Resources']['TestInstance2']['DependsOn'][0]).to eq('TestInstance1')
    end

    it { is_expected.to have_key('Parameters') }

    it { is_expected.to have_key('Mappings') }

    it { is_expected.to have_key('Conditions') }

    it { is_expected.to have_key('Resources') }

    private

    def template_json
      JSON.parse(template.to_json)
    end
  end
end
