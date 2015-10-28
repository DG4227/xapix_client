class XapixClient::Requestor < JsonApiClient::Query::Requestor
  def transactional_create(records)
    request(:post, 'transactions', {
      data: records.map(&:as_json_api)
    })
  end
end
