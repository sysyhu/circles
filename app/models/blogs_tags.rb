class BlogsTags < ActiveRecord::Base

	self.table_name = 'blogs_tags'

	#validates_uniquesness_of :blog_id, scope:[:tag_id] #同一个 tag_id 只有一个 blog_id，反之一样
 
	belongs_to :blog
	belongs_to :tag

end
