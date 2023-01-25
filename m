Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8C867B714
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jan 2023 17:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjAYQnK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Jan 2023 11:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjAYQnK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Jan 2023 11:43:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FE45618B
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 08:43:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E04C7B81B01
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 16:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1B2C4339B
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 16:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674664986;
        bh=6mKPy2dJzEuiQUdKGQzrXXioCbg4fI1rvtq4Xn35+B4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CDjcrWkGDT/E0M9wkHSS5Ll3eUyV3UeAGBXBCcvyys86Ve8Zpn8EwDWd/Szy2RGgn
         FoZOM1boxzbUyvqKoK0B5udPBuzLtzy8T0XnaKT2gWZy1swToygfDaCsmUvcUVZGPB
         yf1zZ0ohTIxhG7YOxb9R70bGjI8mDbyChVD30plYBpHmj9NdRSgpMegEzj9fIn7aiI
         LHhSobztARfPwAbHM6Jr3aTMrSMytUBkHD8TYfpiDsYOZhkcn8iHvmplZvp+X5fwYi
         Hn1PBizR6siO6pCJvQyfQyKWHpgt9KKFgapcwHxiOUSxlMhUjpHVxjEjt7rE9XZfrJ
         YbmrlKJFInt+A==
Received: by mail-lj1-f174.google.com with SMTP id p25so20978284ljn.12
        for <linux-efi@vger.kernel.org>; Wed, 25 Jan 2023 08:43:06 -0800 (PST)
X-Gm-Message-State: AO0yUKXydo8NLar8t2S1+OxH9NCl462ttDKJhgFi+kUyI7OHC29+SU5s
        uO4cVQNRBrZYD9p/Lglk4CvoJXKP2cLMb7Ip+yM=
X-Google-Smtp-Source: AK7set81Q7IaCX3y+aR1udGQYaD72lDfZJftu+ONjPh8p/FgouhLJD3SEw4ZmfLHMjdWvtyWW+LOALvDY88Dkte6Kd8=
X-Received: by 2002:a2e:920c:0:b0:28d:ca43:8eec with SMTP id
 k12-20020a2e920c000000b0028dca438eecmr194625ljg.516.1674664984601; Wed, 25
 Jan 2023 08:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20230111102236.1430401-1-ardb@kernel.org> <20230111102236.1430401-5-ardb@kernel.org>
 <Y9FZsBEu8hSVVIA8@dev-arch.thelio-3990X>
In-Reply-To: <Y9FZsBEu8hSVVIA8@dev-arch.thelio-3990X>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 25 Jan 2023 17:42:53 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE9h_Qc8rTtsVwYhbdJ94qXXRDbnq2XSGaoVC7Up5Y3dg@mail.gmail.com>
Message-ID: <CAMj1kXE9h_Qc8rTtsVwYhbdJ94qXXRDbnq2XSGaoVC7Up5Y3dg@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] arm64: head: avoid cache invalidation when
 entering with the MMU on
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 25 Jan 2023 at 17:32, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Ard,
>
> On Wed, Jan 11, 2023 at 11:22:34AM +0100, Ard Biesheuvel wrote:
> > If we enter with the MMU on, there is no need for explicit cache
> > invalidation for stores to memory, as they will be coherent with the
> > caches.
> >
> > Let's take advantage of this, and create the ID map with the MMU still
> > enabled if that is how we entered, and avoid any cache invalidation
> > calls in that case.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/kernel/head.S | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index c3b898efd3b5288d..d75f419206451d07 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -89,9 +89,9 @@
> >  SYM_CODE_START(primary_entry)
> >       bl      record_mmu_state
> >       bl      preserve_boot_args
> > +     bl      create_idmap
> >       bl      init_kernel_el                  // w0=cpu_boot_mode
> >       mov     x20, x0
> > -     bl      create_idmap
> >
> >       /*
> >        * The following calls CPU setup code, see arch/arm64/mm/proc.S for
> > @@ -377,12 +377,13 @@ SYM_FUNC_START_LOCAL(create_idmap)
> >        * accesses (MMU disabled), invalidate those tables again to
> >        * remove any speculatively loaded cache lines.
> >        */
> > +     cbnz    x19, 0f                         // skip cache invalidation if MMU is on
> >       dmb     sy
> >
> >       adrp    x0, init_idmap_pg_dir
> >       adrp    x1, init_idmap_pg_end
> >       bl      dcache_inval_poc
> > -     ret     x28
> > +0:   ret     x28
> >  SYM_FUNC_END(create_idmap)
> >
> >  SYM_FUNC_START_LOCAL(create_kernel_mapping)
> > --
> > 2.39.0
> >
>
> Our CI started reporting a boot failure in QEMU with defconfig +
> CONFIG_CPU_BIG_ENDIAN=y after this patch as commit 32b135a7fafe ("arm64:
> head: avoid cache invalidation when entering with the MMU on") in the
> arm64 tree (and now next-20230125).
>
> https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/4001750912/jobs/6868612292
>
> $ timeout --foreground 3m qemu-system-aarch64 \
> -cpu max,pauth-impdef=true \
> -machine virt,gic-version=max,virtualization=true \
> -kernel Image.gz \
> -append "console=ttyAMA0 earlycon" \
> -display none \
> -initrd rootfs.cpio
> -m 512m \
> -nodefaults \
> -no-reboot \
> -serial mon:stdio
> qemu-system-aarch64: terminating on signal 15 from pid 389 (timeout)
>
> defconfig is fine at the same change.
>
> There is no output, which makes sense since this is pretty early in
> boot. We are not booting via EFI, in case that matters. This does not
> appear to be a toolchain problem, as I can reproduce it with the
> kernel.org GCC toolchains.
>

Thanks for the report.

With this patch, the ID map is populated before the switch to BE mode,
and so the descriptors are written in the wrong byte order.

This should be easy to fix - I'll have a patch out shortly.
