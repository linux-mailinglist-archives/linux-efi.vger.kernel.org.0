Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC34559F4D
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 19:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiFXRWu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 13:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiFXRWF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 13:22:05 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0733E522E6
        for <linux-efi@vger.kernel.org>; Fri, 24 Jun 2022 10:21:41 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id c30so3474871ljr.9
        for <linux-efi@vger.kernel.org>; Fri, 24 Jun 2022 10:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JlWbCSGLtoiUV9s5S4I2VF33Zo7YdAO/mkxevgyN3qY=;
        b=nJBAU9/tj07UZN5FNXK9+/KHQEQgAEeFhyuesPS5GOApEHjX+EZ8Y696xGVH4AETeS
         ozyG1usKOWwfHkZPditLB7l9QicK4TkDG2HiCWPdki2MlZX1iL4p2yuf1q1Jb071k16n
         jiePdSJPriiouBDtb9EghNbRp0ss52hqUMfmne9fPcanCttDFory5YyqoHUCWRNAP1ML
         G72DpjEFAMUtxUL2Kktl2XU6YrKJ2ZxvnZfUghkVW3zPxR9Uv9hUFaLflu9AER3lo/IV
         eIhOUNmapsoBDrQC9vrn4kpCaBRBhq9RHdMCy6YSNwLoY0lGPtuf9lKqoRHV+rzAh1jV
         yhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JlWbCSGLtoiUV9s5S4I2VF33Zo7YdAO/mkxevgyN3qY=;
        b=x7PqkVDMcN4dZUc+hduN3tGw45wRtmeFJoNTxqVo4ZtXy36KPujJNQl0uJaBemyNm8
         LwGmKxePuKNyfQBvUc/ax7IyLPWFDTB6wp63UZ33abf0u8LfbIHxLw94zVnx6ZgGCUei
         JUf4RL9gp6prKQfH2SJIoMxudjijkKXgEftShX7SOF4mLlC45OIJWqBnROSoNLvxx7X4
         VCxtVrrY73d9cY9h5tm73hI8l14X4rd+q4VtZV9SsWRwhYeSg8Dg3wWtjdmbhScQz/tB
         m/yFF9PCBtvS9sa5U4rWMviW0RBgQ8sbQKz+007KPblrVT7NgGQ232b6XdIzFNlkGwDS
         XEEA==
X-Gm-Message-State: AJIora/ry4wwUR+RFsQTGjdUr9XhQXioZp5BgCftTIIMMlB0vHE/DdoX
        vyKZ91u0Aa07B0RdCaQxMf+4fqSyEGflmwI7WOF9+g==
X-Google-Smtp-Source: AGRyM1tyq/jv822hk5wlM5QlG82jddLwlvGXpXf/h4elvz2TSVuZgsSFmh+n0GoDKUeq9/eS1bNdObIlvQ1xDik8nts=
X-Received: by 2002:a2e:b911:0:b0:25a:9942:4171 with SMTP id
 b17-20020a2eb911000000b0025a99424171mr18800ljb.426.1656091297292; Fri, 24 Jun
 2022 10:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <CAMkAt6osbEGBFrgn=y1=x4mDHC1aL40BwaW0NdGHF8qmWd7ktA@mail.gmail.com>
 <5af19000-4482-7eb9-f158-0a461891f087@intel.com> <CAA03e5F480=psSECDAkXQEvNKk3une-4dJV57Hde4z4MMzh=1A@mail.gmail.com>
 <e09dae40-d269-cfed-d048-3e62275c1bb7@intel.com> <CAA03e5HxiLkOUbOrsgbzVdAUNZvnnryuNcqrz1ZWECtWLwKMXA@mail.gmail.com>
In-Reply-To: <CAA03e5HxiLkOUbOrsgbzVdAUNZvnnryuNcqrz1ZWECtWLwKMXA@mail.gmail.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 24 Jun 2022 11:21:25 -0600
Message-ID: <CAMkAt6o-nrfvefrRoGk2S3EZPeyx8oO=yDgDgNJvgvunRr-nMw@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     Marc Orr <marcorr@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
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

On Fri, Jun 24, 2022 at 11:19 AM Marc Orr <marcorr@google.com> wrote:
>
> On Fri, Jun 24, 2022 at 10:10 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 6/24/22 10:06, Marc Orr wrote:
> > > I think Peter's point is a little more nuanced than that. Once lazy
> > > accept goes into the guest firmware -- without the feature negotiation
> > > that Peter is suggesting -- cloud providers now have a bookkeeping
> > > problem. Which images have kernels that can boot from a guest firmware
> > > that doesn't pre-validate all the guest memory?
> >
> > Hold on a sec though...
> >
> > Is this a matter of
> >
> >         can boot from a guest firmware that doesn't pre-validate all the
> >         guest memory?
> >
> > or
> >
> >         can boot from a guest firmware that doesn't pre-validate all the
> >         guest memory ... with access to all of that guest's RAM?
> >
> > In other words, are we talking about "fails to boot" or "can't see all
> > the RAM"?
>
> Ah... yeah, you're right, Dave -- I guess it's the latter. The guest
> won't have access to all of the memory that the customer is paying
> for. But that's still bad. If the customer buys a 96 GB VM and can
> only see 4GB because they're kernel doesn't have these patches they're
> going to be confused and frustrated.

The other error case which might be more confusing to the customer is
their kernel does have these patches, there is some misconfiguration
and their VM boots slowly because the FW uses the accept all memory
approach.
