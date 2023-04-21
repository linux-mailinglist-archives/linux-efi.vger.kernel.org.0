Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157326EABB4
	for <lists+linux-efi@lfdr.de>; Fri, 21 Apr 2023 15:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjDUNak (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Apr 2023 09:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjDUNac (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Apr 2023 09:30:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BC813879
        for <linux-efi@vger.kernel.org>; Fri, 21 Apr 2023 06:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4AE76509C
        for <linux-efi@vger.kernel.org>; Fri, 21 Apr 2023 13:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A699C43442;
        Fri, 21 Apr 2023 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682083814;
        bh=YO6d67EbEIrwfwGswrgU2nyKSaXVyTYf4KivmoLToEA=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=OKoguNMDRXWsqDH85Wd6YHRwFi7PX0HoUXliL4bkLINnTSWwKgS+CF533kl1te64v
         SK0tW90TDAhc0w6jy9AOMz10yTkUjZBEhgJ7JLWLTuLcTceJ0OugCvaV53tDvrcmth
         qPtSKWTyeiiw7ZNQf91hBiMnTaw31+N0ZB/pvVTYr3bORhR+rndCU4aUuQZm/3s7Qf
         Mea7AwMybgvt7yy9bLPBVFcXwFgonukFUdebz9b69Cc4rBJs8Iy0OpzoiDmq+CPjyM
         Tjs/2wMFJWR7hTgtB/pY5Bw1IcVlcbgmP3FaIzHKcwM+lL8hLCK2WWWnlK+PDoGADN
         cg5N8RiORp1NQ==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 77BB527C0054;
        Fri, 21 Apr 2023 09:30:12 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Fri, 21 Apr 2023 09:30:12 -0400
X-ME-Sender: <xms:449CZAdZpUNuThKPDa60wH_9jRieBejZyh-Ms9VQ-piZ3wokcAB0mw>
    <xme:449CZCNOzcefcHZb4yk4ozepBKNHt_eGmGJmGnhuo1W_TQH3etvQaBsaWrXYJC4f2
    PVt2Cmr595SooW3IOI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtgedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeiteejleegjeekleegveeujeejvdehjeekveegudduudffueek
    jefffeeujeekhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlh
    huthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:449CZBgPQuAojblWS5oWwGnwOK4RyunvMkgkPoq1T0_S0PzxJD1BPg>
    <xmx:449CZF9ps9QKGudfrf44ammWiX-38yNyZq_op1hO9XrSYb2pusm4iQ>
    <xmx:449CZMv75oJZ-EAum1pMuUtVWyUpX3hmtkxtA2JlflFfSibIdB58sQ>
    <xmx:5I9CZAPYfOZm80Ex2CpcOxPQr7rb58n8nQO540lIJkDC6kYHJh17ZQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 98C2231A0063; Fri, 21 Apr 2023 09:30:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <5694ea5d-da9a-413e-9499-02a54588a953@app.fastmail.com>
In-Reply-To: <20230416120729.2470762-1-ardb@kernel.org>
References: <20230416120729.2470762-1-ardb@kernel.org>
Date:   Fri, 21 Apr 2023 06:29:51 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Ard Biesheuvel" <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Evgeniy Baskov" <baskov@ispras.ru>,
        "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Alexey Khoroshilov" <khoroshilov@ispras.ru>,
        "Peter Jones" <pjones@redhat.com>,
        "Gerd Hoffmann" <kraxel@redhat.com>,
        "Dave Young" <dyoung@redhat.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 0/3] efi: Implement generic zboot support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On Sun, Apr 16, 2023, at 5:07 AM, Ard Biesheuvel wrote:
> This series is a proof-of-concept that implements support for the EFI
> zboot decompressor for x86. It replaces the ordinary decompressor, and
> instead, performs the decompression, KASLR randomization and the 4/5
> level paging switch while running in the execution context of EFI.

I like the concept.  A couple high-level questions, since I haven=E2=80=99=
t dug into the code:

Could zboot and bzImage be built into the same kernel image?  That would=
 get this into distros, and eventually someone could modify the legacy p=
ath to switch to long mode and invoke zboot (because zboot surely doesn=E2=
=80=99t need actual UEFI =E2=80=94 just a sensible environment like what=
 UEFI provides.)

Does zboot set up BSS correctly?  I once went down a rabbit hole trying =
to get the old decompressor to jump into the kernel with BSS already usa=
ble and zeroed, and the result was an incredible mess =E2=80=94 IIRC the=
 decompressor does some in-place shenanigans that looked incompatible wi=
th handling BSS without a rewrite. And so we clear BSS in C after jumpin=
g to the kernel, which is gross.

=E2=80=94Andy

>
> This simplifies things substantially, and makes it straight-forward to
> abide by stricter future requirements related to the use of writable a=
nd
> executable memory under EFI, which will come into effect on x86 systems
> that are certified as being 'more secure', and ship with an even shini=
er
> Windows sticker.
>
> This is an alternative approach to the work being proposed by Evgeny [=
0]
> that makes rather radical changes to the existing decompressor, which
> has accumulated too many features already, e.g., related to confidenti=
al
> compute etc.
>
> EFI zboot images can be booted in two ways:
> - by EFI firmware, which loads and starts it as an ordinary EFI
>   application, just like the existing EFI stub (with which it shares
>   most of its code);
> - by a non-EFI loader that parses the image header for the compression
>   metadata, and decompresses the image into memory and boots it.
>
> Realistically, the second option is unlikely to ever be used on x86,
> given that it already has its existing bzImage, but the first option is
> a good choice for distros that target EFI boot only (and some distros
> switched to this format already for arm64). The fact that EFI zboot is
> implemented in the same way on arm64, RISC-V, LoongArch and [shortly]
> ARM helps with maintenance, not only of the kernel itself, but also the
> tooling around it relating to kexec, code signing, deployment, etc.
>
> Series can be pulled from [1], which contains some prerequisite patches
> that are only tangentially related.
>
> [0] https://lore.kernel.org/all/cover.1678785672.git.baskov@ispras.ru/
> [1]=20
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=3D=
efi-x86-zboot
>
> Cc: Evgeniy Baskov <baskov@ispras.ru>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>
> Ard Biesheuvel (3):
>   efi/libstub: x86: Split off pieces shared with zboot
>   efi/zboot: x86: Implement EFI zboot support
>   efi/zboot: x86: Clear NX restrictions on populated code regions
>
>  arch/x86/Makefile                              |  18 +-
>  arch/x86/include/asm/efi.h                     |  10 +
>  arch/x86/kernel/head_64.S                      |  15 +
>  arch/x86/zboot/Makefile                        |  29 +
>  drivers/firmware/efi/Kconfig                   |   2 +-
>  drivers/firmware/efi/libstub/Makefile          |  15 +-
>  drivers/firmware/efi/libstub/Makefile.zboot    |   2 +-
>  drivers/firmware/efi/libstub/efi-stub-helper.c |   3 +
>  drivers/firmware/efi/libstub/x86-stub.c        | 592 +---------------=
---
>  drivers/firmware/efi/libstub/x86-zboot.c       | 322 ++++++++++
>  drivers/firmware/efi/libstub/x86.c             | 612 ++++++++++++++++=
++++
>  drivers/firmware/efi/libstub/zboot.c           |   3 +-
>  drivers/firmware/efi/libstub/zboot.lds         |   5 +
>  13 files changed, 1031 insertions(+), 597 deletions(-)
>  create mode 100644 arch/x86/zboot/Makefile
>  create mode 100644 drivers/firmware/efi/libstub/x86-zboot.c
>  create mode 100644 drivers/firmware/efi/libstub/x86.c
>
> --=20
> 2.39.2
