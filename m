Return-Path: <linux-efi+bounces-3374-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EC1A93A37
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 17:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B09165027
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A778B213E71;
	Fri, 18 Apr 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0SRyJFX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB652AE66;
	Fri, 18 Apr 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744991924; cv=none; b=VzkVfOE/+AzqYQhf0Ynu8bIVaNwEwegouP0vztKenQvf6BVXn5fXLmckgxdwYl09W2I1Z/9Cjlyx+3dHvoyNBkzOF1BYhPMN6As9yImGV12qHxsafViIhB5KUlo2atn09ZSnkfzaLDdP6Hk60VYhVzfWgt/8SriRHlNwQfJXZmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744991924; c=relaxed/simple;
	bh=vGly+NbryR/yfwEhy9YyK7nr94ghld5JIanxfs6hqzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUbs3eVmbcyJfW07Ch+KHt2bpQRags195jBvyGapQ5sxNZTNtJeo+QD4S24HgFBGa5NfhQyrZnwnm++1Oq4IvnBoKXIsQo4W1YHXFrAfDP14k6INMl7R83E53TLIETByJKZ9b8cVMgJ3o/WdS4XsYNHjJis63mxQyYxWXYqzSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0SRyJFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F834C4CEED;
	Fri, 18 Apr 2025 15:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744991924;
	bh=vGly+NbryR/yfwEhy9YyK7nr94ghld5JIanxfs6hqzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j0SRyJFXbuRXtmdVewQcDWhgWdx16MLyjmzrvTrqYmNq+DSwSeg5Vv7rBYxvOWC2C
	 D6CF8XfD8ddrZ1aZ3UOpjEjIadepUmYg/zOGt6hbyiIpLhM7xHyLWjkPHZDVX5X8UE
	 BGguyeoi2Kf5SxDEGBLH2OXntUQ9rVJ6uO1cPl4g6HEzFF49nfvWWrTgI80BVTaWG9
	 z6UW/moQfWy5hRLGc3im6A6ToA/SMeC8WXUKF0PyyJ/0T95PPgqUfhGHv4zlwwhN1l
	 VgRtBXWfUlawWy235zB7tcFycv84Go2k6jmzm62dsJZetGkx4Yr2ut4Mi2JKrQnpRx
	 aenokOXrsANzA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so18529911fa.1;
        Fri, 18 Apr 2025 08:58:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTcuCkpq5D0pqvVAuFNArHGpN64n91dwpL75vdyrVRTUbf2KTiWDmXBTxxhubJH6Ngdg+ulSvcsEU=@vger.kernel.org, AJvYcCXAtuunx2Wr22ihbG/Ldvf8S4akmc6ar58WMEIxurz5IpC8ilEjaSvEvsaTUOVBoarC4o3gKpRbYWOHOc4B@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8DMdsP7B3S7d5SVUlgCchA1/NCdh2SE/bEab3HE4LCtg/Hb5+
	PiuExqHmk8BdyWRJD4Nxxe/gRhObGpCzS21twCQDX5CehgA/1Horo9hu+s73/kyfu/y76x6Ih5x
	ei1kpeJ6GEM4GEAtHtxMnE4WN1i8=
X-Google-Smtp-Source: AGHT+IEmIXZ98MdA0MfZJdR7x/PRqWvMgpSVWl/OhCK8xTgmHq7nLqzeFjy9XEkHjZlIoxEaX0pm9vBFTsSZPnz1Hxk=
X-Received: by 2002:a05:651c:1143:b0:310:80c1:7946 with SMTP id
 38308e7fff4ca-3109055426dmr12507601fa.29.1744991922754; Fri, 18 Apr 2025
 08:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418141253.2601348-8-ardb+git@google.com> <20250418141253.2601348-14-ardb+git@google.com>
 <f465a1b3-c28b-7bfe-7c18-e3fad41842aa@gmail.com>
In-Reply-To: <f465a1b3-c28b-7bfe-7c18-e3fad41842aa@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 18 Apr 2025 17:58:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH=nXgymC8XGO0cxRXJS=N2GY1fCvegSBG4_+mS2-cc4Q@mail.gmail.com>
X-Gm-Features: ATxdqUGFYX3Py4DDco20gd1kySj-rrLaL3n7hJt_OCtQBtLyZcvDBQcMwnW6yak
Message-ID: <CAMj1kXH=nXgymC8XGO0cxRXJS=N2GY1fCvegSBG4_+mS2-cc4Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] x86/asm: Retire RIP_REL_REF()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Apr 2025 at 17:51, Uros Bizjak <ubizjak@gmail.com> wrote:
>
>
>
> On 18. 04. 25 16:13, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Now that all users have been moved into startup/ where PIC codegen is
> > used, RIP_REL_REF() is no longer needed. Remove it.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >   arch/x86/include/asm/asm.h | 5 -----
> >   1 file changed, 5 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
> > index a9f07799e337..eef0771512de 100644
> > --- a/arch/x86/include/asm/asm.h
> > +++ b/arch/x86/include/asm/asm.h
> > @@ -120,11 +120,6 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
> >
> >       return p;
> >   }
> > -#ifndef __pic__
> > -#define RIP_REL_REF(var)     (*(typeof(&(var)))rip_rel_ptr(&(var)))
> > -#else
> > -#define RIP_REL_REF(var)     (var)
> > -#endif
> >   #endif
>
> You can also remove rip_rel_ptr() with the whole "#ifndef __ASSEMBLER__"
> part.
>

No, rip_rel_ptr() needs to be kept, unfortunately.

