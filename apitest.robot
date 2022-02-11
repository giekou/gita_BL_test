*** Settings ***
Library         RequestsLibrary

*** Variables ***
${base_url}     https://jsonplaceholder.cypress.io

*** Test Cases ***
GET_andValidateDataType
# This is for setup connection to API
    create session      mysession           ${base_url}
    ${response}=        get on session      mysession       /posts
#    ${typeInteger}=         Evaluate            type(${response.json()[0]['title']}).__name__
#    log to console      ${typeInteger}

#This is for Validate Response Data Type
    ${validateUserId}=          Evaluate            isinstance(${response.json()[0]['userId']}, int)
    log to console              ${validateUserId}

    ${validateId}=              Evaluate                isinstance(${response.json()[0]['id']}, int)
    log to console              ${validateId}

    ${validateTitle}=           Evaluate                isinstance($response.json()[0]['title'], str)
    log to console              ${validateTitle}

    ${validateBody}=            Evaluate                isinstance($response.json()[0]['body'], str)
    log to console              ${validateBody}

POST_andValidateResponse
# This is for setup connection to API
    create session      mysession       ${base_url}
    ${body}=    create dictionary       title=recomendation     body=motorcycle     userId=${12}
    ${response}=        post on session        mysession        /posts        ${body}

#This is for Validate Response data are equal to post body
    ${respTitle}=           Evaluate            $body.get("title")
    should be equal                 ${respTitle}          ${response.json()['title']}

    ${respBody}=            Evaluate             $body.get("body")
    should be equal                 ${respBody}          ${response.json()['body']}

    ${respUserId}=          Evaluate           $body.get("userId")
    should be equal as strings     ${respUserId}          ${response.json()['userId']}

*** Keywords ***
Provided precondition
    Setup system under test
