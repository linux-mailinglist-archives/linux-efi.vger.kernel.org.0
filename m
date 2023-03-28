Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F1A6CBB22
	for <lists+linux-efi@lfdr.de>; Tue, 28 Mar 2023 11:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjC1Je5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Mar 2023 05:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjC1Jeh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Mar 2023 05:34:37 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CD683D6
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 02:33:23 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id n125so14184097ybg.7
        for <linux-efi@vger.kernel.org>; Tue, 28 Mar 2023 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679995946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXym/K4/07FjzyXf0jQDirxWFD5RUvLjuHPd5E1NC5c=;
        b=TWYXHuSHHWbGghFVTiECyGnNxnagCY/TdpjRnSy3M0J+tjqppJu4PB8746rhi7sFZY
         mOKcFvVIZEOuBO70z7pUIhWsLoMUrVMu3IjwU7FPdE3IetLDuZtcu5owXSa8Pdi63xKd
         vFU+fG/dK3YMeougRLZI/FXokiguTcPmngx4oOmoUmCEXJocehdN0kTRztFpighlNN8r
         afQa8xjilMA39LeMz8q5O1FWe02SzKcIcA8AzwElbc61QfBeIZfI2DFxxV0+2YociEw7
         /nMfYOx4BFQ3IYcnWuR2FcX2EwMjBqTBaMbSONB1jl2/NLzkkGdH2JAfpkZcuPN5GKz5
         4K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679995946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXym/K4/07FjzyXf0jQDirxWFD5RUvLjuHPd5E1NC5c=;
        b=axhd+LOzmbq0XxVfzm/Z9pplqhSpVHe32Wd9nrFP8m87yER761Ghf4rO6jjpY8oQBG
         BBfYgMOXKpn1DHXAxkqZok0/kySo5BlcOQMTurKNjbi/RIkhvgA6K66awaXcE4vvUh98
         fsUlfpvKJzpH9d8JT0vmWHuvRZxBVKo5C9tGUOSKBLzgBPbwUyhF8sSLuhSaHV21iUo5
         CKnwwewzVZ7IeilZxPnMi+L6h9MziKAHy/1rO4cWR7zaCCXMgDaGvQt8T5Q4ewWKKqBb
         oaQMnMGQwsTkjxTZTF5wVC/kQCthaE1/wY2RfyHv5lVAaaOrvHpJMnnjTtU4Gzyr7Q0n
         nkaw==
X-Gm-Message-State: AAQBX9d9f4Rx/ZUnuZoowEwUpdnWyZ9XXYSr1ACIZr/FiYwupV+BqaiC
        vtTNAeKd8CULsvPxxSm4w0I3SECaiQrC45zF6A==
X-Google-Smtp-Source: AKy350YhiP3zPe2Bdnvs4dpOiyY344MXcNYABk6ivLeHUf+veeTDhqlT2uWSN6HBKEDSX0MZYnX8j2DkERD6AnvILnw=
X-Received: by 2002:a05:6902:722:b0:a09:314f:a3ef with SMTP id
 l2-20020a056902072200b00a09314fa3efmr9262236ybt.12.1679995945334; Tue, 28 Mar
 2023 02:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230327095123.20023-1-kernelfans@gmail.com> <CAMj1kXG-gz0R2pPcwoxkSBHD596tycucjuAgm4NXS7kwZib71Q@mail.gmail.com>
 <CAFgQCTuc7yshP8gUJ4XzRR23R5HqoQ02qkA_cvXJM9BXMXLsUw@mail.gmail.com> <CAMj1kXHuc0X2ChArtcecqAma5jZNyFhjpESB6s9c4NmgzE3o9Q@mail.gmail.com>
In-Reply-To: <CAMj1kXHuc0X2ChArtcecqAma5jZNyFhjpESB6s9c4NmgzE3o9Q@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 28 Mar 2023 17:32:14 +0800
Message-ID: <CAFgQCTt=yatTp9vHQa9wHxGJm-LZZ62acyuSkW+KnhVHAV=jQw@mail.gmail.com>
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

On Tue, Mar 28, 2023 at 3:58=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Tue, 28 Mar 2023 at 09:32, Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On Mon, Mar 27, 2023 at 6:57=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
> > > On Mon, 27 Mar 2023 at 11:51, Pingfan Liu <kernelfans@gmail.com> wrot=
e:
> > > >
> > > > Using objcopy to reform vmlinuz.efi.elf to vmlinuz.efi will not con=
vey
> > > > any relocation information. That means vmlinuz.efi is expected to b=
e
> > > > PIC.
> > > >
> > > > At present, vmlinuz.efi is PIC. But it is better to adopt the same
> > >
> > > Why is it better?
> > >
> >
> > I think except carefully coded with asm language, there is no
> > guarantee which prevents the compiler from generating position
> > dependent code.  Or is there any presumption here?
> >
>
> All object files built under drivers/firmware/efi/libstub are scanned
> for absolute relocations, and if any exist, the build is aborted.
>

Oh, I got the code piece now.  Thank you very much for pointing this
out. And only if R_AARCH64_ABS64 is unavoidable, there is no need to
ask the code to fix the relocation by itself.

But one more question, there are many other "S+A" types of relocation,
let's say R_AARCH64_ABS32 or R_AARCH64_LDST64_ABS_LO12_NC. It is also
sensitive to the delta between loading and linking. Should all of them
be excluded by the Makefile?

> > > > solution used by the kernel to resolve the code relocation issue by
> > > > itself. That is to resolve R_AARCH64_RELATIVE at the runtime.
> > > >
> > >
> > > This breaks other architectures.
> > >
> >
> > Oops, could it be done by:
> > #if defined(_aarch64_)
> > #define R_ARCH_RELATIVE R_AARCH64_RELATIVE
> > #else
> > #define R_ARCH_RELATIVE 0
> > #endif
> >
> > Since any r_type equaling 0 can not be ejected into the relocation
> > section, this macro will make the code dummy in essential.
> >
>
> So the assembler instructions you are using are also implemented on
> RISC-V and LoongArch?

Oops. The whole file should be arch dependent. In those cases, they
should be a single jump instruction.

Appreciate for your help.

Thanks,

    Pingfan
