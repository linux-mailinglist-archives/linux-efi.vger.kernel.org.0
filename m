Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403B66CB8D8
	for <lists+linux-efi@lfdr.de>; Tue, 28 Mar 2023 09:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjC1H6x (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Mar 2023 03:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjC1H6w (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Mar 2023 03:58:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0495E10EA
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 00:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B91B9B80FEA
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 07:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C73AC433A7
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 07:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679990329;
        bh=TuujEr+DY8MhAo9rb0JdVpVU0WHQVSx5Y9CkDIjJVvE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fn2FpSATm+t8huxcz9djN83x9vVeruE62jghqZRscunMTxqtPIuwiKOKopHupMFpm
         cPzm3rc2BfkuQHxZEehJUglaYxykQ1dDklxtay5005QPd0hH1en/eL1EGBTKw63fRf
         Q97oHiL2R7+KXZ1EnKnBPrsSq9IolKLbTZjjDz6VYSvt+FvSEil1mF/zCQeyc7040K
         QuwmgT4nZnGC8nbwd1HMHyORZ9QpMOT1dP5eb9nH3mCcDQ7r5xhHi9EPlgYDz6zmwD
         MO0Rl5TtazgCV3R+M5OAEmetXBnSxuusat/gGP8PkBpQCL4R0OvfvETvsn3Lc3dYMz
         uBmNRWe4/qteg==
Received: by mail-lf1-f46.google.com with SMTP id c9so4244488lfb.1
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 00:58:49 -0700 (PDT)
X-Gm-Message-State: AAQBX9eGOc4dfhiswhYZc2uTtdZIlZbjmZVA55DQCXoClEMQYRe/uRUX
        sbrytDg24t/CKl+QFnZeJOrf38GF/cl2vbD3zRg=
X-Google-Smtp-Source: AKy350b1ssF5+3y8LjoIucjdjqOpqoEr7lhhlq6ftAM4nISimA5NVrh8r8F79QYLm1XY50ccvi8OflgPlcwXgmTSuOA=
X-Received: by 2002:a05:6512:4de:b0:4db:1c2a:a96e with SMTP id
 w30-20020a05651204de00b004db1c2aa96emr4311287lfq.9.1679990327454; Tue, 28 Mar
 2023 00:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230327095123.20023-1-kernelfans@gmail.com> <CAMj1kXG-gz0R2pPcwoxkSBHD596tycucjuAgm4NXS7kwZib71Q@mail.gmail.com>
 <CAFgQCTuc7yshP8gUJ4XzRR23R5HqoQ02qkA_cvXJM9BXMXLsUw@mail.gmail.com>
In-Reply-To: <CAFgQCTuc7yshP8gUJ4XzRR23R5HqoQ02qkA_cvXJM9BXMXLsUw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Mar 2023 09:58:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHuc0X2ChArtcecqAma5jZNyFhjpESB6s9c4NmgzE3o9Q@mail.gmail.com>
Message-ID: <CAMj1kXHuc0X2ChArtcecqAma5jZNyFhjpESB6s9c4NmgzE3o9Q@mail.gmail.com>
Subject: Re: [PATCH] efi: zboot: Ensure zboot PIC
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-efi@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 28 Mar 2023 at 09:32, Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Mon, Mar 27, 2023 at 6:57=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Mon, 27 Mar 2023 at 11:51, Pingfan Liu <kernelfans@gmail.com> wrote:
> > >
> > > Using objcopy to reform vmlinuz.efi.elf to vmlinuz.efi will not conve=
y
> > > any relocation information. That means vmlinuz.efi is expected to be
> > > PIC.
> > >
> > > At present, vmlinuz.efi is PIC. But it is better to adopt the same
> >
> > Why is it better?
> >
>
> I think except carefully coded with asm language, there is no
> guarantee which prevents the compiler from generating position
> dependent code.  Or is there any presumption here?
>

All object files built under drivers/firmware/efi/libstub are scanned
for absolute relocations, and if any exist, the build is aborted.

> > > solution used by the kernel to resolve the code relocation issue by
> > > itself. That is to resolve R_AARCH64_RELATIVE at the runtime.
> > >
> >
> > This breaks other architectures.
> >
>
> Oops, could it be done by:
> #if defined(_aarch64_)
> #define R_ARCH_RELATIVE R_AARCH64_RELATIVE
> #else
> #define R_ARCH_RELATIVE 0
> #endif
>
> Since any r_type equaling 0 can not be ejected into the relocation
> section, this macro will make the code dummy in essential.
>

So the assembler instructions you are using are also implemented on
RISC-V and LoongArch?
