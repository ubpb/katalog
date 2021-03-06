class GetUserTransactionsService < Servizio::Service
  include AdapterRelatedService
  include CachingService
  include InstrumentedService
  include RecordRelatedService
  include UserRelatedService

  attr_accessor :ils_adapter
  attr_accessor :search_engine_adapter

  alias_method  :adapter,  :ils_adapter
  alias_method  :adapter=, :ils_adapter=

  validates_presence_of :ils_adapter
  validates_presence_of :ilsuserid

  def call
    cache_key = "#{self.class.name}+#{ilsuserid}"
    cache(key: cache_key) do
      ils_adapter_result = ils_adapter.get_user_transactions(ilsuserid)
      # Do not update records! See issue #81.
      #update_records!(ils_adapter_result, search_engine_adapter)
      strip_source!(ils_adapter_result)
    end
  rescue Skala::Adapter::Error
    errors.add(:base, :failed) and return nil
  end
end
