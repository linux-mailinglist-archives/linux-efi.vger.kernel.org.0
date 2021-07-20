Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54F23D0233
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 21:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhGTS5q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 14:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhGTS5n (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Jul 2021 14:57:43 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA582C0613DB
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 12:38:19 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id y4so23465391pgl.10
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=opGYJ8ATKeLRJGjAJK6R9tbhbI7CJxP6XB4aUSj1rRc=;
        b=U3suekfYP80TfhnSWCdW0AeB5YxRYqo2o3/gq9NjySLOotsA/QHsKv4nrfgs9Q6OW4
         KjSFSlK0XO5pyVT8FlownP4GS3PcIrtF/1itOWU4Pga+6PwG15GCcUmAHgnsNMPMi4LX
         DxT0uRyt0039tsJZa4N+W8sH3nZ3ORXDV7KdShXCKvh6oAxgtZUERz3/kYRLyJ5E2nWy
         NESQv+xyyGvE5IhgT/cYsM8bQaF8F8f+olP6Pv+1dQQcP53pETJLgqGRDE75b9vRhf5t
         erL1h5JQ4WgB3pRfhQQaD4CT4UWWh7xaKg8C46eFTZOacYR8kBVBLxEUzPFoFCtyV1A7
         oJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=opGYJ8ATKeLRJGjAJK6R9tbhbI7CJxP6XB4aUSj1rRc=;
        b=MhbB3FR2F6BST79yXGA+RFlATBs9Yp6lupuoqTMHqKrkMBcUGIKqkcscj0bPilBZv4
         OeCcJyggmNWR3jiDyxSboKRTvchFGqtAlBD5B0Kl8hIQh2dLy+4A5tYZapFPzL4WYq9j
         QZm7SRJTipBCTITujLQHMJ+SBXnDPQp420huRKwPb3/Wl+AlA9xMPFp2BHFQNQpMNH08
         ZfIZf6A/AuL66bVW83+28qJxbdVKop7FAVensToEFm7vpjOoN54uKQ2TAZRGcrK7ZDJ/
         L6YQMalj58HZINal7l9tljX+QDc5iuZEnffJkkzdpfiq6mEyoRtkMGDykd+DZDvaajFs
         p9pg==
X-Gm-Message-State: AOAM530p09E2Pmn+RPeiTKp8MqUz6tV0kmcxSen2khyX/y/0KBHSvsEn
        K43oUzUnNZgo1SZuIDUYXtn63Q==
X-Google-Smtp-Source: ABdhPJxaIdbx05Hn/m0/ilrMVvfZTLe2YGc+vQnLw4+1SqOXt5bk80Vq8MgVTJaPuxiVmjKAyXSIhA==
X-Received: by 2002:a63:5620:: with SMTP id k32mr6362897pgb.32.1626809898963;
        Tue, 20 Jul 2021 12:38:18 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a20sm23827514pfv.101.2021.07.20.12.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 12:38:18 -0700 (PDT)
Date:   Tue, 20 Jul 2021 19:38:14 +0000
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
Subject: Re: [PATCH Part2 RFC v4 27/40] KVM: X86: Add kvm_x86_ops to get the
 max page level for the TDP
Message-ID: <YPcmJuKHFYjCgpqd@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-28-brijesh.singh@amd.com>
 <YPHbxAVbuFk6Xtkj@google.com>
 <1ed3c439-a02c-7182-b140-32cddd5e4f34@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ed3c439-a02c-7182-b140-32cddd5e4f34@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 16, 2021, Brijesh Singh wrote:
> On 7/16/21 2:19 PM, Sean Christopherson wrote:
> > On Wed, Jul 07, 2021, Brijesh Singh wrote:
> > Another option would be to drop the kvm_x86_ops hooks entirely and call
> > snp_lookup_page_in_rmptable() directly from MMU code.  That would require tracking
> > that a VM is SNP-enabled in arch code, but I'm pretty sure info has already bled
> > into common KVM in one form or another.
> 
> I would prefer this as it eliminates some of the other unnecessary call
> sites. Unfortunately, currently there is no generic way to know if its
> an SEV guest (outside the svm/*).  So far there was no need as such but
> with SNP having such information would help. Should we extend the
> 'struct kvm' to include a new field that can be used to determine the
> guest type. Something like
> 
> enum {
> 
>    GUEST_TYPE_SEV,
> 
>    GUEST_TYPE_SEV_ES,
> 
>    GUEST_TYPE_SEV_SNP,
> 
> };
> 
> struct kvm {
> 
>    ...
> 
>   u64 enc_type;
> 
> };
> 
> bool kvm_guest_enc_type(struct kvm *kvm, enum type); {
> 
>     return !!kvm->enc_type & type;
> 
> }
> 
> The mmu.c can then call kvm_guest_enc_type() to check if its SNP guest
> and use the SNP lookup directly to determine the pagesize.

The other option is to use vm_type, which TDX is already planning on leveraging.
Paolo raised the question of whether or not the TDX type could be reused for SNP.
We should definitely sort that out before merging either series.  I'm personally
in favor of separating TDX and SNP, it seems inevitable that common code will
want to differentiate between the two.

https://lkml.kernel.org/r/8eb87cd52a89d957af03f93a9ece5634426a7757.1625186503.git.isaku.yamahata@intel.com

> > As the APM is currently worded, this is wrong, and the whole "tdp_max_page_level"
> > name is wrong.  As noted above, the Page-Size bullet points states that 2mb/1gb
> > pages in the NPT _must_ have RMP.page_size=1, and 4kb pages in the NPT _must_
> > have RMP.page_size=0.  That means that the RMP adjustment is not a constraint,
> > it's an exact requirement.  Specifically, if the RMP is a 2mb page then KVM must
> > install a 2mb (or 1gb) page.  Maybe it works because KVM will PSMASH the RMP
> > after installing a bogus 4kb NPT and taking an RMP violation, but that's a very
> > convoluted and sub-optimal solution.
> 
> This is why I was passing the preferred max_level in the pre-fault
> handle then later query the npt level; use the npt level in the RMP to
> make sure they are in sync.
> 
> There is yet another reason why we can't avoid the PSMASH after doing
> everything to ensure that NPT and RMP are in sync. e.g if NPT and RMP
> are programmed with 2mb size but the guest tries to PVALIDATE the page
> as a 4k. In that case, we will see #NPF with page size mismatch and have
> to perform psmash.

Boo, there's no way to communicate to the guest that it's doing PVALIDATE wrong
is there?
