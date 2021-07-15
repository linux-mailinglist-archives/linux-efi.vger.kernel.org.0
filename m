Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DA83CA1A3
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 17:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbhGOPsx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 11:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbhGOPsx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Jul 2021 11:48:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3881C061762
        for <linux-efi@vger.kernel.org>; Thu, 15 Jul 2021 08:45:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id q10so5786552pfj.12
        for <linux-efi@vger.kernel.org>; Thu, 15 Jul 2021 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JGShUfArb1jvxyvk/PluPuoZRLwcvoX9Y9zVRmEA/LE=;
        b=cvMFpY/OwXDzNZaxDIn8hCltxnXPgoxZFD59snXEi3mihiSlY3m0PQ5CTgOpg4squZ
         AalmskJzdync5QA4IQCm5ffqiWDxrBvwFYYoNj4OuvK7gHrBpci2GtTUFW9X2DHQN0dR
         HFbEerlqGDC1d4sIS9bwC7aNuwwnKpggKW6noufPRcHWlNV1y8HITB7LrzR6AarPqQ0y
         0YNBcIldHRlrOP0V/M5EsmhAkdJeLG9FECbestqwaA742zw0BGPP1fqk0lZKvrFbreFl
         hdSX1/zFa2nbrcaIeXkSea65z702JJp8xh2Zp3ZabADykfikzrxIsq/POXNItxZrpDTl
         Z3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JGShUfArb1jvxyvk/PluPuoZRLwcvoX9Y9zVRmEA/LE=;
        b=uHw/vgREZzhj07Y934DkkHf1drs0YHzE5TUxGYkmTE5rYoP6uKK/OEx6+xO/SdIxeO
         WxeHQgCxdv6l+d/BWZRzmfY42D1ZCk4zkSqVISLknuszs553v5UEvRKMkeOo5ytWOo8P
         4/yVRgXEGgyY36ZNCQeEn0K6R7N26xXfcFlInPDqtM8s7a5vfVYFXwc602CTOUXkgKqQ
         YsTOCUSVMKRmZTaosPX1qRNvSXcgT4/fM9OERDX4513GooWbVcrSeTxrekTjIMtrVrP4
         H7VeSOI0m+amDylHjbQ1AjcmbHHDfR/4sghxWA2cS3CLcPCWZVT0I5Sa48yUEMMFsuN+
         ngFw==
X-Gm-Message-State: AOAM533PQ3XTxajrCBsPwY5ISlS3hxKY0WFh26Il+EzRjgVchTusCan5
        TI+q2k4e3dFzJMvONLOVOsukGg==
X-Google-Smtp-Source: ABdhPJwQyW7bUtVpri0q5g8r0vZu8sEyqzBKIbVZWvT5YFaKDe5mAIuTkn7DhgaMa4VDH0TCblUGFA==
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr5244127pgu.145.1626363958878;
        Thu, 15 Jul 2021 08:45:58 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t37sm7049539pfg.14.2021.07.15.08.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:45:58 -0700 (PDT)
Date:   Thu, 15 Jul 2021 15:45:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 01/40] KVM: SVM: Add support to handle AP
 reset MSR protocol
Message-ID: <YPBYMiOB44dhhPfr@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-2-brijesh.singh@amd.com>
 <YO9GWVsZmfXJ4BRl@google.com>
 <e634061d-78f4-dcb2-b7e5-ebcb25585765@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e634061d-78f4-dcb2-b7e5-ebcb25585765@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 15, 2021, Tom Lendacky wrote:
> On 7/14/21 3:17 PM, Sean Christopherson wrote:
> >> +	case GHCB_MSR_AP_RESET_HOLD_REQ:
> >> +		svm->ap_reset_hold_type = AP_RESET_HOLD_MSR_PROTO;
> >> +		ret = kvm_emulate_ap_reset_hold(&svm->vcpu);
> > 
> > The hold type feels like it should be a param to kvm_emulate_ap_reset_hold().
> 
> I suppose it could be, but then the type would have to be tracked in the
> kvm_vcpu_arch struct instead of the vcpu_svm struct, so I opted for the
> latter. Maybe a helper function, sev_ap_reset_hold(), that sets the type
> and then calls kvm_emulate_ap_reset_hold(), but I'm not seeing a big need
> for it.

Huh.  Why is kvm_emulate_ap_reset_hold() in x86.c?  That entire concept is very
much SEV specific.  And if anyone argues its not SEV specific, then the hold type
should also be considered generic, i.e. put in kvm_vcpu_arch.

> >> +
> >> +		/*
> >> +		 * Preset the result to a non-SIPI return and then only set
> >> +		 * the result to non-zero when delivering a SIPI.
> >> +		 */
> >> +		set_ghcb_msr_bits(svm, 0,
> >> +				  GHCB_MSR_AP_RESET_HOLD_RESULT_MASK,
> >> +				  GHCB_MSR_AP_RESET_HOLD_RESULT_POS);
> >> +
> >> +		set_ghcb_msr_bits(svm, GHCB_MSR_AP_RESET_HOLD_RESP,
> >> +				  GHCB_MSR_INFO_MASK,
> >> +				  GHCB_MSR_INFO_POS);
> > 
> > It looks like all uses set an arbitrary value and then the response.  I think
> > folding the response into the helper would improve both readability and robustness.
> 
> Joerg pulled this patch out and submitted it as part of a small, three
> patch series, so it might be best to address this in general in the
> SEV-SNP patches or as a follow-on series specifically for this re-work.
> 
> > I also suspect the helper needs to do WRITE_ONCE() to guarantee the guest sees
> > what it's supposed to see, though memory ordering is not my strong suit.
> 
> This is writing to the VMCB that is then used to set the value of the
> guest MSR. I don't see anything done in general for writes to the VMCB, so
> I wouldn't think this should be any different.

Ooooh, right.  I was thinking this was writing memory that's shared with the
guest, but this is KVM's copy of the GCHB MSR, not the GHCB itself.  Thanks!

> > Might even be able to squeeze in a build-time assertion.
> > 
> > Also, do the guest-provided contents actually need to be preserved?  That seems
> > somewhat odd.
> 
> Hmmm... not sure I see where the guest contents are being preserved.

The fact that set_ghcb_msr_bits() is a RMW flow implies _something_ is being
preserved.  And unless KVM explicitly zeros/initializes control.ghcb_gpa, the
value being preserved is the value last written by the guest.  E.g. for CPUID
emulation, KVM reads the guest-requested function and register from ghcb_gpa,
then writes back the result.  But set_ghcb_msr_bits() is a RMW on a subset of
bits, and thus it's preserving the guest's value for the bits not being written.

Unless there is an explicit need to preserve the guest value, the whole RMW thing
is unnecessary and confusing.

	case GHCB_MSR_CPUID_REQ: {
		u64 cpuid_fn, cpuid_reg, cpuid_value;

		cpuid_fn = get_ghcb_msr_bits(svm,
					     GHCB_MSR_CPUID_FUNC_MASK,
					     GHCB_MSR_CPUID_FUNC_POS);

		/* Initialize the registers needed by the CPUID intercept */
		vcpu->arch.regs[VCPU_REGS_RAX] = cpuid_fn;
		vcpu->arch.regs[VCPU_REGS_RCX] = 0;

		ret = svm_invoke_exit_handler(vcpu, SVM_EXIT_CPUID);
		if (!ret) {
			ret = -EINVAL;
			break;
		}

		cpuid_reg = get_ghcb_msr_bits(svm,
					      GHCB_MSR_CPUID_REG_MASK,
					      GHCB_MSR_CPUID_REG_POS);
		if (cpuid_reg == 0)
			cpuid_value = vcpu->arch.regs[VCPU_REGS_RAX];
		else if (cpuid_reg == 1)
			cpuid_value = vcpu->arch.regs[VCPU_REGS_RBX];
		else if (cpuid_reg == 2)
			cpuid_value = vcpu->arch.regs[VCPU_REGS_RCX];
		else
			cpuid_value = vcpu->arch.regs[VCPU_REGS_RDX];

		set_ghcb_msr_bits(svm, cpuid_value,
				  GHCB_MSR_CPUID_VALUE_MASK,
				  GHCB_MSR_CPUID_VALUE_POS);

		set_ghcb_msr_bits(svm, GHCB_MSR_CPUID_RESP,
				  GHCB_MSR_INFO_MASK,
				  GHCB_MSR_INFO_POS);
		break;
	}
