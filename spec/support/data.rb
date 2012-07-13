LEARNER_DATA = <<DATA
{
  "url":"/learner/1",
  "learner":{
    "url":"/learner/1"
  },
  "activity":{
    "url":"/shared/example"
  },
  "pages":[
    {
      "url":"/shared/example/page/1",
      "steps":[
        {
          "url":"/shared/example/page/1/step/1",
          "responseTemplate":{
            "url":"/shared/example/response-template/example-q",
            "values":[2]
          }
        }
      ]
    },
    {
      "url":"/shared/example/page/2",
      "steps":[
        {
          "url":"/shared/example/page/2/step/1",
          "responseTemplate":{
            "url":"/components/response-template/numeric",
            "values":[5.0]
          }
        }
      ]
    },
    {
      "url":"/shared/example/page/3",
      "steps":[
        {
          "url":"/shared/example/page/3/step/1",
          "responseTemplate":{
            "url":"/components/response-template/open",
            "values":["This is some text."]
          }
        }
      ]
    },
    {
      "url":"/shared/example/page/4",
      "steps":[
        {
          "url":"/shared/example/page/1/step/3"
        }
      ]
    }
  ]
}
DATA

UPDATED_LEARNER_DATA = <<DATA
{
  "url":"/learner/1",
  "learner":{
    "url":"/learner/1"
  },
  "activity":{
    "url":"/shared/example"
  },
  "pages":[
    {
      "url":"/shared/example/page/1",
      "steps":[
        {
          "url":"/shared/example/page/1/step/1",
          "responseTemplate":{
            "url":"/shared/example/response-template/example-q",
            "values":[1]
          }
        }
      ]
    },
    {
      "url":"/shared/example/page/2",
      "steps":[
        {
          "url":"/shared/example/page/2/step/1",
          "responseTemplate":{
            "url":"/components/response-template/numeric",
            "values":[7.0]
          }
        }
      ]
    },
    {
      "url":"/shared/example/page/3",
      "steps":[
        {
          "url":"/shared/example/page/3/step/1",
          "responseTemplate":{
            "url":"/components/response-template/open",
            "values":["This is totally different text."]
          }
        }
      ]
    },
    {
      "url":"/shared/example/page/4",
      "steps":[
        {
          "url":"/shared/example/page/1/step/3"
        }
      ]
    }
  ]
}
DATA

