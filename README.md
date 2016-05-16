# ResourceSubscriber

Publish/Subscribe to ActiveRecord model events via ActionSubscriber, work with them in model form.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'resource_subscriber'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install resource_subscriber

## Usage

### Setting Up Routes
``` ruby
::ActionSubscriber.draw_routes do
  [ :created, :updated, :destroyed ].each do |action|
    route ::DataWarehouse::PurchasesSubscriber, action, :stack => :resourceful, :exchange => :events
  end
end
```

### Publishing Model Changes
``` ruby
module Ecommerce
  class Purchase < ::ActiveRecord::Base
    include ::ResourceSubscriber::Publishable
    resource_publisher.publish_as 'ecommerce/purchases'
    #can also specify exchange
    #resource_publisher.publish_as 'blog/posts', :exchange => 'events'
  end
end
```

### Setting Up Subscriber
``` ruby
module DataWarehouse
  class PurchasesSubscriber < ::ActionSubscriber::Base
    include ::ResourceSubscriber::Resourceful

    def created
      record_sale
    end

    def updated
      record_reversal if was_chaged_back? || was_returned?
    end

    def destroyed
      record_reversal if was_chaged_back? || was_returned?
    end

    private
    def was_charged_back?
      was_changed?(:status, :from => :processed, :to => :charged_back)
    end

    def was_returned?
      was_changed?(:status, :from => :processed, :to => :returned)
    end

    def record_reversal
      #do whatever
    end

    def record_sale
      #store purchase in a data warehouse table
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/resource_subscriber.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
