Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F41E3CA4C1
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 19:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhGORy0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 13:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhGORyZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Jul 2021 13:54:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EA4C061762
        for <linux-efi@vger.kernel.org>; Thu, 15 Jul 2021 10:51:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id a14so3804256pls.4
        for <linux-efi@vger.kernel.org>; Thu, 15 Jul 2021 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SPUir8j18PLybVHK4M3a0vCQIxEbnuUyBjChvlSKLmw=;
        b=O6AX+9hzZex3eU5uvfUHqD2gB8kkBZk+ho0pFS2dUIJw1QUWPEIQ3cGrzjEgmQ5EGx
         gYai+UQVtsPWNE6v8zHWdWbJJXlcF02q/r7/sQz/nFxk1BSaW85VYOSPU3ABhgUDkUur
         5N6ceKHGHDX7KUttzFzG/IKO2ub60a5iylSdkeqcMkchE0JkEuAicdvSqID+aIUDAu1A
         Az9u0TdsmnrXPgK4u5zDJWgJfYtd4H1fQ8U39B5RZq1fYuA2RNah69hBucHHAQrhcpK6
         H7NekraqO2ltqIVdk8+zE5/NUcItPe6ci/slDsqdql74v6bwnu6pit9OxnS4H2jQscpC
         Dt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SPUir8j18PLybVHK4M3a0vCQIxEbnuUyBjChvlSKLmw=;
        b=O1AKbquGfiz8HNSxcs0v2/1KR329ekPvYMlib+k3Yvb+0R4Du1grKFMa+GJhuSYB/R
         /q7r53jVNoPuvYqSOB2fqmUQCOdSRNmA2RT38uidcJYqM6Wac3mbqfHSe68GtJvQ1BUz
         hTH5QklzCckm5eV2AE/80uox22XdDm+4qE3yV9+UYYuu5KyyfseT8Mof6dyawKCOMeD4
         iftbAH80RjStUsdNIId6ZBCBLJx7Y4CX5uB7zbMmPNEmiUi+QpvQWR2hT9PQpFpCr97G
         ZkudzNYb/ztutMVQy0+xh9scRwMec8z3ybof2yKiKrSJFfRqs1l76u9nF+D5o/MvwzMG
         c5Sw==
X-Gm-Message-State: AOAM531h7tGB7TjbFDzz1RWritgnGWwHbl2idVbM8Y1MJDu8LqNR9MCk
        oY+O6pXfn19fhPvk9l5eMgXdaw==
X-Google-Smtp-Source: ABdhPJwBoOpS4t+WKHVcsb/gcZglXaCGGZ+MYH+86n+Y3LrgK7OgBFTpOpP7AW5uPh8vDSMESTclww==
X-Received: by 2002:a17:90a:9f06:: with SMTP id n6mr5466944pjp.92.1626371491663;
        Thu, 15 Jul 2021 10:51:31 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j19sm8009841pgm.44.2021.07.15.10.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 10:51:31 -0700 (PDT)
Date:   Thu, 15 Jul 2021 17:51:27 +0000
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
Subject: Re: [PATCH Part2 RFC v4 07/40] x86/sev: Split the physmap when
 adding the page in RMP table
Message-ID: <YPB1n0+G+0EoyEvE@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-8-brijesh.singh@amd.com>
 <YO9kP1v0TAFXISHD@google.com>
 <d486a008-8340-66b0-9667-11c8a50974e4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d486a008-8340-66b0-9667-11c8a50974e4@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 15, 2021, Brijesh Singh wrote:
> 
> On 7/14/21 5:25 PM, Sean Christopherson wrote:
> > > @@ -2375,6 +2375,12 @@ int rmpupdate(struct page *page, struct rmpupdate *val)
> > >   	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
> > >   		return -ENXIO;
> > > +	ret = set_memory_4k((unsigned long)page_to_virt(page), 1);
> > 
> > IIUC, this shatters the direct map for page that's assigned to an SNP guest, and
> > the large pages are never recovered?
> > 
> > I believe a better approach would be to do something similar to memfd_secret[*],
> > which encountered a similar problem with the direct map.  Instead of forcing the
> > direct map to be forever 4k, unmap the direct map when making a page guest private,
> > and restore the direct map when it's made shared (or freed).
> > 
> > I thought memfd_secret had also solved the problem of restoring large pages in
> > the direct map, but at a glance I can't tell if that's actually implemented
> > anywhere.  But, even if it's not currently implemented, I think it makes sense
> > to mimic the memfd_secret approach so that both features can benefit if large
> > page preservation/restoration is ever added.
> > 
> 
> thanks for the memfd_secrets pointer. At the lowest level it shares the
> same logic to split the physmap. We both end up calling to
> change_page_attrs_set_clr() which split the page and updates the page
> table attributes.
> 
> Given this, I believe in future if the change_page_attrs_set_clr() is
> enhanced to track the splitting of the pages and restore it later then it
> should work transparently.

But something actually needs to initiate the restore.  If the RMPUDATE path just
force 4k pages then there will never be a restore.  And zapping the direct map
for private pages is a good thing, e.g. prevents the kernel from reading garbage,
which IIUC isn't enforced by the RMP?
