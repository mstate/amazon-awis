# frozen_string_literal: true

module Awis
  module Models
    class Base
      attr_accessor :response, :status_code, :request_id

      def loading_response(response)
        Awis::Utils::XML.new(response.response_body.force_encoding(Encoding::UTF_8))
      en

      def root_node_name
        "/aws:#{action_name}Response/aws:Response/aws:#{action_name}Result/aws:Alexa"
      end

      def action_name
        self.class.name.split(/\:\:/)[-1]
      end

      def relationship_collections(item_object, items, items_count, kclass)
        return if items.empty?

        all_items = {}.array_slice_merge!(:item, items, items_count)
        all_items.map { |item| item_object << kclass.new(item) }
      end

      def success?
        status_code == 'Success'
      end
    end
  end
end
