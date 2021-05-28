module Banknote
  class Data < Grape::API
    resource :banknote_data do
      desc 'list'
      get do
        BanknoteData.all
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
