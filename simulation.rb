require 'pry'

def rand_daily_sessions
  (1650 + (300 * rand)).to_i
end

def rand_conversions(sessions)
  conversion_rate = 0.008 + (0.003 * rand)
  (conversion_rate * sessions).to_i
end

def generate_sample(num_days)
  population = []

  num_days.times do |index|
    daily_sessions = rand_daily_sessions
    daily_conversions = rand_conversions(daily_sessions)
    population << {
      sessions: daily_sessions,
      conversions: daily_conversions,
      dcr: daily_conversions.to_f / daily_sessions,
    }
  end

  population
end

module Enumerable
  def sum
    self.inject(0){|accum, i| accum + i }
  end

  def mean
    self.sum/self.length.to_f
  end

  def sample_variance
    m = self.mean
    sum = self.inject(0){|accum, i| accum +(i-m)**2 }
    sum/(self.length - 1).to_f
  end

  def standard_deviation
    Math.sqrt(self.sample_variance)
  end
end 


def run
  num_days = 90
  population = generate_sample(num_days)
  conversion_rates = population.map { |day| day[:dcr] }
  mean_conversion_rate = conversion_rates.mean
  std_dev_conversion_rate = conversion_rates.standard_deviation
  binding.pry
end
