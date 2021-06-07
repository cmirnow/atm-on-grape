module Banknote
  class Asset < Grape::API
    resource :banknote_asset do
      desc 'list'
      get do
        BanknoteAsset.all
      end

      desc 'get money'
      patch do
        answer = Calculations.get_money(params[:sum])
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
        Calculations.update_cash(params)
      end
    end
  end
end
