Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4D1559F73
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 19:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiFXRQJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 13:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFXRQI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 13:16:08 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6820664798
        for <linux-efi@vger.kernel.org>; Fri, 24 Jun 2022 10:16:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b21so2801634ljf.1
        for <linux-efi@vger.kernel.org>; Fri, 24 Jun 2022 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7TLEeCFth7PheP9Vjw0eOfwGgWMcwKrKSrdpGrebWY=;
        b=IU3rG809nvHZOZvyEcynZb5cx8uhkr0QKQGEbHpM7aM3INwbrTUi+sJoYs+poBe5yp
         SUxlrL0gk2U5l9Tl1uRgX2Nvd+9OoDaDB+rrpLWMA0+YwmNGiX1IXzrNmkjxDMe9VIPF
         DJpA0UjxRjtbScKgaEKHhW7ppvN09yvXNsrNVzUhjEdkni1H9IjXu4Cqtxh2Dm8+7aRH
         LmaYAiHtbI1K235l7U6bwe38YtQjXSw1g0zhcNTQaALYl2nxJaEA70C6ZTI3HaFVPIiB
         80IC0gWVvBSre5Xp3FBbIEwP1uT9dAn+VU8gMLbLK3/QoV2/fGqIq9mRE892Iuk4TWZS
         FE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7TLEeCFth7PheP9Vjw0eOfwGgWMcwKrKSrdpGrebWY=;
        b=dgyBU8LQChsph3x/PV2qEPZbB2xkGEqjeL/O5+11IzhWSCqOtsnksCJP9aR5Lqo73R
         SHePSWybb+gvHuKxou5zfLh+36OOaDkO+x34S5hogS0vei4MJopyb7TgfOgmOjSTGoL+
         fpYkTTBNRByi2VItZjuyWE8SwOlWAQrcowSEy2bYZM5W8XjBHFBIzgmBpQCBPe40H4VU
         AJkh6fK6LeDpwm/XuWJkGQPZWWF+uR+ci9SLoNcCNIKhi0EkyMdbs4z3nETMMALL9hEy
         JHDVEgb/jjI77Q8/T75Aitq8jBZWDWRBEQcUrMLAwcQFrtp0DcWcmdn70UTgCsfFJ0V3
         dWKg==
X-Gm-Message-State: AJIora8ehnxmYFH5MLwqtcCEIEpNt+bU0vajNzCTmJVfa13P2l3QNIVg
        k/qrcS+vCDsfaf1H7x9PqJHJXq/5sr2cHXZUUuNQRw==
X-Google-Smtp-Source: AGRyM1t8yYXv52NYU8Eipze+F/p8oqSexP7qPbPFFLxQEI0Uh3d5+Lj1NFdceTfhcMwRr7ETcSSU7a0q88R1auWwSy8=
X-Received: by 2002:a2e:b911:0:b0:25a:9942:4171 with SMTP id
 b17-20020a2eb911000000b0025a99424171mr9602ljb.426.1656090965474; Fri, 24 Jun
 2022 10:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <5af19000-4482-7eb9-f158-0a461891f087@intel.com> <CAA03e5F480=psSECDAkXQEvNKk3une-4dJV57Hde4z4MMzh=1A@mail.gmail.com>
 <e09dae40-d269-cfed-d048-3e62275c1bb7@intel.com>
In-Reply-To: <e09dae40-d269-cfed-d048-3e62275c1bb7@intel.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 24 Jun 2022 11:15:53 -0600
Message-ID: <CAMkAt6qNkwOPpsqLjvB+FaQRpySYBJYb5sm7nj8khO7Um5EQ5g@mail.gmail.com>
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

>> > Peter, is your enter key broken?  You seem to be typing all your text in
>> > a single unreadable paragraph.

Sorry I will try to format better in the future.

>> > You're saying that firmware basically has two choices:
>> > 1. Accept all the memory up front and boot slowly, but reliably
>> > 2. Use thus "unaccepted memory" mechanism, boot fast, but risk that the
>> >    VM loses a bunch of memory.

That's right. Given that the first round of SNP guest patches are in
but this work to support unaccepted memory for SNP is not we assume we
will have distros that support SNP without this "unaccepted memory"
feature.

On Fri, Jun 24, 2022 at 11:10 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/24/22 10:06, Marc Orr wrote:
> > I think Peter's point is a little more nuanced than that. Once lazy
> > accept goes into the guest firmware -- without the feature negotiation
> > that Peter is suggesting -- cloud providers now have a bookkeeping
> > problem. Which images have kernels that can boot from a guest firmware
> > that doesn't pre-validate all the guest memory?
>
> Hold on a sec though...
>
> Is this a matter of
>
>         can boot from a guest firmware that doesn't pre-validate all the
>         guest memory?
>
> or
>
>         can boot from a guest firmware that doesn't pre-validate all the
>         guest memory ... with access to all of that guest's RAM?
>
> In other words, are we talking about "fails to boot" or "can't see all
> the RAM"?
>

Yes, I'm sorry I was mistaken. If FW uses unaccepted memory but the
kernel doesn't support it the VM should still boot but will fail to
utilize all of its given RAM.

>> > If the customer screws up, they lose a bunch of the RAM they paid for.
>> > That seems like a rather self-correcting problem to me.

Providing customers with an easy to use product is a problem for us
the cloud provider, encoding foot-guns doesn't sound like what's best
for the user here. I wanted to bring this up here since it seems like
a problem most vendors/users of SNP and TDX would run into. We can of
course figure this out internally if no one else sees this as an
issue.
