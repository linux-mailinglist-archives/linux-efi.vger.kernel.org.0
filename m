Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2A4596BCF
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 11:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiHQJJt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 05:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHQJJq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 05:09:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD71A3DBF5
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 02:09:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2C0F612D8
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 09:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F409C4347C
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 09:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660727384;
        bh=r1/o/S0U3gQBZqRKL4nJ51yn3arzomG0Bayi6kgb5iw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fASSq8ns3ZQp/pdBMOyFVKb7tX09ZQwb8X+B2b0xXHI6PddtEU6GNBD9Ta4c44+oD
         eon72raVw01C4Uo9Xw1Pd+ntTpAX3DrkPRVxP/cjRTOseCT1OANmMF683tlctQGHM9
         iJR7/37OJDijAuXvxV5J1E3Uu1Joz+AvTShw9by2EHYo1SwhwRSSHTtgNFEC4XazF9
         dsa3oCtXqVBneawOD3K7OvgvhDOSIN30neSXeXc8UHGJpAb2j1PGcpHvN7ehpvDuVg
         lwkOx0KHa6g7cnSjDZxQ7If9+eYDBCEcDMFrpriEiVNJk1//c10Zt0ypBG4lBa7T40
         erPTDjRsaylrA==
Received: by mail-vk1-f176.google.com with SMTP id q191so6396776vkb.6
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 02:09:44 -0700 (PDT)
X-Gm-Message-State: ACgBeo2hvm//3H4xLCu5WCmTViWxq5jU80gUxB+KE5jJOL79m/E5g5Nr
        47vceHPqVRrGfxpvfMVoTacze914fHqUMuq6MRg=
X-Google-Smtp-Source: AA6agR4VVOCxzbGXtCBkfrpkM7u9U/px8xvFed3+v5RXtERoK7Yy2le2hfYTN5EwtIohHj04rgf7+v8AaO1iXOQKfYA=
X-Received: by 2002:a1f:9d13:0:b0:376:7f81:9b85 with SMTP id
 g19-20020a1f9d13000000b003767f819b85mr11046658vke.18.1660727383020; Wed, 17
 Aug 2022 02:09:43 -0700 (PDT)
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
 <CAMj1kXEuQMy4+uMxg3A0W=F=PnRHUNLfrN=BPpR3pi_kbWaVpQ@mail.gmail.com>
 <137f829f227602593327461b6349abeaf4bb1f26.camel@xry111.site> <CAMj1kXF=kosmBuF7fd_+gkcxxF0MnB8OdvJ+k3k0uL+Oh3haXg@mail.gmail.com>
In-Reply-To: <CAMj1kXF=kosmBuF7fd_+gkcxxF0MnB8OdvJ+k3k0uL+Oh3haXg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 17 Aug 2022 17:09:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6e9WH5GxYiK9CFnUnJC=NzG=bsmNwuR7Waiz7LadV5xg@mail.gmail.com>
Message-ID: <CAAhV-H6e9WH5GxYiK9CFnUnJC=NzG=bsmNwuR7Waiz7LadV5xg@mail.gmail.com>
Subject: Re: EFI zboot on LoongArch [was: LoongArch: Add efistub booting support]
To:     Ard Biesheuvel <ardb@kernel.org>, maobibo <maobibo@loongson.cn>
Cc:     Xi Ruoyao <xry111@xry111.site>,
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

Hi, Ard,

On Wed, Aug 17, 2022 at 4:36 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 17 Aug 2022 at 09:59, Xi Ruoyao <xry111@xry111.site> wrote:
> >
> > On Wed, 2022-08-17 at 09:49 +0200, Ard Biesheuvel wrote:
> >
> > > > > > >
> > > I am trying to port the generic EFI zboot support to LoongArch, but I
> > > am running into a problem:
> > >
> > > The zboot EFI image consists of
> > >
> > > zImage.o, created with objcopy -O binary
> > > zboot-header.o, created using the assembler
> > > libstub.a, created as usual
> > >
> > > This results in errors such as
> > > arch/loongarch/boot/zboot-header.o: can't link different ABI object.
> > > failed to merge target specific data of file
> > > arch/loongarch/boot/zboot-header.o
> > >
> > > which I think is caused by the fact that objcopy does not set the LP64
> > > soft float flags on the ELF object it creates.
> > >
> > > Do you see any way around this limitation?
> >
> > Update to Binutils-2.39
> > (https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=83c5f3a)
> >
>
> Thanks, that worked. I can now build the LoongArch EFI stub and the
> zboot decompressor.
>
> Unfortunately, while the normal EFI stub kernel boots ok in QEMU/edk2,
> the zboot one crashes with
>
> CRMD   0xB0
> PRMD   0x4
> ECFG  0x800
> ESTAT   0x40000
> ERA    0x17B87719C
> BADV    0x17C634000
> BADI 0x381031A5
> PC 0x00017B87719C
>
> or
>
> CRMD   0xB0
> PRMD   0x4
> ECFG  0x800
> ESTAT   0x40000
> ERA    0x17B138D10
> BADV    0x17C3CC000
> BADI 0x294000F7
> PC 0x00017B138D10

Bibo is a key developer of QEMU/EDK2, maybe he can give some help.

Huacai
