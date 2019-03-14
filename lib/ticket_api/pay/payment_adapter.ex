defmodule TicketApi.Pay.PaymentAdapter do

def charge(_, "card_error",_) do
  {:error, :card_error}
end

def charge(_, "payment_error",_) do
  {:error, :payment_error}
end

def charge(amount, _, :eur) do
  {:ok, {amount, :eur}}
end

def charge(_,_,_) do
  {:error, :currency_not_supported}
end

end
