class GetWatchListWatchListEntriesService < Servizio::Service
  include AdapterRelatedService
  include InstrumentedService

  attr_accessor :scopes
  attr_accessor :watch_list
  attr_accessor :watch_list_id

  def watch_list
    @watch_list || WatchList.find_by_id(@watch_list_id)
  end

  validates_presence_of :scopes
  validates_presence_of :watch_list

  def call
    watch_list.watch_list_entries.tap do |_tapped_watch_list_entries|
      _tapped_watch_list_entries
      .group_by(&:scope_id)
      .each do |_scope_id, _watch_list_entries|
        records = GetRecordsService.call(
          adapter: scope_by_id(_scope_id).search_engine_adapter.instance,
          ids: _watch_list_entries.map(&:record_id)
        )

        _watch_list_entries.each do |_watch_list_entry|
          corresponding_record = record_by_id(_watch_list_entry.record_id, records).try(:record)

          _watch_list_entry.define_singleton_method(:record) do
            corresponding_record
          end
        end
      end
    end
    .select do |_watch_list_entry|
      _watch_list_entry.try(:record).present?
    end
  end

  private

  def record_by_id(record_id, records)
    records.find { |_record| _record.record.id == record_id }
  end

  def scope_by_id(scope_id)
    scopes.find { |_scope| _scope.id == scope_id }
  end
end
