Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94696559F5A
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 19:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiFXRUO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 13:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiFXRTr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 13:19:47 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5306E795
        for <linux-efi@vger.kernel.org>; Fri, 24 Jun 2022 10:19:19 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w83so4429271oiw.1
        for <linux-efi@vger.kernel.org>; Fri, 24 Jun 2022 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNiiFv53teFu3CRex5rCry8QLqLkd97P3Hj9fAhbeYc=;
        b=kFAUNKf1rEgkt+OYkPh8tB9E+HPlRDJ57kjd7aaOhWKcIYCN/ZjVerEUwL1D4UqEy6
         jNB2akz9JlmI2z3ciS9Jkc2XEeGMl3dvnEZrG1QqRu/ya7j4cL/8FovPHxIwC5EW6es7
         Ghq27j3amQkzIckOMXvVOxDa7HU8mwaHoI3RREC2uB5mU26z2mV8kUwNG56nJSMHMRqc
         7XxJo0dYVvBtJQS7ebwKtCv1V87zEy9YAPcRV8rTLCfAJuZvL7bdAFhpoy8DPcdAukCV
         I/VMctopfL4nnKopG199aqN6z+kRpGu+YbvvSx5/icPAGuQh+9wvM0ZMI9vQVocoE5BI
         2jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNiiFv53teFu3CRex5rCry8QLqLkd97P3Hj9fAhbeYc=;
        b=aqF/7HvEvVsgAbs4qPPjtPwAqlY6y6ghAMpRwv3mLmGeCEnDJFNLVSLjSgV4otqVMG
         drb1P3UnvaL3vTqS5/OIBBg7oDf6wFtYChkvgtqRbofzn+mYHv5k0/dBFQi+w8387OuB
         JfaZUvEIt7rmb3CrUMDsX2sW7mFQCLa5tCYLeuoNM6NUnxAdgJGIPqxK93S8gnVPrG2x
         LC6fZ/mEtP/poB86zm6MPhndnJYpBHuvKY18ALs6lJXh5EcrSdswFFg6VYy+mzyumb4t
         v9n1IJ1iuRMc2JaFvDwzMs8THYUDsJXGKiKGOSEUHt9ZP8LSd0zlawzAh4qjdfduF2oI
         FU5A==
X-Gm-Message-State: AJIora/WSxdkshfFsc00EXmnHpFY3TjvY6O/RAvz2Giyim2AErBsaOPc
        G3KRSY+GAw+r3/7906pDu0ZGal8SlqhXiKfCOk+nDg==
X-Google-Smtp-Source: AGRyM1vH1Tmei+FucmqSWTWHKYA82g8W5CxsahmZ6gIJ+zkpr7Odp70Gu50EcpESE80fWGtWYk5jJ9pFsVncC/eeohY=
X-Received: by 2002:a05:6808:179a:b0:32f:2b07:e733 with SMTP id
 bg26-20020a056808179a00b0032f2b07e733mr2572280oib.218.1656091158204; Fri, 24
 Jun 2022 10:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <5af19000-4482-7eb9-f158-0a461891f087@intel.com> <CAA03e5F480=psSECDAkXQEvNKk3une-4dJV57Hde4z4MMzh=1A@mail.gmail.com>
 <e09dae40-d269-cfed-d048-3e62275c1bb7@intel.com>
In-Reply-To: <e09dae40-d269-cfed-d048-3e62275c1bb7@intel.com>
From:   Marc Orr <marcorr@google.com>
Date:   Fri, 24 Jun 2022 10:19:07 -0700
Message-ID: <CAA03e5HxiLkOUbOrsgbzVdAUNZvnnryuNcqrz1ZWECtWLwKMXA@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Peter Gonda <pgonda@google.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 24, 2022 at 10:10 AM Dave Hansen <dave.hansen@intel.com> wrote:
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

Ah... yeah, you're right, Dave -- I guess it's the latter. The guest
won't have access to all of the memory that the customer is paying
for. But that's still bad. If the customer buys a 96 GB VM and can
only see 4GB because they're kernel doesn't have these patches they're
going to be confused and frustrated.
