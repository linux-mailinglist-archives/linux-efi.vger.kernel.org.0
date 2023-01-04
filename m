Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D2265D897
	for <lists+linux-efi@lfdr.de>; Wed,  4 Jan 2023 17:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbjADQQO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Jan 2023 11:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbjADQP4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 11:15:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0181081;
        Wed,  4 Jan 2023 08:15:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2087E61797;
        Wed,  4 Jan 2023 16:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885C6C433F0;
        Wed,  4 Jan 2023 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672848947;
        bh=dyIBN4IgBmajGujH1vneRSPhim4zJskbouYILckcoHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MQ//MM6uQhAi+8TFGgISAU1hU979UQidgTySbXnSzIisDoQUj/N3YBc248PCIboA7
         OTOsCBAWElGnIIs3NSVqldEp6VDdzXeDBFfaXcNx8VV15aw+UJKcQYHVo8+L+RO1Em
         uroTqiMRnWIDfpkddnMyzea5D8y4LXBfSR+sr5lYMBGL49vUu9B7uh8nPZiaCLoFNN
         SAM7E5ck0vurgnv67xzHzTd2gZBAbyiwCPk50Ks4OrSn8UnGIEMQdqJBhqX4fUDMdK
         mt3+gxSimZjNxcHundDZZsC92EfKfkQzQHnuu3eteHTxzKOBfuRNUITKNLi1/JIMBH
         9GNCfCjtjiJDQ==
Received: by mail-lj1-f174.google.com with SMTP id v23so25773322ljj.9;
        Wed, 04 Jan 2023 08:15:47 -0800 (PST)
X-Gm-Message-State: AFqh2kpRjJcCL0RoKr26ujayKHW4qwwef1O2VllyS9kLMASAfYBR9F1T
        wSoHdqS9WqTx4TaIrUqjA/nsHDMWQTjI2k4n16U=
X-Google-Smtp-Source: AMrXdXvPuwRqCp2AG0otRJ/TS278kj56coQplJz/imSWlS+tFxPqVbXNIJAxf4zcbcObia5IrS4Rm6ULMHAGI4L4zpo=
X-Received: by 2002:a2e:a99b:0:b0:27f:b833:cf6d with SMTP id
 x27-20020a2ea99b000000b0027fb833cf6dmr2984312ljq.291.1672848945565; Wed, 04
 Jan 2023 08:15:45 -0800 (PST)
MIME-Version: 1.0
References: <20221205201210.463781-1-ardb@kernel.org> <20221205201210.463781-2-ardb@kernel.org>
 <Y7VXg5MCRyAJFmus@google.com> <CAMj1kXEYDHuRmUPvdMVj1H1fLoOKcr+qG6NDpufxwJa57jsWdg@mail.gmail.com>
 <Y7WloqaytMnC8ZIC@FVFF77S0Q05N>
In-Reply-To: <Y7WloqaytMnC8ZIC@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Jan 2023 17:15:34 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEaX_3yFT_GFruXbQj9gfDShH4arPjTQBqokKAGusi_Fw@mail.gmail.com>
Message-ID: <CAMj1kXEaX_3yFT_GFruXbQj9gfDShH4arPjTQBqokKAGusi_Fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: efi: Execute runtime services from a dedicated stack
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Lee Jones <lee@kernel.org>, stable@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Wed, 4 Jan 2023 at 17:13, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Jan 04, 2023 at 02:56:19PM +0100, Ard Biesheuvel wrote:
> > On Wed, 4 Jan 2023 at 11:40, Lee Jones <lee@kernel.org> wrote:
> > >
> > > On Mon, 05 Dec 2022, Ard Biesheuvel wrote:
> > >
> > > > With the introduction of PRMT in the ACPI subsystem, the EFI rts
> > > > workqueue is no longer the only caller of efi_call_virt_pointer() in the
> > > > kernel. This means the EFI runtime services lock is no longer sufficient
> > > > to manage concurrent calls into firmware, but also that firmware calls
> > > > may occur that are not marshalled via the workqueue mechanism, but
> > > > originate directly from the caller context.
> > > >
> > > > For added robustness, and to ensure that the runtime services have 8 KiB
> > > > of stack space available as per the EFI spec, introduce a spinlock
> > > > protected EFI runtime stack of 8 KiB, where the spinlock also ensures
> > > > serialization between the EFI rts workqueue (which itself serializes EFI
> > > > runtime calls) and other callers of efi_call_virt_pointer().
> > > >
> > > > While at it, use the stack pivot to avoid reloading the shadow call
> > > > stack pointer from the ordinary stack, as doing so could produce a
> > > > gadget to defeat it.
> > > >
> > > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > >  arch/arm64/include/asm/efi.h       |  3 +++
> > > >  arch/arm64/kernel/efi-rt-wrapper.S | 13 +++++++++-
> > > >  arch/arm64/kernel/efi.c            | 25 ++++++++++++++++++++
> > > >  3 files changed, 40 insertions(+), 1 deletion(-)
> > >
> > > Could we have this in Stable please?
> > >
> > > Upstream commit: ff7a167961d1b ("arm64: efi: Execute runtime services from a dedicated stack")
> > >
> > > Ard, do we need Patch 2 as well, or can this be applied on its own?
> > >
> >
> > Thanks for the reminder.
> >
> > Only patch #1 is needed. It should be applied to v5.10 and later.
>
> Hold on, why did this go into mainline when I had an outstanding comment w.r.t.
> the stack unwinder?
>
> From your last reply to me there I was expecting a respin with that fixed.
>

Apologies for the confusion.

I have a patch for this queued up, but AIUI, that cannot be merged all
the way back to v5.10, so these need to remain separate changes in any
case.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c2530a04a73e6b75ed71ed14d09d7b42d6300013
