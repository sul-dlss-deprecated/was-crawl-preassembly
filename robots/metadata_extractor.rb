module Robots
  module DorRepo
    module WASCrawl

      class WASCrawlMetadataExtractor
        include LyberCore::Robot

        def initialize
          super('dor', 'wasCrawlPreassemblyWF', 'was-crawl-metadata-extractor')
        end

        def perform(druid)
          druid_obj = Dor::Item.find(druid)
          #Fill the input parameters
          collection_id = Dor::WASCrawl::Utilities::get_collection_id(druid_obj)
          crawl_id = Dor::WASCrawl::Utilities::get_crawl_id(druid_obj)
          staging_path = Dor::Config.was_crawl.staging_path
          metadata_extractor_service = Dor::WASCrawl::MetadataExtractor.new(@collection_id, @crawl_id, @staging_path.to_s, druid)
          metadata_extractor_service.run_metadata_extractor_jar
        end
      end

    end
  end
end