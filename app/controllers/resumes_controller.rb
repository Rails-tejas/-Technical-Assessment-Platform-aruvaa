class ResumesController < ApplicationController
  def create
    assessment = Assessment.find_by(id: session[:assessment_id])
    unless assessment&.passed
      redirect_to assessment_result_path, alert: "Not authorized to upload resume" and return
    end

    candidate = assessment.candidate
    if params[:resume].present?
      # simple validations: content type & size
      uploaded = params[:resume]
      allowed = ["application/pdf", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"]
      if !allowed.include?(uploaded.content_type)
        redirect_to assessment_result_path, alert: "Invalid file type. Only PDF, DOC, DOCX allowed." and return
      end

      if uploaded.size > 5.megabytes
        redirect_to assessment_result_path, alert: "File too large (max 5 MB)." and return
      end

      candidate.resume.attach(uploaded)
      redirect_to assessment_result_path, notice: "Resume uploaded successfully."
    else
      redirect_to assessment_result_path, alert: "Please attach a file."
    end
  end
end
