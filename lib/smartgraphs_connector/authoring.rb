module SmartgraphsConnector
  AUTHORING_URL="http://sg-authoring.local"

  class Authoring
    def self.activities
      act_json = Net::HTTP.get(URI.parse(AUTHORING_URL + "/activities.json"))
      acts = JSON.parse(act_json)
      acts.map{|a| a["activity"] }
    end

    def self.activity(id)
      act_json = Net::HTTP.get(URI.parse(AUTHORING_URL + "/activities/#{id}.json"))
      act = JSON.parse(act_json)
    end
  end
end
