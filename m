Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565853CF0A4
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 02:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356770AbhGSXcb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 19:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441888AbhGSWOD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Jul 2021 18:14:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF37C0613B5
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 15:50:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p36so17956975pfw.11
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 15:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/KQZ/og+MMwG7+gZQy+I2ifIZbW2sC3CrysTm6RWo48=;
        b=TrC6uyzelR+/+DuhHGkQhT8ZilBSns6EN6zr6R3GsDzwt1A0B1ob14VfGLKbKtyYHf
         UnePiDR4FpHICi6z5QS4Br4KOWkHIgLEeR8gx7IzpIzQOJFTLlF7+NNZycoVeKnxYD6h
         HbjmZ/PaBHV0V8e+cfLnxBcowZivtCrjpWnTV8c2ZjABFcunj+ENtzWsgGQLyJbKIFv/
         VR+A8muZqP5sibfw7uvl/qPo2Ty2GVOGxwdOKplp/U4hoGQCi7nhVUCLUrGwfAlFMGnd
         p98tI4Tr+xvCXIgbQNI2AJDXVbX1JKOsFuuzRo2sS//yKyLQdg5uMFTMCUas9NSy8J5b
         Frtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/KQZ/og+MMwG7+gZQy+I2ifIZbW2sC3CrysTm6RWo48=;
        b=JbBcyk/L7ltzj+0v1clkACyTYzc/Sytw5NUobvLDsSFzyfKlCqxXad9vEf2p8YozlZ
         /XTaiw6EN8G0oijowm5uj0bLCn8DLRVzZVPGqN3/RCUJweueK37mGEL4aPkbt1+vcYQr
         93XBZpuXwKSdXSTULaq4jBCgozojIArLH4Lynd7OyIY25lsIOAQ9qlPBoeBQKkpauMik
         VvEaDQ4lDINdT1IBZYhk2OfbO5pp/51RxAbgluwy2S3Pv4qmuT0v8HsdjWDY7LC96lv4
         yC5SUtw6cTrwQYDUR0K9HcVn4JO0QD+R6NdnM9M83l7N+wpW3FtLyA83qwQ9dlc+ltVG
         ZOxg==
X-Gm-Message-State: AOAM532tDQwUx2AbBfPnKmX8rWucHG3AC6sKnuJc54Iv3+3PVCmXxKBy
        dYmU/x00xbEq42p5mqEOVihVjg==
X-Google-Smtp-Source: ABdhPJy/imUID7VPk45W7GZdlhJTj17s4zd4R4dZUGmjWKYmnjQB23dmeWQOvmtu+8kvlA6P6vSXfw==
X-Received: by 2002:a63:a558:: with SMTP id r24mr12070616pgu.438.1626735006916;
        Mon, 19 Jul 2021 15:50:06 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p33sm21208412pfw.40.2021.07.19.15.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:50:06 -0700 (PDT)
Date:   Mon, 19 Jul 2021 22:50:02 +0000
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
Subject: Re: [PATCH Part2 RFC v4 38/40] KVM: SVM: Provide support for
 SNP_GUEST_REQUEST NAE event
Message-ID: <YPYBmlCuERUIO5+M@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-39-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-39-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> Version 2 of GHCB specification added the support two SNP Guest Request
> Message NAE event. The events allows for an SEV-SNP guest to make request
> to the SEV-SNP firmware through hypervisor using the SNP_GUEST_REQUEST
> API define in the SEV-SNP firmware specification.

IIUC, this snippet in the spec means KVM can't restrict what requests are made
by the guests.  If so, that makes it difficult to detect/ratelimit a misbehaving
guest, and also limits our options if there are firmware issues (hopefully there
aren't).  E.g. ratelimiting a guest after KVM has explicitly requested it to
migrate is not exactly desirable.

  The hypervisor cannot alter the messages without detection nor read the
  plaintext of the messages.

> The SNP_GUEST_REQUEST requires two unique pages, one page for the request
> and one page for the response. The response page need to be in the firmware
> state. The GHCB specification says that both the pages need to be in the
> hypervisor state but before executing the SEV-SNP command the response page
> need to be in the firmware state.
 
...

> Now that KVM supports all the VMGEXIT NAEs required for the base SEV-SNP
> feature, set the hypervisor feature to advertise it.

It would helpful if this changelog listed the Guest Requests that are required
for "base" SNP, e.g. to provide some insight as to why we care about guest
requests.

>  static int snp_bind_asid(struct kvm *kvm, int *error)
> @@ -1618,6 +1631,12 @@ static int snp_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  	if (rc)
>  		goto e_free_context;
>  
> +	/* Used for rate limiting SNP guest message request, use the default settings */
> +	ratelimit_default_init(&sev->snp_guest_msg_rs);

Is this exposed to userspace in any way?  This feels very much like a knob that
needs to be configurable per-VM.

Also, what are the estimated latencies of a guest request?  If the worst case
latency is >200ms, a default ratelimit frequency of 5hz isn't going to do a whole
lot.

> +static void snp_handle_guest_request(struct vcpu_svm *svm, struct ghcb *ghcb,
> +				     gpa_t req_gpa, gpa_t resp_gpa)
> +{
> +	struct sev_data_snp_guest_request data = {};
> +	struct kvm_vcpu *vcpu = &svm->vcpu;
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sev_info *sev;
> +	int rc, err = 0;
> +
> +	if (!sev_snp_guest(vcpu->kvm)) {
> +		rc = -ENODEV;
> +		goto e_fail;
> +	}
> +
> +	sev = &to_kvm_svm(kvm)->sev_info;
> +
> +	if (!__ratelimit(&sev->snp_guest_msg_rs)) {
> +		pr_info_ratelimited("svm: too many guest message requests\n");
> +		rc = -EAGAIN;

What guarantee do we have that the guest actually understands -EAGAIN?  Ditto
for -EINVAL returned by snp_build_guest_buf().  AFAICT, our options are to return
one of the error codes defined in "Table 95. Status Codes for SNP_GUEST_REQUEST"
of the firmware ABI, kill the guest, or ratelimit the guest without returning
control to the guest.

> +		goto e_fail;
> +	}
> +
> +	rc = snp_build_guest_buf(svm, &data, req_gpa, resp_gpa);
> +	if (rc)
> +		goto e_fail;
> +
> +	sev = &to_kvm_svm(kvm)->sev_info;
> +
> +	mutex_lock(&kvm->lock);

Question on the VMPCK sequences.  The firmware ABI says:

   Each guest has four VMPCKs ... Each message contains a sequence number per
   VMPCK. The sequence number is incremented with each message sent. Messages
   sent by the guest to the firmware and by the firmware to the guest must be
   delivered in order. If not, the firmware will reject subsequent messages ...

Does that mean there are four independent sequences, i.e. four streams the guest
can use "concurrently", or does it mean the overall freshess/integrity check is
composed from four VMPCK sequences, all of which must be correct for the message
to be valid?

If it's the latter, then a traditional mutex isn't really necessary because the
guest must implement its own serialization, e.g. it's own mutex or whatever, to
ensure there is at most one request in-flight at any given time.  And on the KVM
side it means KVM can simpy reject requests if there is already an in-flight
request.  It might also give us more/better options for ratelimiting?

> +	rc = sev_issue_cmd(kvm, SEV_CMD_SNP_GUEST_REQUEST, &data, &err);
> +	if (rc) {
> +		mutex_unlock(&kvm->lock);

I suspect you reused this pattern from other, more complex code, but here it's
overkill.  E.g.

	if (!rc)
		rc = kvm_write_guest(kvm, resp_gpa, sev->snp_resp_page, PAGE_SIZE);
	else if (err)
		rc = err;

	mutex_unlock(&kvm->lock);

	ghcb_set_sw_exit_info_2(ghcb, rc);

> +		/* If we have a firmware error code then use it. */
> +		if (err)
> +			rc = err;
> +
> +		goto e_fail;
> +	}
> +
> +	/* Copy the response after the firmware returns success. */
> +	rc = kvm_write_guest(kvm, resp_gpa, sev->snp_resp_page, PAGE_SIZE);
> +
> +	mutex_unlock(&kvm->lock);
> +
> +e_fail:
> +	ghcb_set_sw_exit_info_2(ghcb, rc);
> +}
> +
> +static void snp_handle_ext_guest_request(struct vcpu_svm *svm, struct ghcb *ghcb,
> +					 gpa_t req_gpa, gpa_t resp_gpa)
> +{
> +	struct sev_data_snp_guest_request req = {};
> +	struct kvm_vcpu *vcpu = &svm->vcpu;
> +	struct kvm *kvm = vcpu->kvm;
> +	unsigned long data_npages;
> +	struct kvm_sev_info *sev;
> +	unsigned long err;
> +	u64 data_gpa;
> +	int rc;
> +
> +	if (!sev_snp_guest(vcpu->kvm)) {
> +		rc = -ENODEV;
> +		goto e_fail;
> +	}
> +
> +	sev = &to_kvm_svm(kvm)->sev_info;
> +
> +	if (!__ratelimit(&sev->snp_guest_msg_rs)) {
> +		pr_info_ratelimited("svm: too many guest message requests\n");
> +		rc = -EAGAIN;
> +		goto e_fail;
> +	}
> +
> +	if (!sev->snp_certs_data) {
> +		pr_err("svm: certs data memory is not allocated\n");
> +		rc = -EFAULT;

Another instance where the kernel's error numbers will not suffice.

> +		goto e_fail;
> +	}
> +
> +	data_gpa = ghcb_get_rax(ghcb);
> +	data_npages = ghcb_get_rbx(ghcb);
