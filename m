Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED941520772
	for <lists+linux-efi@lfdr.de>; Tue, 10 May 2022 00:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiEIWVz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 May 2022 18:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiEIWVy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 May 2022 18:21:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3537A26BC9A;
        Mon,  9 May 2022 15:17:59 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44E961EC0505;
        Tue, 10 May 2022 00:17:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652134673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2k2dEWW2F1hrc51g6pFhQEncF54Nbue4YVbgz5LkyTE=;
        b=lV/tv/BBA10J6KuReciOQ9eOK4caCe95n4wYgIVJjxAnm/MvUQV1MMl/fvLSanKq3O8I+h
        /WI2c8ufp0ts8T7FBmUQza5KOUUZx8AwJj4xvAqNH45y8lo3IFnbxg40+yVgxqBY0F2wls
        fezDy9Tqdv9Nm71Pao3DSOnHh2SHL4Q=
Date:   Tue, 10 May 2022 00:17:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        "H. Peter Anvin" <hpa@zytor.com>, daniel.gutson@eclypsium.com,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, X86 ML <x86@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v8 0/8] x86: Show in sysfs if a memory node is able to do
 encryption
Message-ID: <YnmTFB1iXy7Qo403@zn.tnic>
References: <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com>
 <YnUYLDjIThbIz/Uf@zn.tnic>
 <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com>
 <CAPcyv4i73m6iPPfJE9CBdxf-OWGXahvGqvh6G-pqVO=3LB6ktQ@mail.gmail.com>
 <47140A56-D3F8-4292-B355-5F92E3BA9F67@alien8.de>
 <6abea873-52a2-f506-b21b-4b567bee1874@intel.com>
 <FDABC5C8-B80A-4977-9F97-5A8FC47F69D6@alien8.de>
 <4bc56567-e2ce-40ec-19ab-349c8de8d969@intel.com>
 <CE52D65A-C9F4-408D-B18A-72D87495A433@alien8.de>
 <ec93952f-d09a-2dda-bfa9-5d667a257fdc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec93952f-d09a-2dda-bfa9-5d667a257fdc@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 09, 2022 at 11:47:43AM -0700, Dave Hansen wrote:
> ... adding some KVM/TDX folks

+ AMD SEV folks as they're going to probably need something like that
too.

> On 5/6/22 12:02, Boris Petkov wrote:
> >> This node attribute punts the problem back out to userspace.  It
> >> gives userspace the ability to steer allocations to compatible NUMA
> >> nodes.  If something goes wrong, they can use other NUMA ABIs to
> >> inspect the situation, like /proc/$pid/numa_maps.
> > That's all fine and dandy but I still don't see the *actual*,
> > real-life use case of why something would request memory of
> > particular encryption capabilities. Don't get me wrong  - I'm not
> > saying there are not such use cases - I'm saying we should go all the
> > way and fully define properly  *why* we're doing this whole hoopla.
> 
> Let's say TDX is running on a system with mixed encryption
> capabilities*.  Some NUMA nodes support TDX and some don't.  If that
> happens, your guest RAM can come from anywhere.  When the host kernel
> calls into the TDX module to add pages to the guest (via
> TDH.MEM.PAGE.ADD) it might get an error back from the TDX module.  At
> that point, the host kernel is stuck.  It's got a partially created
> guest and no recourse to fix the error.

Thanks for that detailed use case, btw!

> This new ABI provides a way to avoid that situation in the first place.
>  Userspace can look at sysfs to figure out which NUMA nodes support
> "encryption" (aka. TDX) and can use the existing NUMA policy ABI to
> avoid TDH.MEM.PAGE.ADD failures.
> 
> So, here's the question for the TDX folks: are these mixed-capability
> systems a problem for you?  Does this ABI help you fix the problem?

What I'm not really sure too is, is per-node granularity ok? I guess it
is but let me ask it anyway...

> Will your userspace (qemu and friends) actually use consume from this ABI?

Same question for SEV folks - do you guys think this interface would
make sense for the SEV side of things?

> * There are three ways we might hit a system with this issue:
>   1. NVDIMMs that don't support  TDX, like lack of memory integrity
>      protection.
>   2. CXL-attached memory controllers that can't do encryption at all
>   3. Nominally TDX-compatible memory that was not covered/converted by
>      the kernel for some reason (memory hot-add, or ran out of TDMR
>      resources)

And I think some of those might be of interest to the AMD side of things
too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
