outputs {
  value = kubernetes_service_v1.s3_app.metadata[0].name
  
  description = "The name of the Kubernetes service for the S3 app"
}

outputs {
  value = kubernetes_service_v1.s3_app.spec[0].status
  
  description = "The Status of the Kubernetes service for the S3 app"
}