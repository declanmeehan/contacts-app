class Contact < ApplicationRecord
    def updated_at
      created_at.strftime("%F") 
    end

    def full_name
      first_name + " " + last_name
    end

    def japan_phone_number
      "81" + " " + phone_number
    end

  def as_json
    {
      id: id,
      first_name: first_name,
      last_name: last_name,
      phone_number: phone_number,
      email: email,
      updated_at: updated_at,  
      full_name: full_name,
      japan_phone_number: japan_phone_number,
      middle_name: middle_name,
      bio: bio
    }
  end
end
