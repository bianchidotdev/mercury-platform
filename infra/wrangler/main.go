package main

import (
	"fmt"

	"github.com/pulumi/pulumi-gcp/sdk/v2/go/gcp/cloudrun"
	"github.com/pulumi/pulumi-gcp/sdk/v2/go/gcp/storage"
	"github.com/pulumi/pulumi/sdk/go/pulumi"
)

const (
	GCRRepoPath = "gcr.io/"
	GCPProject  = "mercuy"
	ProjectName = "wrangler"
)

func main() {
	pulumi.Run(func(ctx *pulumi.Context) error {
		// Create a GCP resource (Storage Bucket)
		location := pulumi.String("us-central-1")
		bucket, err := storage.NewBucket(ctx, ProjectName, &storage.BucketArgs{
			Location: location,
		})
		if err != nil {
			return err
		}

		image_name := pulumi.String(fmt.Sprintf("%s/%s/%s", GCRRepoPath, GCPProject, ProjectName))

		containers := cloudrun.ServiceTemplateSpecContainerArray{
			cloudrun.ServiceTemplateSpecContainerArgs{
				Image: image_name,
			},
		}

		service_template := cloudrun.ServiceTemplateArgs{
			Spec: &cloudrun.ServiceTemplateSpecArgs{
				Containers: containers,
			},
		}
		service_args := cloudrun.ServiceArgs{
			Template: service_template,
			Location: location,
		}
		cloud_run_service, err := cloudrun.NewService(ctx, ProjectName, &service_args)
		if err != nil {
			return err
		}

		// Export the DNS name of the bucket
		ctx.Export("bucketName", bucket.Url)
		ctx.Export("cloudRunService", cloud_run_service.Status)
		return nil
	})
}
