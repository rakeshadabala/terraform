provider "google" {
    project = "venkat-473005"
    #region  = "us-central1"

  
}

resource "google_storage_bucket" "bu" {
    name = "venkat-473005-12-6666"
    location = "US"
    force_destroy = true
    storage_class = "STANDARD"
    versioning {
      enabled = true
    }
  
}
resource "google_storage_bucket_object" "obj" {
    name = "venkat.txt"
    bucket = google_storage_bucket.bu.name
    source = "./Su.jpeg"
  
}

resource "google_storage_bucket_iam_member" "name" {
    bucket = google_storage_bucket.bu.name
    role   = "roles/storage.objectViewer"
    member = "allUsers"
  
}

# resource "local_file" "tf_content" {
#     filename = "C:/Users/venka/OneDrive/Desktop/terraform/usecase/2/plan.txt"
#     content  = google_storage_bucket_object.obj.content
# }