class Calculations
  def self.subset_sum(inp, sum)
    candidates = inp.filter { |i| i < sum }
    sum_combi_hash = Hash.new do |hash, key|
      if key > 0
        hash[key] = { candidates[key] => [candidates[key]] }
        if hash[key - 1][sum].nil?
          hash[key - 1].each do |s, c|
            hash[key][s] = c
            new_s = s + candidates[key]
            next unless hash[key][new_s].nil?

            hash[key][new_s] = c + [candidates[key]]
            break if new_s == sum
          end
        else
          hash[key][sum] = hash[key - 1][sum]
        end
        hash[key]
      else
        hash[key] = { candidates.first => [candidates.first] }
      end
    end
    sum_combi_hash[candidates.size - 1][sum]
  end

  def self.counting(*args)
    tmp = []
    [1, 2, 5, 10, 25, 50].map.with_index { |d, index| args[0][index].times { tmp << d } }
    tmp
  end

  def self.get_banknotes
    BanknoteAsset.all.map do |value|
      [
        value['banknote1'],
        value['banknote2'],
        value['banknote5'],
        value['banknote10'],
        value['banknote25'],
        value['banknote50']
      ]
    end
  end

  def self.get_money(*args)
    answer = subset_sum(counting(get_banknotes.flatten), args[0].to_i)
    begin
      given_away = { 1 => 0, 2 => 0, 5 => 0, 10 => 0, 25 => 0, 50 => 0 }.merge(Hash[
  answer.group_by { |i| i }.map do |k, v|
    [k, v.count]
  end
  ]).values
      # reduce the number of banknotes:
      BanknoteAsset.update({
                             banknote1: BanknoteAsset.all[0][:banknote1] - given_away[0],
                             banknote2: BanknoteAsset.all[0][:banknote2] - given_away[1],
                             banknote5: BanknoteAsset.all[0][:banknote5] - given_away[2],
                             banknote10: BanknoteAsset.all[0][:banknote10] - given_away[3],
                             banknote25: BanknoteAsset.all[0][:banknote25] - given_away[4],
                             banknote50: BanknoteAsset.all[0][:banknote50] - given_away[5]
                           })
      answer
    rescue StandardError
      'transaction not allowed'
    end
  end

  def self.update_cash(params)
    BanknoteAsset.find(1).update({
                                   banknote1: params[:banknote1],
                                   banknote2: params[:banknote2],
                                   banknote5: params[:banknote5],
                                   banknote10: params[:banknote10],
                                   banknote25: params[:banknote25],
                                   banknote50: params[:banknote50]
                                 })
  end
end
