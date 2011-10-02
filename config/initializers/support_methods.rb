class ActiveRecord::Base
  def self.sub_query(query)
    query = query.to_sql if query.is_a?(ActiveRecord::Relation)
    from("(#{query}) AS #{self.table_name}")
  end
end

