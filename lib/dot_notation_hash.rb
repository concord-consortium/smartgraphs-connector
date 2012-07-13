class Hash
  # allows using dot-notation to access hash values
  # eg hash.something == (hash["something"] || hash[:something])
  # also, hash.something = foo, is the same as hash["something"] = foo
  def method_missing(method_name, *args, &block)
    if method_name.to_s =~ /=$/
      self[method_name.to_s.sub(/=$/,'')] = args[0]
    else
      self[method_name.to_s] || self[method_name]
    end
  end
end
