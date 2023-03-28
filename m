Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09516CBB2F
	for <lists+linux-efi@lfdr.de>; Tue, 28 Mar 2023 11:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjC1JiO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Mar 2023 05:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjC1JiC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Mar 2023 05:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB51735
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 02:37:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3736061630
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 09:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983E2C433D2
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 09:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679996277;
        bh=5Yr30RWeJijlAfuhVihnhl6NvkXEXTKQDP3Cyh61sjg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jFfAwxJHuZF5dbKxFL0tzzSpOIWH5kJLFhSJnsQWueA62W4bz4+porKBTsCCyFU32
         h1G9MMgZtnEJb2/wA1khaaP8Pw+LRbzQZ+ycgjt2dVAxceeKEo02DKEBg3w+hLfxCv
         yhiS18fNSxzbLagNwNw53XiobvYwqmQF98efwEzOJBOocAsP8SaeiMgoKpjrbfMgiN
         GTfE8swUuGI1jaBPxQSNzBu83kOK0JtK9v5jcXRYfWxxV4Rd8h1pZci4PwjqFIsxLE
         YbzgH7rL8rKe8eFB9afe6CP0LXMpPEQprnKEApz9uNdabNS2UA1jf8EXIVhQFkrPek
         wAboLvb5Yze7A==
Received: by mail-lj1-f180.google.com with SMTP id a11so11808904lji.6
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 02:37:57 -0700 (PDT)
X-Gm-Message-State: AAQBX9eShxjqQrBA2G/Xw0EOUrdYML38M8FeCX/XxcrvmKQMLDfFFbWT
        0yGC355agRfY+DkLK+e1SMqqtWWNf+GhRAr1cSc=
X-Google-Smtp-Source: AKy350bdILxC4jBfLrqdn+ksXXXdsU7AQ9tKFtAOnPi0vueKadL2e7RLnRAF89OAz5HZ4IcHKCfI1FAYVuki4oJZmok=
X-Received: by 2002:a2e:84c1:0:b0:2a5:f850:c356 with SMTP id
 q1-20020a2e84c1000000b002a5f850c356mr1802995ljh.2.1679996275666; Tue, 28 Mar
 2023 02:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230327095123.20023-1-kernelfans@gmail.com> <CAMj1kXG-gz0R2pPcwoxkSBHD596tycucjuAgm4NXS7kwZib71Q@mail.gmail.com>
 <CAFgQCTuc7yshP8gUJ4XzRR23R5HqoQ02qkA_cvXJM9BXMXLsUw@mail.gmail.com>
 <CAMj1kXHuc0X2ChArtcecqAma5jZNyFhjpESB6s9c4NmgzE3o9Q@mail.gmail.com> <CAFgQCTt=yatTp9vHQa9wHxGJm-LZZ62acyuSkW+KnhVHAV=jQw@mail.gmail.com>
In-Reply-To: <CAFgQCTt=yatTp9vHQa9wHxGJm-LZZ62acyuSkW+KnhVHAV=jQw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Mar 2023 11:37:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFOejD-uP05V0L5u3dUPeZG7OYA89sHrV9XjzwnuZeYmg@mail.gmail.com>
Message-ID: <CAMj1kXFOejD-uP05V0L5u3dUPeZG7OYA89sHrV9XjzwnuZeYmg@mail.gmail.com>
Subject: Re: [PATCH] efi: zboot: Ensure zboot PIC
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-efi@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Mar 2023 at 11:32, Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Tue, Mar 28, 2023 at 3:58=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Tue, 28 Mar 2023 at 09:32, Pingfan Liu <kernelfans@gmail.com> wrote:
> > >
> > > On Mon, Mar 27, 2023 at 6:57=E2=80=AFPM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
> > > >
> > > > On Mon, 27 Mar 2023 at 11:51, Pingfan Liu <kernelfans@gmail.com> wr=
ote:
> > > > >
> > > > > Using objcopy to reform vmlinuz.efi.elf to vmlinuz.efi will not c=
onvey
> > > > > any relocation information. That means vmlinuz.efi is expected to=
 be
> > > > > PIC.
> > > > >
> > > > > At present, vmlinuz.efi is PIC. But it is better to adopt the sam=
e
> > > >
> > > > Why is it better?
> > > >
> > >
> > > I think except carefully coded with asm language, there is no
> > > guarantee which prevents the compiler from generating position
> > > dependent code.  Or is there any presumption here?
> > >
> >
> > All object files built under drivers/firmware/efi/libstub are scanned
> > for absolute relocations, and if any exist, the build is aborted.
> >
>
> Oh, I got the code piece now.  Thank you very much for pointing this
> out. And only if R_AARCH64_ABS64 is unavoidable, there is no need to
> ask the code to fix the relocation by itself.
>
> But one more question, there are many other "S+A" types of relocation,
> let's say R_AARCH64_ABS32 or R_AARCH64_LDST64_ABS_LO12_NC. It is also
> sensitive to the delta between loading and linking. Should all of them
> be excluded by the Makefile?
>

None of those can be used to relocate absolute addresses, so these are
not the ones we should care about.

There are the ones related to the GOT, which could result in GOT
entries in the final executable with R_AARCH64_RELATIVE relocations.
However, we use 'hidden' visibility for all codegen related to the EFI
stub, so the compiler knows all symbol references can be resolved at
link time. This means that under -fpic or -fpie, it will always use
relative references.


> > > > > solution used by the kernel to resolve the code relocation issue =
by
> > > > > itself. That is to resolve R_AARCH64_RELATIVE at the runtime.
> > > > >
> > > >
> > > > This breaks other architectures.
> > > >
> > >
> > > Oops, could it be done by:
> > > #if defined(_aarch64_)
> > > #define R_ARCH_RELATIVE R_AARCH64_RELATIVE
> > > #else
> > > #define R_ARCH_RELATIVE 0
> > > #endif
> > >
> > > Since any r_type equaling 0 can not be ejected into the relocation
> > > section, this macro will make the code dummy in essential.
> > >
> >
> > So the assembler instructions you are using are also implemented on
> > RISC-V and LoongArch?
>
> Oops. The whole file should be arch dependent. In those cases, they
> should be a single jump instruction.
>
> Appreciate for your help.
>
> Thanks,
>
>     Pingfan
