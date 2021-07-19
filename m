Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044943CEE73
	for <lists+linux-efi@lfdr.de>; Mon, 19 Jul 2021 23:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345628AbhGSU5c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Jul 2021 16:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383892AbhGSSPV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Jul 2021 14:15:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A4DC061762
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 11:44:35 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j199so17269756pfd.7
        for <linux-efi@vger.kernel.org>; Mon, 19 Jul 2021 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lOc5+rloDVdT/oQx00DjmvvmSON6OrGGoIPjsiSNP8Y=;
        b=g4AlSOFhPm6hVf/7SR105tRah3Aea3+9KqN56Ke/OvVzbLLxQa+2FEdnRI5yCBDV+U
         4E04weFnBKUQ3efnvzdPhRQY+2+Od5nqIyCKNKgiFX0wtkQXrweRsh5bUaswhmgDdflh
         twIaMTzdSaq840Cc7sDRoqigwkJn4mAzbH3OXS7gdeaYNQPustFoljMzhp71Jz/EDIPl
         iQ0u6pB02qRWEy9NOKHisJRFVf53eOgb0bPRjLegKpAPXdgUt4CSFJjUZQnOg29L//qi
         bWnnKN93uYWfM5tgm7e4zrwTJ+oo8OaLK8lCgwcR4sL6wlqDO3MXhRGr9K/4lw9CfxuI
         K3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lOc5+rloDVdT/oQx00DjmvvmSON6OrGGoIPjsiSNP8Y=;
        b=V9I9NTN1Ket8ClkIuQItunypBTXT5opPtvzmDI52SM65LdT3uoztb50yyOD/rKC1Pu
         lraOTFmiG10XWVbiFqq6nkynY8tmpyRfkqyzFWPitenfortYIyQGQ4tE2paZQ/X340aw
         f6gp4ktBw1D/QTRamYDu8XqtWPhBT9AYvGcOootNTWIowiSnhithGOr3+Krs7Xvq8wsa
         Oso8lNVChumBgNhQ+sXKu87aeCmB19cyc/f3N5LQC/Xy8QEzCMzjeZHYEMgkKDKy957F
         GGnilBPGmOhjfXjc5p5EooHfVZmOKJrzclsaUJm4y0jKy4bVemw2cFBv0VthXG89O/Nf
         Yq0g==
X-Gm-Message-State: AOAM5322taAnqNvHFqNqeeKQRxhnKVPnKl1jQNFtlg4IfcE7uAkLoTzK
        XgzOJSvkDkdcoB+1za5dNIsiGw==
X-Google-Smtp-Source: ABdhPJxmSOu7+O2DfzTj7tTZcm5PtaeD09Hlmp3Y4R1m0EFLmxzdwqmHKXKDHGBPl5X7i0P9uc4f5A==
X-Received: by 2002:a05:6a00:1951:b029:333:64d3:e1f1 with SMTP id s17-20020a056a001951b029033364d3e1f1mr24076104pfk.43.1626720959003;
        Mon, 19 Jul 2021 11:55:59 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q17sm24643642pgd.39.2021.07.19.11.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 11:55:58 -0700 (PDT)
Date:   Mon, 19 Jul 2021 18:55:54 +0000
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
Subject: Re: [PATCH Part2 RFC v4 33/40] KVM: SVM: Add support to handle MSR
 based Page State Change VMGEXIT
Message-ID: <YPXKuiRCjod8Wn2n@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-34-brijesh.singh@amd.com>
 <YPHzcstus9mS8hOm@google.com>
 <b9527f12-f3ad-c6b9-2967-5d708d69d937@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9527f12-f3ad-c6b9-2967-5d708d69d937@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 19, 2021, Brijesh Singh wrote:
> 
> On 7/16/21 4:00 PM, Sean Christopherson wrote:
> > On Wed, Jul 07, 2021, Brijesh Singh wrote:
> > > +static int __snp_handle_psc(struct kvm_vcpu *vcpu, int op, gpa_t gpa, int level)
> > 
> > I can live with e.g. GHCB_MSR_PSC_REQ, but I'd strongly prefer to spell this out,
> > e.g. __snp_handle_page_state_change() or whatever.  I had a hell of a time figuring
> > out what PSC was the first time I saw it in some random context.
> 
> Based on the previous review feedback I renamed from
> __snp_handle_page_state_change to __snp_handle_psc(). I will see what others
> say and based on that will rename accordingly.

I've no objection to using PSC for enums and whatnot, and I'll happily defer to
Boris for functions in the core kernel and guest, but for KVM I'd really like to
spell out the name for the two or so main handler functions.

> > > +	while (gpa < gpa_end) {
> > > +		/*
> > > +		 * Get the pfn and level for the gpa from the nested page table.
> > > +		 *
> > > +		 * If the TDP walk failed, then its safe to say that we don't have a valid
> > > +		 * mapping for the gpa in the nested page table. Create a fault to map the
> > > +		 * page is nested page table.
> > > +		 */
> > > +		if (!kvm_mmu_get_tdp_walk(vcpu, gpa, &pfn, &tdp_level)) {
> > > +			pfn = kvm_mmu_map_tdp_page(vcpu, gpa, PFERR_USER_MASK, level);
> > > +			if (is_error_noslot_pfn(pfn))
> > > +				goto out;
> > > +
> > > +			if (!kvm_mmu_get_tdp_walk(vcpu, gpa, &pfn, &tdp_level))
> > > +				goto out;
> > > +		}
> > > +
> > > +		/* Adjust the level so that we don't go higher than the backing page level */
> > > +		level = min_t(size_t, level, tdp_level);
> > > +
> > > +		write_lock(&kvm->mmu_lock);
> > 
> > Retrieving the PFN and level outside of mmu_lock is not correct.  Because the
> > pages are pinned and the VMM is not malicious, it will function as intended, but
> > it is far from correct.
> 
> Good point, I should have retrieved the pfn and level inside the lock.
> 
> > The overall approach also feels wrong, e.g. a guest won't be able to convert a
> > 2mb chunk back to a 2mb large page if KVM mapped the GPA as a 4kb page in the
> > past (from a different conversion).
> > 
> 
> Maybe I am missing something, I am not able to follow 'guest won't be able
> to convert a 2mb chunk back to a 2mb large page'. The page-size used inside
> the guest have to relationship with the RMP/NPT page-size. e.g, a guest can
> validate the page range as a 4k and still map the page range as a 2mb or 1gb
> in its pagetable.

The proposed code walks KVM's TDP and adjusts the RMP level to be the min of the
guest+host levels.  Once KVM has installed a 4kb TDP SPTE, that walk will find
the 4kb TDP SPTE and thus operate on the RMP at a 4kb granularity.  To allow full
restoration of 2mb PTE+SPTE+RMP, KVM needs to zap the 4kb SPTE(s) at some point
to allow rebuilding a 2mb SPTE.
