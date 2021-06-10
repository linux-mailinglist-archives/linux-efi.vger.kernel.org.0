Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9F53A3196
	for <lists+linux-efi@lfdr.de>; Thu, 10 Jun 2021 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhFJRAJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Jun 2021 13:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231699AbhFJRAI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Jun 2021 13:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623344291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/r/hUN+4lM6VgG4ONfhlHdUQ8gl/bwP/FKByDaDe0w=;
        b=BiV9aLeKAoQiccflvGj8j8K+6+kRkrerc8rRfL0oKxaOqufFvj+RSz7gVKdzbka/nBVIb9
        hEuGbb2teEnzzFA4vDhAKu0Es9wNliruiQLpKLnFudptOGQ3ackd3uLb2kYZ10LP7jrPLn
        0RrujIYCd14UFzKS4cUc4iQtcB8X/bU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-0YUI-i0_N6mvOwN7FODncg-1; Thu, 10 Jun 2021 12:58:10 -0400
X-MC-Unique: 0YUI-i0_N6mvOwN7FODncg-1
Received: by mail-wm1-f69.google.com with SMTP id r4-20020a7bc0840000b02901b7cb5713ecso1448462wmh.1
        for <linux-efi@vger.kernel.org>; Thu, 10 Jun 2021 09:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D/r/hUN+4lM6VgG4ONfhlHdUQ8gl/bwP/FKByDaDe0w=;
        b=Llf22rPshXoOoRM95GptYcvGEBaypXuboZAVEMKYbqSVbfYsrcYWNPSCMu4E+1MenD
         fJqKXla6tSQc087Dm5avDYVNxFrzpcvgHerwOOEzM4rByABF+NouJTtgjNcCIU1zTxK3
         EIS/N189+MXPNbs5l35FKttvNnVV0s0GrD/+WmVK/vYk6Kmg+8tb/R9OR9Re45UODrYX
         OPbzoyWM/7yV88VLpddschngFae9FAzmsrpyiYwewqCgzBHzHYXDoUXAE4RtFVLJdcUU
         ZyD+H3tj0chLIve9xD6QD3qpqD8WbpcxFe6Fvpc3Sozok3FaTOLgCUJjMstNPAeGz9eh
         ilcA==
X-Gm-Message-State: AOAM532K4+tfZgYlFWdPTUOucGyDE/ckRJKvELQGNb8HItCkyIdFTXO9
        Nems8pxB6snIyKkqF8rdM7qu7xlG0BMKnTicK1ygKOGdexxp6f5v01CZRQk8oDyrxq+khE0crx6
        R6mZLeoqpXn/pB7Vj4UuVY7E6rHm0PuaBOT9TEIi38uMO6iVS4gMJ7tVi17wXC4wy4w89AtCp
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr16257384wmi.151.1623344287093;
        Thu, 10 Jun 2021 09:58:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydOtexA98InvTnVVg6SkRGGoG6nZ/JiiprLn/cVgRar6Mqa6QEbeWyfMz3KwvA+t0QN5d2Ag==
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr16257348wmi.151.1623344286809;
        Thu, 10 Jun 2021 09:58:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id a15sm5278270wrs.63.2021.06.10.09.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 09:58:06 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] KVM: X86: Introduce KVM_HC_MAP_GPA_RANGE hypercall
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     seanjc@google.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com, linux-efi@vger.kernel.org
References: <cover.1623174621.git.ashish.kalra@amd.com>
 <90778988e1ee01926ff9cac447aacb745f954c8c.1623174621.git.ashish.kalra@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47f158c6-3dba-91e8-3607-7c787262248d@redhat.com>
Date:   Thu, 10 Jun 2021 18:58:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <90778988e1ee01926ff9cac447aacb745f954c8c.1623174621.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 08/06/21 20:05, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> This hypercall is used by the SEV guest to notify a change in the page
> encryption status to the hypervisor. The hypercall should be invoked
> only when the encryption attribute is changed from encrypted -> decrypted
> and vice versa. By default all guest pages are considered encrypted.
> 
> The hypercall exits to userspace to manage the guest shared regions and
> integrate with the userspace VMM's migration code.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Steve Rutherford <srutherford@google.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   Documentation/virt/kvm/api.rst        | 19 +++++++++++
>   Documentation/virt/kvm/cpuid.rst      |  7 ++++
>   Documentation/virt/kvm/hypercalls.rst | 21 ++++++++++++
>   Documentation/virt/kvm/msr.rst        | 13 ++++++++
>   arch/x86/include/asm/kvm_host.h       |  2 ++
>   arch/x86/include/uapi/asm/kvm_para.h  | 13 ++++++++
>   arch/x86/kvm/x86.c                    | 46 +++++++++++++++++++++++++++
>   include/uapi/linux/kvm.h              |  1 +
>   include/uapi/linux/kvm_para.h         |  1 +
>   9 files changed, 123 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 7fcb2fd38f42..6396ce8bfa44 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6891,3 +6891,22 @@ This capability is always enabled.
>   This capability indicates that the KVM virtual PTP service is
>   supported in the host. A VMM can check whether the service is
>   available to the guest on migration.
> +
> +8.33 KVM_CAP_EXIT_HYPERCALL
> +---------------------------
> +
> +:Capability: KVM_CAP_EXIT_HYPERCALL
> +:Architectures: x86
> +:Type: vm
> +
> +This capability, if enabled, will cause KVM to exit to userspace
> +with KVM_EXIT_HYPERCALL exit reason to process some hypercalls.
> +
> +Calling KVM_CHECK_EXTENSION for this capability will return a bitmask
> +of hypercalls that can be configured to exit to userspace.
> +Right now, the only such hypercall is KVM_HC_MAP_GPA_RANGE.
> +
> +The argument to KVM_ENABLE_CAP is also a bitmask, and must be a subset
> +of the result of KVM_CHECK_EXTENSION.  KVM will forward to userspace
> +the hypercalls whose corresponding bit is in the argument, and return
> +ENOSYS for the others.
> diff --git a/Documentation/virt/kvm/cpuid.rst b/Documentation/virt/kvm/cpuid.rst
> index cf62162d4be2..bda3e3e737d7 100644
> --- a/Documentation/virt/kvm/cpuid.rst
> +++ b/Documentation/virt/kvm/cpuid.rst
> @@ -96,6 +96,13 @@ KVM_FEATURE_MSI_EXT_DEST_ID        15          guest checks this feature bit
>                                                  before using extended destination
>                                                  ID bits in MSI address bits 11-5.
>   
> +KVM_FEATURE_HC_MAP_GPA_RANGE       16          guest checks this feature bit before
> +                                               using the map gpa range hypercall
> +                                               to notify the page state change
> +
> +KVM_FEATURE_MIGRATION_CONTROL      17          guest checks this feature bit before
> +                                               using MSR_KVM_MIGRATION_CONTROL
> +
>   KVM_FEATURE_CLOCKSOURCE_STABLE_BIT 24          host will warn if no guest-side
>                                                  per-cpu warps are expected in
>                                                  kvmclock
> diff --git a/Documentation/virt/kvm/hypercalls.rst b/Documentation/virt/kvm/hypercalls.rst
> index ed4fddd364ea..e56fa8b9cfca 100644
> --- a/Documentation/virt/kvm/hypercalls.rst
> +++ b/Documentation/virt/kvm/hypercalls.rst
> @@ -169,3 +169,24 @@ a0: destination APIC ID
>   
>   :Usage example: When sending a call-function IPI-many to vCPUs, yield if
>   	        any of the IPI target vCPUs was preempted.
> +
> +8. KVM_HC_MAP_GPA_RANGE
> +-------------------------
> +:Architecture: x86
> +:Status: active
> +:Purpose: Request KVM to map a GPA range with the specified attributes.
> +
> +a0: the guest physical address of the start page
> +a1: the number of (4kb) pages (must be contiguous in GPA space)
> +a2: attributes
> +
> +    Where 'attributes' :
> +        * bits  3:0 - preferred page size encoding 0 = 4kb, 1 = 2mb, 2 = 1gb, etc...
> +        * bit     4 - plaintext = 0, encrypted = 1
> +        * bits 63:5 - reserved (must be zero)
> +
> +**Implementation note**: this hypercall is implemented in userspace via
> +the KVM_CAP_EXIT_HYPERCALL capability. Userspace must enable that capability
> +before advertising KVM_FEATURE_HC_MAP_GPA_RANGE in the guest CPUID.  In
> +addition, if the guest supports KVM_FEATURE_MIGRATION_CONTROL, userspace
> +must also set up an MSR filter to process writes to MSR_KVM_MIGRATION_CONTROL.
> diff --git a/Documentation/virt/kvm/msr.rst b/Documentation/virt/kvm/msr.rst
> index e37a14c323d2..9315fc385fb0 100644
> --- a/Documentation/virt/kvm/msr.rst
> +++ b/Documentation/virt/kvm/msr.rst
> @@ -376,3 +376,16 @@ data:
>   	write '1' to bit 0 of the MSR, this causes the host to re-scan its queue
>   	and check if there are more notifications pending. The MSR is available
>   	if KVM_FEATURE_ASYNC_PF_INT is present in CPUID.
> +
> +MSR_KVM_MIGRATION_CONTROL:
> +        0x4b564d08
> +
> +data:
> +        This MSR is available if KVM_FEATURE_MIGRATION_CONTROL is present in
> +        CPUID.  Bit 0 represents whether live migration of the guest is allowed.
> +
> +        When a guest is started, bit 0 will be 0 if the guest has encrypted
> +        memory and 1 if the guest does not have encrypted memory.  If the
> +        guest is communicating page encryption status to the host using the
> +        ``KVM_HC_MAP_GPA_RANGE`` hypercall, it can set bit 0 in this MSR to
> +        allow live migration of the guest.
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 55efbacfc244..5b9bc8b3db20 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1067,6 +1067,8 @@ struct kvm_arch {
>   	u32 user_space_msr_mask;
>   	struct kvm_x86_msr_filter __rcu *msr_filter;
>   
> +	u32 hypercall_exit_enabled;
> +
>   	/* Guest can access the SGX PROVISIONKEY. */
>   	bool sgx_provisioning_allowed;
>   
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> index 950afebfba88..5146bbab84d4 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -33,6 +33,8 @@
>   #define KVM_FEATURE_PV_SCHED_YIELD	13
>   #define KVM_FEATURE_ASYNC_PF_INT	14
>   #define KVM_FEATURE_MSI_EXT_DEST_ID	15
> +#define KVM_FEATURE_HC_MAP_GPA_RANGE	16
> +#define KVM_FEATURE_MIGRATION_CONTROL	17
>   
>   #define KVM_HINTS_REALTIME      0
>   
> @@ -54,6 +56,7 @@
>   #define MSR_KVM_POLL_CONTROL	0x4b564d05
>   #define MSR_KVM_ASYNC_PF_INT	0x4b564d06
>   #define MSR_KVM_ASYNC_PF_ACK	0x4b564d07
> +#define MSR_KVM_MIGRATION_CONTROL	0x4b564d08
>   
>   struct kvm_steal_time {
>   	__u64 steal;
> @@ -90,6 +93,16 @@ struct kvm_clock_pairing {
>   /* MSR_KVM_ASYNC_PF_INT */
>   #define KVM_ASYNC_PF_VEC_MASK			GENMASK(7, 0)
>   
> +/* MSR_KVM_MIGRATION_CONTROL */
> +#define KVM_MIGRATION_READY		(1 << 0)
> +
> +/* KVM_HC_MAP_GPA_RANGE */
> +#define KVM_MAP_GPA_RANGE_PAGE_SZ_4K	0
> +#define KVM_MAP_GPA_RANGE_PAGE_SZ_2M	(1 << 0)
> +#define KVM_MAP_GPA_RANGE_PAGE_SZ_1G	(1 << 1)
> +#define KVM_MAP_GPA_RANGE_ENC_STAT(n)	(n << 4)
> +#define KVM_MAP_GPA_RANGE_ENCRYPTED	KVM_MAP_GPA_RANGE_ENC_STAT(1)
> +#define KVM_MAP_GPA_RANGE_DECRYPTED	KVM_MAP_GPA_RANGE_ENC_STAT(0)
>   
>   /* Operations for KVM_HC_MMU_OP */
>   #define KVM_MMU_OP_WRITE_PTE            1
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9b6bca616929..6686d99b1d7b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -102,6 +102,8 @@ static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
>   
>   static u64 __read_mostly cr4_reserved_bits = CR4_RESERVED_BITS;
>   
> +#define KVM_EXIT_HYPERCALL_VALID_MASK (1 << KVM_HC_MAP_GPA_RANGE)
> +
>   #define KVM_X2APIC_API_VALID_FLAGS (KVM_X2APIC_API_USE_32BIT_IDS | \
>                                       KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK)
>   
> @@ -3894,6 +3896,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_VM_COPY_ENC_CONTEXT_FROM:
>   		r = 1;
>   		break;
> +	case KVM_CAP_EXIT_HYPERCALL:
> +		r = KVM_EXIT_HYPERCALL_VALID_MASK;
> +		break;
>   	case KVM_CAP_SET_GUEST_DEBUG2:
>   		return KVM_GUESTDBG_VALID_MASK;
>   #ifdef CONFIG_KVM_XEN
> @@ -5499,6 +5504,14 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>   		if (kvm_x86_ops.vm_copy_enc_context_from)
>   			r = kvm_x86_ops.vm_copy_enc_context_from(kvm, cap->args[0]);
>   		return r;
> +	case KVM_CAP_EXIT_HYPERCALL:
> +		if (cap->args[0] & ~KVM_EXIT_HYPERCALL_VALID_MASK) {
> +			r = -EINVAL;
> +			break;
> +		}
> +		kvm->arch.hypercall_exit_enabled = cap->args[0];
> +		r = 0;
> +		break;
>   	default:
>   		r = -EINVAL;
>   		break;
> @@ -8384,6 +8397,17 @@ static void kvm_sched_yield(struct kvm_vcpu *vcpu, unsigned long dest_id)
>   	return;
>   }
>   
> +static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
> +{
> +	u64 ret = vcpu->run->hypercall.ret;
> +
> +	if (!is_64_bit_mode(vcpu))
> +		ret = (u32)ret;
> +	kvm_rax_write(vcpu, ret);
> +	++vcpu->stat.hypercalls;
> +	return kvm_skip_emulated_instruction(vcpu);
> +}
> +
>   int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>   {
>   	unsigned long nr, a0, a1, a2, a3, ret;
> @@ -8449,6 +8473,28 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>   		kvm_sched_yield(vcpu, a0);
>   		ret = 0;
>   		break;
> +	case KVM_HC_MAP_GPA_RANGE: {
> +		u64 gpa = a0, npages = a1, attrs = a2;
> +
> +		ret = -KVM_ENOSYS;
> +		if (!(vcpu->kvm->arch.hypercall_exit_enabled & (1 << KVM_HC_MAP_GPA_RANGE)))
> +			break;
> +
> +		if (!PAGE_ALIGNED(gpa) || !npages ||
> +		    gpa_to_gfn(gpa) + npages <= gpa_to_gfn(gpa)) {
> +			ret = -KVM_EINVAL;
> +			break;
> +		}
> +
> +		vcpu->run->exit_reason        = KVM_EXIT_HYPERCALL;
> +		vcpu->run->hypercall.nr       = KVM_HC_MAP_GPA_RANGE;
> +		vcpu->run->hypercall.args[0]  = gpa;
> +		vcpu->run->hypercall.args[1]  = npages;
> +		vcpu->run->hypercall.args[2]  = attrs;
> +		vcpu->run->hypercall.longmode = op_64_bit;
> +		vcpu->arch.complete_userspace_io = complete_hypercall_exit;
> +		return 0;
> +	}
>   	default:
>   		ret = -KVM_ENOSYS;
>   		break;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 3fd9a7e9d90c..1fb4fd863324 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1082,6 +1082,7 @@ struct kvm_ppc_resize_hpt {
>   #define KVM_CAP_SGX_ATTRIBUTE 196
>   #define KVM_CAP_VM_COPY_ENC_CONTEXT_FROM 197
>   #define KVM_CAP_PTP_KVM 198
> +#define KVM_CAP_EXIT_HYPERCALL 199
>   
>   #ifdef KVM_CAP_IRQ_ROUTING
>   
> diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
> index 8b86609849b9..960c7e93d1a9 100644
> --- a/include/uapi/linux/kvm_para.h
> +++ b/include/uapi/linux/kvm_para.h
> @@ -29,6 +29,7 @@
>   #define KVM_HC_CLOCK_PAIRING		9
>   #define KVM_HC_SEND_IPI		10
>   #define KVM_HC_SCHED_YIELD		11
> +#define KVM_HC_MAP_GPA_RANGE		12
>   
>   /*
>    * hypercalls use architecture specific
> 

Queued this one for 5.14, thanks!

Paolo

