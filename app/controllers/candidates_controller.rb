class CandidatesController < ApplicationController
  def fetch
    marvel_params = setup_params(params[:letter])
    candidates = RestClient.get(Rails.application.secrets.marvel_candidates_url, marvel_params)
    Candidate.create_new_candidates(current_user.id, JSON.parse(candidates.body)["data"]["results"])
    redirect_to root_path
  end

  def assign_badge
    candidate = Candidate.find(params[:candidate])
    unless candidate.badge
      new_badge = JSON.parse(issue_badge_call(candidate))["data"]["badge_template"]["name"]
      candidate.update_attributes!(badge: new_badge)
    end
    redirect_to root_path
  end

  def destroy
    Candidate.find(params[:candidate]).destroy!
    redirect_to root_path
  end

  private

  def setup_params(letter)
    timestamp = Time.now.to_s.delete(' ')
    hash = Digest::MD5.hexdigest("#{timestamp}#{Rails.application.secrets.marvel_private_key}#{Rails.application.secrets.marvel_public_key}")
    { params: { ts: timestamp, apikey: Rails.application.secrets.marvel_public_key,
                limit: 5, nameStartsWith: letter, hash: hash } }
  end

  def issue_badge_call(candidate)
    payload = {
                "recipient_email": "#{candidate.name.gsub(/\W+/, '')}@email.com",
                "badge_template_id": "8117c0df-d072-4026-b52e-af4b1986e197",
                "issued_at": "#{Time.now}",
                "issued_to_first_name": "#{candidate.name}",
                "issued_to_last_name": "N/A"
              }.to_json
    header = { "Accept" => "application/json", "Authorization" => "Basic #{Base64.encode64(Rails.application.secrets.acclaim_token)}",
               "Content-Type" => "application/json"}
    RestClient.post("#{Rails.application.secrets.acclaim_url}/badges", payload, header).body
  end
end
