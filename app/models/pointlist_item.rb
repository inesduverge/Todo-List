class PointlistItem < ActiveRecord::Base

  def self.find_all_items(tab_id)
    items = {}
    select_query = "SELECT pl.* FROM pointlist_items pl, pointlists p WHERE pl.pointlist_id = p.id AND p.tab_id = '#{tab_id}'"
    points = PointlistItem.find_by_sql(select_query)

    if points.empty?
      return nil
    end

    points.each do |point|
      if items[point.pointlist_id].nil?
        items[point.pointlist_id] = {point.level => {point.parent_id => [point]}}
      else
        if items[point.pointlist_id][point.level].nil?
          items[point.pointlist_id][point.level] = {point.parent_id => [point]}
        else
          (items[point.pointlist_id][point.level][point.parent_id] ||= Array.new) << point
        end
      end
    end
    return items
  end

  def self.create(level, parent_id, pointlist_id, title)
    sql_connection = ActiveRecord::Base.connection
    insertion_query = "INSERT INTO pointlist_items (level, parent_id, pointlist_id, title, updated_at, created_at) values ('#{level}', '#{parent_id}', '#{pointlist_id}', '#{title}', '#{Time.now}', '#{Time.now}') RETURNING id"

    return sql_connection.execute(insertion_query)
  end

  def validate(item)
    !item[:title].empty? 
  end

end
