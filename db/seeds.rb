Language.destroy_all
Question.destroy_all

js = Language.create!(name: "JavaScript")
py = Language.create!(name: "Python")
rb = Language.create!(name: "Ruby")

Question.create!(
  language: js,
  question_text: "What is the output of: console.log(typeof typeof 1)?",
  options: ["number", "string", "undefined", "object"],
  correct_answer: "string",
  difficulty: 2
)

Question.create!(
  language: js,
  question_text: "Which method converts JSON string to object?",
  options: ["JSON.parse()", "JSON.stringify()", "JSON.toObject()", "JSON.convert()"],
  correct_answer: "JSON.parse()",
  difficulty: 1
)

Question.create!(
  language: py,
  question_text: "What is the difference between list and tuple?",
  options: ["List is mutable, tuple is immutable", "Tuple is mutable, list is immutable", "Both are mutable", "Both are immutable"],
  correct_answer: "List is mutable, tuple is immutable",
  difficulty: 1
)

Question.create!(
  language: rb,
  question_text: "Which method adds an element to an array in Ruby?",
  options: [ "push", "append", "add", "put" ],
  correct_answer: "push",
  difficulty: 1
)

puts "Seeded Languages: #{Language.count}, Questions: #{Question.count}"
