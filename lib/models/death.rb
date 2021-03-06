class Death
  attr_accessor :death_hash, :year

  def initialize
    @death_hash = NYCDeathApi.new.death_data
  end

  def accumulate_deaths
    total = 0

    death_hash.each do |death|
      if death["year"] == year && death["deaths"] != "."
        total += death["deaths"].to_i
      else
      end
    end

    total
  end

  def accumulated_death_by_diseases
    hash = {}

    death_hash.each do |death|
      if death["year"] == year && (hash.has_key?(death["leading_cause"]) && death["deaths"] != ".")
        hash[death["leading_cause"]] += death["deaths"].to_i
      elsif death["year"] == year && death["death"] != "."
        hash[death["leading_cause"]] = death["deaths"].to_i
      end
    end

    hash = hash.sort_by{|k, v| v}.reverse.to_h

    hash.each do |disease, amount|
      if amount != 0
        puts "#{amount}\tDeaths : #{disease}"
        puts " "
      end
    end
  end

end
