Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A621720A4E
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 22:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjFBUaH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 16:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjFBUaH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 16:30:07 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5893D1BE;
        Fri,  2 Jun 2023 13:30:02 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5659d85876dso23397147b3.2;
        Fri, 02 Jun 2023 13:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685737801; x=1688329801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNUQoopzu/4sZs0Dok8eUXcxEQzI9pr9YORM3E8m7co=;
        b=ar6lll9MQZ0WO8OLBy4TmLqLl2Q2Ec2Ent6TefN/LU59iz8UsMXlnw/APq6QxFofYN
         TgGjr/1wRCEmMuUFshiIetPsvgC1r1oCp0DdFwPX2GeVO2idqbobhPRHei85YYqKvsoR
         KUPKqSe4+xVj5/YspPFVsN48o6XWGEKE/yxmGDVCVrAYcPm3TRtChPIr4g8T+7yMegPo
         Sz2TdK75JTc19Ab12l6iKR/TKgMDG6/lQ8be6Mo1TvrmI65JQSSkA/gKh9BJBnDIwokL
         etVqBFpN1x3BEcjhL7wX63rI347aFDJaod5nUj54k+ZWLFPokj+twGw57K+oWISUx1Ao
         yDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685737801; x=1688329801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNUQoopzu/4sZs0Dok8eUXcxEQzI9pr9YORM3E8m7co=;
        b=T56aWFgtvLgkmUIjdr7h3lM5Bg1FrLPQOv56+YFBEMKW8Ydy1bquFnYhXX/uBACQCb
         MhITWyREvCN9LfDWFXpi2KLGFQ1Xg0t/99oaeDlm+BCOMTSXuIDJyVvuzI85cZPiwlCe
         VE6ZYpYjzhEzHoy0pXay8VN/jM03RxXIPsdVNznEsZzsVaBvpPPyM2+X29LT3ykUWUbS
         zwKnruq6oyaj3ZWXjmi1H9InjUhGtopm/TuBW22BdwTJGzjwxkWNKuTDsZsH9du1jvjB
         ncf22/sLURg5tkLWHqm3hUOcHuiNw7HSLT8YBUudx1KkOfyA7h10q0HgdYY1P89aM67t
         ge4w==
X-Gm-Message-State: AC+VfDwt4zTAg5qGCdj76CtKm+eahM1azH8y+nbc/xBUyP3ju4CCLvDS
        0dXhKkKn0ji3z/u0uMRoBX4U723r1YR4cE/cbWH2GqtDJZtnWw==
X-Google-Smtp-Source: ACHHUZ7NKTE9yJ3wsOkCBNWtimt/DfrAA2F2FS21e4VPCB9EcKbJ19lSY3Zf1Gm/AuQFNa9DBOaRBK/Jn7eUKAk/ymg=
X-Received: by 2002:a81:6044:0:b0:568:f405:cbfe with SMTP id
 u65-20020a816044000000b00568f405cbfemr1043665ywb.47.1685737800823; Fri, 02
 Jun 2023 13:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAG8fp8Te=oT1JJhTpOZvgWJrgcTq2DXan8UOVZ=KYCYNa8cKog@mail.gmail.com>
 <CAMj1kXG0q-pJEnvqJxxpecVqJcB2jk3rj7S4KNp728THM=de3Q@mail.gmail.com> <CAG8fp8Tnfb5tt3Eea4+=zznZLxBfqwha_wkQcPDvU4QhcSckEw@mail.gmail.com>
In-Reply-To: <CAG8fp8Tnfb5tt3Eea4+=zznZLxBfqwha_wkQcPDvU4QhcSckEw@mail.gmail.com>
From:   Akihiro Suda <suda.kyoto@gmail.com>
Date:   Sat, 3 Jun 2023 05:29:49 +0900
Message-ID: <CAG8fp8QbQqDVxEvzeyijbkfU5HoAwbRH0VptMK4-oPnJ7-0Ljg@mail.gmail.com>
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

> > I'll queue this as a fix, but I'm going to tweak the comment (and the
> > commit log) a bit, if you don't mind

Thank you for rewriting my comments, but the new comments seem
slightly incorrect:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D36e4fc57fc1619f462e669e939209c45763bc8f5

> efi: Bump stub image version for macOS HVF compatibility

The commit is about Virtualization.framework, not about
Hypervisor.framework (HVF).

Virtualization.framework =3D high-level VMM, similar to QEMU
(/usr/bin/qemu-system-*)
Hypervisor.framework     =3D low-level  VMM, similar to kvm.ko

> The macOS hypervisor framework includes a host-side VMM called VZLinuxBoo=
tLoader

VZLinuxBootLoader is a part of Virtualization.framework, not
Hypervisor.framework.
Also, VZLinuxBootLoader is not a VMM; it is just an API for loading
vmlinuz into Virtualization.framework.
(similar to the `-kernel` and the `-initrd` flags of QEMU)

> On x86, it incorporates a BIOS style loader that does not implement or ex=
pose EFI to the loaded kernel.

AFAICS, it does not seem to use real mode BIOS.



2023=E5=B9=B45=E6=9C=8829=E6=97=A5(=E6=9C=88) 9:51 Akihiro Suda <suda.kyoto=
@gmail.com>:
>
> > > The next version will be 7 (0b111).
> >
> > How so? If this is going to be a monotonically increasing sequence
> > after all, it is still not a bit mask, and this change defeats the
> > purpose.
>
> Sorry, I forgot to append ", if it will retain compatibility with 0b11".
>
> > I'll queue this as a fix, but I'm going to tweak the comment (and the
> > commit log) a bit, if you don't mind
>
> Thanks, please feel free to tweak that.
>
> > I'd appreciate it if you still report this as a bug with Apple, though.
>
> Reported via https://www.apple.com/feedback/macos.html
>
>
> 2023=E5=B9=B45=E6=9C=8829=E6=97=A5(=E6=9C=88) 3:48 Ard Biesheuvel <ardb@k=
ernel.org>:
> >
> > On Sun, 28 May 2023 at 09:59, Akihiro Suda <suda.kyoto@gmail.com> wrote=
:
> > >
> > > - LINUX_EFISTUB_MAJOR_VERSION is bumped from 1 (0b1) to 3 (0b11).
> > >   The value is now a bitfield.
> > >
> >
> > OK
> >
> > > The next version will be 7 (0b111).
> >
> > How so? If this is going to be a monotonically increasing sequence
> > after all, it is still not a bit mask, and this change defeats the
> > purpose.
> >
> > > - LINUX_EFISTUB_MINOR_VERSION is pinned to 0x0, because Apple's
> > >   VZLinuxBootLoader [1] cannot boot a kernel with other minor version=
 value [2],
> > >   even though it does not use UEFI. Tested with macOS 13.4 (x86_64).
> > >
> > > [1] https://developer.apple.com/documentation/virtualization/vzlinuxb=
ootloader
> > > [2] https://lore.kernel.org/linux-efi/CAG8fp8Teu4G9JuenQrqGndFt2Gy+V4=
YgJ=3DhN1xX7AD940YKf3A@mail.gmail.com/
> > >
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217485
> > > Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
> >
> > I'll queue this as a fix, but I'm going to tweak the comment (and the
> > commit log) a bit, if you don't mind
> >
> > I'd appreciate it if you still report this as a bug with Apple, though.
> >
> > Thanks,
> > Ard.
> >
> > > ---
> > >  include/linux/pe.h | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/pe.h b/include/linux/pe.h
> > > index 5e1e11540870..ee5ade19b7eb 100644
> > > --- a/include/linux/pe.h
> > > +++ b/include/linux/pe.h
> > > @@ -27,9 +27,25 @@
> > >   * On x86, LoadImage() and StartImage() can be omitted if the EFI ha=
ndover
> > >   * protocol is implemented, which can be inferred from the version,
> > >   * handover_offset and xloadflags fields in the bootparams structure=
.
> > > + *
> > > + * Linux EFI stub v1.1 unconditionally enabled initrd command line l=
oader,
> > > + * which was previously gated by CONFIG_EFI_GENERIC_STUB_INITRD_CMDL=
INE_LOADER.
> > > + *
> > > + * Linux EFI stub v3.0 changed the major version to be a bitfield (0=
b11).
> > > + * The rightmost bit means that it is compatible with v1.0 at least.
> > > + * The second rightmost bit means that initrd command line loader is=
 enabled.
> > > + * So, there is no v2.0 (0b10), and the next version will be v7.0 (0=
b111).
> > > + */
> > > +#define LINUX_EFISTUB_MAJOR_VERSION            0x3
> > > +
> > > +/*
> > > + * LINUX_EFISTUB_MINOR_VERSION is pinned to 0x0, because Apple's
> > > + * VZLinuxBootLoader cannot boot a kernel with other minor version v=
alue, even
> > > + * though it does not use UEFI. Tested with macOS 13.4 (x86_64).
> > > + *
> > > + * https://lore.kernel.org/linux-efi/CAG8fp8Teu4G9JuenQrqGndFt2Gy+V4=
YgJ=3DhN1xX7AD940YKf3A@mail.gmail.com/
> > >   */
> > > -#define LINUX_EFISTUB_MAJOR_VERSION            0x1
> > > -#define LINUX_EFISTUB_MINOR_VERSION            0x1
> > > +#define LINUX_EFISTUB_MINOR_VERSION            0x0
> > >
> > >  /*
> > >   * LINUX_PE_MAGIC appears at offset 0x38 into the MS-DOS header of E=
FI bootable
> > > --
> > > 2.39.2
