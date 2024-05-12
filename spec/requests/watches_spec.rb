    require 'rails_helper'
    require 'json'

    RSpec.describe "WatchesController", type: :request do
        let(:user) { create(:user) }
        before { sign_in user }

        describe "GET /watches" do 
            it "returns 3 watches" do
                create(:watch)
                create(:watch)
                create(:watch)
                    get watches_path
                    expect(response).to have_http_status(200)
                    watches = JSON.parse(response.body)
                    expect(watches.length).to eq(3)
            end
        

            it "returns watch with name starting with Fir" do
                create(:watch, name: "First")
                create(:watch, name: "Second")
                    get "http://127.0.0.1:3000/watches?name=Fir"
                    expect(response).to have_http_status(200)
                    watches = JSON.parse(response.body)
                    expect(watches.length).to eq(1)
                    expect(watches[0]["name"]).to eq("First")
            end

            it "returns watch with name starting with fir" do
                create(:watch, name: "First")
                create(:watch, name: "Second")
                    get "http://127.0.0.1:3000/watches?name=fir"
                    expect(response).to have_http_status(200)
                    watches = JSON.parse(response.body)
                    expect(watches.length).to eq(1)
                    expect(watches[0]["name"]).to eq("First")
            end

            it "returns only premium_plus watches" do
                create(:watch, category: "premium")
                create(:watch, category: "premium_plus")
                    get "http://127.0.0.1:3000/watches?category=2"
                    expect(response).to have_http_status(200)
                    watches = JSON.parse(response.body)
                    expect(watches.length).to eq(1)
                    expect(watches[0]["category"]).to eq("premium_plus")
            end

            it "returns only watches with price in range 20 - 100" do
                create(:watch, price: 50.0)
                create(:watch, price: 60.0)
                create(:watch, price: 200.0)
                    get "http://127.0.0.1:3000/watches?price_min=20&price_max=100"
                    expect(response).to have_http_status(200)
                    watches = JSON.parse(response.body)
                    expect(watches.length).to eq(2)
            end
    
            it "returns watches sorted asc by name " do
                create(:watch, name: "Third")
                create(:watch, name: "Second")
                create(:watch, name: "First")
                    get "http://127.0.0.1:3000/watches?sort=name"
                    expect(response).to have_http_status(200)
                    watches = JSON.parse(response.body)
                    expect(watches[0]["name"]).to eq("First")
                    expect(watches[1]["name"]).to eq("Second")
                    expect(watches[2]["name"]).to eq("Third")
            end

            it "returns watches sorted desc by name " do
                create(:watch, name: "Third")
                create(:watch, name: "Second")
                create(:watch, name: "First")
                    get "http://127.0.0.1:3000/watches?sort=-name"
                    expect(response).to have_http_status(200)
                    watches = JSON.parse(response.body)
                    expect(watches[0]["name"]).to eq("Third")
                    expect(watches[1]["name"]).to eq("Second")
                    expect(watches[2]["name"]).to eq("First")
            end

            it "returns watches sorted asc by price" do
                create(:watch, price: 200.0)
                create(:watch, price: 60.0)
                create(:watch, price: 50.0)
                    get "http://127.0.0.1:3000/watches?sort=price"
                    expect(response).to have_http_status(200)
                    watches = JSON.parse(response.body)
                    expect(watches[0]["price"]).to eq("50.0")
                    expect(watches[1]["price"]).to eq("60.0")
                    expect(watches[2]["price"]).to eq("200.0")
            end

            it "returns watches sorted desc by price" do
                create(:watch, price: 50.0)
                create(:watch, price: 60.0)
                create(:watch, price: 200.0)
                    get "http://127.0.0.1:3000/watches?sort=-price"
                    expect(response).to have_http_status(200)
                    watches = JSON.parse(response.body)
                    expect(watches[0]["price"]).to eq("200.0")
                    expect(watches[1]["price"]).to eq("60.0")
                    expect(watches[2]["price"]).to eq("50.0")
            end

            it "returns watches sorted asc by category" do
                create(:watch, category: "premium")
                create(:watch, category: "premium_plus")
                create(:watch, category: "standard")
                    get "http://127.0.0.1:3000/watches?sort=category"
                    expect(response).to have_http_status(200)
                    watches = JSON.parse(response.body)
                    expect(watches[0]["category"]).to eq("standard")
                    expect(watches[1]["category"]).to eq("premium")
                    expect(watches[2]["category"]).to eq("premium_plus")
            end

            it "returns watches sorted desc by category" do
                create(:watch, category: "premium")
                create(:watch, category: "premium_plus")
                create(:watch, category: "standard")
                    get "http://127.0.0.1:3000/watches?sort=-category"
                    expect(response).to have_http_status(200)
                    watches = JSON.parse(response.body)
                    expect(watches[0]["category"]).to eq("premium_plus")
                    expect(watches[1]["category"]).to eq("premium")
                    expect(watches[2]["category"]).to eq("standard")
            end
        end

        describe "GET /watches/id" do 
            it "returns watch with valid id" do
                watch = create(:watch, name: "First")
                    get watches_path(watch_id: watch.id)
                    expect(response).to have_http_status(200)
                    watches = JSON.parse(response.body)
                    expect(watches.length).to eq(1)
                    expect(watches[0]["name"]).to eq("First")
            end

            it "fails - watch with invalid id" do
                get watches_path(90)
                watches = JSON.parse(response.body)
                expect(watches).to be_empty
            end
        end 

        describe "POST /watches" do
            it "sends a post request to create a watch" do
            post "http://localhost:3000/watches", params: {watch: {name: "First Watch", description: "This is the first watch"}}
    
            expect(response).to have_http_status(200)
            watch = JSON.parse(response.body)
            expect(watch["name"]).to eq("First Watch")
            expect(watch["description"]).to eq("This is the first watch")
            end
        end
    end
