Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B870596B6A
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 10:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiHQIgZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 04:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiHQIgZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 04:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5C46B8E7
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 01:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D119661336
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 08:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D52C433B5
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 08:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660725383;
        bh=Z+PQtXqf/OLjNf2ZFvtv3fYc30t2T5CScmSeX09WGiU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u9L6Ly4kNbgidbAYUuw1s21uAoVOrCnRQFdUfvMXfbutKWGtQ2EZnRAsmhkxy2vtH
         KiQsnAWROv/L2FQwJ+/ah8s0ZuxeIXd4LLdMgykmBrfdcTsyh8rI902QWsrlbJCgmW
         CtuUvz1cRsUScm6o7rMz6tjVLx9AkHv7iEhFtLfMPBJ8lp3GzQ4lLabZWB2Rdot5qs
         IF/xUgJgkPguE8BgRubp8CioGsQYBbXAQ73I0FNeD3kgT60LqK8yX5WsgBIqKUOuPR
         +L7g0fAWzd45OBf8QR7+PKMK/WDAbVmlBZ9uNxJOslQDd+hw9xLen0ENrZM5bSjYYb
         yqnlOYEwXWwJQ==
Received: by mail-wm1-f51.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so589758wmb.4
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 01:36:23 -0700 (PDT)
X-Gm-Message-State: ACgBeo2yeq45goLYLx7Sy9+NpMT/VMCj92J4bspxT1AmmjEmDRQCfcle
        TXX901/osfnwe7v5jJodBVPi3/l6k4d8lBN0tyM=
X-Google-Smtp-Source: AA6agR4upO21rpjoHkIymE4aWOK5QZEwql/e8jMJf1j2cgIyX1R86Wr00jmzxP/rZ6hitfIMTttzDODyokaqkgcjSVo=
X-Received: by 2002:a05:600c:34d3:b0:3a5:fea5:1be8 with SMTP id
 d19-20020a05600c34d300b003a5fea51be8mr1375860wmq.106.1660725381457; Wed, 17
 Aug 2022 01:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145754.582056-1-chenhuacai@loongson.cn>
 <CAMj1kXERN209b7dbVs_hy4BeUwrmk2p9_vF+Wq2W8PUeHOQTkg@mail.gmail.com>
 <CAAhV-H60CJDRY4c+Eu+L=rNgHsXQqx=HK9nNSqg69WVV+Bm3SQ@mail.gmail.com>
 <CAMj1kXE1MijqonkPeH+Ydg8ti4_4YFXxBKK6Wztb=HtSY5EAgQ@mail.gmail.com>
 <CAAhV-H503hgyUZND2MmZ2h3qVb3SRt79HcQy7HrFmfGBci-QMA@mail.gmail.com>
 <CAMj1kXEzzAXYP3nXo8-Ny+iwuDorrO-JqoKjg3R+4kmhV_v_KQ@mail.gmail.com>
 <CAAhV-H60mSKx3k1CwBCdubswosgqe+NuVaMtKA=hpjBhq5w5wA@mail.gmail.com>
 <CAMj1kXFi0o3dOmpW9qarJPH2L2EWKCPKE--3z=jsGjaYh1JrTQ@mail.gmail.com>
 <CAAhV-H5CXeG9mNxqJLouvSGLqno4DSwbpPOO5xG2D6ptF2dSTQ@mail.gmail.com>
 <CAMj1kXEuQMy4+uMxg3A0W=F=PnRHUNLfrN=BPpR3pi_kbWaVpQ@mail.gmail.com> <137f829f227602593327461b6349abeaf4bb1f26.camel@xry111.site>
In-Reply-To: <137f829f227602593327461b6349abeaf4bb1f26.camel@xry111.site>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 Aug 2022 10:36:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF=kosmBuF7fd_+gkcxxF0MnB8OdvJ+k3k0uL+Oh3haXg@mail.gmail.com>
Message-ID: <CAMj1kXF=kosmBuF7fd_+gkcxxF0MnB8OdvJ+k3k0uL+Oh3haXg@mail.gmail.com>
Subject: Re: EFI zboot on LoongArch [was: LoongArch: Add efistub booting support]
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 17 Aug 2022 at 09:59, Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Wed, 2022-08-17 at 09:49 +0200, Ard Biesheuvel wrote:
>
> > > > > >
> > I am trying to port the generic EFI zboot support to LoongArch, but I
> > am running into a problem:
> >
> > The zboot EFI image consists of
> >
> > zImage.o, created with objcopy -O binary
> > zboot-header.o, created using the assembler
> > libstub.a, created as usual
> >
> > This results in errors such as
> > arch/loongarch/boot/zboot-header.o: can't link different ABI object.
> > failed to merge target specific data of file
> > arch/loongarch/boot/zboot-header.o
> >
> > which I think is caused by the fact that objcopy does not set the LP64
> > soft float flags on the ELF object it creates.
> >
> > Do you see any way around this limitation?
>
> Update to Binutils-2.39
> (https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=83c5f3a)
>

Thanks, that worked. I can now build the LoongArch EFI stub and the
zboot decompressor.

Unfortunately, while the normal EFI stub kernel boots ok in QEMU/edk2,
the zboot one crashes with

CRMD   0xB0
PRMD   0x4
ECFG  0x800
ESTAT   0x40000
ERA    0x17B87719C
BADV    0x17C634000
BADI 0x381031A5
PC 0x00017B87719C

or

CRMD   0xB0
PRMD   0x4
ECFG  0x800
ESTAT   0x40000
ERA    0x17B138D10
BADV    0x17C3CC000
BADI 0x294000F7
PC 0x00017B138D10
