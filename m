Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57395A3D01
	for <lists+linux-efi@lfdr.de>; Sun, 28 Aug 2022 11:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiH1Jod (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Aug 2022 05:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiH1Jod (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Aug 2022 05:44:33 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1497124F22
        for <linux-efi@vger.kernel.org>; Sun, 28 Aug 2022 02:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661679869;
        bh=XMIgWTZajiVi1DuydJMDFKkU+arFT2Ctire9oFavhDA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GkB5sVfg4uq6Hs+qV+9NdXqrVuepUczTsBW7T2RduW9KzKmqvhViKgGv4yf+338Fl
         nEQg6AnoNP9CK/ThP2oviiQ4gA7Jo4a/hx+0cvnpwsZAXIAEn5knZdt3A3pXth8nd9
         G4qgIQj9GHb97+x41K43URzpKaw0QbgIXApQUkG0=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 0A6F065926;
        Sun, 28 Aug 2022 05:44:25 -0400 (EDT)
Message-ID: <00a60dc58fe182782fdc8ef834323414232104fb.camel@xry111.site>
Subject: Re: [PATCH v4 8/9] loongarch: avoid orphan input sections
From:   Xi Ruoyao <xry111@xry111.site>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     =?gb2312?Q?=B3=C2=BB=AA=B2=C5?= <chenhuacai@loongson.cn>,
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
Date:   Sun, 28 Aug 2022 17:44:24 +0800
In-Reply-To: <CAMj1kXGHLans85vpGzY6FbdW0w5DZ0uqT7eEk2yava=udUHY1w@mail.gmail.com>
References: <20220827083850.2702465-1-ardb@kernel.org>
         <20220827083850.2702465-9-ardb@kernel.org>
         <7aa14d72.3a4f.182deccc341.Coremail.chenhuacai@loongson.cn>
         <CAMj1kXG4CXUEtx9r=r-sOyU6cUmDaknKqu3_W_FUQ+_gpdLzXg@mail.gmail.com>
         <adb55eda511ad6de85936dd37f584687a22e7437.camel@xry111.site>
         <CAMj1kXGHLans85vpGzY6FbdW0w5DZ0uqT7eEk2yava=udUHY1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 2022-08-28 at 11:36 +0200, Ard Biesheuvel wrote:
> But does the ELF psABI for LoongArch describe L_ARCH_NONE as a dynamic
> relocation? .rela.dyn typically only contains relocations that are
> specified as being suitable for runtime relocation.

In Binutils 2.39 the BFD linker often over-estimate the size of .rela.*.
For example if there is only 42 relocations, it may allocate the space
for 47 relocations and fill the unused space in the section with zero.=20
Then 5 R_LARCH_NONE will appear.

This has already caused trouble when we reviewed LoongArch glibc port,
but at last the reviewers considered using NONE relocations as a
"padding" acceptable.  So in glibc ld.so will treat R_LARCH_NONE as a
"dynamic" relocation with no real effect.

The issue (or "bug", if we want a more serious term) seems fixed in
Binutils trunk, but I've not rebuilt the entire system with it so I'm
not sure if it's completely fixed.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
