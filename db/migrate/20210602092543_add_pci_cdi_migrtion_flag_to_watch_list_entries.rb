class AddPciCdiMigrtionFlagToWatchListEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :watch_list_entries, :pci_cdi_migration, :boolean, null: true, default: nil
    add_column :watch_list_entries, :pci_record_id, :string, null: true, default: nil
  end
end
