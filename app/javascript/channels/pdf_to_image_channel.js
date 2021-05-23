import consumer from "./consumer"

// This will create a subscription for PdfToImageChannel
const channel = consumer.subscriptions.create("PdfToImageChannel", {
  connected() {
    console.log('channel connected');
  },

  disconnected() {
    console.log('channel disconnected');
  },

  // This method receive page data from broadcasting and shows the progress while pages of doc being converted into images  
  received(data) {
    let responseContent = data.content

    const documentId = $("#conversion-progress-bar").attr("data-last-uploaded-document-id");

    if (documentId == responseContent.doc_id) {
      // calculating percentage of page conversion
      let percentage = Math.round((responseContent.page_no / responseContent.total_pages) * 100)
      // to show the current no. of pages converted
      let progressBarNow = `
        <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${percentage}%" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100">${percentage}%</div>
      `
      // rendering progress bar inside modal popup
      let progressBar = document.querySelector('#conversion-progress-bar');

      console.log($("#conversion-progress-bar").attr("data-last-uploaded-document-id"));

      if(progressBar != null) {
        progressBar.innerHTML = progressBarNow;
      }
      // displaying page conversion message to user
      let pageNoToShow = responseContent.page_no == responseContent.total_pages ? responseContent.total_pages : responseContent.page_no + 1

      // displaying processing data to pages
      let progressMessage = `<span class="text-primary font-weight-bold">Status:</span> Processing page ${pageNoToShow} out of ${responseContent.total_pages}`

      console.log($("#converted-page-number").attr("data-last-uploaded-document-id"));

      $("#converted-page-number").html(progressMessage);
      if(percentage == 100) {
        // this is to check of users has close the upload modal form or refreshed the page. This prevents page from redirect if ay of these occurs 
        window.location.replace("/documents/" + responseContent.doc_id);
      } 
    }
  }
});
