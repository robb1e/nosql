# Nosql

A simple ActiveRecord 'adapter' that raises an exception whenever the database is used. This is to ensure unit tests do not integrate with a database.

When testing scopes and complex queries, applying a tag can disable this gem and replace the normal adapter implementation. 

[Write up on usage](http://pivotallabs.com/testing-strategies-rspec-nulldb-nosql)

## Installation

Add this line to your application's Gemfile:

    gem 'nosql'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nosql

## Usage

If you were using RSpec and tagged tests which did hit the datbase with ':db', then you could use the following.

    config.around(:each, type: :model) do |example|
      if example.metadata[:db]
        Nosql::Connection.disable!
        example.run
      else
        Nosql::Connection.enable!
        example.run
        Nosql::Connection.disable!
      end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Authors

* [Robbie](https://github.com/robb1e)
* [JT](https://github.com/jtarchie)
