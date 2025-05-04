Return-Path: <linux-efi+bounces-3548-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE46AA8488
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1449C1897F78
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 07:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9578494;
	Sun,  4 May 2025 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grCc3sB2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DEC28F4;
	Sun,  4 May 2025 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746343987; cv=none; b=FAoMO94Lfv7OUnylEBbVa94veMCgklOcFkjuoRoKYyS3xJ0FeD6boYgDGt5bGpdn//usevJ4asZOfLN/CX3O1PhV75l8zajBpP8/DjjB0A9CAnipYHU76SGQuzEFWjDBRjGHQDeZgu2/xeCcuYycfcx3/jLEEjlM06CYHKrcuAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746343987; c=relaxed/simple;
	bh=gdrZ9xZiSUdvqtaCcWoVCHNWwWD7lz2mYEbitFGulZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7+VC0aNqgzXhHaalH0j9vY6+022vjQ0f3U/RxD5S17iFwMkvNd+yTHEs9crWGiB+jfM9yvQbbKb9xTTY3D4H8OrECH69InIhx7E1+Ll/6JM/4P5p6mlx7rZgBjxCZnurM3viAeYUplnH1Ep94lcFygnaFyd6CT8smHobdu3r9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grCc3sB2; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3105ef2a071so34554131fa.1;
        Sun, 04 May 2025 00:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746343984; x=1746948784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYiayAZSUyOm+8KV8iySpwRx7cWI85tBux/RcLlm+hY=;
        b=grCc3sB2Pqc3RUiRF5H0uk8qHHkWAt7PYI1zZdhSI6ce+V0PPaSs1CZG3b2S4xz3g+
         XQVVEuOTv2nlVvSIqgRDLwuCuKmzGpY5AhDc4XLrMC6My7ZXt6GqhajtVv08K1CmBxM4
         kvIj/cmUAEK/LRZEqrucR6NLmdwLEANmLYBp0MmYe9c0VAMxXpRdreqcNDmFLIqZDvEx
         Qumm2ophd6L0VzTF0SA5JDRPw0GvGYsX7Up5HWknSMMngQnNpDDbiYt8V6b2FkNr94r+
         cOawWgbc5v+gzOqYNwAMxkzai8QlJtoCda6mjE/n8T5X0zs2zTYrwiQud+jGxsm0SKvO
         HM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746343984; x=1746948784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYiayAZSUyOm+8KV8iySpwRx7cWI85tBux/RcLlm+hY=;
        b=qyR2XCBQoh6TEwOU2Pk8p0Qd+MzZzF88SfK7mQgILHqhhAagd3mV5Ey0v7vAS6DdsS
         pyCtYevcF4V8Lbc0Fpbd3Bu+vDQkGPTdoxa5tZMoK+2R+Yz98eowfUs4vq2edfas5oqR
         pexdDiQG8dFNSZ6AbkMuILjnYjREwQig11F5dwboIbOyccVd66ZTdm34vS84Kw9CY78n
         tf8JunP2tyZXgTS/8AAJVVnOUicXRJr4CjyNeTcyEHEiakUOUZA5PdH0y9E8Vc1XAQiL
         Evvs/7uwmTdH22wOAhQ+3kYcRmbtAW83IO9Z14cz6iQ6MulE3npfQ8k4dXV2PdKNmfPq
         uX+w==
X-Forwarded-Encrypted: i=1; AJvYcCUXTb1ybn28g0Z9SXSWErqTztjAjXeDHRyzLJ6JMdDZOrdMA1m3Wfh4dVHY00lt1kCzlfa9iT0TySSvJzrj@vger.kernel.org, AJvYcCV5AYLmAkX1WB7uYerLcu+43XF37MX+mdzRN02fKQi7BUjSG2k+/Zv6r2xGKIdkWKhPs3a5mtiX95E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9kGkp6H4YSxDiuUx/5LR+xyYKx92xIH3/+IkxjkNoqL8xWLcI
	0k4Mepv7yxIX4TBOcU6Mh8x0vnZbZIJnQ3GdZ7L1xFuDBmcdZXI37Eb4UyFwKwARWEt3mX9+xay
	z+bVGHvSREjRC9E7MojaOkhygOGs=
X-Gm-Gg: ASbGncs3BeVGa7h3bhmcRKnK9vlthE+v7t1rbcNWDRSXCBpRdl1NDWiU4BQwvGFtmi5
	bdaH8kj9+bLac/mzJoI0c7cpe42ZbrOpQXJ4Br3IOAbGmCSnpvTylBq3Ir9ENNTe3w/TVLouU6Z
	+3r3lor082M/klRihP55Q6rA==
X-Google-Smtp-Source: AGHT+IFoSqJnnXGmXvA0S9Lpu8fzifjVDHFLr+eAGZAqz2XZdFs9ClMvGoiTXrkOW+xXZqlAqa6L+NW2Mp0wbc1Y3M8=
X-Received: by 2002:a05:651c:1601:b0:30c:3099:13d0 with SMTP id
 38308e7fff4ca-32348f5f9f8mr9314401fa.21.1746343983560; Sun, 04 May 2025
 00:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418141253.2601348-8-ardb+git@google.com> <20250418141253.2601348-14-ardb+git@google.com>
 <f465a1b3-c28b-7bfe-7c18-e3fad41842aa@gmail.com> <CAMj1kXH=nXgymC8XGO0cxRXJS=N2GY1fCvegSBG4_+mS2-cc4Q@mail.gmail.com>
In-Reply-To: <CAMj1kXH=nXgymC8XGO0cxRXJS=N2GY1fCvegSBG4_+mS2-cc4Q@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 4 May 2025 09:33:04 +0200
X-Gm-Features: ATxdqUH9bkMSwuk8Z5NEpFtrAaMVMTJZTjZNc92XY0TDxWXQrYOLxywe0urF7o0
Message-ID: <CAFULd4b3uHB+tvTXroDP-MLgpBHtGxMZgxCp3FVpN7bx=Ov+7w@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] x86/asm: Retire RIP_REL_REF()
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 5:58=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Fri, 18 Apr 2025 at 17:51, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> >
> >
> > On 18. 04. 25 16:13, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Now that all users have been moved into startup/ where PIC codegen is
> > > used, RIP_REL_REF() is no longer needed. Remove it.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >   arch/x86/include/asm/asm.h | 5 -----
> > >   1 file changed, 5 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
> > > index a9f07799e337..eef0771512de 100644
> > > --- a/arch/x86/include/asm/asm.h
> > > +++ b/arch/x86/include/asm/asm.h
> > > @@ -120,11 +120,6 @@ static __always_inline __pure void *rip_rel_ptr(=
void *p)
> > >
> > >       return p;
> > >   }
> > > -#ifndef __pic__
> > > -#define RIP_REL_REF(var)     (*(typeof(&(var)))rip_rel_ptr(&(var)))
> > > -#else
> > > -#define RIP_REL_REF(var)     (var)
> > > -#endif
> > >   #endif
> >
> > You can also remove rip_rel_ptr() with the whole "#ifndef __ASSEMBLER__=
"
> > part.
> >
>
> No, rip_rel_ptr() needs to be kept, unfortunately.

Indeed, I scanned the source before your patch, where rip_rel_ptr()
was used exclusively via RIP_REL_REF.

On a related note,

asm("leaq %c1(%%rip), %0" : "=3Dr"(p) : "i"(p));

the above asm can use %a1 generic operand modifier instead of
"%c1(%%rip)" [1], similar to d689863c1a60b9 [2], which also explains
the modifier:

--q--
The "a" asm operand modifier substitutes a memory reference, with the
actual operand treated as address. For x86_64, when a symbol is
provided, the "a" modifier emits "sym(%rip)" instead of "sym",
enabling shorter %rip-relative addressing.
--/q--

[1] https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Generic-Operand-Mo=
difiers
[2] https://web.git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/=
arch/x86/include/asm?id=3Dd689863c1a60b9936b47a34fa5c3330de374f4fc

Uros.

