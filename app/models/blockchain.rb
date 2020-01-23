require 'singleton'

class Blockchain
  include Singleton

  def new_transaction(sender, recipient, amount)
    @current_transactions.append(
      {
        sender: sender,
        recipient: recipient,
        amount: amount
      }
    )

    return last_block[:index] +1
  end

  def valid_proof(last_proof, proof)
    guess = "#{last_proof}#{proof}"
    guess_hash = Digest::SHA256.hexdigest(guess)

    return guess_hash.first(4) == "0000"
  end

  def new_block(proof, previous_hash=nil)
    block = {
      index: @chain.size + 1,
      timestamp: Time.now.to_i,
      transactions: @current_transactions,
      proof: proof,
      previous_hash: previous_hash || self.class.hash(last_block)
    }
    @current_transactions = []
    @chain.append(block)
    return block
  end

  def register_node(address)
    parsed_url = URI::parse(address)
    @nodes.add("#{parsed_url.host}:#{parsed_url.port}")
  end

  def resolve_conflicts
    neighbours = @nodes
    new_chain = nil

    max_length = @chain.size
    @nodes.each do |node|
      io = OpenURI.open_uri("http://#{node}/blocks")
      response = JSON.parse(io.read).deep_symbolize_keys!
      status = io.status[0]

      if status == "200"
        length = response[:length]
        chain = response[:chain]

        if length > max_length && self.valid_chain(chain)
          max_length = length
          new_chain = chain
        end
      end
    end

    if new_chain
      @chain = new_chain
      return true
    end

    return false
  end
end