Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1482A4EDEA5
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 18:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbiCaQWX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 12:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239827AbiCaQWV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 12:22:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CD81F162B
        for <linux-efi@vger.kernel.org>; Thu, 31 Mar 2022 09:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7B8BB82056
        for <linux-efi@vger.kernel.org>; Thu, 31 Mar 2022 16:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84339C340ED
        for <linux-efi@vger.kernel.org>; Thu, 31 Mar 2022 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648743631;
        bh=rn1U+fbho+WqXE0a5aP5XyteoGH62P/PxwZ4lDmvQ7E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i5RzlfytaPZS6fuI60ZFLqiI26wCoFRw2nbxUN86132ivqb25I3mXnRiOTRRzAPoe
         5P6dnOJLcRrD7p4lfokcwARY8BUCMYWIadM1UosnaMt5PsTR9iZWY5lMJdmgUZZ5w/
         V4ejcpdgDDH3NkE3lhdcsbUMhNnks8hQ2EZy1+DZywDBIn8M22EekwZV8+lZnZl7bT
         VGlHAPWz5RWORSlZu1FPtGjflmX5FbKvgyG1xP21TJ16hCLqcbFagfNf6Z2v1xVsm1
         WdYpYEG+JJj5mQOpT14QdwnTBl42KIggukzAXdDJKdt72zA9+J//gIjXHQ7uY65rOg
         D2ssJyIsxhJfg==
Received: by mail-ot1-f41.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso270894otj.0
        for <linux-efi@vger.kernel.org>; Thu, 31 Mar 2022 09:20:31 -0700 (PDT)
X-Gm-Message-State: AOAM530n1HtsXYE0Ub4GFC/Jc722R2D1LmQlM4GuWvliDSGtcKtmTzVe
        mmMFGcVA4BpCYG8z9IJNiPyphYTVblthvmQ3HYo=
X-Google-Smtp-Source: ABdhPJx8+AF/ExTmuRiVARJZyq6n6K0ODIVXWQrKy7pHi9WpxWL/cAftEt2VOEMWZNH0doO99l3R/76SH0OYKS5O86I=
X-Received: by 2002:a05:6830:2e7:b0:5b2:68c1:182a with SMTP id
 r7-20020a05683002e700b005b268c1182amr6054306ote.71.1648743630549; Thu, 31 Mar
 2022 09:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220330154205.2483167-1-ardb@kernel.org> <YkXKuIChPg4xBReW@FVFF77S0Q05N>
In-Reply-To: <YkXKuIChPg4xBReW@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 31 Mar 2022 18:20:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEVDBH9vH2qEBWV1ngTRtPthWpB34MdsJAmFZuqVSwm7w@mail.gmail.com>
Message-ID: <CAMj1kXEVDBH9vH2qEBWV1ngTRtPthWpB34MdsJAmFZuqVSwm7w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/18] arm64: efi: leave MMU and caches on at boot
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 31 Mar 2022 at 17:37, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Ard,
>

Hi Mark,

Thanks for taking a look.

> On Wed, Mar 30, 2022 at 05:41:47PM +0200, Ard Biesheuvel wrote:
> > This is a followup to a previous series of mine [0], and it aims to
> > streamline the boot flow with respect to cache maintenance and redundant
> > copying of data in memory.
> >
> > Combined with my proof-of-concept firmware for QEMU/arm64 [1], this
> > results in a boot where both the kernel and the initrd are loaded
> > straight to their final locations in memory, while the physical
> > placement of the kernel image is still randomized by the loader. It also
> > removes all memory accesses performed with the MMU and caches off
> > (except for instruction fetches) that are done from the moment the VM
> > comes out of reset.
> >
> > On the kernel side, this comes down to:
> > - increasing the ID map to cover the entire kernel image, so we can
> >   build the kernel page tables with the MMU and caches enabled;
> > - deal with the MMU already being on at boot, and keep it on while
> >   building the ID map;
> > - ensure all stores to memory that are now done with the MMU and caches
> >   on are not negated by the subsequent cache invalidation.
>
> This is on my queue to review in detail, but for now I have a couple of
> high-level thoughts:
>
> 1) I like the idea of deferring/staging some work until after the MMU is on,
>    and I'm in favour of doing so where we can do so in all cases. If we end up
>    with infrastructure to run some MMU-on TTBR0 stub environment(s), that could
>    be useful elsewhere, e.g. idmap_kpti_install_ng_mappings().
>

Yeah, good point. I as aware that there might be other code that we
would prefer to run in the same way.

> 2) I do not think that we should support entering the kernel with the MMU on.
>
>    I think that consistently using the same MMU-off boot code has saved us a
>    great deal of pain thus far, and the more I think about booting with the MMU
>    on, I think it opens us up to a lot of potential pain, both in the short term
>    and longer term as the architecture evolves. For example, as rhetoricals
>    from the top of my head:
>
>   * How do we safely inherit whatever VMSA state the loader has left us with?
>     e.g. what do we require w.r.t. TCRs, MAIRS?
>     e.g. what to do when the loader uses a different granule size from the
>          kernel?
>
>   * What can we expect is mapped, and with which specific attributes and
>     permissions?
>
>   * What do we document here for loaders other than the EFI stub?
>     ... and what about kexec?
>

The only requirement is that the entire image is mapped writeback
cacheable, with the code region executable and the data region
writable. Beyond that, it doesn't really matter, not even whether we
boot at EL2 or EL1. The 1:1 mapping we inherit from the previous boot
stage is only used to create the ID map (and to set some global
variables), we never run our page tables under the old TCR/MAIR regime
or vice versa.

Whether or not we should relax the documented boot protocol as well is
a separate question. I wouldn't be opposed to doing that, if we
document the requirements, but it is not something I'm pursuing with
this series.

>   ... and generally this is another complication for maintenance and testing
>   that I'd rather not open the door to.
>
> In other words, my view is that we should *minimize* what we do with the MMU
> off, but only where we can do that consistently, and we should still
> consistently enter with the MMU off such that we can consistently and safely
> initialize the VMSA state.
>

I see your point. I personally think this is manageable, but I'll let
the maintainers be the judge of that.

Thanks,
Ard.
