Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D055BC2C5
	for <lists+linux-efi@lfdr.de>; Mon, 19 Sep 2022 08:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiISGW6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Sep 2022 02:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiISGW5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Sep 2022 02:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C991D1928D
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 23:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 689E460E65
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 06:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89F4C433B5
        for <linux-efi@vger.kernel.org>; Mon, 19 Sep 2022 06:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663568575;
        bh=H9q85IeFPWJCWziSAJFdx462XycBV7Hn4qswWn4iXHo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gqi/wTHCAsF2mOwPmYKJa/k/gPlW8VQblr62+yIRNZK15O19rv3NomIKfUdrmvXI+
         qLcOO/pTDlJ3fcIEcMe7CjKwSusnyMONaJZRvn3HrW2xt4RXJLKIluO5c/AIaOqnFU
         k/Pw6Wg6s/AGg/hpvz6Pfc7B6jtPHgKYVDbLueW82zTtwxQ/wrwLBo1vqSUNM2DR5h
         /Bw1H+gNzt6YvnL3OyxCveGpXd2ZDk/p39YwYgXJk5+ociBhpusrQuuIhmDPxsueoZ
         reuWuaUO3VEgvA5r3nZ+5M5OwuYUUZLHB4WJ/8r7PG+UuY9xl0BusSj05CpChZPBjI
         JowkxvT0+gKLg==
Received: by mail-lf1-f47.google.com with SMTP id a2so21298025lfb.6
        for <linux-efi@vger.kernel.org>; Sun, 18 Sep 2022 23:22:55 -0700 (PDT)
X-Gm-Message-State: ACrzQf3miwKtPG+ebrINckUYvldADjIzy4M6Ox5T2bdmXNPENRk0gBNZ
        JXjmfMZmmjYvY2maIR07oBmKoZkcal9wObSs2RE=
X-Google-Smtp-Source: AMsMyM7qpu0ls+DvorbLlt5NA01F0k4ODKrWjIPSFEUB5HZylxt81wbWXUSLNQ4N0GNMhIiPFkVoO0CKvwTCGl782r4=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr5385733lfb.583.1663568573745; Sun, 18
 Sep 2022 23:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220918213544.2176249-1-ardb@kernel.org> <20220918213544.2176249-12-ardb@kernel.org>
 <CAAhV-H6Ke88sirvX9ut7JLWy+xaERZ7BeMEf97WHRWbsLqZC0A@mail.gmail.com>
 <CAMj1kXHuQHuCt9Z=qWRH_aZY5_+LzpicyE=agMyAX+O14khL_g@mail.gmail.com> <CAAhV-H7-JFwcwz5pBt7WZxJ2CkeUvc07OLgWxB9z-QTkr=njWw@mail.gmail.com>
In-Reply-To: <CAAhV-H7-JFwcwz5pBt7WZxJ2CkeUvc07OLgWxB9z-QTkr=njWw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 19 Sep 2022 08:22:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFKmvSt1092xBUHVXf9NxDFDSDyPDNpwfGUKWGWAPAE9Q@mail.gmail.com>
Message-ID: <CAMj1kXFKmvSt1092xBUHVXf9NxDFDSDyPDNpwfGUKWGWAPAE9Q@mail.gmail.com>
Subject: Re: [PATCH 11/12] efi/loongarch: libstub: remove dependency on
 flattened DT
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, loongarch@lists.linux.dev,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 19 Sept 2022 at 08:06, Huacai Chen <chenhuacai@kernel.org> wrote:
>
>  Hi, Ard,
>
> On Mon, Sep 19, 2022 at 1:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 19 Sept 2022 at 03:58, Huacai Chen <chenhuacai@kernel.org> wrote:
> > >
> > > Hi, Ard,
> > >
> > > I think the parameters passed to the core kernel need to be discussed.
> > > The old way (so-called old world):
> > > a0=argc, a1=argv, a1=bpi
> > >
> > > The current way (so-called new world):
> > > a0=efi boot flag, a1=fdt pointer
> > >
> > > The new way (in this patchset):
> > > a0=efi boot flag, a1=systemtable, a2=cmdline
> > >
> > > I prefer to use the current way, there are 3 reasons:
> > > 1, both acpi system and dt system can use the same parameters passing method;
> >
> > DT systems will use this too. The distinction is between EFI boot and
> > non-EFI boot. We *really* should keep these separate, given the
> > experience on ARM, where other projects invent ways to pass those
> > values to the kernel without going through the stub.
> In the last patch I see:
> +               void *fdt_ptr = early_memremap_ro(fw_arg1, SZ_64K);
> +
> +               early_init_dt_scan(fdt_ptr);
> +               early_init_fdt_reserve_self();
> +
>                 clear_bit(EFI_BOOT, &efi.flags);
> So I suppose for the DT system that means a0=efi boot flag, a1=fdt
> pointer, a2=cmdline? Then it is not exactly the same as the ACPI
> system, but similar.
>

No, for non-EFI DT boot, the command line is passed via the DT, so
a0=0x0 (non-efi), a1=DT, a2=0x0

Do you intend to support non-EFI DT boot by the way?

So

a2  != 0x0 means old world
a0 != 0x0 means EFI boot, a1 is the command line
a0 == 0x0 means !EFI boot, a1 is the DT

> >
> > > 2, arm64, riscv and loongarch can use similar logics (light FDT);
> >
> > No need to repeat a mistake. I intend to fix RISC-V next.
> >
> > > 3, out-of-tree patches can make compatibility with the old world
> > > easier by just judging whether a2 is zero.
> > >
> >
> > The whole point of this series is that the EFI stub should not be
> > touching the DT at all. In other words, there is no DT pointer, so the
> > current method needs to be revised.
> >
> > What we might do is
> >
> > a0=systemtable, a1=cmdline
> >
> > as any non-zero value is treated as logic true. That way, your logic
> > to test a2 is zero will still work.
> I think the efi boot flag is still needed, even boot from efistub.
> Because if boot with "efi=novamap", the efi runtime should be
> disabled. Then we need efi_enabled(EFI_BOOT) to be false in
> efi_init().
>

I don't think it makes sense to allow efi=novamap on LoongArch, given
that we cannot make use of the runtime services that way. So in my
code, efi_novamap is set to false unconditionally.
