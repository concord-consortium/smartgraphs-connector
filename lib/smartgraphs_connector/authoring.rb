require 'net/http'
module SmartgraphsConnector
  class Authoring
    def self.activities
      act_json = Net::HTTP.get(URI.parse(SmartgraphsConnector.authoring_url + "/activities.json"))
      acts = JSON.parse(act_json)
      acts.map{|a| a["activity"] }
    end

    def self.activity(id)
      act = nil
      res = Net::HTTP.get_response(URI.parse(SmartgraphsConnector.authoring_url + "/activities/#{id}.json"))
      if res.code == "200"
        act_json = res.body
        act = JSON.parse(act_json)
        act.id = id.to_i
      end
      act
    end
  end
end
