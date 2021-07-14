require "skala/adapter/search"
require_relative "../primo_adapter"

class Skala::PrimoAdapter::GetRecords < Skala::Adapter::GetRecords
  def call(record_ids, options = {})

    #
    # Because CDI doesn't support ORing record ids (out previous implementation),
    # we must fetch the record one by one. To speed this up, we do this in parallel
    # with 5 threads. Threads are ok here because this operation is IO bound
    # (waiting for response of external API call)
    #
    results = Parallel.map(record_ids, in_threads: 5) do |record_id|
      search_request = Skala::Adapter::Search::Request.new(
        queries: [
          {
            type: "ids",
            query: record_id
          }
        ]
      )

      cache_key = "primo_central/get_records/#{record_id}"
      search_result = Rails.cache.fetch(cache_key, expires_in: 24.hours) do
        adapter.search(search_request, on_campus: true)
      end

      {
        record_id: record_id,
        search_result: search_result
      }
    end

    records = results.map do |result|
      if (hit = result[:search_result].hits&.first)
        self.class::Result::Record.new(
          id: result[:record_id],
          found: true,
          record: hit.record,
          index: hit.index,
          type: hit.type,
          version: hit.version
        )
      else
        # add "pseudo" records if the given record id was not found
        self.class::Result::Record.new(
          id: result[:record_id],
          found: false,
          record: Skala::Record.new(id: result[:record_id])
        )
      end
    end

    self.class::Result.new(records: records)
  end
end
