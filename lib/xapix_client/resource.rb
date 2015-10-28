require 'json_api_client'

module XapixClient
  class Resource < JsonApiClient::Resource
    self.connection_class = XapixClient::Connection
    self.requestor_class = XapixClient::Requestor

    class << self
      def transactional_create(attributes = {}, associated_records)
        new(attributes).tap do |resource|
          resource.transactional_save(associated_records)
        end
      end
    end

    # Commit the current changes to the resource to the remote server.
    # If the resource was previously loaded from the server, we will
    # try to update the record. Otherwise if it's a new record, then
    # we will try to create it
    #
    # @return [Boolean] Whether or not the save succeeded
    def transactional_save(associated_records)
      return false unless valid?
      return false unless associated_records.all?(&:valid?)

      self.last_result_set = if persisted?
        #TODO
        raise 'NOT YET IMPLEMENTED'
        self.class.requestor.update(self)
      else
        self.class.requestor.transactional_create([self] + associated_records)
      end

      if last_result_set.has_errors?
        last_result_set.errors.each do |error|
          if error.source_parameter
            errors.add(error.source_parameter, error.title)
          else
            errors.add(:base, error.title)
          end
        end
        false
      else
        self.errors.clear if self.errors
        mark_as_persisted!
        associated_records.each(&:mark_as_persisted!)
        if updated = last_result_set.first
          self.attributes = updated.attributes
          self.relationships.attributes = updated.relationships.attributes
          clear_changes_information
        end
        true
      end
    end
  end
end
