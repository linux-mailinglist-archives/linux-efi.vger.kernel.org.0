Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A611368D1D1
	for <lists+linux-efi@lfdr.de>; Tue,  7 Feb 2023 09:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBGIyY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Feb 2023 03:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjBGIyW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Feb 2023 03:54:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E63D35246;
        Tue,  7 Feb 2023 00:54:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A28D0B816BF;
        Tue,  7 Feb 2023 08:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5416EC4339B;
        Tue,  7 Feb 2023 08:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675760057;
        bh=wQoSa+cN9MaWyWJWj8r9PVBuM2PT+IysPQrisWqXrdc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MkaayqP/8TANhZC+/LWDCSi3Uz/x3tB1Ar1a5GmjD0zS6HG3moUfqQ64xScRGNSdR
         qmHXj0yCLnECT9bsng6a0g6GJQZI0ieEmn+tG6RnCJD8N5rUeTg7FhlYbJrnqzwKu1
         U7qePb5l1SgcSAUp8jLdpfYC0Xd/bTJNL/RITsye2UMhD80pZ1UiBMEyXaI1TVAmwu
         WHyfJ7KK0ZEi/uthkZ3dynZdQIINton0UR/WkgGZy6yxe6Kjh3Sx5TaipmlKV2PZgJ
         jRoTamQdJ8TXMsHnsYm2NTfUl0moEY7pKGSmYbhCu5A6lK0FKkbYygBLdkBwO9soDf
         l16u6RETddS+g==
Received: by mail-lj1-f181.google.com with SMTP id g14so14763000ljh.10;
        Tue, 07 Feb 2023 00:54:17 -0800 (PST)
X-Gm-Message-State: AO0yUKVDw503zo6DQDeH6MxWY78bT1eLzHFLB9s5gGcNqeXzO8KA2vjh
        aKGABkarlYp2OHDin1I/H+3y6s2wuuOhDKXeVOo=
X-Google-Smtp-Source: AK7set/W2Xa8sm/iGjFWjSOJ+HNvFMdqB8e9+xK5AKMSyz04oDl5qInaH/nMsDu+G+S2wPvJ16vcUb815mDoZi/Pyiw=
X-Received: by 2002:a2e:2c09:0:b0:28b:9149:6291 with SMTP id
 s9-20020a2e2c09000000b0028b91496291mr330351ljs.142.1675760055379; Tue, 07 Feb
 2023 00:54:15 -0800 (PST)
MIME-Version: 1.0
References: <20230131040355.3116-1-justin.he@arm.com> <CAMj1kXFTUXgaENBSYh+cGCS3wFCFunf+auk3nKwHVJWiZ7crig@mail.gmail.com>
 <DBBPR08MB45383B479656BA18FEFFB7D5F7D09@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Y9lchEgyNGLKu/4R@zx2c4.com> <DBBPR08MB4538E2CE68BCBF15B9F0093AF7D69@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <DBBPR08MB4538A07A62DC4A10257B3277F7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAMj1kXFE7A0=+MA2tCtuwjeGMcc1hgzvDnEJy1xGE=fh9Kgc2Q@mail.gmail.com> <DBBPR08MB4538E402B7DC8C747252E22FF7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB4538E402B7DC8C747252E22FF7DB9@DBBPR08MB4538.eurprd08.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Feb 2023 09:54:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGKhWJii7Q7yQR9U+1F5Vo4SaVXVixNXeY4U0aZyrJBdA@mail.gmail.com>
Message-ID: <CAMj1kXGKhWJii7Q7yQR9U+1F5Vo4SaVXVixNXeY4U0aZyrJBdA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix boot hang issue on Ampere Emag server
To:     Justin He <Justin.He@arm.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 7 Feb 2023 at 09:49, Justin He <Justin.He@arm.com> wrote:
>
>
>
> > -----Original Message-----
> [..]
> > > The root cause of the hung IMO might be similar to commit
> > > 550b33cfd445296868a478e8413ffb2e963eed32
> > > Author: Ard Biesheuvel <ardb@kernel.org>
> > > Date:   Thu Nov 10 10:36:20 2022 +0100
> > >
> > >     arm64: efi: Force the use of SetVirtualAddressMap() on Altra
> > > machines
> > >
> > > Do you agree with the idea if I add Ampere =E2=80=9DeMAG=E2=80=9D mac=
hine into the
> > > list of Using SetVirtualAddressMap() forcibly?
> > >
> > > Please note that even in previous kernel patch, the efibootmgr -t 10
> > > will make kernel hung if I passed "efi=3Dnovamap" to the boot paramet=
er.
> > >
> >
> > Interesting. What does dmidecode return for the family in the type 1 re=
cord?
>
> # dmidecode |grep -i family
>         Family: eMAG
>         Family: ARMv8
>
> The full dmidecode log is at https://pastebin.com/M3MAJtUG
>

OK please try this:

diff --git a/drivers/firmware/efi/libstub/arm64.c
b/drivers/firmware/efi/libstub/arm64.c
index ff2d18c42ee74979..fae930dec82be7c6 100644
--- a/drivers/firmware/efi/libstub/arm64.c
+++ b/drivers/firmware/efi/libstub/arm64.c
@@ -22,7 +22,8 @@ static bool system_needs_vamap(void)
         * Ampere Altra machines crash in SetTime() if SetVirtualAddressMap=
()
         * has not been called prior.
         */
-       if (!type1_family || strcmp(type1_family, "Altra"))
+       if (!type1_family ||
+           (strcmp(type1_family, "Altra") && strcmp(type1_family, "eMAG"))=
)
                return false;

        efi_warn("Working around broken SetVirtualAddressMap()\n");
