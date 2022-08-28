Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EEE5A3CFE
	for <lists+linux-efi@lfdr.de>; Sun, 28 Aug 2022 11:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiH1JhK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Aug 2022 05:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiH1JhJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Aug 2022 05:37:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03740220EB
        for <linux-efi@vger.kernel.org>; Sun, 28 Aug 2022 02:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 813F4B80B17
        for <linux-efi@vger.kernel.org>; Sun, 28 Aug 2022 09:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429A9C43141
        for <linux-efi@vger.kernel.org>; Sun, 28 Aug 2022 09:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661679426;
        bh=Kn5Y1T5scAwqjm26Cvv/96utupRdwMa/v5Q09fDDo3Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N/OVQ0JWQlcbv5G7zlf0eQ2FaMGVa757v4uLbA1jt2mmEDWsJIeFzy3uBw2uSxtrY
         L6IixuMGAlladcmIUyLHGsFZHTO3YKpINvnt+XUh68Q3gqA2j4m5ocmsZvTNMo7AjR
         oqcOCVmQDXP0Ze7C5mczWmJamdw7HhBbQdUVgtzTgyEEoj4O4n9amjlF7NXg2AcYM0
         d7goRN/0+/WHiuitmNskH1AMZ/wzWIZWL2nKcYL50woaacpvDMa2etYyEDK9Ti97tO
         Xe/TYvsu67KJdNQerSOHQnM3zh7xkEuGcM5DcIhP/eCkEiKeGZ3FMcNtU3Owe0dtPH
         dXkt/UAaax4lQ==
Received: by mail-lj1-f169.google.com with SMTP id y10so2267590ljq.0
        for <linux-efi@vger.kernel.org>; Sun, 28 Aug 2022 02:37:06 -0700 (PDT)
X-Gm-Message-State: ACgBeo2efs/YpZyWtmplSGbVkz/nMYSH2Zl19HkhHfkBcdX7zpW+Hqxn
        X94rwT6M0H3VYYjwqW70xR1nolUEQweQ/H0eEJ8=
X-Google-Smtp-Source: AA6agR63je3TCGyOI13Eq3OAYgdHPfwM1ViZpWU8Laf2skVbI0TSRRv3HjH0cX2ffre/wTcypahXqNufKR2g5XpTsIU=
X-Received: by 2002:a05:651c:1a25:b0:261:dfe2:3990 with SMTP id
 by37-20020a05651c1a2500b00261dfe23990mr4092646ljb.415.1661679424208; Sun, 28
 Aug 2022 02:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220827083850.2702465-1-ardb@kernel.org> <20220827083850.2702465-9-ardb@kernel.org>
 <7aa14d72.3a4f.182deccc341.Coremail.chenhuacai@loongson.cn>
 <CAMj1kXG4CXUEtx9r=r-sOyU6cUmDaknKqu3_W_FUQ+_gpdLzXg@mail.gmail.com> <adb55eda511ad6de85936dd37f584687a22e7437.camel@xry111.site>
In-Reply-To: <adb55eda511ad6de85936dd37f584687a22e7437.camel@xry111.site>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 28 Aug 2022 11:36:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGHLans85vpGzY6FbdW0w5DZ0uqT7eEk2yava=udUHY1w@mail.gmail.com>
Message-ID: <CAMj1kXGHLans85vpGzY6FbdW0w5DZ0uqT7eEk2yava=udUHY1w@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] loongarch: avoid orphan input sections
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>
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

On Sun, 28 Aug 2022 at 05:31, Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Sat, 2022-08-27 at 15:27 +0200, Ard Biesheuvel wrote:
> > It does have a relation: the signing tool will complain because the
> > PE/COFF metadata goes out of sync, like so
> >
> >   SBSIGN  arch/loongarch/boot/vmlinux.efi.signed
> > warning: data remaining[20754944 vs 20755016]: gaps between PE/COFF
> > sections?
> >
> > This is because of the *(.rela.dyn) section created by the linker,
> > which is appended after the .data section, and so the PE/COFF .data
> > section size does not match the file size.
> >
> > *However*, you explained to me that vmlinux is not a PIC binary, and
> > the link should be non-PIE as well. So this looks like another
> > toolchain issue to me, that you may want to look into.
>
> In my builds:
>
> With Binutils 2.39 and GCC 12, vmlinux rela.dyn contains 48 zero bytes
> (or 3 R_LARCH_NONE relocations, which is defined "do thing" and is
> ignored by ld, ld.so, and kernel module loader).
>

But does the ELF psABI for LoongArch describe L_ARCH_NONE as a dynamic
relocation? .rela.dyn typically only contains relocations that are
specified as being suitable for runtime relocation.

> With Binutils trunk and GCC trunk, rela.dyn does not exist in
> vmlinux.(But for using the trunks of Binutils and GCC we'll need to
> either disable CONFIG_MODULES or apply [1].)
>

If this is going to land in v6.1 as well, I suggest to drop the patch
entirely. By the time this gets released, you can document which
minimal toolchain version is required for UEFI secure boot signed
kernels.

> [1]:https://lore.kernel.org/loongarch/20220827175436.156464-1-xry111@xry111.site/T/
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
