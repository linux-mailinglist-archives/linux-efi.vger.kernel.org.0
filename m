Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD7063FC4F
	for <lists+linux-efi@lfdr.de>; Fri,  2 Dec 2022 00:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiLAXwk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 18:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLAXwk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 18:52:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13577667
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 15:52:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 911B6621BE
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 23:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008FDC433B5
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 23:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669938758;
        bh=i2E8izrH8hqoFXZy1EASD4tZKOUg3cwTgEhDvuqcqVo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nB93TxM4adqREEWtGzfyjDyMGLcBBVMXNnPLD3p73YAq1W8uC3+ZPiDgfBpp/OOZs
         i81QSY9fEN3vW71tAEdKMUZiLM6ijuvRj0N5IIqlLe3dmvhiekNi5UNw/Fgo71Bolt
         LdZ5keAYadj1Pb8h0xHkfmAT1fe19R6vw8y3ZegvGO+UWVvA/7RBtiJZOvZ5wcYiFB
         00gQmHKBwQ/7giEwATVxGKnGn5i2bhjnYxUqnMpI5rPhb5/4jQJzGu7Pdwd2ebpiEU
         HlqqweC7LpLIFwCa6Bgb1tKcFv1HZjQsvsS0KGjMgHcfOBDDnfICAuIUt6/HRWUoms
         Ocher2xaKikPQ==
Received: by mail-lj1-f182.google.com with SMTP id a7so3653978ljq.12
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 15:52:37 -0800 (PST)
X-Gm-Message-State: ANoB5pmQO8CaHKNo1yvuRuAhag0h4KoMSowxjGRVOllo6hafft58XuXi
        vcHdyW6EzvHvXWuQ5L5MqJKmm8hk+N0SOjWBmpw=
X-Google-Smtp-Source: AA0mqf5xEyNcbA+lyZkTav0qxuQETAxi7yyXXelv6MiHlT8cmuMVC4+jHYQk+ndYliQVWaF0uO3C+MkIrtA7MJzyVhM=
X-Received: by 2002:a05:651c:1603:b0:26d:d603:8df2 with SMTP id
 f3-20020a05651c160300b0026dd6038df2mr20217573ljq.189.1669938756017; Thu, 01
 Dec 2022 15:52:36 -0800 (PST)
MIME-Version: 1.0
References: <20221128094939.801232-1-ardb@kernel.org> <202212011544.2AA7C8A5@keescook>
 <CAMj1kXGBSv6jODKgayeChn5wPO0m0ahLGt+2GdU4OF8JBeQdmQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGBSv6jODKgayeChn5wPO0m0ahLGt+2GdU4OF8JBeQdmQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 2 Dec 2022 00:52:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFU=joOhs=xcZ_PKvee2DT8V9YE6_0c0TsRDnPCTCRRNg@mail.gmail.com>
Message-ID: <CAMj1kXFU=joOhs=xcZ_PKvee2DT8V9YE6_0c0TsRDnPCTCRRNg@mail.gmail.com>
Subject: Re: [PATCH] arm64: efi: Make runtime service wrapper more robust
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2 Dec 2022 at 00:47, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 2 Dec 2022 at 00:45, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Nov 28, 2022 at 10:49:39AM +0100, Ard Biesheuvel wrote:
> > > Prevent abuse of the runtime service wrapper code by avoiding restoring
> > > the shadow call stack pointer from the ordinary stack, or the stack
> > > pointer itself from a GPR. Also, given that the exception recovery
> > > routine is never called in an ordinary way, it doesn't need BTI landing
> > > pads so it can be SYM_CODE rather than SYM_FUNC.
> >
> > Does this mean x18 is now being spilled to the stack? (Do we already
> > spill it in other places?)
> >
>
> I've found a better way of addressing this, by moving this code out of
> the kernel .text mapping entirely, and only mapping it executable in
> the EFI page tables (which are only active while a runtime service
> call is in progress, and only on a single CPU running with preemption
> disabled)
>
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=47f68266d6ad94860c6cd9d2145cb91350b47e43

And to answer your question: yes, x18 is currently spllled to the
stack in both of those routines. I've reverted the patch that added
the second one (which was only added this cycle). The other one needs
a fix going to -stable, so I'll backport the patch I quoted above once
it hits linus's tree.
