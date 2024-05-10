class Watch < ApplicationRecord
    enum category: { standard: 0, premium: 1, premium_plus: 2 }
end
