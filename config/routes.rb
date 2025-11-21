Rails.application.routes.draw do
  root "languages#index"

  resources :languages, only: [:index]
  post "sessions/start_test", to: "sessions#start_test", as: :start_test

  get "assessment/question", to: "assessments#show", as: :assessment_question
  post "assessment/answer", to: "assessments#answer", as: :assessment_answer
  post "assessment/previous", to: "assessments#previous", as: :assessment_previous

  get "assessment/result", to: "assessments#result", as: :assessment_result


  post "resume/upload", to: "resumes#create", as: :resume_upload

  # optional: for admin to manage questions
  namespace :admin do
    resources :languages
    resources :questions
  end
end
