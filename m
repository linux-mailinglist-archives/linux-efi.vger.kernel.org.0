Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC50B3C91E9
	for <lists+linux-efi@lfdr.de>; Wed, 14 Jul 2021 22:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbhGNUU1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 14 Jul 2021 16:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbhGNUU0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 14 Jul 2021 16:20:26 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326E3C061762
        for <linux-efi@vger.kernel.org>; Wed, 14 Jul 2021 13:17:34 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 62so3705318pgf.1
        for <linux-efi@vger.kernel.org>; Wed, 14 Jul 2021 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gI+EA8/Nf0J6cK0TpEGVYGTiyDY2bGvR4CfRf7LwiKE=;
        b=g5d0iCWIXzMtG9uTu4/WlfhcZDBDTSjF3SH5HB9h4kkyFWdS7ZFPeo0oNtlcStWvtn
         OANE7EZVNP4nmKgWq8tgYnWAvrvGJWebyAdeeXhf96uLFGMcFQsamzdhmuuzVPYGOyb8
         O5RDhJG8U68pCLJi5ASJNrLwnUrnkZNoF7FD6XOsrw74H2NswKJvPvJgBvUDCkLvprwV
         NLId20507N3qid+yv8cijIDtEser1wyOco2oH3TW+xXgGAo00hgYD3DO+d60Or3VkQeb
         Wx27yxaXGRcyWXv3NnYcW7bUilesUtohyflmFOm3jAn7bgNguf6V8uYVWOpKM14JokT9
         aPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gI+EA8/Nf0J6cK0TpEGVYGTiyDY2bGvR4CfRf7LwiKE=;
        b=jEN+1CmIcZFc+R4aKYC5K8r+RKkd67vZnv31vTUiY0aSysIytTVh/4FBLG3s30bu/C
         hWiYFWY34m8tTx8SnKIPR5KwjouaN7TFFUNVuCo4WThv+y38fd6vKFE2inegBCeU56u9
         8IYG1HOmVQgaAiqZfOfEMxyexTN0f4s7pIHLTIr1/fe0EEd8C7Ejevjs3Tpb1ec87Xm+
         d8CEyC3ryz40K4N5XnEZNNRMYSfLYE7sSC2ecDlYW1wCm6EVbZP7CzF15MF8Y37xtKBL
         08nMTQzcKgvy8cjoC5Ph2y2Zy8/yoKQ/nM0ONMQvJEB1XTYDaIs0Esas33e0o4rEsrIw
         wSqQ==
X-Gm-Message-State: AOAM530QLMbKKjFu9ZgxUvEvGFka3u3uZKtyrRh8C8pJEmHPf1TLTqTn
        pEe4jZQUWZnmOKUvI1Ryg/5ZnA==
X-Google-Smtp-Source: ABdhPJxZmb+DhcGTDT/5mCgrCU1UlHYl4NvPyzbchWS9bE34G11Vek+44z/cDUPxjy/753noD0t2Cw==
X-Received: by 2002:a63:471b:: with SMTP id u27mr11470643pga.301.1626293853407;
        Wed, 14 Jul 2021 13:17:33 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p1sm3784881pfp.137.2021.07.14.13.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:17:32 -0700 (PDT)
Date:   Wed, 14 Jul 2021 20:17:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
Message-ID: <YO9GWVsZmfXJ4BRl@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-2-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-2-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Add support for AP Reset Hold being invoked using the GHCB MSR protocol,
> available in version 2 of the GHCB specification.

Please provide a brief overview of the protocol, and why it's needed.  I assume
it's to allow AP wakeup without a shared GHCB?

> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---

...

>  static u8 sev_enc_bit;
>  static DECLARE_RWSEM(sev_deactivate_lock);
>  static DEFINE_MUTEX(sev_bitmap_lock);
> @@ -2199,6 +2203,9 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
>  
>  void sev_es_unmap_ghcb(struct vcpu_svm *svm)
>  {
> +	/* Clear any indication that the vCPU is in a type of AP Reset Hold */
> +	svm->ap_reset_hold_type = AP_RESET_HOLD_NONE;
> +
>  	if (!svm->ghcb)
>  		return;
>  
> @@ -2404,6 +2411,22 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
>  				  GHCB_MSR_INFO_POS);
>  		break;
>  	}
> +	case GHCB_MSR_AP_RESET_HOLD_REQ:
> +		svm->ap_reset_hold_type = AP_RESET_HOLD_MSR_PROTO;
> +		ret = kvm_emulate_ap_reset_hold(&svm->vcpu);

The hold type feels like it should be a param to kvm_emulate_ap_reset_hold().

> +
> +		/*
> +		 * Preset the result to a non-SIPI return and then only set
> +		 * the result to non-zero when delivering a SIPI.
> +		 */
> +		set_ghcb_msr_bits(svm, 0,
> +				  GHCB_MSR_AP_RESET_HOLD_RESULT_MASK,
> +				  GHCB_MSR_AP_RESET_HOLD_RESULT_POS);
> +
> +		set_ghcb_msr_bits(svm, GHCB_MSR_AP_RESET_HOLD_RESP,
> +				  GHCB_MSR_INFO_MASK,
> +				  GHCB_MSR_INFO_POS);

It looks like all uses set an arbitrary value and then the response.  I think
folding the response into the helper would improve both readability and robustness.
I also suspect the helper needs to do WRITE_ONCE() to guarantee the guest sees
what it's supposed to see, though memory ordering is not my strong suit.

Might even be able to squeeze in a build-time assertion.

Also, do the guest-provided contents actually need to be preserved?  That seems
somewhat odd.

E.g. can it be

static void set_ghcb_msr_response(struct vcpu_svm *svm, u64 response, u64 value,
				  u64 mask, unsigned int pos)
{
	u64 val = (response << GHCB_MSR_INFO_POS) | (val << pos);

	WRITE_ONCE(svm->vmcb->control.ghcb_gpa |= (value & mask) << pos;
}

and

		set_ghcb_msr_response(svm, GHCB_MSR_AP_RESET_HOLD_RESP,
				      GHCB_MSR_AP_RESET_HOLD_RESULT_MASK,
				      GHCB_MSR_AP_RESET_HOLD_RESULT_POS);

> +		break;
>  	case GHCB_MSR_TERM_REQ: {
>  		u64 reason_set, reason_code;
>  
> @@ -2491,6 +2514,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
>  		ret = svm_invoke_exit_handler(vcpu, SVM_EXIT_IRET);
>  		break;
>  	case SVM_VMGEXIT_AP_HLT_LOOP:
> +		svm->ap_reset_hold_type = AP_RESET_HOLD_NAE_EVENT;
>  		ret = kvm_emulate_ap_reset_hold(vcpu);
>  		break;
>  	case SVM_VMGEXIT_AP_JUMP_TABLE: {
> @@ -2628,13 +2652,29 @@ void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
>  		return;
>  	}
>  
> -	/*
> -	 * Subsequent SIPI: Return from an AP Reset Hold VMGEXIT, where
> -	 * the guest will set the CS and RIP. Set SW_EXIT_INFO_2 to a
> -	 * non-zero value.
> -	 */
> -	if (!svm->ghcb)
> -		return;
> +	/* Subsequent SIPI */
> +	switch (svm->ap_reset_hold_type) {
> +	case AP_RESET_HOLD_NAE_EVENT:
> +		/*
> +		 * Return from an AP Reset Hold VMGEXIT, where the guest will
> +		 * set the CS and RIP. Set SW_EXIT_INFO_2 to a non-zero value.
> +		 */
> +		ghcb_set_sw_exit_info_2(svm->ghcb, 1);
> +		break;
> +	case AP_RESET_HOLD_MSR_PROTO:
> +		/*
> +		 * Return from an AP Reset Hold VMGEXIT, where the guest will
> +		 * set the CS and RIP. Set GHCB data field to a non-zero value.
> +		 */
> +		set_ghcb_msr_bits(svm, 1,
> +				  GHCB_MSR_AP_RESET_HOLD_RESULT_MASK,
> +				  GHCB_MSR_AP_RESET_HOLD_RESULT_POS);
>  
> -	ghcb_set_sw_exit_info_2(svm->ghcb, 1);
> +		set_ghcb_msr_bits(svm, GHCB_MSR_AP_RESET_HOLD_RESP,
> +				  GHCB_MSR_INFO_MASK,
> +				  GHCB_MSR_INFO_POS);
> +		break;
> +	default:
> +		break;
> +	}
>  }
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 0b89aee51b74..ad12ca26b2d8 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -174,6 +174,7 @@ struct vcpu_svm {
>  	struct ghcb *ghcb;
>  	struct kvm_host_map ghcb_map;
>  	bool received_first_sipi;
> +	unsigned int ap_reset_hold_type;

Can't this be a u8?

>  
>  	/* SEV-ES scratch area support */
>  	void *ghcb_sa;
> -- 
> 2.17.1
> 
