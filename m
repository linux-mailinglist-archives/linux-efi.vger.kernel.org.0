Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8333DBCBD
	for <lists+linux-efi@lfdr.de>; Fri, 30 Jul 2021 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhG3QAW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Jul 2021 12:00:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35436 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhG3QAV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Jul 2021 12:00:21 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4368C22428;
        Fri, 30 Jul 2021 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627660815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kw6stp8k72daDKN6GtjAkWV2DdxxOIrOovtdOiv+Lbo=;
        b=VWJLSUNx/UXqcLjpye1h9LwuHPVOsgkM7hkJQ8ymPmqpgoEeIKlw+m0VGitoXHpsIrIbbZ
        bUZLrnYuwlKrcsDcZ+nhoBTkUCfS5FepMiIkmw2GCMfaQkDhntNXYp8dkb+1SdLgjnqXfi
        Dus9D5j3zqWexTfrbcdpU+pK15yvxH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627660815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kw6stp8k72daDKN6GtjAkWV2DdxxOIrOovtdOiv+Lbo=;
        b=5ZGpDrmFl/crYJnLVvuY6F74NkKit4pZoyVsypvoNjwAIHc+o4K5kJd0pkfMDOSYtIZDTq
        +zu4zbkiiVKEFIDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CF57D134B1;
        Fri, 30 Jul 2021 16:00:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id vSnqMQ4iBGG1EgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 30 Jul 2021 16:00:14 +0000
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
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
        Michael Roth <michael.roth@amd.com>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-11-brijesh.singh@amd.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH Part2 RFC v4 10/40] x86/fault: Add support to handle the
 RMP fault for user address
Message-ID: <95a27dfd-bb41-cf32-acd3-f6fdf3780d15@suse.cz>
Date:   Fri, 30 Jul 2021 18:00:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210707183616.5620-11-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/7/21 8:35 PM, Brijesh Singh wrote:
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4407,6 +4407,15 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  	return 0;
>  }
>  
> +static int handle_split_page_fault(struct vm_fault *vmf)
> +{
> +	if (!IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
> +		return VM_FAULT_SIGBUS;
> +
> +	__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
> +	return 0;
> +}
> +

I think back in v1 Dave asked if khugepaged will just coalesce this back, and it
wasn't ever answered AFAICS.

I've checked the code and I think the answer is: no. Khugepaged isn't designed
to coalesce a pte-mapped hugepage back to pmd in place. And the usual way (copy
to a new huge page) I think will not succeed because IIRC the page is also
FOLL_PIN pinned and  khugepaged_scan_pmd() will see the elevated refcounts via
is_refcount_suitable() and give up.

So the lack of coalescing (in case the sub-page leading to split becomes guest
private again later) is somewhat suboptimal, but not critical.
