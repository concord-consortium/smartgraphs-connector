require 'fakeweb'
FakeWeb.allow_net_connect = false

FakeWeb.register_uri(:get, SmartgraphsConnector.authoring_url + "/activities.json", :body => <<JSON)
[
  {"activity":{"author_name":"Aaron Unger","created_at":"2012-07-10T20:30:31Z","id":1,"name":"one","owner_id":1,"updated_at":"2012-07-10T20:30:31Z"}},
  {"activity":{"author_name":"Aaron Unger","created_at":"2012-07-11T20:30:31Z","id":2,"name":"two","owner_id":1,"updated_at":"2012-07-11T20:30:31Z"}},
  {"activity":{"author_name":"Aaron Unger","created_at":"2012-07-12T20:30:31Z","id":3,"name":"three","owner_id":1,"updated_at":"2012-07-12T20:30:31Z"}}
]
JSON
FakeWeb.register_uri(:get, SmartgraphsConnector.authoring_url + "/activities/34.json", :status => ["404", "Not Found"])

def set_original_activity
  FakeWeb.register_uri(:get, SmartgraphsConnector.authoring_url + "/activities/2.json", :body => <<JSON)
{
  "type": "Activity",
  "name": "Second Test Activity",
  "authorName": "Aaron Unger",
  "pages": [
    {
      "type": "Page",
      "name": "Multiple choice",
      "text": "Page 1.",
      "panes": [
        {
          "type": "ImagePane",
          "name": "Arches National Park",
          "url": "http://photos.ungerdesign.com/Professional/2012-Calendar/i-VsrWqxF/1/L/DSC03597-L.jpg",
          "license": "All Rights Reserved.",
          "attribution": "Aaron Unger"
        }
      ],
      "sequence": {
        "type": "MultipleChoiceWithSequentialHintsSequence",
        "initialPrompt": "What color is the sky?",
        "choices": [
          "Blue",
          "Red",
          "Purple",
          "Fuchsia"
        ],
        "correctAnswerIndex": 0,
        "giveUp": "The sky is blue.",
        "confirmCorrect": "Yep, blue!",
        "hints": [

        ]
      }
    },
    {
      "type": "Page",
      "name": "Numeric response",
      "text": "This is page 2.",
      "panes": [
        {
          "type": "ImagePane",
          "name": "Arches National Park",
          "url": "http://photos.ungerdesign.com/Professional/2012-Calendar/i-VsrWqxF/1/L/DSC03597-L.jpg",
          "license": "All Rights Reserved.",
          "attribution": "Aaron Unger"
        }
      ],
      "sequence": {
        "type": "NumericSequence",
        "initialPrompt": {
          "text": "Pick an integer between 3 and 7."
        },
        "correctAnswer": 5.0,
        "tolerance": 0.01,
        "giveUp": {
          "text": "It was 5."
        },
        "confirmCorrect": {
          "text": "Good job!"
        },
        "hints": [
          {
            "name": "Middle",
            "text": "Try the middle-most integer."
          }
        ]
      }
    },
    {
      "type": "Page",
      "name": "Open Response",
      "text": "This is an open response.",
      "panes": [
        {
          "type": "ImagePane",
          "name": "Arches National Park",
          "url": "http://photos.ungerdesign.com/Professional/2012-Calendar/i-VsrWqxF/1/L/DSC03597-L.jpg",
          "license": "All Rights Reserved.",
          "attribution": "Aaron Unger"
        }
      ],
      "sequence": {
        "type": "ConstructedResponseSequence",
        "initialPrompt": "Where does the road meet the sky?",
        "initialContent": "I think..."
      }
    },
    {
      "type": "Page",
      "name": "Conclusion",
      "text": "That's all.",
      "panes": [
        {
          "type": "ImagePane",
          "name": "Arches National Park",
          "url": "http://photos.ungerdesign.com/Professional/2012-Calendar/i-VsrWqxF/1/L/DSC03597-L.jpg",
          "license": "All Rights Reserved.",
          "attribution": "Aaron Unger"
        }
      ]
    }
  ],
  "units": [

  ]
}
JSON
end

def set_updated_activity
  FakeWeb.register_uri(:get, SmartgraphsConnector.authoring_url + "/activities/2.json", :body => <<JSON)
{
  "type": "Activity",
  "name": "Second Test Activity with Updates",
  "authorName": "Aaron Unger",
  "pages": [
    {
      "type": "Page",
      "name": "Multiple choice",
      "text": "Page 1.",
      "panes": [
        {
          "type": "ImagePane",
          "name": "Arches National Park",
          "url": "http://photos.ungerdesign.com/Professional/2012-Calendar/i-VsrWqxF/1/L/DSC03597-L.jpg",
          "license": "All Rights Reserved.",
          "attribution": "Aaron Unger"
        }
      ],
      "sequence": {
        "type": "MultipleChoiceWithSequentialHintsSequence",
        "initialPrompt": "What color is the sea?",
        "choices": [
          "Green",
          "Red",
          "Black",
          "Brown"
        ],
        "correctAnswerIndex": 3,
        "giveUp": "The sea is black.",
        "confirmCorrect": "Yep, black!",
        "hints": [

        ]
      }
    },
    {
      "type": "Page",
      "name": "Numeric response",
      "text": "This is page 2.",
      "panes": [
        {
          "type": "ImagePane",
          "name": "Arches National Park",
          "url": "http://photos.ungerdesign.com/Professional/2012-Calendar/i-VsrWqxF/1/L/DSC03597-L.jpg",
          "license": "All Rights Reserved.",
          "attribution": "Aaron Unger"
        }
      ],
      "sequence": {
        "type": "NumericSequence",
        "initialPrompt": {
          "text": "What hour is noon?"
        },
        "correctAnswer": 12.0,
        "tolerance": 0.01,
        "giveUp": {
          "text": "It was 12."
        },
        "confirmCorrect": {
          "text": "Good job!"
        },
        "hints": [
          {
            "name": "Numbers",
            "text": "What's the largest number on a clock?"
          }
        ]
      }
    },
    {
      "type": "Page",
      "name": "Open Response",
      "text": "This is an open response.",
      "panes": [
        {
          "type": "ImagePane",
          "name": "Arches National Park",
          "url": "http://photos.ungerdesign.com/Professional/2012-Calendar/i-VsrWqxF/1/L/DSC03597-L.jpg",
          "license": "All Rights Reserved.",
          "attribution": "Aaron Unger"
        }
      ],
      "sequence": {
        "type": "ConstructedResponseSequence",
        "initialPrompt": "What's at the bottom of the sea?",
        "initialContent": "The bottom has..."
      }
    },
    {
      "type": "Page",
      "name": "Conclusion",
      "text": "That's all.",
      "panes": [
        {
          "type": "ImagePane",
          "name": "Arches National Park",
          "url": "http://photos.ungerdesign.com/Professional/2012-Calendar/i-VsrWqxF/1/L/DSC03597-L.jpg",
          "license": "All Rights Reserved.",
          "attribution": "Aaron Unger"
        }
      ]
    }
  ],
  "units": [

  ]
}
JSON
end

set_original_activity
