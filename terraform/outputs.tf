output "bastion_instance_external_ip" {
  value       = google_compute_instance.bastion_instance.network_interface.0.access_config.0.nat_ip
  description = "The external IP address of the bastion instance to access from browser."
}

output "bastion_instance_name" {
  value       = google_compute_instance.bastion_instance.name
  description = "The name of the bastion instance."
}

output "sql_instance_name" {
  value       = google_sql_database_instance.sql_instance.name
  description = "The name of the Cloud SQL instance."
}

output "bucket_data_name" {
  value       = google_storage_bucket.bucket_data.name
  description = "The name of the storage bucket."
}

output "fast_api_instance_name" {
  value       = google_compute_instance.fast_api_instance_private.name
  description = "The name of the FastAPI private instance."
}

output "private_network_name" {
  value = google_compute_network.terraform_network.self_link
}

output "private_subnetwork_name" {
  value = google_compute_subnetwork.private.self_link
}

output "public_subnetwork_name" {
  value = google_compute_subnetwork.public.self_link
}
