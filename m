Return-Path: <linux-efi+bounces-745-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F49587375E
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 14:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8ECF1F21776
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 13:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F4312FB0F;
	Wed,  6 Mar 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwIWtSoL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E13E48E;
	Wed,  6 Mar 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730560; cv=none; b=u7mDY1U/zsrlBYH5LN5x720imFm0rvPyGKGtydsrLZr6JNWLxzBqMzXBIMoZIKxQ5DRLOv0zwhpd9Q1ZDEKUbdIoflFZBWjKaWFJwGENZbQqRrhIBtwyzNat79QQJk6a23YoV1A4tjoyyD1um2PpAMJoLwssmt0hx0v/lohnkGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730560; c=relaxed/simple;
	bh=Qya9yJoMGG3fudaQfNFX/s/AVyf3oZ2gxPRqZT8uKeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kANJCCwwg2ZfqFVaoLc6gMKIM9xFgm6r+X/ocKQmY+BsmmLez5ulf3xAIvpQdCJ1ntdxpm5IMZIhvc31eWrN9GPtXvDUBp6LNvngmPbKJ8nw8R55d4xoURAqbDl7OyN0coYx8Bbgm0Q3prx5QRFUB96GACmz1Q9YmfI6otgIXFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwIWtSoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A81C43394;
	Wed,  6 Mar 2024 13:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709730560;
	bh=Qya9yJoMGG3fudaQfNFX/s/AVyf3oZ2gxPRqZT8uKeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XwIWtSoLbvEa9MhGORRYxc8QnVHeSBZx51PTtbZB7fxTEPlXUS7zchMwigINxmwsA
	 wlfRa6xgG6jV03x8bk2o775DNydGMGIs/5jy8VjXh/b+hEGuIMZmIrl1LByAylEzxc
	 M107S7flaE0Vn6O8d7JyrGLEJGBsL2JRo2F0P+mFOo9IilxDJGb93Xu1QapTYWbu9n
	 m+1tqmU19+hh5m9BrZMpgfxNHfzLfqriMxqcVZ7jb/N5DB1i2IauttaxwQsh4Z8Moz
	 cD9irKSGJxR4SqWaEsVEFyyQMeN675D1FVNS1cDQSAttQcW6ijiqdeeyLYCagIsnmr
	 zQ4j9FjGDjNYQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513181719easo4934382e87.3;
        Wed, 06 Mar 2024 05:09:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWY1k/V2fxsgR0PNHcvhlfTpIu923aEmPq2MQr5iBhSqXB8/RChAhK2m3qSRuKtUGP0CNB5iTMa6c9Y+U1IRttC7+rwIxj8uPTEdH9wDE/0+Zt11RX+KFSd6OODSiP0zEwVUrqtYu/d
X-Gm-Message-State: AOJu0YyfOdz2LAQ1LmP2WvwQar8BfW96QP5gJzN1ltiGIL0iR7BelBm+
	cLLjjuSLoRpa57RQeykikQo18griwhJJRrN0Md5/5QQ8krPP6A418wk8jc0pIQqosVv1L2SFNjj
	Pez0B9r4VuGUasNPmApKDZ48+doo=
X-Google-Smtp-Source: AGHT+IG1umg2a74pIqVk/gcNbcCB3wjXo/3Jy5oVRf6N2X3k6Avjv/4LBUAamkxwcSjo41Byn67QX79jDAeUuBJqscs=
X-Received: by 2002:a05:6512:3b0e:b0:513:57af:2416 with SMTP id
 f14-20020a0565123b0e00b0051357af2416mr3635734lfv.42.1709730558218; Wed, 06
 Mar 2024 05:09:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
 <20240306085622.87248-3-cuiyunhui@bytedance.com> <CAMj1kXEjjFAeVAVwiDO22RJECSM=L=0q6J=zog7JR38rUZpLGQ@mail.gmail.com>
 <CAEEQ3w=2pX+pjwoz=hNFpR4thD+d6o9OmBob8LMzZ8BbKZ=pqg@mail.gmail.com> <CAMj1kXFG=y_XXiaBHZOXDApZiCb48i0U5pX+GBRO2KAUom52VA@mail.gmail.com>
In-Reply-To: <CAMj1kXFG=y_XXiaBHZOXDApZiCb48i0U5pX+GBRO2KAUom52VA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 6 Mar 2024 14:09:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH1oMbONoHFMPaatfaqrHNE2ryfrG7kw-7J-eFsuXkK-Q@mail.gmail.com>
Message-ID: <CAMj1kXH1oMbONoHFMPaatfaqrHNE2ryfrG7kw-7J-eFsuXkK-Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/3] efistub: fix missed the initialization
 of gp
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, samitolvanen@google.com, 
	bp@alien8.de, xiao.w.wang@intel.com, jan.kiszka@siemens.com, 
	kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Mar 2024 at 14:02, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 6 Mar 2024 at 13:34, yunhui cui <cuiyunhui@bytedance.com> wrote:
> >
> > Hi Ard,
> >
> > On Wed, Mar 6, 2024 at 5:36=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> > >
> > > On Wed, 6 Mar 2024 at 09:56, Yunhui Cui <cuiyunhui@bytedance.com> wro=
te:
> > > >
> > > > Compared with gcc version 12, gcc version 13 uses the gp
> > > > register for compilation optimization, but the efistub module
> > > > does not initialize gp.
> > > >
> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > Co-Developed-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>
> > >
> > > This needs a sign-off, and your signoff needs to come after.
> > >
> > > > ---
> > > >  arch/riscv/kernel/efi-header.S | 11 ++++++++++-
> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi=
-header.S
> > > > index 515b2dfbca75..fa17c08c092a 100644
> > > > --- a/arch/riscv/kernel/efi-header.S
> > > > +++ b/arch/riscv/kernel/efi-header.S
> > > > @@ -40,7 +40,7 @@ optional_header:
> > > >         .long   __pecoff_data_virt_end - __pecoff_text_end      // =
SizeOfInitializedData
> > > >  #endif
> > > >         .long   0                                       // SizeOfUn=
initializedData
> > > > -       .long   __efistub_efi_pe_entry - _start         // AddressO=
fEntryPoint
> > > > +       .long   _efistub_entry - _start         // AddressOfEntryPo=
int
> > > >         .long   efi_header_end - _start                 // BaseOfCo=
de
> > > >  #ifdef CONFIG_32BIT
> > > >         .long  __pecoff_text_end - _start               // BaseOfDa=
ta
> > > > @@ -121,4 +121,13 @@ section_table:
> > > >
> > > >         .balign 0x1000
> > > >  efi_header_end:
> > > > +
> > > > +       .global _efistub_entry
> > > > +_efistub_entry:
> > >
> > > This should go into .text or .init.text, not the header.
> > >
> > > > +       /* Reload the global pointer */
> > > > +       load_global_pointer
> > > > +
> > >
> > > What is supposed to happen here if CONFIG_SHADOW_CALL_STACK=3Dy? The =
EFI
> > > stub Makefile removes the SCS CFLAGS, so the stub will be built
> > > without shadow call stack support, which I guess means that it might
> > > use GP as a global pointer as usual?
> > >
> > > > +       call __efistub_efi_pe_entry
> > > > +       ret
> > > > +
> > >
> > > You are returning to the firmware here, but after modifying the GP
> > > register. Shouldn't you restore it to its old value?
> > There is no need to restore the value of the gp register. Where gp is
> > needed, the gp register must first be initialized. And here is the
> > entry.
> >
>
> But how should the firmware know that GP was corrupted after calling
> the kernel's EFI entrypoint? The EFI stub can return to the firmware
> if it encounters any errors while still running in the EFI boot
> services.
>

Actually, I wonder if GP can be modified at all before
ExitBootServices(). The EFI timer interrupt is still live at this
point, and so the firmware is being called behind your back, and might
rely on GP retaining its original value.

