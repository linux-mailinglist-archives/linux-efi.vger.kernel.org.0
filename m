Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3339D596AB7
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 09:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiHQH7L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 03:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiHQH7L (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 03:59:11 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EB331DE6
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 00:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1660723146;
        bh=V2lLYN1jBbuKCR31QqZpcVMfEcz40ORuyX9rbWEsoKg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dyDHQ52n3vnpxuTuP6luvAuPcUJvJ3kO1PO0i95N6Kw4A9BsXZTsCxtexQ1P7uGY8
         su1nbpVYb5eFWK3K1RcXbs0RI7CT0ccYCv7H9mEgcRJBKICstG5nIENBNoNhbISq2v
         93R7laDkcCKf1abSE+7f9aNVx8ovhMMYl66RniBY=
Received: from [IPv6:240e:358:118c:b800:dc73:854d:832e:3] (unknown [IPv6:240e:358:118c:b800:dc73:854d:832e:3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id BF2FB66804;
        Wed, 17 Aug 2022 03:59:01 -0400 (EDT)
Message-ID: <137f829f227602593327461b6349abeaf4bb1f26.camel@xry111.site>
Subject: Re: EFI zboot on LoongArch [was: LoongArch: Add efistub booting
 support]
From:   Xi Ruoyao <xry111@xry111.site>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Date:   Wed, 17 Aug 2022 15:58:55 +0800
In-Reply-To: <CAMj1kXEuQMy4+uMxg3A0W=F=PnRHUNLfrN=BPpR3pi_kbWaVpQ@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2022-08-17 at 09:49 +0200, Ard Biesheuvel wrote:

> > > > >=20
> I am trying to port the generic EFI zboot support to LoongArch, but I
> am running into a problem:
>=20
> The zboot EFI image consists of
>=20
> zImage.o, created with objcopy -O binary
> zboot-header.o, created using the assembler
> libstub.a, created as usual
>=20
> This results in errors such as
> arch/loongarch/boot/zboot-header.o: can't link different ABI object.
> failed to merge target specific data of file
> arch/loongarch/boot/zboot-header.o
>=20
> which I think is caused by the fact that objcopy does not set the LP64
> soft float flags on the ELF object it creates.
>=20
> Do you see any way around this limitation?

Update to Binutils-2.39
(https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3D83c5f3a)

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
