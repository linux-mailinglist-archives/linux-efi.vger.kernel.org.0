Return-Path: <linux-efi+bounces-748-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0858737BA
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 14:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871171C20DF3
	for <lists+linux-efi@lfdr.de>; Wed,  6 Mar 2024 13:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22FF12FB0F;
	Wed,  6 Mar 2024 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dnQKyjq5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68A130AF7
	for <linux-efi@vger.kernel.org>; Wed,  6 Mar 2024 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731865; cv=none; b=HovB9R44ZOXBawBeSkYnweRtOrDnFmWbwMmxFLZ8rL5Bhb5pF3PXy9edcMqSbmnnz2LwdozHfNc8XNzdMyMABt4i1p8qvdMcsRJqG5N7zq4m3IDmG/q92OnIG/cdbQMjJedoSLN2+t1EyZiqbWWZPZdXKmJ7ynP3DqRqfFHbdiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731865; c=relaxed/simple;
	bh=s9L9wOsEMWKTm3VHb4hKYH2x0J14mbxKsTebR1oSvmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4rZkinXyKhb1iceMTg+jpyyYcMoHJynrFrJl5npDNBzBmJJafGq/J6hK8hs91ixm9GFoP/1B6Wnb9+76JEgRL7OkJpvZc86Eyv8AV8b9/WThgGiucl89Odr1sPYr+XAU3FWNze+9g1J4b8g1Am1qQH1GFfVbxkZ2VFlU6Uu/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dnQKyjq5; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2210865d962so2361267fac.3
        for <linux-efi@vger.kernel.org>; Wed, 06 Mar 2024 05:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709731863; x=1710336663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kh51b/rQt55meA6gXpgSjO1cqO3LzSbrLvgk9FvgIw=;
        b=dnQKyjq5cztTK1swhDMh8Vq4s4iV7HiTfu7TdrSN2zTcqD66Oo/Cc4CtZxbdYD3Q/B
         ypahWzWzG4f0CfxUd3H35WGHuxyx+1ejKdAB7w479/XdVFmCojL2fLHjXFcqKWrkqVuA
         kjoeriG4TGwsL79GqfuD3NoyrfxuxSBzFTShcKjXLFilcvSaX6wZcDNQws0ueDwE+62N
         n7AVpR2hHgMTTpKdiHKclCeW2Vpe/UBv3HU+YeTP+gVH2kpP8bQXWRThaSyvz6qhsxZK
         tv9vDHhd0uMQAO49Z4ZyqFVSqVt731j5iHcWaLl1yimunmjR9JtGZEHoh2bB5PX+E8rF
         attg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709731863; x=1710336663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kh51b/rQt55meA6gXpgSjO1cqO3LzSbrLvgk9FvgIw=;
        b=qJ3j06uBCzefveLJfF5PEN1EtZ/eupZ1IrTvz3vklckYCvA1x7w3sr2fE6n37eZwDY
         YuIwx7U6JJgrLXvhhs2aMsEFO7FbZlRi9jHUA/TBKoXLABaJwGkcWo5rPgKxNyHHuv6s
         udWUEvbCbn1wSaGubP8Y1wJx6Oh3ef6LExRFS2McVzTayFBTjQcbyF5cEyEGNwRLSRHz
         hKaG+XR1viJvHvzBBDBIVgwPsXwyZoLQfM8BC/d9crezQ5inxi+VSk472VOXHsSglvfV
         BZv3bi+uFtEnIFSig2/3mn/eTvzg43BVfDi3a05yf4sC5wRu9yAOjeCjhr41CGjdf0Ee
         A9zw==
X-Forwarded-Encrypted: i=1; AJvYcCU6HyFlzb3aYYRLsr82rX0yRyQv/tWRsYhWE2ns703tcwp5sQsJHcvev8//1p0ChryOIuuhq1VyPmj+JRfYbC7FSDbOaj0mCsXT
X-Gm-Message-State: AOJu0YyP2yjcUGQ8m/16eH306koPihj11LnNItEGsincLjuSZaEXg/AN
	CHITJRcMiftsnWuRuuks3mkOUkairbkLQnLI/V7Xu78oyjofrRMcDsd+FGtdAFrp7Zn9bPnVzBB
	+2Z03CduyHX7vCYRkzD8MLaHqzoXKLJAJNiR/VA==
X-Google-Smtp-Source: AGHT+IGsESZ28cADtj1/qO3+J9Uodvw2vXH9gd6MIiRper+aJOdmK0FpZ5KKlkyJpg9j4OHGhq9BJkjNjaQwfBjs/x0=
X-Received: by 2002:a05:6870:2302:b0:220:bce1:448f with SMTP id
 w2-20020a056870230200b00220bce1448fmr4753787oao.40.1709731863257; Wed, 06 Mar
 2024 05:31:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
 <20240306085622.87248-3-cuiyunhui@bytedance.com> <CAMj1kXEjjFAeVAVwiDO22RJECSM=L=0q6J=zog7JR38rUZpLGQ@mail.gmail.com>
 <CAEEQ3w=2pX+pjwoz=hNFpR4thD+d6o9OmBob8LMzZ8BbKZ=pqg@mail.gmail.com>
 <CAMj1kXFG=y_XXiaBHZOXDApZiCb48i0U5pX+GBRO2KAUom52VA@mail.gmail.com> <CAMj1kXH1oMbONoHFMPaatfaqrHNE2ryfrG7kw-7J-eFsuXkK-Q@mail.gmail.com>
In-Reply-To: <CAMj1kXH1oMbONoHFMPaatfaqrHNE2ryfrG7kw-7J-eFsuXkK-Q@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 6 Mar 2024 21:30:52 +0800
Message-ID: <CAEEQ3wnuqBYcrwaRhx46E2kbwcHR_miE4+JzK=CmYhF0zMA07Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/3] efistub: fix missed the initialization
 of gp
To: Ard Biesheuvel <ardb@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	xuzhipeng.1973@bytedance.com, alexghiti@rivosinc.com, samitolvanen@google.com, 
	bp@alien8.de, xiao.w.wang@intel.com, jan.kiszka@siemens.com, 
	kirill.shutemov@linux.intel.com, nathan@kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard,

On Wed, Mar 6, 2024 at 9:09=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Wed, 6 Mar 2024 at 14:02, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 6 Mar 2024 at 13:34, yunhui cui <cuiyunhui@bytedance.com> wrote=
:
> > >
> > > Hi Ard,
> > >
> > > On Wed, Mar 6, 2024 at 5:36=E2=80=AFPM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> > > >
> > > > On Wed, 6 Mar 2024 at 09:56, Yunhui Cui <cuiyunhui@bytedance.com> w=
rote:
> > > > >
> > > > > Compared with gcc version 12, gcc version 13 uses the gp
> > > > > register for compilation optimization, but the efistub module
> > > > > does not initialize gp.
> > > > >
> > > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > > Co-Developed-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>
> > > >
> > > > This needs a sign-off, and your signoff needs to come after.
> > > >
> > > > > ---
> > > > >  arch/riscv/kernel/efi-header.S | 11 ++++++++++-
> > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/e=
fi-header.S
> > > > > index 515b2dfbca75..fa17c08c092a 100644
> > > > > --- a/arch/riscv/kernel/efi-header.S
> > > > > +++ b/arch/riscv/kernel/efi-header.S
> > > > > @@ -40,7 +40,7 @@ optional_header:
> > > > >         .long   __pecoff_data_virt_end - __pecoff_text_end      /=
/ SizeOfInitializedData
> > > > >  #endif
> > > > >         .long   0                                       // SizeOf=
UninitializedData
> > > > > -       .long   __efistub_efi_pe_entry - _start         // Addres=
sOfEntryPoint
> > > > > +       .long   _efistub_entry - _start         // AddressOfEntry=
Point
> > > > >         .long   efi_header_end - _start                 // BaseOf=
Code
> > > > >  #ifdef CONFIG_32BIT
> > > > >         .long  __pecoff_text_end - _start               // BaseOf=
Data
> > > > > @@ -121,4 +121,13 @@ section_table:
> > > > >
> > > > >         .balign 0x1000
> > > > >  efi_header_end:
> > > > > +
> > > > > +       .global _efistub_entry
> > > > > +_efistub_entry:
> > > >
> > > > This should go into .text or .init.text, not the header.
> > > >
> > > > > +       /* Reload the global pointer */
> > > > > +       load_global_pointer
> > > > > +
> > > >
> > > > What is supposed to happen here if CONFIG_SHADOW_CALL_STACK=3Dy? Th=
e EFI
> > > > stub Makefile removes the SCS CFLAGS, so the stub will be built
> > > > without shadow call stack support, which I guess means that it migh=
t
> > > > use GP as a global pointer as usual?
> > > >
> > > > > +       call __efistub_efi_pe_entry
> > > > > +       ret
> > > > > +
> > > >
> > > > You are returning to the firmware here, but after modifying the GP
> > > > register. Shouldn't you restore it to its old value?
> > > There is no need to restore the value of the gp register. Where gp is
> > > needed, the gp register must first be initialized. And here is the
> > > entry.
> > >
> >
> > But how should the firmware know that GP was corrupted after calling
> > the kernel's EFI entrypoint? The EFI stub can return to the firmware
> > if it encounters any errors while still running in the EFI boot
> > services.
> >
>
> Actually, I wonder if GP can be modified at all before
> ExitBootServices(). The EFI timer interrupt is still live at this
> point, and so the firmware is being called behind your back, and might
> rely on GP retaining its original value.

OK, in v2 I will restore the value of gp as follows:

  efi_header_end:
+
+ __INIT
+ .global_efistub_entry
+_efistub_entry:
+ /* Reload the global pointer */
+.option push
+.option norelax
+ addi sp,sp,-8
+ sd gp,0(sp)
+ la gp, __global_pointer$
+.option pop
+ call __efistub_efi_pe_entry
+ld gp,0(sp)
+addi sp,sp,8
+ret
+ __HEAD
+
         .endm

what do you think?

Thanks,
Yunhui

