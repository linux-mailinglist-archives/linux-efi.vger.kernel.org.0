Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0755A0A2
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 20:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiFXSKV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 14:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiFXSKU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 14:10:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B23649F8B
        for <linux-efi@vger.kernel.org>; Fri, 24 Jun 2022 11:10:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z13so5731609lfj.13
        for <linux-efi@vger.kernel.org>; Fri, 24 Jun 2022 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcN3XwIcZstb9s64xvU12TX0znKfRFFze9XJS0Qbx3c=;
        b=i388ivDFxBMUiQA7obdzFBcEsHyr2kSx+7nBsDjM07lnEAK/xcdqGFSUgzgUY2x5hz
         DEXehsWQSvUsV1Imkd8PWGjk00nG59mSuOc1lCrJJBgRYyUpD1jYVMip2WU88Ju3wXQC
         9mMUu5erd6kQecAreB6NiXoTvzd9EWpyT6+hFRSjep65bDfex49cbaRobzUMHHHZ0Z84
         eXEGdW5cEkmpQdRIfZYO6ikD12SduftZiMeR9H+O6dCGKcrFYtydLGHlB5ozixdcHDZo
         Sofuo2cji7slhGZ5UqgKB7QK/oxD3m0HAUfdsQDFVoue1IcLToG3jzOqCB83xL9+874H
         Tl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcN3XwIcZstb9s64xvU12TX0znKfRFFze9XJS0Qbx3c=;
        b=M3KbZ1cMW18p7PZxIaVuWnNcycJE5Qimmwp/W22gdFWxZPzzOMUdAPqgHEKvG82BBb
         gLbVyl8hlSt+HK4EoGotZu7Eg+u0qpwxOveoBv8y/X6ufG9Rjy3VRR3wVlvKfed6v1MD
         ELX7z57S9D1358NCLFBHtSuAOSy/jSfVp7cxw9izqnvqSbcDmjVbcLoshI14BNbYSweV
         2klk4BTK76dMijZ+R9JI04oX4GCM7+2AVAdpUNe4XGhjuedCPiaNRIU/9SVAazUwMRjt
         VjDUyJDiTbJVeseArt5exJn50aGA/WB4Q3AMajvb6YryjbFVuX9hwK5AhdnctjrKzXjq
         sJdw==
X-Gm-Message-State: AJIora9iEQupayf5Wva5jhoQnyxqRH6T4mMg9n6D7FImBmugMsK2LPrh
        kABdHWa8QMAcC7nyaqNhLGX1tiFIAHWKgd6mL+FzDw==
X-Google-Smtp-Source: AGRyM1tdkubN4l5CrWuEurB1wstbops6ikfefa6G3OKJ5WraDCy19/A/YOyuGj3Y9SbrsN+Oqd+6FVxlMDlWtFoEghE=
X-Received: by 2002:ac2:5974:0:b0:47f:92db:4480 with SMTP id
 h20-20020ac25974000000b0047f92db4480mr59927lfp.685.1656094217190; Fri, 24 Jun
 2022 11:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <5af19000-4482-7eb9-f158-0a461891f087@intel.com> <CAA03e5F480=psSECDAkXQEvNKk3une-4dJV57Hde4z4MMzh=1A@mail.gmail.com>
 <e09dae40-d269-cfed-d048-3e62275c1bb7@intel.com> <CAA03e5HxiLkOUbOrsgbzVdAUNZvnnryuNcqrz1ZWECtWLwKMXA@mail.gmail.com>
 <1e7ad728-d796-c84d-b7ba-b96d8f9fcd0c@intel.com>
In-Reply-To: <1e7ad728-d796-c84d-b7ba-b96d8f9fcd0c@intel.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 24 Jun 2022 12:10:05 -0600
Message-ID: <CAMkAt6pzMSUuuA7Kc-sVEGw1FYpDoRrKs-dco++2rpqB219_ng@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Marc Orr <marcorr@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Marcelo <marcelo.cerri@canonical.com>, tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        "the arch/x86 maintainers" <x86@kernel.org>, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 24, 2022 at 11:47 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/24/22 10:19, Marc Orr wrote:
> >> Is this a matter of
> >>
> >>         can boot from a guest firmware that doesn't pre-validate all the
> >>         guest memory?
> >>
> >> or
> >>
> >>         can boot from a guest firmware that doesn't pre-validate all the
> >>         guest memory ... with access to all of that guest's RAM?
> >>
> >> In other words, are we talking about "fails to boot" or "can't see all
> >> the RAM"?
> > Ah... yeah, you're right, Dave -- I guess it's the latter. The guest
> > won't have access to all of the memory that the customer is paying
> > for. But that's still bad. If the customer buys a 96 GB VM and can
> > only see 4GB because they're kernel doesn't have these patches they're
> > going to be confused and frustrated.
>
> They'll at least be a _bit_ less angry and frustrated than if they were
> staring at a blank screen. ;)  But, yeah, I totally get the point.

Ha! Well we do have that issue in some cases. If you try to run an SEV
VM with an image that doesn't support SEV you will just get a blank
serial screen. If we had something like this back then the FW could
have surfaced a nice error to the user but that's history now.

>
> How big is the window going to be where we have guests that can have
> unaccepted memory, but don't have acceptance support?  For TDX, it's
> looking like it'll probably _just_ be 5.19.  Is TDX on 5.19 in shape
> that cloud providers can deploy it?  Or, is stuff like lack of
> attestation a deal breaker?

This is complicated because distros don't run upstream linux versions.
If I understand correctly (I see some distro emails on here so please
correct me) distros normally maintain forks which they backport things
into. So I cannot answer this question. It is possible that a
hypothetical distro backports only the SNP/TDX initial patches and
doesn't take these for many releases.

I am more familiar with SNP and it does have some attestation support
in the first patch sets.

Also I should have been more clear. I don't want to try and hold up
this feature but instead discuss a future usability add-on feature.

>
>
