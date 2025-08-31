Return-Path: <linux-efi+bounces-4658-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8CDB3D243
	for <lists+linux-efi@lfdr.de>; Sun, 31 Aug 2025 12:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E28D189E70D
	for <lists+linux-efi@lfdr.de>; Sun, 31 Aug 2025 10:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F0024DD15;
	Sun, 31 Aug 2025 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKLZ49wo"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FACE190685;
	Sun, 31 Aug 2025 10:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637551; cv=none; b=TSom+zvtqmYCQmSVleF5mA5+POBSBEOe5obkYu99gUZLKSnOKdnJgZgXuqHi/wqva10HyVt4w1Hvl7zM3NC9VjKAvz9FcQ1vUDKs3knHbvJOzXeCxovRdHNJTcPeUAP/rmVBXz6FrYC9XKHucFRvmSFsQdn5ZHxJ0PeW0DOuP0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637551; c=relaxed/simple;
	bh=9tqtR2btKbtZnH82F64NMFQOXmSyv6SCsiv6SFOhv7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apzV6M3SUdhO54uizMgtT2D7Q3bvVApHwK/YAojXT29rVbypB6fary0TU/DmjF0fhT0zliIBBjYh/Qdb1jFoHnUwW8cKdWCIo2BqCzp9JIMxqlwTewIeufaLXrvAD4LZBlVYVAq9qR3AAFCrTUAIf8pdpI0AHpuWJc1VUwvD4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKLZ49wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7564BC4CEF5;
	Sun, 31 Aug 2025 10:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756637550;
	bh=9tqtR2btKbtZnH82F64NMFQOXmSyv6SCsiv6SFOhv7Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uKLZ49woBI/I2mC9x/PLeE8ogM/xr1GCeIpuHvt/3MMVvDJvFENMjVaJRxTUgxcLA
	 Gj4ixPm1z/i4PChxz2SMGHsIvvKjxveX7Lv0xHrANPAsKIUNwFhMzZppe1HpCNsUrR
	 iJ+Viee539TFotyNsLgUaQoLMMtpLajhwPfiF5hc9wMg37gLXjmhtd3W63GU9nX1Ni
	 4loAzI2ztMkxF5o3NP0FyXonkppSGC0ktv9D3r+DiGAJqCDn8k77PHOme7AXGbSbzC
	 +MuL5tGYRqxPrgl3EW8Z3gz0UaEaTaUSC47qpVY5niJ3mbFgJ2Z68yaWO3epzEinBB
	 BMpP/hSxPS4yQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f6bb0a364so2244300e87.1;
        Sun, 31 Aug 2025 03:52:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFBG/gVSC3D8xOOXVD3SS/qeZXWUIH2QXJc127MYGS/uce9Mb27DmlI8pUPHRF+g0WSCA4H+XwLxH28KEu@vger.kernel.org, AJvYcCXWXqswl3VwRbZz8Z9R6EgF0nx+mM99XFvBUmxYyZ9RuHh3VSalF8tN/B1bz74zLBCvyigU1ecXHSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp34gGVNyBIieini6wWHvrlelmLOZdls24ItM9X/2AmvcffY5i
	OFLYEPib7WUOMDy9hSS3Yrp4tBjT6oVmwFKlGaC2EC1ur4hdOaz4QAOnjsCklLMqpwiMRsWhF9E
	XDMWMiJA/f9mUjwCEzMI/2YDETrTjqio=
X-Google-Smtp-Source: AGHT+IHLwDM35kxhuyulmuEsfuPnlyKfR9eY1uJs2dyyyMgi5EDfTtEG+/mYze6p2f+QjeX/5addguEk5AzdLMJwxpY=
X-Received: by 2002:a05:6512:688:b0:55f:6a49:6e6b with SMTP id
 2adb3069b0e04-55f708ecda1mr1260193e87.32.1756637548807; Sun, 31 Aug 2025
 03:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-29-ardb+git@google.com> <20250831104945.GAaLQoyYmr316kHrKs@fat_crate.local>
In-Reply-To: <20250831104945.GAaLQoyYmr316kHrKs@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 31 Aug 2025 12:52:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF-aD74+O_xf_f902wq2RdPpiXCEjJ9osbnEwAMoN_5Rw@mail.gmail.com>
X-Gm-Features: Ac12FXzNXML0LnqcXzMPpKzwdV_rbFU9QHlM6Xx6DuQQKEBbu7UKoaXbLDgQBHM
Message-ID: <CAMj1kXF-aD74+O_xf_f902wq2RdPpiXCEjJ9osbnEwAMoN_5Rw@mail.gmail.com>
Subject: Re: [PATCH v7 05/22] x86/sev: Move GHCB page based HV communication
 out of startup code
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 31 Aug 2025 at 12:50, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Aug 28, 2025 at 12:22:08PM +0200, Ard Biesheuvel wrote:
> > diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup=
/sev-shared.c
> > index 83c222a4f1fa..24cbeaf7ff4f 100644
> > --- a/arch/x86/boot/startup/sev-shared.c
> > +++ b/arch/x86/boot/startup/sev-shared.c
> > @@ -13,12 +13,9 @@
> >
> >  #ifndef __BOOT_COMPRESSED
> >  #define error(v)                     pr_err(v)
> > -#define has_cpuflag(f)                       boot_cpu_has(f)
>
> In file included from arch/x86/boot/startup/sev-startup.c:106:
> arch/x86/boot/startup/sev-shared.c: In function =E2=80=98pvalidate_4k_pag=
e=E2=80=99:
> arch/x86/boot/startup/sev-shared.c:661:26: error: implicit declaration of=
 function =E2=80=98has_cpuflag=E2=80=99 [-Wimplicit-function-declaration]
>   661 |         if (validate && !has_cpuflag(X86_FEATURE_COHERENCY_SFW_NO=
))
>       |                          ^~~~~~~~~~~
> make[3]: *** [scripts/Makefile.build:287: arch/x86/boot/startup/sev-start=
up.o] Error 1
> make[2]: *** [scripts/Makefile.build:556: arch/x86/boot/startup] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/mnt/kernel/kernel/linux/Makefile:2011: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>
> We probably will have to use the CPUID MSR protocol thing here or so...
>

Huh I thought I had fixed that: we can just keep that has_cpuflag()
definition if there is a need for it.

