require 'metadata_generator_service'

module Dor
  module WASCrawl
  
    class ContentMetadataGenerator < MetadataGenerator
    
      
      def initialize(collection_id, staging_path, druid_id)
        super(collection_id, staging_path, druid_id)
        @content_metadata_name = "contentMetadata"
      end
    
      def generate_metadata_output
        xml_input = read_metadata_xml_input_file
        xslt_template = read_template(@content_metadata_name)
        metadata_content = transform_xml_using_xslt(xml_input,xslt_template)
        metadata_content = do_post_transform(metadata_content)
        write_file_to_druid_metadata_folder( @content_metadata_name, metadata_content)
      end
      
      def do_post_transform(metadata_content)
        #include druid_id in the xml before saving
        metadata_content_xml = Nokogiri::XML(metadata_content)
        unless metadata_content_xml.errors.empty?
           raise "The input string is not a valid xml file.\nNokogiri errors: #{metadata_content_xml.errors}\n#{metadata_content_xml}"
         end
        metadata_content_xml.root().set_attribute('id', @druid_id)
        return metadata_content_xml.to_s
     end
        
    end 
  end
end