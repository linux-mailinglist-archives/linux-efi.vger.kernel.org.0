Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568DC3D0438
	for <lists+linux-efi@lfdr.de>; Wed, 21 Jul 2021 00:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhGTVZx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhGTVZx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Jul 2021 17:25:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C0CC061768
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 15:06:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p17so12102162plf.12
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 15:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BB0NGsGv3epWhxiQYCc03cLFHcDOFlK36/5xOhr9iGo=;
        b=G60QHWuyRH6eWtLou5HaWRxEN7Yq6nKV9T1iAIqyAq6fVrq1WWQgHIEV53g1ohgNc9
         EQohQSGMoRnwcSERx2WtsFUY2oBHP2L7o6RLWdjM/8DnxS/jS2gR62e2ZdzQzsD/Cfqi
         t26NKDlXSIHcL8jfXQ4F7qrg5pPOvQuoI2mBqA5sqIxf4jaH3gQ080WBkK8r5zzKZj6Q
         G/9z8dSeMgvga8DzcwvEltKCTyVWefclmiDtlzTovNTWLqmL4Y7wltkF8n7JL2lbJV27
         Rqq2Y/zqOcIZ3UnQEC1ynwVVGlNk1MtMr3wIXyYacV1olaGdhCMiOjk/TQIOvra62SgO
         XgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BB0NGsGv3epWhxiQYCc03cLFHcDOFlK36/5xOhr9iGo=;
        b=IfR5MspTqOsSzqes140veD4rdoFjuPpImhy/c0Oqp6N19kqtJISQX20N+7LHsMcBpM
         nZzwyO6ZORiHl7LaaC+fS39raA0+GAEp2uObWRGMj0VVaUh7s796i3kt/a5slIfjoFMx
         w+xYb2GSDfqb85VnIbrduXaPRsaWIyAv3iPZxoV01cYpqi4pCa15ISVv93VK2OI2UvOD
         Zy9fNRd9gVnmZhkib+wV+pq4eMuZDrNXxAn9jDd+urkHGlej+IDKR54pT/gcxE3bknEV
         RODjOZTn/6PupoN8y3Xj41twUiXaa8ZuvVj7O1TlaVDeiy8LJug6zVRw5OXNnqR8ZUS8
         BnVw==
X-Gm-Message-State: AOAM533Ym/X9pQwsD8ikl+0iLkyW+tYq9zXep7hgBtxrSWsV6UvVdrOe
        wW4VRHYlLys3dgp/MDRe1VZvUQ==
X-Google-Smtp-Source: ABdhPJwDD9+zuJ6DYICNGOinctEj1Edxq+hD2yj+AdZXjLWVr+ao/12i42Q3S8W5xw+1pKf5QwmK4Q==
X-Received: by 2002:a17:90a:4295:: with SMTP id p21mr30863822pjg.149.1626818788641;
        Tue, 20 Jul 2021 15:06:28 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w184sm419793pfw.85.2021.07.20.15.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 15:06:27 -0700 (PDT)
Date:   Tue, 20 Jul 2021 22:06:24 +0000
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
Subject: Re: [PATCH Part2 RFC v4 05/40] x86/sev: Add RMP entry lookup helpers
Message-ID: <YPdI4JLrJJdPxy7e@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-6-brijesh.singh@amd.com>
 <YPCAZaROOHNskGlO@google.com>
 <437a5230-64fc-64ab-9378-612c34e1b641@amd.com>
 <39be0f79-e8e4-fd4a-5c4a-47731c61740d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39be0f79-e8e4-fd4a-5c4a-47731c61740d@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 16, 2021, Brijesh Singh wrote:
> 
> On 7/15/21 2:28 PM, Brijesh Singh wrote:
> >> Looking at the future patches, dump_rmpentry() is the only power user,
> >> e.g.  everything else mostly looks at "assigned" and "level" (and one
> >> ratelimited warn on "validated" in snp_make_page_shared(), but I suspect
> >> that particular check can and should be dropped).
> >
> > Yes, we need "assigned" and "level" and other entries are mainly for
> > the debug purposes.
> >
> For the debug purposes, we would like to dump additional RMP entries. If
> we go with your proposed function then how do we get those information
> in the dump_rmpentry()?

As suggested below, move dump_rmpentry() into sev.c so that it can use the
microarchitectural version.  For debug, I'm pretty that's what we'll want anyways,
e.g. dump the raw value along with the meaning of various bits.

> How about if we provide two functions; the first
> function provides architectural format and second provides the raw
> values which can be used by the dump_rmpentry() helper.
> 
> struct rmpentry *snp_lookup_rmpentry(unsigned long paddr, int *level);
> 
> The 'struct rmpentry' uses the format defined in APM Table 15-36.
> 
> struct _rmpentry *_snp_lookup_rmpentry(unsigned long paddr, int *level);
> 
> The 'struct _rmpentry' will use include the PPR definition (basically
> what we have today in this patch).
> 
> Thoughts ?

Why define an architectural "struct rmpentry"?  IIUC, there isn't a true
architectural RMP entry; the APM defines architectural fields but doesn't define
a layout.  Functionally, making up our own struct isn't a problem, I just don't
see the point since all use cases only care about Assigned and Page-Size, and
we can do them a favor by translating Page-Size to X86_PG_LEVEL.

> >> /*
> >>   * Returns 1 if the RMP entry is assigned, 0 if it exists but is not
> >>   * assigned, and -errno if there is no corresponding RMP entry.
> >>   */
> >> int snp_lookup_rmpentry(struct page *page, int *level)
> >> {
> >>     unsigned long phys = page_to_pfn(page) << PAGE_SHIFT;
> >>     struct rmpentry *entry, *large_entry;
> >>     unsigned long vaddr;
> >>
> >>     if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
> >>         return -ENXIO;
> >>
> >>     vaddr = rmptable_start + rmptable_page_offset(phys);
> >>     if (unlikely(vaddr > rmptable_end))
> >>         return -EXNIO;
> >>
> >>     entry = (struct rmpentry *)vaddr;
> >>
> >>     /* Read a large RMP entry to get the correct page level used in
> >> RMP entry. */
> >>     vaddr = rmptable_start + rmptable_page_offset(phys & PMD_MASK);
> >>     large_entry = (struct rmpentry *)vaddr;
> >>     *level = RMP_TO_X86_PG_LEVEL(rmpentry_pagesize(large_entry));
> >>
> >>     return !!entry->assigned;
> >> }
> >>
> >>
> >> And then move dump_rmpentry() (or add a helper) in sev.c so that "struct
> >> rmpentry" can be declared in sev.c.
