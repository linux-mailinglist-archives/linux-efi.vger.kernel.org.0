Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C868D714169
	for <lists+linux-efi@lfdr.de>; Mon, 29 May 2023 02:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjE2AvW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 May 2023 20:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE2AvW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 May 2023 20:51:22 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C69BB;
        Sun, 28 May 2023 17:51:20 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-565ba2c7554so18931407b3.3;
        Sun, 28 May 2023 17:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685321480; x=1687913480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSHgw3noI0eZWKZ+3dsLQ9cv+/CKYVf+MoUH5NF6B8w=;
        b=D0b9oeooY4esvuzZltWoU6SygJU5jz7FBKXPIk9VXkls0mrteYXEqO61mwwuWSGMk4
         /u2WexXATM5lLSiXiZ1hyh+Hj02IKbcorPN3HgDra9P9uokFOTTXd2iEQBqR8qRKTGAW
         /vXjMV8o7cmEbd0ndEP7g1auY8UCwU8ugiQv6f07bGtiba/ilnYfYu58yJyav0UnTzAV
         +w6HkiOQyj7FhHTukk8pa+kxYJx52De9rJeR8/AccLpVzPCVrTsIjVzK7yOTmdd0KhTE
         aQsYvvdmfCBqg91mOSRCwC5u+GGzEq1CHTLGj7Ji4wB6CNiRftE1cOy6l7hRFDaCTGzJ
         r5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685321480; x=1687913480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSHgw3noI0eZWKZ+3dsLQ9cv+/CKYVf+MoUH5NF6B8w=;
        b=f0dzKIyIQHWagPaY15RGfgM8sD1/BpR/bvkDrfuVzi5f7mt0EYtYsQQ7ejleFyHdal
         5hh1zLn5uCWtHdSMitDkKzuvgHwWN+WEwfvEUt7XqV+tY1m1W6nFrDNDpOp04dS73UOo
         tD6nkomtovzKCp3HBqDE7lUHqE3xOhp9Ncx/OZGH24sSd4txe4OCoAcHUZ+8PIMWYzbk
         Ip+yWxM/IhQrPc3XdFp7V/9HeU6QtJA6kwSFWCVgvwwRyzHrHQ5+systVdftxrVwUoCd
         L01bLkwfpMdL0Fh+dihfFU7dnTXsYZRhgI8V2BM28DWdk0KivTp3zCtTEJxtUcFRq9Y/
         114A==
X-Gm-Message-State: AC+VfDzPj5frNu4oX+iJ5XGrmjSErfgP3eoShapLLge50+B0O3TX0xCi
        yuuZFm1vuVCiyxpun+L2vDqPSj711/HvYwIFS5LlvodugrHX6g==
X-Google-Smtp-Source: ACHHUZ6x02o1dpI3u2xKaByENrgPOBCjPWuPYO3bc4AEDMrHOdswttmuiOTCSTu2occzo3gYeXkTkGok5/TfqiRG1Zo=
X-Received: by 2002:a81:4806:0:b0:561:b5b4:ce58 with SMTP id
 v6-20020a814806000000b00561b5b4ce58mr10358382ywa.38.1685321479714; Sun, 28
 May 2023 17:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAG8fp8Te=oT1JJhTpOZvgWJrgcTq2DXan8UOVZ=KYCYNa8cKog@mail.gmail.com>
 <CAMj1kXG0q-pJEnvqJxxpecVqJcB2jk3rj7S4KNp728THM=de3Q@mail.gmail.com>
In-Reply-To: <CAMj1kXG0q-pJEnvqJxxpecVqJcB2jk3rj7S4KNp728THM=de3Q@mail.gmail.com>
From:   Akihiro Suda <suda.kyoto@gmail.com>
Date:   Mon, 29 May 2023 09:51:08 +0900
Message-ID: <CAG8fp8Tnfb5tt3Eea4+=zznZLxBfqwha_wkQcPDvU4QhcSckEw@mail.gmail.com>
Subject: Re: [PATCH] efi: bump efistub version from 1.1 to 3.0 for
 VZLinuxBootLoader compatibility
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org, Linux x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> > The next version will be 7 (0b111).
>
> How so? If this is going to be a monotonically increasing sequence
> after all, it is still not a bit mask, and this change defeats the
> purpose.

Sorry, I forgot to append ", if it will retain compatibility with 0b11".

> I'll queue this as a fix, but I'm going to tweak the comment (and the
> commit log) a bit, if you don't mind

Thanks, please feel free to tweak that.

> I'd appreciate it if you still report this as a bug with Apple, though.

Reported via https://www.apple.com/feedback/macos.html


2023=E5=B9=B45=E6=9C=8829=E6=97=A5(=E6=9C=88) 3:48 Ard Biesheuvel <ardb@ker=
nel.org>:
>
> On Sun, 28 May 2023 at 09:59, Akihiro Suda <suda.kyoto@gmail.com> wrote:
> >
> > - LINUX_EFISTUB_MAJOR_VERSION is bumped from 1 (0b1) to 3 (0b11).
> >   The value is now a bitfield.
> >
>
> OK
>
> > The next version will be 7 (0b111).
>
> How so? If this is going to be a monotonically increasing sequence
> after all, it is still not a bit mask, and this change defeats the
> purpose.
>
> > - LINUX_EFISTUB_MINOR_VERSION is pinned to 0x0, because Apple's
> >   VZLinuxBootLoader [1] cannot boot a kernel with other minor version v=
alue [2],
> >   even though it does not use UEFI. Tested with macOS 13.4 (x86_64).
> >
> > [1] https://developer.apple.com/documentation/virtualization/vzlinuxboo=
tloader
> > [2] https://lore.kernel.org/linux-efi/CAG8fp8Teu4G9JuenQrqGndFt2Gy+V4Yg=
J=3DhN1xX7AD940YKf3A@mail.gmail.com/
> >
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217485
> > Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
>
> I'll queue this as a fix, but I'm going to tweak the comment (and the
> commit log) a bit, if you don't mind
>
> I'd appreciate it if you still report this as a bug with Apple, though.
>
> Thanks,
> Ard.
>
> > ---
> >  include/linux/pe.h | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/pe.h b/include/linux/pe.h
> > index 5e1e11540870..ee5ade19b7eb 100644
> > --- a/include/linux/pe.h
> > +++ b/include/linux/pe.h
> > @@ -27,9 +27,25 @@
> >   * On x86, LoadImage() and StartImage() can be omitted if the EFI hand=
over
> >   * protocol is implemented, which can be inferred from the version,
> >   * handover_offset and xloadflags fields in the bootparams structure.
> > + *
> > + * Linux EFI stub v1.1 unconditionally enabled initrd command line loa=
der,
> > + * which was previously gated by CONFIG_EFI_GENERIC_STUB_INITRD_CMDLIN=
E_LOADER.
> > + *
> > + * Linux EFI stub v3.0 changed the major version to be a bitfield (0b1=
1).
> > + * The rightmost bit means that it is compatible with v1.0 at least.
> > + * The second rightmost bit means that initrd command line loader is e=
nabled.
> > + * So, there is no v2.0 (0b10), and the next version will be v7.0 (0b1=
11).
> > + */
> > +#define LINUX_EFISTUB_MAJOR_VERSION            0x3
> > +
> > +/*
> > + * LINUX_EFISTUB_MINOR_VERSION is pinned to 0x0, because Apple's
> > + * VZLinuxBootLoader cannot boot a kernel with other minor version val=
ue, even
> > + * though it does not use UEFI. Tested with macOS 13.4 (x86_64).
> > + *
> > + * https://lore.kernel.org/linux-efi/CAG8fp8Teu4G9JuenQrqGndFt2Gy+V4Yg=
J=3DhN1xX7AD940YKf3A@mail.gmail.com/
> >   */
> > -#define LINUX_EFISTUB_MAJOR_VERSION            0x1
> > -#define LINUX_EFISTUB_MINOR_VERSION            0x1
> > +#define LINUX_EFISTUB_MINOR_VERSION            0x0
> >
> >  /*
> >   * LINUX_PE_MAGIC appears at offset 0x38 into the MS-DOS header of EFI=
 bootable
> > --
> > 2.39.2
