require "rails_helper"

RSpec.describe ReservationMailer, :type => :mailer do
  describe "notify_kitchen_owner_of_new_reservation" do
    let(:user) { FactoryGirl.create(:user, :first_name => "John") }
    let(:mail) { ReservationMailer.notify_kitchen_owner_of_new_reservation(user) }

    it "renders the subject" do
      expect(mail.subject).to eq("Someone made a reservation to your kitchen on Couchfoodie")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["noreply@couchfoodie.io"])
    end

    it 'assigns @user.first_name' do
      expect(mail.body.encoded).to match(user.first_name)
    end

    it 'assigns @home_page' do
      expect(mail.body.encoded).to match("http://couchfoodie.io")
    end
  end

  describe "notify_guest_reservation_approval" do
    let(:user) { FactoryGirl.create(:user, :first_name => "John") }
    let(:mail) { ReservationMailer.notify_guest_reservation_approval(user) }

    it "renders the subject" do
      expect(mail.subject).to eq("Your reservation is approved on Couchfoodie")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["noreply@couchfoodie.io"])
    end

    it 'assigns @user.first_name' do
      expect(mail.body.encoded).to match(user.first_name)
    end

    it 'assigns @home_page' do
      expect(mail.body.encoded).to match("http://couchfoodie.io")
    end
  end

  describe "notify_guest_reservation_denial" do
    let(:user) { FactoryGirl.create(:user, :first_name => "John") }
    let(:mail) { ReservationMailer.notify_guest_reservation_denial(user) }

    it "renders the subject" do
      expect(mail.subject).to eq("Your reservation is declined on Couchfoodie")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["noreply@couchfoodie.io"])
    end

    it 'assigns @user.first_name' do
      expect(mail.body.encoded).to match(user.first_name)
    end

    it 'assigns @home_page' do
      expect(mail.body.encoded).to match("http://couchfoodie.io")
    end
  end
end
