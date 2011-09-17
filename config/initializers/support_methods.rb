class ActiveRecord::Base
  def self.sub_query(query)
    case
      when query.is_a?(ActiveRecord::Relation)
        from("(#{query.to_sql}) AS #{self.table_name}")
      when query.is_a?(String)
        from("(#{query}) AS #{self.table_name}")
    end
  end
end

