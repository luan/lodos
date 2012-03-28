$facebook_id, $facebook_secret = case Rails.env
when 'development' then ['249511985086492', 'eb373879c5242b129d6939ddbefcef9c']
when 'test' then ['249511985086492', 'eb373879c5242b129d6939ddbefcef9c']
when 'staging' then ['300850183272649', '8549d49f1b2ddd8081146d8642676428']
when 'production' then ['132962686778962', 'd964d5d9c8439f1e2a142d41c20c7f79']
end

