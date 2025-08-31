Return-Path: <linux-efi+bounces-4659-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD46B3D25A
	for <lists+linux-efi@lfdr.de>; Sun, 31 Aug 2025 12:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5E53A48DD
	for <lists+linux-efi@lfdr.de>; Sun, 31 Aug 2025 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD0A256C76;
	Sun, 31 Aug 2025 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1ObgOPO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E62459C9;
	Sun, 31 Aug 2025 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637814; cv=none; b=C/y/RfgzEeIRV0S8rCfjjkk7gn8OqPRKs8e5SZcEQMzGwsyDFxl9CW8bTOrRiXTscNZq9FMOy8tkWUJBRGfmjXjzNC+PFsAAixy4orkQ/3P3QsB2vIEAhj+70gTYVxy055mtHjBG6MlTJ0AGqR40fG+WP9Xwb/q0l2ChGZJcEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637814; c=relaxed/simple;
	bh=QsXK6w3cPQvz/g6m4dpqnZsvsl09NwFAlgfqt6oXtbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXIUj2XwZLXo3ASf1fj2JDPQmNSCTtbmktYhAnVUGOBMog8U7sC3SM0v3Xi5Eu4iWj9oMbihEcLWZBH8YhvfEXMhsfeMn8fLHvgmyS9CgNb4Lz5O15w5EgHg9qkyvV6Sd3jHuP5/o/ws8PJaLD4i2ul7I1WqZ/FcI8cQ/d2y1Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1ObgOPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7967DC4AF09;
	Sun, 31 Aug 2025 10:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756637814;
	bh=QsXK6w3cPQvz/g6m4dpqnZsvsl09NwFAlgfqt6oXtbE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o1ObgOPO0JApcclnU4wNt0nU684yYvMt27/M1RjT/o+gZMpzb15dGx6nVFyl6lnZA
	 fqh7OpRFQP7xDL2CVrnpFKbchSvhLbFSvA8r/tWPZg9279rzW+AL7TYzo24S5FruMt
	 WeS6dhdrwzpFBmhbIE0dFxviOFFIgmJKooQWESPHeI3SEfAPCS8iv2BjgA9h4Awy48
	 lPP/cRfIwcvinZPpMnl+AwUhWYwZdv1DelJ1jtavquwm0J/yBc0pFAJPVHndKMIo5s
	 mIZAO6Py7QzOQZqboQYr0FevNz/GyVJiyErVZ3ADu6a7uz7Or0txBaY2wRhVNziesO
	 SOyUygIMJIf+w==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f687fd3bdso2765783e87.1;
        Sun, 31 Aug 2025 03:56:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkRsME63jLnpJcmJKKKRMNRElvqvyf+oPt2UJ5iGiaZ4atmTUVS1TqSqqSUA8DWaNfHz6GtabM9MQ=@vger.kernel.org, AJvYcCWsL7+nhKMnH/paleYo68TeBog0N1cmyWhgScWkkqg9QkLF6K3hmPybntpIKlP4AGI1Rt00w2Z1KvkXyTTX@vger.kernel.org
X-Gm-Message-State: AOJu0YxjWJn/ejgzKz3tCh4CXLynS8fNOfHEsJlTWmaHEdUzuT3m2d2h
	kXbcin2ilcbcA/ETCHV+Y1t/ftrJLDrWmDiiwibt8B4O+VdSlAQZOk143HLyJIYvtvLa+7GHvLe
	u/LFVBXPTpxWpaomnDnhkLtQaUdCUyuo=
X-Google-Smtp-Source: AGHT+IEgl9OC//RhxwrR+svllAr0NqVtk43HgtnmM6YUnUIjh6nqaiGuslruhjyDdtQ3kEfjxkOYTE5ugh9CMkjkSCU=
X-Received: by 2002:ac2:5693:0:b0:55f:68d4:c72e with SMTP id
 2adb3069b0e04-55f708b6b29mr1417768e87.18.1756637812817; Sun, 31 Aug 2025
 03:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
 <20250828102202.1849035-29-ardb+git@google.com> <20250831104945.GAaLQoyYmr316kHrKs@fat_crate.local>
 <CAMj1kXF-aD74+O_xf_f902wq2RdPpiXCEjJ9osbnEwAMoN_5Rw@mail.gmail.com>
In-Reply-To: <CAMj1kXF-aD74+O_xf_f902wq2RdPpiXCEjJ9osbnEwAMoN_5Rw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 31 Aug 2025 12:56:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEQghhi4qCdV6PrYK-mTYFu5yVcn3fEOSZsC6vR7TiMEg@mail.gmail.com>
X-Gm-Features: Ac12FXwtKEcxNeIMVJCKUhJtrQGhh2zNGurWaS4cbDcQL5TZb-sHfFxQRLrGzGU
Message-ID: <CAMj1kXEQghhi4qCdV6PrYK-mTYFu5yVcn3fEOSZsC6vR7TiMEg@mail.gmail.com>
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

On Sun, 31 Aug 2025 at 12:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 31 Aug 2025 at 12:50, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Thu, Aug 28, 2025 at 12:22:08PM +0200, Ard Biesheuvel wrote:
> > > diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/start=
up/sev-shared.c
> > > index 83c222a4f1fa..24cbeaf7ff4f 100644
> > > --- a/arch/x86/boot/startup/sev-shared.c
> > > +++ b/arch/x86/boot/startup/sev-shared.c
> > > @@ -13,12 +13,9 @@
> > >
> > >  #ifndef __BOOT_COMPRESSED
> > >  #define error(v)                     pr_err(v)
> > > -#define has_cpuflag(f)                       boot_cpu_has(f)
> >
> > In file included from arch/x86/boot/startup/sev-startup.c:106:
> > arch/x86/boot/startup/sev-shared.c: In function =E2=80=98pvalidate_4k_p=
age=E2=80=99:
> > arch/x86/boot/startup/sev-shared.c:661:26: error: implicit declaration =
of function =E2=80=98has_cpuflag=E2=80=99 [-Wimplicit-function-declaration]
> >   661 |         if (validate && !has_cpuflag(X86_FEATURE_COHERENCY_SFW_=
NO))
> >       |                          ^~~~~~~~~~~
> > make[3]: *** [scripts/Makefile.build:287: arch/x86/boot/startup/sev-sta=
rtup.o] Error 1
> > make[2]: *** [scripts/Makefile.build:556: arch/x86/boot/startup] Error =
2
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [/mnt/kernel/kernel/linux/Makefile:2011: .] Error 2
> > make: *** [Makefile:248: __sub-make] Error 2
> >
> > We probably will have to use the CPUID MSR protocol thing here or so...
> >
>
> Huh I thought I had fixed that: we can just keep that has_cpuflag()
> definition if there is a need for it.

OK it appears I've fixed it in the wrong place: the next patch adds
back the definition of has_cpuflag() so I squashed that hunk into the
wrong patch, it seems.

