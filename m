Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C873A3CAECC
	for <lists+linux-efi@lfdr.de>; Thu, 15 Jul 2021 23:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhGOV4T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 17:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhGOV4S (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Jul 2021 17:56:18 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF26C061765
        for <linux-efi@vger.kernel.org>; Thu, 15 Jul 2021 14:53:23 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o8so4155184plg.11
        for <linux-efi@vger.kernel.org>; Thu, 15 Jul 2021 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fT5PdprpzzVdpuGRQjB10wOKBXaawvXKa53cRx1HK6I=;
        b=svmrN+O4TI98vQfj9n2X/vE50XmQmqn1PaXKCP4Nr/CQyCC4gpvE/2A44G7O3EEASy
         /EfSX6dHh4q+I/a6RzTa5Z+Q8thrryvjaD57bsWLXbdH95pEPz+xykR9xEgUdH4Bv4Z3
         ZoAGTa8Dt+Ijjc+XetNUvdXC7ojCQeJcD0LZiPZWKk/RdXBOQA7PxVYGDtHqNFQ/g3+1
         ouQ3Nz6ZGFswmzMs7fe8Jr1UislrbNvLnmgdVpL88bQPCqp5nJlc9aQYclxLYlImlTzk
         iqbO3a14CqCw0bGU2cATmeN0NT1CTHGMNXISk50SAZ9lM50oC08Hg9k5l20FPm3XWnsR
         s63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fT5PdprpzzVdpuGRQjB10wOKBXaawvXKa53cRx1HK6I=;
        b=DxBGmOrfTi5UMe3+otX5VXfUbBaAwJULwu/dSUBPgFe6tsDeThPS3L5hNe7RzQH+J8
         Feh50VEe17zUdxqbvwI7LycAGrFP0wlln0F1w99AzPzJaPiHgk0EeOEQzlDCRAMejGx2
         dHovmD0QsExVjnNF+gg2XMgsE50afCy/iV0WB1hxaM0jxnjNE4YkvHK+mFZZMf30c1Je
         Wx0IsNvX1MRTWs/Hm2uTK3OsT6tqIw643l4l9Qftl6k6mNTDgjAXOn3Md1ae/fOz98H/
         AKAQUipBjyrwx3X6wJWcwIS1Yojvzpnq0+1CrmPgyI9wUoS0/cDJNQ4lgMRVQHtpPJQR
         SefA==
X-Gm-Message-State: AOAM533NuGVaRJlE+LAeY0atYI41YylR8WdjgCs0GsnGSjVInkTa/FkX
        nOtplsOiyvnp9IoNg24Ki+GZrQ==
X-Google-Smtp-Source: ABdhPJwIwDUr/HSzt1W7U3WJexPF19d/NdRvrPK8Jq2C1qfjx7umE1NH31E27//HtmrPWVEOD8ZZLw==
X-Received: by 2002:a17:90a:9b89:: with SMTP id g9mr12007893pjp.200.1626386003022;
        Thu, 15 Jul 2021 14:53:23 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m21sm7561729pfo.159.2021.07.15.14.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 14:53:22 -0700 (PDT)
Date:   Thu, 15 Jul 2021 21:53:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
Subject: Re: [PATCH Part2 RFC v4 10/40] x86/fault: Add support to handle the
 RMP fault for user address
Message-ID: <YPCuTiNET/hJHqOY@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-11-brijesh.singh@amd.com>
 <3c6b6fc4-05b2-8d18-2eb8-1bd1a965c632@intel.com>
 <2b4accb6-b68e-02d3-6fed-975f90558099@amd.com>
 <a249b101-87d1-2e66-d7d6-af737c045cc3@intel.com>
 <5592d8ff-e2c3-6474-4a10-96abe1962d6f@amd.com>
 <bfb857d2-8e3c-4a3b-c64e-96a16c0c6d49@intel.com>
 <aef6be8a-c93a-1aaa-57fe-116e70483542@amd.com>
 <c3c71a5b-8100-63f2-1792-d7b53731147c@intel.com>
 <298d2e19-566d-2e58-b639-724c10885646@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <298d2e19-566d-2e58-b639-724c10885646@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jul 12, 2021, Brijesh Singh wrote:
> 
> 
> On 7/12/21 11:29 AM, Dave Hansen wrote:
> > On 7/12/21 9:24 AM, Brijesh Singh wrote:
> > > Apologies if I was not clear in the messaging, that's exactly what I
> > > mean that we don't feed RMP entries during the page state change.
> > > 
> > > The sequence of the operation is:
> > > 
> > > 1. Guest issues a VMGEXIT (page state change) to add a page in the RMP
> > > 2. Hyperivosr adds the page in the RMP table.
> > > 
> > > The check will be inside the hypervisor (#2), to query the backing page
> > > type, if the backing page is from the hugetlbfs, then don't add the page
> > > in the RMP, and fail the page state change VMGEXIT.
> > 
> > Right, but *LOOOOOONG* before that, something walked the page tables and
> > stuffed the PFN into the NPT (that's the AMD equivalent of EPT, right?).
> >   You could also avoid this whole mess by refusing to allow hugetblfs to
> > be mapped into the guest in the first place.
> > 
> 
> Ah, that should be doable. For SEV stuff, we require the VMM to register the
> memory region to the hypervisor during the VM creation time. I can check the
> hugetlbfs while registering the memory region and fail much earlier.

That's technically unnecessary, because this patch is working on the wrong set of
page tables when handling faults from KVM.

The host page tables constrain KVM's NPT, but the two are not mirrors of each
other.  Specifically, KVM cannot exceed the size of the host page tables because
that would give the guest access to memory it does not own, but KVM isn't required
to use the same size as the host.  E.g. a 1gb page in the host can be 1gb, 2mb, or
4kb in the NPT.

The code "works" because the size contraints mean it can't get false negatives,
only false positives, false positives will never be fatal, e.g. the fault handler
may unnecessarily demote a 1gb, and demoting a host page will further constrain
KVM's NPT.

The distinction matters because it changes our options.  For RMP violations on
NPT due to page size mismatches, KVM can and should handle the fault without
consulting the primary MMU, i.e. by demoting the NPT entry.  That means KVM does
not need to care about hugetlbfs or any other backing type that cannot be split
since KVM will never initiate a host page split in response to a #NPT RMP violation.

That doesn't mean that hugetlbfs will magically work since e.g. get/put_user()
will fault and fail, but that's a generic non-KVM problem since nothing prevents
remapping and/or accessing the page(s) outside of KVM context.

The other reason to not disallow hugetlbfs and co. is that a guest that's
enlightened to operate at 2mb granularity, e.g. always do page state changes on
2mb chunks, can play nice with hugetlbfs without ever hitting an RMP violation.

Last thought, have we taken care in the guest side of things to work at 2mb
granularity when possible?  AFAICT, PSMASH is effectively a one-way street since
RMPUPDATE to restore a 2mb RMP is destructive, i.e. requires PVALIDATE on the
entire 2mb chunk, and the guest can't safely do that without reinitializing the
whole page, e.g. would either lose data or have to save/init/restore.
