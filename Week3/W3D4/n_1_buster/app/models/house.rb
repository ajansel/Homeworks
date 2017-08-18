class House < ActiveRecord::Base
  has_many(
    :gardeners,
    class_name: "Gardener",
    foreign_key: :house_id,
    primary_key: :id
  )

  has_many(
    :plants,
    through: :gardeners,
    source: :plants
  )

  def n_plus_one_seeds
    plants = self.plants
    seeds = []
    plants.each do |plant|
      seeds << plant.seeds
    end

    seeds
  end

  def better_seeds_query
    # TODO: your code here
    #This will still require us to iterate through tracks
    # albums = self.albums.includes(:tracks)
    #Instead, if we do this first we can use an alias that stores the tracks_count
    plants = self.plants.includes(:seeds)


    plants_seeds = []
    plants.each do |plant|
      plants_seeds << plant.seeds
    end

    plants_seeds
  end
end
