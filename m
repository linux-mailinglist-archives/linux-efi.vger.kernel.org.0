Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A173CBD72
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 22:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhGPUFC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 16:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhGPUFA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jul 2021 16:05:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AA6C061762
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 13:02:04 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y3so1463088plp.4
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=15+pAbK3BFL8YJdD4x+WorUOU6nduiGry4z4wlzYpfU=;
        b=Cyr5L2zEBLE8/ksq+6DuvYBQHNzA3lUhBq5RN/lGQ7ITJN4E4KHqi2Y4Y/PDi8Cw+k
         LgZxelkzxGtwQ3vX7j+9nHKvicMlGxo30mEZa0NgFtklTEFp7ycmu3tXFkTJL9F5MtXF
         N4OgbjbtyXdHVpg10u1AizQXhjJ2v5nPnexpUXB5+iy2Rpy2sCCgV+MyGooJ3eBm9EhT
         oL61J8ZYqq2wlTsQlQfCe2FKPAjYplnoKjF2SrbVUrgsy3mgtjpmVVJKDUXXHqIERDQR
         LZUHmydAP5gskJZjZ1h+/m/940DfzWZ8IPiRW+BZa8iIdoeacgrO40FZ7vMRrGZneQe/
         kTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=15+pAbK3BFL8YJdD4x+WorUOU6nduiGry4z4wlzYpfU=;
        b=Yh2SbamCJH+mGrhqn9upucQspeQ2dFyUdHxh2mAzA3CP3ei4SJMvWupNslnnjsbwJT
         xauyu8NYzjcQp82eekKocBRwYdLgVfRTWbvlDxZCr/gakBmASPPKwZ/V7Z8gyXkbIQMs
         bOPopj1Rwa1518bwyrGN6bLnZAh3ji2/51sXWid8xoG3GYcYo9lUvvXv0sxmT328QR58
         PWXm3uLVW79uNr5d6T2zTiSu03+3TOjcpx90+ZeSs8bEaarJa03BG4mq0Usj1uR6HagI
         +6v9C8dCAoIMd4Ashlt9JyZTWeHUgZd+4bLsN4y/jLoN9gdqv8VSnbuOvxBFGJHrr631
         LQzw==
X-Gm-Message-State: AOAM533XpiebZqhf6sB53Q79XZqNmVTK4BLyjQ298Cij4dmfkWH8Jamj
        47dFgbM/pGNDpCyVttfwZ+5Ddw==
X-Google-Smtp-Source: ABdhPJwWpPahXyFixmehdaGRHPqE/aN5FF1yBNsVgYBBc9MRSRQaMhtfBDhaq4PsI/PssYJfE2RCwQ==
X-Received: by 2002:a17:902:bd02:b029:12b:1c90:eb65 with SMTP id p2-20020a170902bd02b029012b1c90eb65mr9012602pls.81.1626465723635;
        Fri, 16 Jul 2021 13:02:03 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id mu9sm11224943pjb.26.2021.07.16.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:02:03 -0700 (PDT)
Date:   Fri, 16 Jul 2021 20:01:59 +0000
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
Subject: Re: [PATCH Part2 RFC v4 24/40] KVM: SVM: Add
 KVM_SEV_SNP_LAUNCH_UPDATE command
Message-ID: <YPHlt4VCm6b2MZMs@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-25-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-25-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> +static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
> +{
> +	unsigned long npages, vaddr, vaddr_end, i, next_vaddr;
> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> +	struct sev_data_snp_launch_update data = {};
> +	struct kvm_sev_snp_launch_update params;
> +	int *error = &argp->error;
> +	struct kvm_vcpu *vcpu;
> +	struct page **inpages;
> +	struct rmpupdate e;
> +	int ret;
> +
> +	if (!sev_snp_guest(kvm))
> +		return -ENOTTY;
> +
> +	if (!sev->snp_context)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
> +		return -EFAULT;
> +
> +	data.gctx_paddr = __psp_pa(sev->snp_context);
> +
> +	/* Lock the user memory. */
> +	inpages = sev_pin_memory(kvm, params.uaddr, params.len, &npages, 1);

params.uaddr needs to be checked for validity, e.g. proper alignment.
sev_pin_memory() does some checks, but not all checks.

> +	if (!inpages)
> +		return -ENOMEM;
> +
> +	vcpu = kvm_get_vcpu(kvm, 0);
> +	vaddr = params.uaddr;
> +	vaddr_end = vaddr + params.len;
> +
> +	for (i = 0; vaddr < vaddr_end; vaddr = next_vaddr, i++) {
> +		unsigned long psize, pmask;
> +		int level = PG_LEVEL_4K;
> +		gpa_t gpa;
> +
> +		if (!hva_to_gpa(kvm, vaddr, &gpa)) {

I'm having a bit of deja vu...  This flow needs to hold kvm->srcu to do a memslot
lookup.

That said, IMO having KVM do the hva->gpa is not a great ABI.  The memslots are
completely arbitrary (from a certain point of view) and have no impact on the
validity of the memory pinning or PSP command.  E.g. a memslot update while this
code is in-flight would be all kinds of weird.

In other words, make userspace provide both the hva (because it's sadly needed
to pin memory) as well as the target gpa.  That prevents KVM from having to deal
with memslot lookups and also means that userspace can issue the command before
configuring the memslots (though I've no idea if that's actually feasible for
any userspace VMM).

> +			ret = -EINVAL;
> +			goto e_unpin;
> +		}
> +
> +		psize = page_level_size(level);
> +		pmask = page_level_mask(level);

Is there any hope of this path supporting 2mb/1gb pages in the not-too-distant
future?  If not, then I vote to do away with the indirection and just hardcode
4kg sizes in the flow.  I.e. if this works on 4kb chunks, make that obvious.

> +		gpa = gpa & pmask;
> +
> +		/* Transition the page state to pre-guest */
> +		memset(&e, 0, sizeof(e));
> +		e.assigned = 1;
> +		e.gpa = gpa;
> +		e.asid = sev_get_asid(kvm);
> +		e.immutable = true;
> +		e.pagesize = X86_TO_RMP_PG_LEVEL(level);
> +		ret = rmpupdate(inpages[i], &e);

What happens if userspace pulls a stupid and assigns the same page to multiple
SNP guests?  Does RMPUPDATE fail?  Can one RMPUPDATE overwrite another?

> +		if (ret) {
> +			ret = -EFAULT;
> +			goto e_unpin;
> +		}
> +
> +		data.address = __sme_page_pa(inpages[i]);
> +		data.page_size = e.pagesize;
> +		data.page_type = params.page_type;
> +		data.vmpl3_perms = params.vmpl3_perms;
> +		data.vmpl2_perms = params.vmpl2_perms;
> +		data.vmpl1_perms = params.vmpl1_perms;
> +		ret = __sev_issue_cmd(argp->sev_fd, SEV_CMD_SNP_LAUNCH_UPDATE, &data, error);
> +		if (ret) {
> +			snp_page_reclaim(inpages[i], e.pagesize);
> +			goto e_unpin;
> +		}
> +
> +		next_vaddr = (vaddr & pmask) + psize;
> +	}
> +
> +e_unpin:
> +	/* Content of memory is updated, mark pages dirty */
> +	memset(&e, 0, sizeof(e));
> +	for (i = 0; i < npages; i++) {
> +		set_page_dirty_lock(inpages[i]);
> +		mark_page_accessed(inpages[i]);
> +
> +		/*
> +		 * If its an error, then update RMP entry to change page ownership
> +		 * to the hypervisor.
> +		 */
> +		if (ret)
> +			rmpupdate(inpages[i], &e);

This feels wrong since it's purging _all_ RMP entries, not just those that were
successfully modified.  And maybe add a RMP "reset" helper, e.g. why is zeroing
the RMP entry the correct behavior?

> +	}
> +
> +	/* Unlock the user pages */
> +	sev_unpin_memory(kvm, inpages, npages);
> +
> +	return ret;
> +}
> +

