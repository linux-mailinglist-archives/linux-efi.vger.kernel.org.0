Return-Path: <linux-efi+bounces-743-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8B6873738
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 14:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822131F274D1
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 13:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25C512D743;
	Wed,  6 Mar 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZx6X8VF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA483CBA;
	Wed,  6 Mar 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730162; cv=none; b=DaaUaQEuk9kFn9p1Kcnat+rCb7vWkuSw9mxN4oNYXOF9jMBqq05q/SpFFcWaoBVtXfOCU7mnvESVDfWvrgpAf4A4TWQfwCQ9W5XmjjBhiLLezdAdek7kSpFdlXiAhP7zTIDXq9ge1To3PA/hlWjBonbGFRJFcLdH2F2U5czNyNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730162; c=relaxed/simple;
	bh=xqlXieFYyjBFUDabcN0/XVC9R8+fZoD83jS3/xfMXgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Luk7C5C/tbZm6xpGXITgzfoWy6FS7KCdl7mezlarPZ3khOG5knAU9eZwy1qT88yS0qCH858FyIrTzKcUY41QH4nvZcmQRvDOukzmASFtuT/Yk2PvJyhLNDuL/leN4bNxsKbKZXb6QpT5mX1zwxYv2mtULQrTtbr1cgjdLUXGUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZx6X8VF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B054C433B1;
	Wed,  6 Mar 2024 13:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709730162;
	bh=xqlXieFYyjBFUDabcN0/XVC9R8+fZoD83jS3/xfMXgQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YZx6X8VFN6PtDH+uTL8WY4EYlGJQTvWxSYSjpi1UxDn/PI4CuCbZqJbobnzySq6w0
	 9FIMALKKxs9A1JcntyKsG8stN+tVixbXwmxwq+9lGtuj2cqLjeUJPd/JTZglEzGs5u
	 FRfWGMdlQzj6prvoCMBfRaqiBnXkv0bFq8xm2iKd99HhVoogpMigj6ZP4eE2UdhfRT
	 FBlFjDSb6j6g0Ioz++G+AkqZgednyMulnrFGc13R6u4OqgbP24aZ/vSIs866nVCkOU
	 gviYn7RdgPuwfUes+8QIJHGVBHUrRv9LJFKBRT9OxxqcsDGqk1kzLgqkcjef2W4107
	 v9NDQ1oTPBM3A==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d3fd0e6832so10381861fa.2;
        Wed, 06 Mar 2024 05:02:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0p/yEMqVOMqS+5EbhXDMANTBj5jXU653a2KbKP6OU+YLyJLfb3DQDFt6Z+Qydyi+bdGPqshxFj+4YGn4d1/SQGjb2QzvO0v6DHy5ihHljrjwJQOxjQqF3crjO7bXyfiT6sIunyKST
X-Gm-Message-State: AOJu0YzG+UrrBD1dVlmkafQdOx6GaGUFcKIWjxOFu6ISuhNnnb+c34es
	Eawdoi6SP8Kp29kfKBoS9Riag/YXo8ok9t5Zl0fsZ24R7kevsVeee1K7n7uqdpDgh8KZSTprJ+f
	61lx7GIVXvUjxxGBxm8OdhSGnLsI=
X-Google-Smtp-Source: AGHT+IFN9slhZQp0MLbB7aRkcD7nL2BGfAfaw5R/2c2MSPjA6BDrQsiEXQNvYFLOmRtv/h6N5T0jPpresVWzCzFOhFM=
X-Received: by 2002:a2e:a266:0:b0:2d2:c8c2:5cb3 with SMTP id
 k6-20020a2ea266000000b002d2c8c25cb3mr3059245ljm.33.1709730160042; Wed, 06 Mar
 2024 05:02:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
 <20240306085622.87248-3-cuiyunhui@bytedance.com> <CAMj1kXEjjFAeVAVwiDO22RJECSM=L=0q6J=zog7JR38rUZpLGQ@mail.gmail.com>
 <CAEEQ3w=2pX+pjwoz=hNFpR4thD+d6o9OmBob8LMzZ8BbKZ=pqg@mail.gmail.com>
In-Reply-To: <CAEEQ3w=2pX+pjwoz=hNFpR4thD+d6o9OmBob8LMzZ8BbKZ=pqg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 6 Mar 2024 14:02:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFG=y_XXiaBHZOXDApZiCb48i0U5pX+GBRO2KAUom52VA@mail.gmail.com>
Message-ID: <CAMj1kXFG=y_XXiaBHZOXDApZiCb48i0U5pX+GBRO2KAUom52VA@mail.gmail.com>
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

On Wed, 6 Mar 2024 at 13:34, yunhui cui <cuiyunhui@bytedance.com> wrote:
>
> Hi Ard,
>
> On Wed, Mar 6, 2024 at 5:36=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> >
> > On Wed, 6 Mar 2024 at 09:56, Yunhui Cui <cuiyunhui@bytedance.com> wrote=
:
> > >
> > > Compared with gcc version 12, gcc version 13 uses the gp
> > > register for compilation optimization, but the efistub module
> > > does not initialize gp.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > Co-Developed-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>
> >
> > This needs a sign-off, and your signoff needs to come after.
> >
> > > ---
> > >  arch/riscv/kernel/efi-header.S | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-h=
eader.S
> > > index 515b2dfbca75..fa17c08c092a 100644
> > > --- a/arch/riscv/kernel/efi-header.S
> > > +++ b/arch/riscv/kernel/efi-header.S
> > > @@ -40,7 +40,7 @@ optional_header:
> > >         .long   __pecoff_data_virt_end - __pecoff_text_end      // Si=
zeOfInitializedData
> > >  #endif
> > >         .long   0                                       // SizeOfUnin=
itializedData
> > > -       .long   __efistub_efi_pe_entry - _start         // AddressOfE=
ntryPoint
> > > +       .long   _efistub_entry - _start         // AddressOfEntryPoin=
t
> > >         .long   efi_header_end - _start                 // BaseOfCode
> > >  #ifdef CONFIG_32BIT
> > >         .long  __pecoff_text_end - _start               // BaseOfData
> > > @@ -121,4 +121,13 @@ section_table:
> > >
> > >         .balign 0x1000
> > >  efi_header_end:
> > > +
> > > +       .global _efistub_entry
> > > +_efistub_entry:
> >
> > This should go into .text or .init.text, not the header.
> >
> > > +       /* Reload the global pointer */
> > > +       load_global_pointer
> > > +
> >
> > What is supposed to happen here if CONFIG_SHADOW_CALL_STACK=3Dy? The EF=
I
> > stub Makefile removes the SCS CFLAGS, so the stub will be built
> > without shadow call stack support, which I guess means that it might
> > use GP as a global pointer as usual?
> >
> > > +       call __efistub_efi_pe_entry
> > > +       ret
> > > +
> >
> > You are returning to the firmware here, but after modifying the GP
> > register. Shouldn't you restore it to its old value?
> There is no need to restore the value of the gp register. Where gp is
> needed, the gp register must first be initialized. And here is the
> entry.
>

But how should the firmware know that GP was corrupted after calling
the kernel's EFI entrypoint? The EFI stub can return to the firmware
if it encounters any errors while still running in the EFI boot
services.


> Regarding your first two comments above, I plan to make the following
> changes in v2,
> efi_header_end:
> +
> +       __INIT
> +       .global _efistub_entry
> +_efistub_entry:
> +       /* Reload the global pointer */
> +.option push
> +.option norelax
> +       la gp, __global_pointer$
> +.option pop
> +
> +       call __efistub_efi_pe_entry
> +       ret
> +       __HEAD
> +
>         .endm
>
> what do you think?
>

This looks ok to me, but I would still like to understand why it is ok
to return to the firmware with a modified GP value.

