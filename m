Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2316CD48A
	for <lists+linux-efi@lfdr.de>; Wed, 29 Mar 2023 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjC2IZl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Mar 2023 04:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjC2IZ1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Mar 2023 04:25:27 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B134239
        for <linux-efi@vger.kernel.org>; Wed, 29 Mar 2023 01:24:54 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-544f7c176easo279431797b3.9
        for <linux-efi@vger.kernel.org>; Wed, 29 Mar 2023 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680078294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njnvUp1zVukTipjucCz0aTrvGmsl6IFrKCMEBeNtAgs=;
        b=SrcnStE6pOZlEPxu25CEpPqYSu6eZIHaSvH59n9X1cn0P3ji8BO4/6/Y/nyAn5B3sN
         aIURbkyJfMUKArpKF0yQ/WnXREN2hp3rB0k44f2+1xanZx7f+M9iMo/Q8kjzDK5/zZQz
         aJdvJBoQIAbPz09cu3H0cj3i4EW4UzWpBf/YxOo0pf6toJE8z9KjJHa17+qxzMMvDNOG
         1Ke9XgU91YsCxARXSAZAlisab16RWgpp03Ch9JFKyrOZwKGbtEjKJty9jDBFBfgWeqJc
         iIISVjdoy/5hIv21v8m46/vcE38tOk8fLaJf+lIwJoHazFxoGkVl5/Kt2dwJs/nQoDGP
         qM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680078294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njnvUp1zVukTipjucCz0aTrvGmsl6IFrKCMEBeNtAgs=;
        b=ciuE094lcCj7X6EmA72aicE7tSX/W4fIyeQJfv4OgEcy0j7VjAJK/pOubkshhX44Go
         27h5pqymxdjlGFFvdPXudGpALThvcc5Xl7YEjbmqFwEGWlVxAuokSIBgF/IZTyUG6OF+
         CMuel5GK2TrQAPwxkAiI3LR9z5pAOVgdxFOdbEPS5cQV2MFK2u2dxa6CYWKPlNwVi0jA
         ekFOxk1+8hwDBR+J4q85wUzpwxm4WcY6h2V3DqxD1ikSY7AgXaD64athLOQNKXThZUwU
         wv5kVb68QaJw6mHYmZw/SXn28kXczs3VKXepCAnMh5+PSCxNvqgHD9zPeQqhnm7g7AyH
         vNZQ==
X-Gm-Message-State: AAQBX9cSXfD4vs2HBvmeY8v2WUa1ZoESwES3TYsPS86lxHc+ZBjQT242
        BCFbIUuB2ZTaqlFt6LwR4Wvx/uRse9hUnzRSbw==
X-Google-Smtp-Source: AKy350YOynZPXiuyWm2VjQetrjkBDID3Ou0r30PZkf55ruN0R1RHfWrT+btrUkU2K+59yWrqyFetGQp93kk2kpraaSs=
X-Received: by 2002:a81:ad21:0:b0:545:62cb:3bcf with SMTP id
 l33-20020a81ad21000000b0054562cb3bcfmr9070700ywh.2.1680078294021; Wed, 29 Mar
 2023 01:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230327095123.20023-1-kernelfans@gmail.com> <CAMj1kXG-gz0R2pPcwoxkSBHD596tycucjuAgm4NXS7kwZib71Q@mail.gmail.com>
 <CAFgQCTuc7yshP8gUJ4XzRR23R5HqoQ02qkA_cvXJM9BXMXLsUw@mail.gmail.com>
 <CAMj1kXHuc0X2ChArtcecqAma5jZNyFhjpESB6s9c4NmgzE3o9Q@mail.gmail.com>
 <CAFgQCTt=yatTp9vHQa9wHxGJm-LZZ62acyuSkW+KnhVHAV=jQw@mail.gmail.com> <CAMj1kXFOejD-uP05V0L5u3dUPeZG7OYA89sHrV9XjzwnuZeYmg@mail.gmail.com>
In-Reply-To: <CAMj1kXFOejD-uP05V0L5u3dUPeZG7OYA89sHrV9XjzwnuZeYmg@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 29 Mar 2023 16:24:42 +0800
Message-ID: <CAFgQCTsCQWbw+ezJTZaHLf93VVTRHt5UXSk7LJXhSVNeMo4zDA@mail.gmail.com>
Subject: Re: [PATCH] efi: zboot: Ensure zboot PIC
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Mar 28, 2023 at 5:37=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Tue, 28 Mar 2023 at 11:32, Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On Tue, Mar 28, 2023 at 3:58=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
> > > On Tue, 28 Mar 2023 at 09:32, Pingfan Liu <kernelfans@gmail.com> wrot=
e:
> > > >
> > > > On Mon, Mar 27, 2023 at 6:57=E2=80=AFPM Ard Biesheuvel <ardb@kernel=
.org> wrote:
> > > > >
> > > > > On Mon, 27 Mar 2023 at 11:51, Pingfan Liu <kernelfans@gmail.com> =
wrote:
> > > > > >
> > > > > > Using objcopy to reform vmlinuz.efi.elf to vmlinuz.efi will not=
 convey
> > > > > > any relocation information. That means vmlinuz.efi is expected =
to be
> > > > > > PIC.
> > > > > >
> > > > > > At present, vmlinuz.efi is PIC. But it is better to adopt the s=
ame
> > > > >
> > > > > Why is it better?
> > > > >
> > > >
> > > > I think except carefully coded with asm language, there is no
> > > > guarantee which prevents the compiler from generating position
> > > > dependent code.  Or is there any presumption here?
> > > >
> > >
> > > All object files built under drivers/firmware/efi/libstub are scanned
> > > for absolute relocations, and if any exist, the build is aborted.
> > >
> >
> > Oh, I got the code piece now.  Thank you very much for pointing this
> > out. And only if R_AARCH64_ABS64 is unavoidable, there is no need to
> > ask the code to fix the relocation by itself.
> >
> > But one more question, there are many other "S+A" types of relocation,
> > let's say R_AARCH64_ABS32 or R_AARCH64_LDST64_ABS_LO12_NC. It is also
> > sensitive to the delta between loading and linking. Should all of them
> > be excluded by the Makefile?
> >
>
> None of those can be used to relocate absolute addresses, so these are
> not the ones we should care about.
>
> There are the ones related to the GOT, which could result in GOT
> entries in the final executable with R_AARCH64_RELATIVE relocations.
> However, we use 'hidden' visibility for all codegen related to the EFI
> stub, so the compiler knows all symbol references can be resolved at
> link time. This means that under -fpic or -fpie, it will always use
> relative references.
>

Appreciate for the elaboration. I got the whole story now.

Thanks,

    Pingfan

>
> > > > > > solution used by the kernel to resolve the code relocation issu=
e by
> > > > > > itself. That is to resolve R_AARCH64_RELATIVE at the runtime.
> > > > > >
> > > > >
> > > > > This breaks other architectures.
> > > > >
> > > >
> > > > Oops, could it be done by:
> > > > #if defined(_aarch64_)
> > > > #define R_ARCH_RELATIVE R_AARCH64_RELATIVE
> > > > #else
> > > > #define R_ARCH_RELATIVE 0
> > > > #endif
> > > >
> > > > Since any r_type equaling 0 can not be ejected into the relocation
> > > > section, this macro will make the code dummy in essential.
> > > >
> > >
> > > So the assembler instructions you are using are also implemented on
> > > RISC-V and LoongArch?
> >
> > Oops. The whole file should be arch dependent. In those cases, they
> > should be a single jump instruction.
> >
> > Appreciate for your help.
> >
> > Thanks,
> >
> >     Pingfan
