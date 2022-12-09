Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37C464812C
	for <lists+linux-efi@lfdr.de>; Fri,  9 Dec 2022 11:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiLIKxW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 9 Dec 2022 05:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLIKxU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 9 Dec 2022 05:53:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4DD21830
        for <linux-efi@vger.kernel.org>; Fri,  9 Dec 2022 02:53:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAB60B8284D
        for <linux-efi@vger.kernel.org>; Fri,  9 Dec 2022 10:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F387C433F2
        for <linux-efi@vger.kernel.org>; Fri,  9 Dec 2022 10:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670583195;
        bh=yw0hhNDcGvVA+6qXSsqTYiF06vec7FBXDLG4mA+gQFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aSVi12KErAwi5WnvDpCvyrM5EkzSf4dzlgbCpLzZjBb7KTdW3xnIeQcLR0ACLxj40
         uLgFcmf8eqbvOilnJ946LFYM50B2HlCNTKm5hDuSaVQy6YVNuLbK/p2gib980iZl2h
         jSi3etZWxdJAGd6yobxs5aNcHaytIiwYzdlKC/x9Yp2wrDw709g98S8Z3iLOx6DKbk
         iCpLhbAMsOxY0d7Ug9cVAqnK40Yi3KtqvI+mF3GmuEIy9kjqQ5cbMI6k1RgVYa1k9w
         WnW8gSHb32uV6P6puQ7AkCgpUpl5P28ER6V4FEnBEIurdTia4XCCgXxJ0MQC7A1AYo
         zw6qKoEv9+6kA==
Received: by mail-lf1-f44.google.com with SMTP id x28so6422154lfn.6
        for <linux-efi@vger.kernel.org>; Fri, 09 Dec 2022 02:53:15 -0800 (PST)
X-Gm-Message-State: ANoB5pm5fW2r1+EvLftA8ajUNR0aDOVoMK2EDCnUGtdCQd6qWp/u5f1s
        WiwwTrX1j1bWjAY3afl8BeiyEKBaltFUujsI4jU=
X-Google-Smtp-Source: AA0mqf6le3f92BHuZVQcboeJ1ATrYr96U+qranh88xdOpZqGxxdPgQ5fRqv8eozq3p2UDt0YcYLGSq38hzAGKf8dmXs=
X-Received: by 2002:ac2:488e:0:b0:4b4:cf32:e105 with SMTP id
 x14-20020ac2488e000000b004b4cf32e105mr31437807lfc.110.1670583193425; Fri, 09
 Dec 2022 02:53:13 -0800 (PST)
MIME-Version: 1.0
References: <20221205201210.463781-1-ardb@kernel.org> <20221205201210.463781-2-ardb@kernel.org>
 <Y5MTLBJgcCiwGWZ1@FVFF77S0Q05N>
In-Reply-To: <Y5MTLBJgcCiwGWZ1@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 9 Dec 2022 11:53:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGe=_EZc8xhQkZVoP-fMNm8+sc5L6FHsNH0D8=q7o_9uQ@mail.gmail.com>
Message-ID: <CAMj1kXGe=_EZc8xhQkZVoP-fMNm8+sc5L6FHsNH0D8=q7o_9uQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: efi: Execute runtime services from a dedicated stack
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, catalin.marinas@arm.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 9 Dec 2022 at 11:51, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Ard,
>
> One drive-by comment below...
>
> On Mon, Dec 05, 2022 at 09:12:09PM +0100, Ard Biesheuvel wrote:
> > With the introduction of PRMT in the ACPI subsystem, the EFI rts
> > workqueue is no longer the only caller of efi_call_virt_pointer() in the
> > kernel. This means the EFI runtime services lock is no longer sufficient
> > to manage concurrent calls into firmware, but also that firmware calls
> > may occur that are not marshalled via the workqueue mechanism, but
> > originate directly from the caller context.
> >
> > For added robustness, and to ensure that the runtime services have 8 KiB
> > of stack space available as per the EFI spec, introduce a spinlock
> > protected EFI runtime stack of 8 KiB, where the spinlock also ensures
> > serialization between the EFI rts workqueue (which itself serializes EFI
> > runtime calls) and other callers of efi_call_virt_pointer().
> >
> > While at it, use the stack pivot to avoid reloading the shadow call
> > stack pointer from the ordinary stack, as doing so could produce a
> > gadget to defeat it.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/efi.h       |  3 +++
> >  arch/arm64/kernel/efi-rt-wrapper.S | 13 +++++++++-
> >  arch/arm64/kernel/efi.c            | 25 ++++++++++++++++++++
>
> We'll need to teach the stack unwinder about this, or if we take an exception
> from the EFI stack, the backtrace will terminate as soon as it hits a frame
> record on the EFI stack.
>
> In arch/arm64/kernel/stacktrace.c's arch_stack_walk(), that'll need to be added
> to the array of stack bounds. Ideally we'd only add that when a thread is
> making an EFI call.
>

Thanks, I'll look into that.
