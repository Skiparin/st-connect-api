class PurchaseMailer < MandrillMailer::TemplateMailer
  default from: 'og1806x9@hotmail.com',
          from_name: 'Guttesen inc',
          view_content_link: true

  def purchase_success_email(user, course, price)
    mandrill_mail(
      template: "purchase-success",
      subject: "Payment successful for Talks Academy!",
      to: "og1806x9@hotmail.com",
      vars: {
        'USER_NAME' => "testname",
        'COURSE_TITLE' => "course.title",
        'PRICE' => 100
      },
      important: true,
      inline_css: true
    )
  end
end