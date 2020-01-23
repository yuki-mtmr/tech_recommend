class Block::TransactionsController < ApplicationController
  def create
    sender = create_params[:sender]
    recipient = create_params[:recipient]
    amount = create_params[:amount]

    blockchain = Blockchain.instance
    index = blockchain.new_transaction(sender, recipient, amount)

    response = {'message': "Transaction will be added to Block #{index}"}
    render json: response, status: :created
  end

  def create_params
    params.permit(:sender, :recipient, :amount)
  end
end