require "xapix_client/version"
require "xapix_client/config"
require "xapix_client/connection"
require "xapix_client/requestor"
require "xapix_client/resource"

class InputEndpoint < XapixClient::Resource; end
class Schema < XapixClient::Resource; end
class SchemaRelationship < XapixClient::Resource; end

module XapixClient
  def self.autoload_models
    Schema.includes(:schema_relationships).map do |schema|
      model_name = schema[:id].classify
      resource_class = Class.new(Resource) do
        schema.attributes.except(:id, :type).each do |name, data_type|
          property(name.to_sym, type: data_type.to_sym)
        end
        relations_by_cardinality = schema.schema_relationships.group_by(&:cardinality)
        (relations_by_cardinality['to_one'] || {}).each do |schema_relationship|
          has_one(schema_relationship.name.to_sym, class_name: schema_relationship.referenced_endpoint_name.classify)
        end
        (relations_by_cardinality['to_many'] || {}).each do |schema_relationship|
          has_many(schema_relationship.name.to_sym, class_name: schema_relationship.referenced_endpoint_name.classify)
        end
      end
      Object.const_set(model_name, resource_class)
      resource_class
    end
  end
end
