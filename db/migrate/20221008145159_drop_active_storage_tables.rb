# frozen_string_literal: true

class DropActiveStorageTables < ActiveRecord::Migration[6.1]
  def change
    drop_table 'active_storage_attachments', force: :cascade do |t|
      t.string 'name', null: false
      t.string 'record_type', null: false
      t.bigint 'record_id', null: false
      t.bigint 'blob_id', null: false
      t.datetime 'created_at', null: false
      t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
      t.index \
        %w[record_type record_id name blob_id],
        name: 'index_active_storage_attachments_uniqueness',
        unique: true
    end

    drop_table 'active_storage_blobs', force: :cascade do |t|
      t.string 'key', null: false
      t.string 'filename', null: false
      t.string 'content_type'
      t.text 'metadata'
      t.bigint 'byte_size', null: false
      t.string 'checksum', null: false
      t.datetime 'created_at', null: false
      t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
    end
  end
end
