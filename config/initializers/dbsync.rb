if Rails.env.development?

  Dbsync.file_config = {
    :remote => TaprootSetting.remote.db_backup_file,
    :local  => TaprootDatabase.new.backup_file_copy
  }

end
