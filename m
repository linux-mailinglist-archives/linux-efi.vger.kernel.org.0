Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B5A596AA7
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiHQHuM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 03:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHQHuK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 03:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E177B1CD
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 00:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC4D061267
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 07:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C83AC433D7
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 07:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660722609;
        bh=K9bXyxX0+RghSfyNAr6gwZUIT5olXJ1bRyiQBF48s0s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NwscqJJf97E6NTETmTL026TLjl8pPn+pucnlpT3iNIVCsyE3Z6iJ8WkXCz1JVoLVQ
         h6b+6/4NhvBFQoaIKmAkOmeenRFbTVV6wvhRXBJ4vzrCO0klBRhEwjabfRFZ9BWY0o
         /Ap9iT9pl2yqQ6ry12EFGC8IBlOS9LBqVdbu8wtKtn2JfjbrI0Ns0RoYYGKJb3aT79
         aqQ9PNfbk3LM6hKhZc0bza4wzE43aDFJq+xSIHduSpKqu3dsj+rptTQhoF6/1l/NCs
         bfYMWLyR3fvx4255OB3AD93DRLjmlJLApHT5wxN6ft4BIRRDAsm9x9d9ppU/boi05w
         dqKYLBB0ivGYQ==
Received: by mail-wm1-f50.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so555781wms.0
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 00:50:09 -0700 (PDT)
X-Gm-Message-State: ACgBeo1o8GunpM1aj7klVvqyBGqU8MBlMyCrehrdLkOQTGQV4yMRJSBM
        OB5qxMIKdZ2PsMbG4kEFbutiYopLfSnuZVjK1NQ=
X-Google-Smtp-Source: AA6agR6nLmdSRee+rp7gcLg2SgHu37BhlC5rKJaS5hwfc8sIpCcu5/dANDz/FR4G/e1lrSp7wEDpBpgHrjlxlvYtB5A=
X-Received: by 2002:a05:600c:3b8c:b0:3a6:71a:f286 with SMTP id
 n12-20020a05600c3b8c00b003a6071af286mr1263402wms.120.1660722607399; Wed, 17
 Aug 2022 00:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220617145754.582056-1-chenhuacai@loongson.cn>
 <CAMj1kXERN209b7dbVs_hy4BeUwrmk2p9_vF+Wq2W8PUeHOQTkg@mail.gmail.com>
 <CAAhV-H60CJDRY4c+Eu+L=rNgHsXQqx=HK9nNSqg69WVV+Bm3SQ@mail.gmail.com>
 <CAMj1kXE1MijqonkPeH+Ydg8ti4_4YFXxBKK6Wztb=HtSY5EAgQ@mail.gmail.com>
 <CAAhV-H503hgyUZND2MmZ2h3qVb3SRt79HcQy7HrFmfGBci-QMA@mail.gmail.com>
 <CAMj1kXEzzAXYP3nXo8-Ny+iwuDorrO-JqoKjg3R+4kmhV_v_KQ@mail.gmail.com>
 <CAAhV-H60mSKx3k1CwBCdubswosgqe+NuVaMtKA=hpjBhq5w5wA@mail.gmail.com>
 <CAMj1kXFi0o3dOmpW9qarJPH2L2EWKCPKE--3z=jsGjaYh1JrTQ@mail.gmail.com> <CAAhV-H5CXeG9mNxqJLouvSGLqno4DSwbpPOO5xG2D6ptF2dSTQ@mail.gmail.com>
In-Reply-To: <CAAhV-H5CXeG9mNxqJLouvSGLqno4DSwbpPOO5xG2D6ptF2dSTQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 17 Aug 2022 09:49:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEuQMy4+uMxg3A0W=F=PnRHUNLfrN=BPpR3pi_kbWaVpQ@mail.gmail.com>
Message-ID: <CAMj1kXEuQMy4+uMxg3A0W=F=PnRHUNLfrN=BPpR3pi_kbWaVpQ@mail.gmail.com>
Subject: EFI zboot on LoongArch [was: LoongArch: Add efistub booting support]
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>
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

> > > > > So screen_info is a global variable in the core kernel. For the zboot
> > > > > case (our own implementation, not sure about the proposing new
> > > > > method), efistub may be able to fill this info, but while
> > > > > decompressing, screen_info will be overwritten. I think.
> > > > >
> > > >
> > > > Right. So you can drop it then.
> > > OK, then can we rename LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID to
> > > LINUX_EFI_SCREEN_INFO_TABLE_GUID and avoid define a dedicated GUID for
> > > each arch?
> > >
> >
> > If you use the arm64 approach, you don't need a GUID at all.
> Oh, I misunderstood.
> OK, I will use the arm64 approach now, my problem only exists when the
> order is "stub, decompression, core-kernel". If the new zboot way is
> "decompression, stub, core-kernel", then there is no problem.
>

Indeed.

I am trying to port the generic EFI zboot support to LoongArch, but I
am running into a problem:

The zboot EFI image consists of

zImage.o, created with objcopy -O binary
zboot-header.o, created using the assembler
libstub.a, created as usual

This results in errors such as
arch/loongarch/boot/zboot-header.o: can't link different ABI object.
failed to merge target specific data of file arch/loongarch/boot/zboot-header.o

which I think is caused by the fact that objcopy does not set the LP64
soft float flags on the ELF object it creates.

Do you see any way around this limitation?
