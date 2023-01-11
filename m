Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D982C666575
	for <lists+linux-efi@lfdr.de>; Wed, 11 Jan 2023 22:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjAKVTQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Jan 2023 16:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjAKVSa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Jan 2023 16:18:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94091193C6
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 13:18:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EF24B81D5C
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 21:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E990C433D2;
        Wed, 11 Jan 2023 21:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673471907;
        bh=gE7iiQqZo4EDwR53HuYYitcV2oTBz3bJ4nXSfMJJo5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ULZGowEsOaE6Gr3qQoM1M5xBd+3x09nQ7c9yB4Ykqrdvj4gBuItp7an6WM8PajB4a
         Gj8N6Y2KByHelHOGgtW+7CHPGadC7GQNmgdFwajA72Yhxs1vG9TgCedj1CyV4zEzPK
         WK1yzjAMg6qdFwAhnlTkGeSTOnMDD3R7Bzi0BX74dkkoh+55F04D+Pu4cX+N46DLai
         1BGMBJ9lq6xoXaBtKF0FfUDBEfABru6AB84Ka9cpbIlERVIbPrESxJR5TFwYDVBNaU
         5/XrERgtSkDVpUa8GfywMGuxVZw4p4LLGzbkb3fUK1JKhWj8ITYZRe0zD57rA4PCI7
         NK2AsuB/V6Obw==
Date:   Wed, 11 Jan 2023 14:18:24 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee@kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v3 2/2] arm64: efi: Account for the EFI runtime stack in
 stack unwinder
Message-ID: <Y78noHxkLQbM6bIK@dev-arch.thelio-3990X>
References: <20230106174703.1883495-1-ardb@kernel.org>
 <20230106174703.1883495-3-ardb@kernel.org>
 <Y73PAtm6FPuT+1cM@dev-arch.thelio-3990X>
 <CAMj1kXGFa=Zriyp_mS7bbQr0wiwikt0ObjOKUSNGpJtFvLmnkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGFa=Zriyp_mS7bbQr0wiwikt0ObjOKUSNGpJtFvLmnkg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Wed, Jan 11, 2023 at 09:45:32AM +0100, Ard Biesheuvel wrote:
> On Tue, 10 Jan 2023 at 21:48, Nathan Chancellor <nathan@kernel.org> wrote:
> > On Fri, Jan 06, 2023 at 06:47:03PM +0100, Ard Biesheuvel wrote:
> > > The EFI runtime services run from a dedicated stack now, and so the
> > > stack unwinder needs to be informed about this.
> > >
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > Apologies if this has been reported and/or fixed already, I searched
> > lore and did not find anything but I just bisected a QEMU boot hang [1]
> > that we see in the ClangBuiltLinux CI with Fedora's configuration [2] to
> > this change in next-20220110 as commit a7334dc70496 ("arm64: efi:
> > Account for the EFI runtime stack in stack unwinder").
> >
> 
> Thanks for the report. This is due to an oversight on my part: we
> removed a spin_is_locked() check, and the lock in question can only be
> in the locked state when EFI runtime services are enabled to begin
> with.
> 
> Without the lock check, we may end up dereferencing the uninitialized
> efi_rt_stack_top on non-EFI boots.
> 
> I've fixed this up in the EFI fixes tree, so the issue should
> disappear once -next is updated. (We just missed 20230111
> unfortunately)

Thank you for the quick response! That issue appears to be fixed.

Unfortunately, I am still seeing a hang while booting via EFI on either
bare metal or KVM when CONFIG_DEBUG_PREEMPT is enabled (Fedora's rawhide
config appears to enable several debugging options), so it appears I was
seeing two distinct issues :/ defconfig + CONFIG_DEBUG_PREEMPT=y is
enough for me to reproduce this problem.

I see

  [    0.015382] Remapping and enabling EFI services.

as the last line in the console (via earlycon) with the bad kernel and
nothing after it (I assume we deadlock somewhere or hit a BUG_ON()?), vs

  [    0.015191] Remapping and enabling EFI services.
  [    0.016725] smp: Bringing up secondary CPUs ...

on the good kernel, followed by a normal boot.

Sorry for not noticing this sooner! It should be pretty easy to
reproduce but if there is any other information I can provide, I am more
than happy to do so.

Cheers,
Nathan
