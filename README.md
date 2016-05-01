# ActsAsPluggable

Make a rails app pluggable

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'acts_as_pluggable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acts_as_pluggable

## Usage

Add following line in Gemfile
```ruby
  gem 'acts_as_pluggable',github: 'tachyons/acts_as_pluggable'
  Dir[File.join(File.dirname(__FILE__), '/plugins/*')].each do |plugin_dir|
    gem(File.basename(plugin_dir), path: plugin_dir)
  end
```

```
rails plugin new 'plugins/sample_plugin --full'
```

Now register plugin from engine.rb
Eg,
```ruby
module SamplePlugin
  class Engine < ::Rails::Engine
    if defined?(ActsAsPluggable)
      ::ActsAsPluggable::Plugin.register(:sample_plugin,:sample_tag,{
        :engine=>self,
        :description=>"sample description",
        :website=> "https://github.com/tachyons/acts_as_pluggable",
        :author=> "Aboobacker MK",
        :version=>SamplePlugin::VERSION,
        :settings=>{
          :display_in_topbar=>true
        }
        })
    end
  end
end
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/acts_as_pluggable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
