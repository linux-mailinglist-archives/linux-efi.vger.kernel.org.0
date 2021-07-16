Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327C53CBD98
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 22:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhGPUVd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 16:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbhGPUVa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jul 2021 16:21:30 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FFCC061764
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 13:18:32 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h4so11047394pgp.5
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7BfdE/UnNU5Cufvf6AxaiSfhYzH0BNSWGCMFhxKGx24=;
        b=E/6CFLEks/63BAj+rvhYCFw8+j7smWigt7E6yUbBVKRWlRh4N7F8j6bfSFznq5Pexd
         iEJCSF81FF07VW1In+vgw7fKVgU1GCERXQxf8aQZUNZbSALSG+CX2F+XKV7NUrUtAWJ7
         ZfhTy9tv9CvIii44N6QwKBAajeafbJHnYCiBPRppBc7l6DZwSY9HDsTA6fAGWgC5XQl9
         uHP0lCmDLTn/ZErBYw/dnr8p5AzKbvX/5t0q1qetAfHdGQm5eBeQuyiumdM3qN90KASo
         4BWIk/iOoYKVnBz4sy81Zudtpai8KHzWDLeVVYFmFgedPtIMuywTSq6e+ol03K9nNUhB
         oisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7BfdE/UnNU5Cufvf6AxaiSfhYzH0BNSWGCMFhxKGx24=;
        b=PBK871iE4gFUXslBNL3Q4dsUsTSvHYVnP7nimryUdaEWMVC4yN0OQSHd7Xd4mrk51c
         svsO4NbzFBg2dpOLNHeNcBZY1MxqcrHeGCk9GrfLiPp/lW2l8pnuwOqP/IcfG8DD5Dnu
         j37vrpnXvPFnqRdxryjLW5tQut74C5sHoXoPgQpvEkWVhja7HyNOu3UiJyywBB12EnoY
         BBLRylWtN8DtIP8tllPYNoljrseUf0RODzmehxKTvX18T6doihYYJYf5BRrMEfuQHUPW
         sZoKLleHXBjjjClYZ5x7yp3kAvOguyEcwKJ7Tn2OQv5qT/xzFzLUBqpAuybk7GTaQi1R
         SzoA==
X-Gm-Message-State: AOAM533uu+4e55IDvkszIy1EOfML4DGRcy47fXrtAtEbKZrn/XOxQK4w
        2SK2RkVQ8segm6DnvJKmlS4wVA==
X-Google-Smtp-Source: ABdhPJxGmVxKHvgAi++bhPO4+E3+foVmkz5V2tqUg30o5TimNltdIyo4I4VHmzy377lREouP3naHHw==
X-Received: by 2002:a63:770c:: with SMTP id s12mr7009862pgc.339.1626466711719;
        Fri, 16 Jul 2021 13:18:31 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k8sm3003625pfu.116.2021.07.16.13.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:18:31 -0700 (PDT)
Date:   Fri, 16 Jul 2021 20:18:27 +0000
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
Subject: Re: [PATCH Part2 RFC v4 26/40] KVM: SVM: Add
 KVM_SEV_SNP_LAUNCH_FINISH command
Message-ID: <YPHpk3RFSmE13ZXz@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-27-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-27-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> +        struct kvm_sev_snp_launch_finish {
> +                __u64 id_block_uaddr;
> +                __u64 id_auth_uaddr;
> +                __u8 id_block_en;
> +                __u8 auth_key_en;
> +                __u8 host_data[32];

Pad this one too?

> +        };
> +
> +
> +See SEV-SNP specification for further details on launch finish input parameters.

...

> +	data->gctx_paddr = __psp_pa(sev->snp_context);
> +	ret = sev_issue_cmd(kvm, SEV_CMD_SNP_LAUNCH_FINISH, data, &argp->error);

Shouldn't KVM unwind everything it did if LAUNCH_FINISH fails?  And if that's
not possible, take steps to make the VM unusable?

> +
> +	kfree(id_auth);
> +
> +e_free_id_block:
> +	kfree(id_block);
> +
> +e_free:
> +	kfree(data);
> +
> +	return ret;
> +}
> +

...

> @@ -2346,8 +2454,25 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
>  
>  	if (vcpu->arch.guest_state_protected)
>  		sev_flush_guest_memory(svm, svm->vmsa, PAGE_SIZE);
> +
> +	/*
> +	 * If its an SNP guest, then VMSA was added in the RMP entry as a guest owned page.
> +	 * Transition the page to hyperivosr state before releasing it back to the system.

"hyperivosr" typo.  And please wrap at 80 chars.

> +	 */
> +	if (sev_snp_guest(vcpu->kvm)) {
> +		struct rmpupdate e = {};
> +		int rc;
> +
> +		rc = rmpupdate(virt_to_page(svm->vmsa), &e);

So why does this not need to go through snp_page_reclaim()?

> +		if (rc) {
> +			pr_err("Failed to release SNP guest VMSA page (rc %d), leaking it\n", rc);

Seems like a WARN would be simpler.  But the more I see the rmpupdate(..., {0})
pattern, the more I believe that nuking an RMP entry needs a dedicated helper.

> +			goto skip_vmsa_free;

