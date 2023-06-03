Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F662720FA5
	for <lists+linux-efi@lfdr.de>; Sat,  3 Jun 2023 12:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjFCKux (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 3 Jun 2023 06:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjFCKuw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 3 Jun 2023 06:50:52 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFA3E72;
        Sat,  3 Jun 2023 03:50:27 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-568ba7abc11so34332937b3.3;
        Sat, 03 Jun 2023 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685789426; x=1688381426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhk+FTHFrBmjng1l4FaLO0XbEr20/z5NnN2R+/a0y9I=;
        b=WICmglInHtpq/+1zPVqjaftbQw+OxUIfaE4lJknx8UhWFdMk6shN0NrIdXU6wol1rv
         LdMhT11VDRynM0gW526UFDGKPRH3zdh/pbkWN8sbGQBOcMksFL5jKDtX7pZZKke3yrmd
         MStDArC2bBafPEXIHm+U2HECM8/+ZSAPiU4YJrvwELU7JCCzYh+J+gW26DdPIZIqA6J0
         Uq96vdv+939hFTIik/g7vydyar8M1XrJiHXVMSQCTOB2kSJkG3e72mfoPPbxRXuOMRfh
         uJyTxMZ5TG2Mjo6N3Pu/ZkaAV9UGP0t6MQ/5Lg3RbVFM0kEYlxOB02Y0GHxSuLm0d2v5
         UsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685789426; x=1688381426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhk+FTHFrBmjng1l4FaLO0XbEr20/z5NnN2R+/a0y9I=;
        b=XsxTxvXJStF/9+v0R56FVw1uKPIeQ5FjLFf9SMBjZYOpywIBdUKeGXa6cstdJCTA3A
         qpbpkYu+YvSUYbBdbeHKpD5upvFxSB9mLwhZICiaGBDb+PkKOHl9+PqyQCKWJGs3BNJm
         ARxT8C/Pypf76nLGxMDnFxbu8SEnFX7u7PnWCjztaqehXmyQV1hRCaZg5sWf2oglOIzx
         +nLNYmP9bVKnemw3RPqIN8tIGiZTsf9uGV28aWRbqeQfJdLlVtV8ipluqbz8EZHpS1Wt
         O2l3jPaaJ6sI5nsmAB+6hqFVii3A8kA7RABGrysKgY9I823WL7IfXRYZWuqrwO2uomH8
         XGGQ==
X-Gm-Message-State: AC+VfDz1oOnXzf4aClG5EkH3vAlUu+Szl7UqDDGc781It6dJrrIwRwcF
        yDU/W3ecgy+iZWVBq1NOXcK6HQfndrEnRRg0KPM=
X-Google-Smtp-Source: ACHHUZ6Vd6CnsBPqP7aYagxKWt3Oc7qkiNmhBQY7PH9Ghde129d1hiugljj6y4m1+yZwz56Pmb5G1R9sGTjbFd8a6b8=
X-Received: by 2002:a81:d34d:0:b0:565:9a3d:a3f9 with SMTP id
 d13-20020a81d34d000000b005659a3da3f9mr4329111ywl.9.1685789426424; Sat, 03 Jun
 2023 03:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAG8fp8Te=oT1JJhTpOZvgWJrgcTq2DXan8UOVZ=KYCYNa8cKog@mail.gmail.com>
 <CAMj1kXG0q-pJEnvqJxxpecVqJcB2jk3rj7S4KNp728THM=de3Q@mail.gmail.com>
 <CAG8fp8Tnfb5tt3Eea4+=zznZLxBfqwha_wkQcPDvU4QhcSckEw@mail.gmail.com>
 <CAG8fp8QbQqDVxEvzeyijbkfU5HoAwbRH0VptMK4-oPnJ7-0Ljg@mail.gmail.com> <CAMj1kXHAt69QqFdZDOTFKNLvAYuY9cwrVFgE+eDNZ8FSQA-45w@mail.gmail.com>
In-Reply-To: <CAMj1kXHAt69QqFdZDOTFKNLvAYuY9cwrVFgE+eDNZ8FSQA-45w@mail.gmail.com>
From:   Akihiro Suda <suda.kyoto@gmail.com>
Date:   Sat, 3 Jun 2023 19:50:15 +0900
Message-ID: <CAG8fp8TXA2UG+tS8F5KhSW7Xi1o7oHk0kQTs=Z8JpDU5VStjfQ@mail.gmail.com>
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

> > > On x86, it incorporates a BIOS style loader that does not implement o=
r expose EFI to the loaded kernel.
> >
> > AFAICS, it does not seem to use real mode BIOS.
> >
>
> I never mentioned real mode, did I?

Sorry, I just misinterpreted "BIOS style loader".

2023=E5=B9=B46=E6=9C=883=E6=97=A5(=E5=9C=9F) 7:52 Ard Biesheuvel <ardb@kern=
el.org>:
>
> On Fri, 2 Jun 2023 at 22:30, Akihiro Suda <suda.kyoto@gmail.com> wrote:
> >
> > > > I'll queue this as a fix, but I'm going to tweak the comment (and t=
he
> > > > commit log) a bit, if you don't mind
> >
> > Thank you for rewriting my comments, but the new comments seem
> > slightly incorrect:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D36e4fc57fc1619f462e669e939209c45763bc8f5
> >
> > > efi: Bump stub image version for macOS HVF compatibility
> >
> > The commit is about Virtualization.framework, not about
> > Hypervisor.framework (HVF).
> >
> > Virtualization.framework =3D high-level VMM, similar to QEMU
> > (/usr/bin/qemu-system-*)
> > Hypervisor.framework     =3D low-level  VMM, similar to kvm.ko
> >
> > > The macOS hypervisor framework includes a host-side VMM called VZLinu=
xBootLoader
> >
> > VZLinuxBootLoader is a part of Virtualization.framework, not
> > Hypervisor.framework.
> > Also, VZLinuxBootLoader is not a VMM; it is just an API for loading
> > vmlinuz into Virtualization.framework.
> > (similar to the `-kernel` and the `-initrd` flags of QEMU)
> >
>
> Apologies for these mistakes. Unfortunately, this patch has been
> merged now so there is nothing we can do about it.
>
> > > On x86, it incorporates a BIOS style loader that does not implement o=
r expose EFI to the loaded kernel.
> >
> > AFAICS, it does not seem to use real mode BIOS.
> >
>
> I never mentioned real mode, did I?
