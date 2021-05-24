module Banknote
  class Data < Grape::API
    helpers do
      def get_banknotes
        BanknoteData.all.map do |value|
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

      def subset_sum(inp, sum)
        inp.length.downto(1).flat_map do |i|
          inp.combination(i).to_a
        end.select do |a|
          a.inject(:+) == sum
        end
      end

      # ### Perhaps this solution is more successful.
      #
      # def subset_sum(numbers, target, partial=[])
      #   s = partial.inject 0, :+
      # check if the partial sum is equals to target
      #   puts "sum(#{partial})=#{target}" if s == target
      #   return if s >= target # if we reach the number why bother to continue
      #   (0..(numbers.length - 1)).each do |i|
      #     n = numbers[i]
      #     remaining = numbers.drop(i+1)
      #     subset_sum(remaining, target, partial + [n])
      #   end
      # end
      #
      # subset_sum([3,9,8,4,5,7,10],15)

      def counting(quantity)
        denominations = [1, 2, 5, 10, 25, 50]
        tmp = []

        denominations.each_with_index do |d, index|
          quantity[index].times do
            tmp << d
          end
        end
        tmp
      end
    end

    resource :banknote_data do
      desc 'list'
      get do
        BanknoteData.all
      end

      desc 'get money'
      patch do
        answer = subset_sum(counting(get_banknotes.flatten), params[:sum].to_i).first
        begin
          given_away = { 1 => 0, 2 => 0, 5 => 0, 10 => 0, 25 => 0, 50 => 0 }.merge(Hash[
    answer.group_by { |i| i }.map do |k, v|
      [k, v.count]
    end
  ]).values

      # reduce the number of banknotes:
          BanknoteData.update({
                                banknote1: BanknoteData.all[0][:banknote1] - given_away[0],
                                banknote2: BanknoteData.all[0][:banknote2] - given_away[1],
                                banknote5: BanknoteData.all[0][:banknote5] - given_away[2],
                                banknote10: BanknoteData.all[0][:banknote10] - given_away[3],
                                banknote25: BanknoteData.all[0][:banknote25] - given_away[4],
                                banknote50: BanknoteData.all[0][:banknote50] - given_away[5]
                              })

          answer
        rescue StandardError
          'transaction not allowed'
        end
      end

      desc 'update cash'
      params do
        requires :banknote1, type: Integer
        requires :banknote2, type: Integer
        requires :banknote5, type: Integer
        requires :banknote10, type: Integer
        requires :banknote25, type: Integer
        requires :banknote50, type: Integer
      end
      put ':id' do
        BanknoteData.find(1).update({
                                      banknote1: params[:banknote1],
                                      banknote2: params[:banknote2],
                                      banknote5: params[:banknote5],
                                      banknote10: params[:banknote10],
                                      banknote25: params[:banknote25],
                                      banknote50: params[:banknote50]
                                    })
      end
    end
  end
end
