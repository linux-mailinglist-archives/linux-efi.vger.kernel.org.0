Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C81B7A1FBF
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 15:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbjIONWd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 09:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjIONWc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 09:22:32 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF4F30D3
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 06:21:48 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-41761e9181eso250751cf.1
        for <linux-efi@vger.kernel.org>; Fri, 15 Sep 2023 06:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694784107; x=1695388907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQik1sImnP3JtDcAUVKtHO2B2JhgasNq9FvI7Jv8Wqk=;
        b=hZrphL8DPTEGN7qAAAhqLE8+4x4H2fDUQAuAkFd9V8k/T8ibASLW+okXtt2S0rHlry
         6TyLq1FWg7qaouQXhKktUsR0Sb2kalOe2dQjobYhoXtefI60zivG1s31hgkTDzoB5Yxl
         1L4VYwjra8NLaGJ4STo6zk+Efbslir5MGdyNxfBApnXjVwhmCMIAvwF0Yye8uwQgdRQh
         RdpMh91/hOgZvWPSOt+/JaRkQTDZlBe2PmZqt+Gu2qm2QO+g4790Dscw6U7zi/hdcLR5
         PQCpfO+nSx9Upd0Gx9xLuqkNH+IDoWcYAKYdJPC/mYFxpWqZUxVGJPHrhzGEjHrEVJez
         nKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784107; x=1695388907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQik1sImnP3JtDcAUVKtHO2B2JhgasNq9FvI7Jv8Wqk=;
        b=UdTaEEIj579xnOauaX5Q/eFgloY6OmkiIWwxYATZ/isZ5IrbAA5CTH4QUiqS8XQ7wB
         eSfzi621exOTvl5PSdbmyB0qEg9G72efznozpOSgnW827nP8cHkM2MXjNReXtsD2uylY
         5llvf/1Q3ijQ/Ysr/tv1Hhk1PJ1Ghz54N3bwiLQhQpbg/nb7iZtM+5rj64RE3DVe4i9S
         AKD0otZ+AdlrMe/EEyWjxUsZXX8XEw/uEX94AGOA4WgIAFg5l4FtP5wzJLsxVBLFtNl+
         lUSxMl2JT1KT93bwEVwCUzk8pXu+wb6C5LzGBZJQ3WUGZM0gTvlNrM/eKpww3dHFDIcI
         xTcA==
X-Gm-Message-State: AOJu0YwbCvWnQc1cPQJFeN+NCPQfgZjAiHdzJggUNNx7l7bq2zedeTvy
        6h9Xf9cFxYXuk0FJgbIbvhJwyLg3jLoshxSAkKHOYA==
X-Google-Smtp-Source: AGHT+IEQu5D6irDVWU7e+S2C9j3gtbNyXsRlrL8KmuOpuqyhVi1cnfZwaAM9GgbgpDlteEZdm9a6WBLXqXQHJn8nkOA=
X-Received: by 2002:ac8:4e51:0:b0:3de:1aaa:42f5 with SMTP id
 e17-20020ac84e51000000b003de1aaa42f5mr218397qtw.15.1694784107649; Fri, 15 Sep
 2023 06:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230912090051.4014114-17-ardb@google.com> <ZQQiUxh5vmeZnp7s@gmail.com>
 <ZQRAckHVxQZRNEGA@gmail.com>
In-Reply-To: <ZQRAckHVxQZRNEGA@gmail.com>
From:   Ard Biesheuvel <ardb@google.com>
Date:   Fri, 15 Sep 2023 15:21:36 +0200
Message-ID: <CAGnOC3Zw49_30FkGY=RRLn-sCHNgFY_T0ugNJZCgg_T3opHm+Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] x86/boot: Rework PE header generation
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 15, 2023 at 1:31=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> > > Ard Biesheuvel (15):
> > >   x86/efi: Drop EFI stub .bss from .data section
> > >   x86/efi: Disregard setup header of loaded image
> > >   x86/efi: Drop alignment flags from PE section headers
> > >   x86/boot: Remove the 'bugger off' message
> > >   x86/boot: Omit compression buffer from PE/COFF image memory footpri=
nt
> > >   x86/boot: Drop redundant code setting the root device
> > >   x86/boot: Grab kernel_info offset from zoffset header directly
> > >   x86/boot: Drop references to startup_64
> >
> > I've applied these first 8 patches to tip:x86/boot with minor edits.

Thanks.

> > (Please preserve existing comment capitalization conventions ...)
> >

Ack

> > >   x86/boot: Set EFI handover offset directly in header asm
> > >   x86/boot: Define setup size in linker script
> > >   x86/boot: Derive file size from _edata symbol
> > >   x86/boot: Construct PE/COFF .text section from assembler
> > >   x86/boot: Drop PE/COFF .reloc section
> > >   x86/boot: Split off PE/COFF .data section
> > >   x86/boot: Increase section and file alignment to 4k/512
> >
> > The rest conflicted with recent upstream changes, and I suppose it's
> > prudent to test these changes bit by bit anyway.
>

Agreed. So you mean this conflicts with other stuff queued up in -tip
already, right?

> So, the first 8 patches broke the x86-64-defconfig-ish Qemu bzImage bootu=
p,
> due to the 8th patch:
>
>   988b52b207a9fe74c3699bda8c2256714926b94b is the first bad commit
>   commit 988b52b207a9fe74c3699bda8c2256714926b94b
>   Author: Ard Biesheuvel <ardb@kernel.org>
>   Date:   Tue Sep 12 09:01:01 2023 +0000
>
>       x86/boot: Define setup size in linker script
>
> I've removed it for now - but this side effect was not expected.
>

No, definitely not expected. I tested various combinations of i386 /
x86_64 built with GCC / Clang doing EFI or BIOS boot.

I'll rebase the remaining stuff onto -tip and see if I can reproduce this.
