# frozen_string_literal: true

class Gutentag::Tagging < ActiveRecord::Base
  self.table_name = "gutentag_taggings"

  belongs_to :parent, :polymorphic => true, :optional => true
  belongs_to :taggable, :polymorphic => true
  belongs_to :tag, :class_name => "Gutentag::Tag", :counter_cache => true

  validates :taggable, :presence => true
  validates :tag,      :presence => true
  validates :tag_id,   :uniqueness => {
    :scope => %i[ taggable_id taggable_type ]
  }, :if => proc { |t| t.parent.nil? }
  validates :tag_id,   :uniqueness => {
    :scope => %i[ parent_id parent_type taggable_id taggable_type ]
  }, :if => proc { |t| t.parent.present? }
end
