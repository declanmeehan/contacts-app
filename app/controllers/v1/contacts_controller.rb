class V1::ContactsController < ApplicationController

  def index
    contacts = Contact.all
    if params[:search]
     contact = Contact.where("first_name ILIKE ?", "%#{params[:search]}%")
    end
    render json: contacts.as_json
  end

  def create 
    contact = Contact.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      phone_number: params[:phone_number],
      email: params[:email],
      middle_name: params[:middle_name],
      bio: params[:bio]
    )
  end

  def show
      contact = Contact.find_by(id: params[:id])
      render json: contact.as_json
  end

  def update
    contact_id = params["id"].to_i
   contact = Contact.find_by(id: contact_id)
    contact.first_name = params[:first_name] \
     || contact.first_name
    contact.last_name = params[:last_name] \
     || contact.last_name
    contact.phone_number = params[:phone_number] \
     || contact.phone_number
    contact.email = params[:email] \
     || contact.email
     contact.middle_name = params[:middle_name] \
     || contact.middle_name
     contact.bio = params[:bio] \
     || contact.bio 
    if contact.save
    render json: contact.as_json
    else
    render json: {errors: product.errors.full_messages}, status: :bad_request 
    end
  end

  def destroy
    contact = Contact.find_by(id: params[:id])
    contact.destroy
    render json: {message: "contact destroyed"}
  end

end


