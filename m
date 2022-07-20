Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD27757AAF9
	for <lists+linux-efi@lfdr.de>; Wed, 20 Jul 2022 02:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiGTA0f (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Jul 2022 20:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGTA0e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Jul 2022 20:26:34 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD12339B95
        for <linux-efi@vger.kernel.org>; Tue, 19 Jul 2022 17:26:33 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31d85f82f0bso157702877b3.7
        for <linux-efi@vger.kernel.org>; Tue, 19 Jul 2022 17:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXFCfDqvLrq9o9WRcAb2bry5GNfeEVn8GlJpnRDObuY=;
        b=hpR/vH1V8plhuaqeiB0LitY272ggX3bQv0nXd6Y1BK7Bwal8MhI8mqq1jAQjbvj/Wo
         O+/3MIyG9XbRVzS8JgrWNKl87KDU6Eq1+d1hFiW/qgjlFVU/J2bUcja0vmliWIdV5cuy
         GLJRr5o1CbYd4rnWtvQyI+ssrUm7QlB+1im8tGLur7pQHEb16hOL5YLtLdcWkvaBrqGN
         ruD1N7GI152c4a0egyQ0lm3qMW8V5wX3VU1CVrCka/cNse9swyafctm8jQaUghqoZjUS
         ijtU/SJd0WILD2FWaGsfSjESFK4FhyzJ4ayaWMpNsX4UC6eKmD70XnRuMyaoaZu5tHTK
         29UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXFCfDqvLrq9o9WRcAb2bry5GNfeEVn8GlJpnRDObuY=;
        b=xuoFLWOfxe6noQKDn7hwX+z6nVhEIa9Sa5TsaBFEPZjklsPPHw8AIu4Y1h8+jrM754
         wsu70YzsE1dT72RUUSJAnnXr221NQIvhIAbIwKrNCmqUNeD3+NXAHyqvagjDg54P4sf4
         xHIpJMQ6ftfUzT1yRKnBztiDeCXmbzePPInO9dYEa91MXMF3ZvV+g+lB6d6wOwxMiUHr
         g01gJ2TXWqHRHo0t3k04fqfOQT4KP45/X/wFclCH99yNQCCj8UQRmPUQx1RBwGpf1+ep
         jpEnbgFliVgO6SD07JMW1b10XW/hq3Q+Xqj9O6RiBdyvj7/28FgW4u4lqdMyg9x6SeIJ
         vL5w==
X-Gm-Message-State: AJIora+gSkEjrkpPKB8NuWZsGgR78gHJ9qfoVYkGsNIJTaBw/ur5VoGQ
        HKzymUA5FPyAflW2kdsVGSAQo/6KVQwQFpzt+A9VWQ==
X-Google-Smtp-Source: AGRyM1ucYfvEDqy8c2bJqjvjQcMSu4rDtbwnmg0DLGP5d4Yvdv55/Fz6kUTxYLVBWG5VR5+ybBgntVeWxP1KiCKRMVk=
X-Received: by 2002:a81:49c6:0:b0:31c:7f19:a5f0 with SMTP id
 w189-20020a8149c6000000b0031c7f19a5f0mr38675292ywa.385.1658276792919; Tue, 19
 Jul 2022 17:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220627223808.ihgy3epdx6ofll43@black.fi.intel.com>
 <CAMj1kXEdS9SzFZZ4WGH6sR0WDCOgYDZ3Geg6X2sqSnQ-CXXpZA@mail.gmail.com>
 <20220718172159.4vwjzrfthelovcty@black.fi.intel.com> <CAAH4kHYR+VkSJ5J8eWmeaEvstuRz_EuqVQqPfwmp5dhNGRyJwQ@mail.gmail.com>
 <CAAH4kHaHJo4NUb72tHeica4a34hq5u_QP6d6Vuzngf6EqTJ8Aw@mail.gmail.com>
 <CAAH4kHaB2tL+sAn0NAciu5DQeX5hpNkDees=n=f83S=Ph9Y6tw@mail.gmail.com>
 <YtcCWfCQuEsVhH6W@zn.tnic> <CAMj1kXEKtcieycyyFMyuLKJK61FgaDwtLieC0N47W1Sa5LaBsA@mail.gmail.com>
 <YtcgxxMyFTReuuRw@zn.tnic> <bb7479df-7871-9861-600d-c2fed783b659@intel.com>
 <YtcnQbiRgZPtR+rQ@zn.tnic> <22d54786-bc12-ecc5-2b37-cbaa56090aa8@intel.com>
In-Reply-To: <22d54786-bc12-ecc5-2b37-cbaa56090aa8@intel.com>
From:   Marc Orr <marcorr@google.com>
Date:   Tue, 19 Jul 2022 17:26:21 -0700
Message-ID: <CAA03e5FMEyswDhoXRJ5U_n9RG4QM524aQYpF4473ydnAVJr1PA@mail.gmail.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted memory
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Gonda <pgonda@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
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
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Yao, Jiewen" <jiewen.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 19, 2022 at 3:02 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 7/19/22 14:50, Borislav Petkov wrote:
> > On Tue, Jul 19, 2022 at 02:35:45PM -0700, Dave Hansen wrote:
> >> They're trying to design something that can (forever) handle guests that
> >> might not be able to accept memory.
> > Wait, what?
> >
> > If you can't modify those guests to teach them to accept memory, how do
> > you add TDX or SNP guest support to them?
>
> Mainline today, for instance, doesn't have unaccepted memory support for
> TDX or SEV-SNP guests.  But, they both still boot fine because folks
> either configure it on the host side not to *have* any unaccepted
> memory.  Or, they just live with the small (4GB??) amount of
> pre-accepted memory, which is fine for testing things.

For us (Google cloud), "1. Deal with that at the host level
configuration" looks like:
https://cloud.google.com/compute/docs/images/create-delete-deprecate-private-images#guest-os-features

In other words, we have to tag images with "feature tags" to
distinguish which images have kernels that support which features.

Part of the reason we need to do it this way is that we use a single
guest firmware (i.e., guest UEFI) that lives outside of the image.

These feature tags are a mess to keep track of.

All that being said, I can totally see the upstream perspective being
"not our problem". It's hard to argue with that :-).

A few more thoughts:

- If the guest-side patches weren't upstream before this patch set to
handle unaccepted memory, you're all definitely right, that this isn't
a real issue. (Maybe it still isn't...)
- Do we anticipate (many) more features for confidential compute in
the future that require code in both the guest FW and guest kernel? If
yes, then designing a FW-kernel feature negotiation could be useful
beyond this situation.
- Dave's suggestion to "2. Boot some intermediate thing like a
bootloader that does acceptance ..." is pretty clever! So if upstream
thinks this FW-kernel negotiation is not a good direction, maybe we
(Google) can pursue this idea to avoid introducing yet another tag on
our images.

Thank you all for this discussion.

Thanks,
Marc
