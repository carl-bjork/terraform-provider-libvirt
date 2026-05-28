package regression

import (
	"context"
	"testing"

	"github.com/dmacvicar/terraform-provider-libvirt/v2/internal/generated"
	"github.com/hashicorp/terraform-plugin-framework/types"
	"libvirt.org/go/libvirtxml"
)

func TestDomainChannelTargetVirtIOStatePreservesPlannedValueAgainstRuntimeReadback(t *testing.T) {
	ctx := context.Background()

	plan := &generated.DomainChannelTargetVirtIOModel{
		Name:  types.StringValue("org.qemu.guest_agent.0"),
		State: types.StringValue("connected"),
	}
	xml := &libvirtxml.DomainChannelTargetVirtIO{
		Name:  "org.qemu.guest_agent.0",
		State: "disconnected",
	}

	model, err := generated.DomainChannelTargetVirtIOFromXML(ctx, xml, plan)
	if err != nil {
		t.Fatalf("converting channel target virtio from XML: %v", err)
	}

	want := "connected"
	if got := model.State.ValueString(); got != want {
		t.Fatalf("expected planned state to be preserved against libvirt runtime readback, got %q want %q", got, want)
	}
}
