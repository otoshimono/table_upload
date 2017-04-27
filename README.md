# TableUpload
※ This gem is internal use only now.  sorry for not well tested and documented.

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/table_upload`. 

By using this gem you can easily export your table attributes to csv file and upload to Google Drive.
Also you can define your original exporter and uploader :)


## Installation

Add this line to your application's Gemfile:
(Now,  this gem is internal use. Not Released to rubygems.org)

```ruby
gem 'table_upload', :github => 'otoshimono/table_upload'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install table_upload

## Usage
If you want to upload  to Google Drive, you need to create config.json file.
See this document to learn how to create config.json(You need to create with first way)
https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md#on-behalf-of-you-command-line-authorization

Most usage cases, you define upload rake task, like this.
```ruby
namespace :batches do
  desc "export csv and upload to GoogleDrive"
  
  # upload all tables
  task :upload_all_table_csv_to_drive => :environment do
    TableUpload.setup do |config|
      config.export_dir = Rails.root.join("db", "csv") # csv save dir
      config.google_drive_dir = "AwsomeDir" # You need to prepare GoogleDrive Directory which you can access
    end
    TableUpload.exec_upload_all
  end

  # upload specific tables
  task :upload_users_csv_to_drive => :environment do
    TableUpload.setup do |config|
      config.export_dir = Rails.root.join("db", "csv") # csv save dir
      config.google_drive_dir = "AwsomeDir" # You need to prepare GoogleDrive Directory
    end
    TableUpload.exec_upload([User, Customer]) #set classes array here
  end
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/table_upload.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).



