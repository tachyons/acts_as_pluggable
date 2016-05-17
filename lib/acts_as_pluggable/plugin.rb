require 'active_model'
module ActsAsPluggable
  class Plugin
    attr_accessor :id, :tag, :name, :description, :website, :author, :version, :settings
    extend Enumerable
    include ActiveModel::Validations
    validates :id, presence: true

    @@registered_plugins = {}
    @meta_data = {}
    def initialize(id, tag, meta_data = {})
      @id = id
      @tag = tag
      @meta_data = meta_data
      set_instance_variables_from_hash(@meta_data)
      self
    end

    def engine
      @meta_data[:engine]
    end

    def self.register(id, tag = nil, meta_data = {})
      raise DuplicatePlugin if Plugin.find_by_id(id)
      plugin = Plugin.new(id, tag, meta_data)
      return false unless plugin.valid?
      @@registered_plugins[id] = plugin
    end

    def self.find(id)
      plugin = @@registered_plugins[id]
      raise PluginNotFound if plugin.nil?
    end

    # Do not raise exception here
    def self.find_by_id(id)
      @@registered_plugins[id]
    end

    def self.find_all_by_tag(tag)
      @@registered_plugins.values.select { |p| p.tag == tag.to_s }
    end

    def self.all
      @@registered_plugins
    end

    def <=>(other)
      id.to_s <=> other.id.to_s
    end

    def self.each(&block)
      @@registered_plugins.values.each do |plugin|
        block.call(plugin)
      end
    end

    private

    def set_instance_variables_from_hash(hash)
      hash.each do |k, v|
        instance_variable_set("@#{k}", v)
      end
    end
  end
end
