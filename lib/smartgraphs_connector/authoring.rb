require 'net/http'
module SmartgraphsConnector
  AUTHORING_URL="http://sg-authoring.local"

  class Authoring
    def self.activities
      act_json = Net::HTTP.get(URI.parse(AUTHORING_URL + "/activities.json"))
      acts = JSON.parse(act_json)
      acts.map{|a| a["activity"] }
    end

    def self.activity(id)
      act = nil
      res = Net::HTTP.get_response(URI.parse(AUTHORING_URL + "/activities/#{id}.json"))
      if res.code == "200"
        act_json = res.body
        act = JSON.parse(act_json)
        act.id = id.to_i
      end
      act
    end
  end
end
