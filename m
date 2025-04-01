Return-Path: <linux-efi+bounces-3155-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71070A7774A
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 11:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDAC1686DA
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BBB1EBFE4;
	Tue,  1 Apr 2025 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOxtm+++"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A213B1EBFE3
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498623; cv=none; b=H0M4r9Ix+cxEihMmj1y78RC4DTPGm0/XT6LuZ4DlKGuqOOgOj/muQB6COb4ju9V9JV3XhMFSVVj3ZUfPCVvy7FD5p6MxSUFgbjst2Em1Zqpz9QTUNpZ9iYIRO4ymWnxE9wuPWZbTQmVC3th7jQarw1hKfVg6F+U2wW/Z8UPS5kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498623; c=relaxed/simple;
	bh=FuSBUyaSbHpMo2dKdS6hx9LnvYnqusiQLViAow2OEF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3IhQYwGL8GviCTzIb9oI5zUJJJaKp2gf9RmjDglXUQC9/dkOzIZ3C1P9WUpEg+UdWw1cDgXg+2NzZYkwKsjFZA8+Q6NHy/iW8Tm/WFuJIst95JKfeHjZ6rvrUtupocCNuAxMN8AA7zgeDg3kpFt6hwPPfZOcuAwwaxIUSusqe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOxtm+++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C21C4CEE4
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743498623;
	bh=FuSBUyaSbHpMo2dKdS6hx9LnvYnqusiQLViAow2OEF8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oOxtm+++IvYNtukIGw3KcjxfgmVdBQgOGW7P/eKOCWHN/YylKc+Kv5SkQMgi1J3tt
	 Ea19ljUjQo8ClK1tH3RdV/Hy/lheKsDMG5ZrIC+RMYAyicFBq432Yd5KAw7r7WxRSO
	 2AZ5LQ/Cg1v/seaSG2huBKsr89TTd2S5MF37v/0WoSbIlwtSMmY5aNdq+sY+h76zVp
	 ROvjyW17gc6hdoHi/iQlYQE2DlSP/1OS6K/qTanEa0a8ZNW1nJrJwkKjHo18oRKUwI
	 JGXKk636ilK/guIsnEjJ7MGfIzoWvln1ZZ63sc2QB92NkoL47TpdR0sBKfS/PEZYV5
	 VUkbcJBG6uKGA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bee1cb370so47941801fa.1
        for <linux-efi@vger.kernel.org>; Tue, 01 Apr 2025 02:10:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVI9BMBWmAMoQ/6xTpBr2KAVMc+AUOCka/kKgWdnrdzBV6ip379lfNpEbaECFiZXfbl5DzpXDFufnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGy17W6dkPoRkw+ain9nInZ2Pm6ttV2zbZ4IGMa362kg1AcC0C
	HWJTYG42RzCZSh1sVJYtlTbE9kS6FyPnRsr1h1ab0OMd5mEneGjzF+MO9ECVDPd23BZk6zNlu+m
	Kuk6xRjpwEwisc9Iq8in8eTuegUY=
X-Google-Smtp-Source: AGHT+IE3e5jcPyzQRvqZeCy5lZwRt+j1uO2CXG4AxgSuldUcz9LhlCJGkvgAj1y79YmBvlJFg6D8IwvlV8U+4DJhe54=
X-Received: by 2002:a2e:a99a:0:b0:30c:514d:92ed with SMTP id
 38308e7fff4ca-30de024b2camr31070511fa.14.1743498621783; Tue, 01 Apr 2025
 02:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328070525.2248563-2-ardb+git@google.com> <CAHk-=wjc-EAEtv02iUFGej6RZs9C7ALAMtuh4rFNYs5VUt+4UA@mail.gmail.com>
 <CAMj1kXF61PeyercrHdkevq+UdKvBsfJ4QV2RFJyXMWAYtJ95oQ@mail.gmail.com>
 <Z-j8b7Z5oja05cCI@gmail.com> <CAMj1kXEpYG7LFgDiM2g4VsBVy1-+8pPxSwy6Xc9DS5u9f8aQZg@mail.gmail.com>
 <Z-rJESxkzhg438vo@gmail.com> <CAMj1kXFEgLz2LCzOVZ=+V9aESJEReWr2mguDJzV=roTKQpZccg@mail.gmail.com>
 <Z-ukkz_83lAvm49n@gmail.com> <CAMj1kXGyjJeFkzHhxm-UzRw_9N26MHY2NeAJVEzLRugkiShAMQ@mail.gmail.com>
 <Z-us-SG96wJ0BQCv@gmail.com>
In-Reply-To: <Z-us-SG96wJ0BQCv@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 1 Apr 2025 12:10:10 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHbG_pGtzuUjPc-Y7cEvjD_HF3599DiFkBaybsMCmguaw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq2EBVKqpBTa9mvz54gL0qgCZZ8Qk8_dxk6olNlL5uEJF3dlXL4-y0D99g
Message-ID: <CAMj1kXHbG_pGtzuUjPc-Y7cEvjD_HF3599DiFkBaybsMCmguaw@mail.gmail.com>
Subject: Re: [GIT PULL] EFI updates for v6.15
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Apr 2025 at 12:08, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > On Tue, 1 Apr 2025 at 11:32, Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >
> > > * Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > > > Look into arch/x86/lib/ and you'll see that EFI functionality
> > > > > doesn't really fit there.
> > > >
> > > > Again, EFI is only one aspect of this. The SEV-SNP startup code and
> > > > the early 5-level paging are used by non-EFI boot as well. But they
> > > > suffer from the same issue (C code that runs so early that it does
> > > > not tolerate ordinary non-PIC codegen with instrumentation etc)
> > > >
> > > > Should we maybe classify this as startup code? And put it in
> > > > arch/x86/boot/startup or arch/x86/kernel/startup?
> > >
> > > Yeah, so the canonical place for platform startup code is
> > > arch/x86/platform/, we could certainly open up arch/x86/platform/efi/
> > > there too, in addition to arch/x86/boot/efi/.
> > >
> >
> > But what about code that has nothing to do with EFI? That is what I
> > am asking about.
>
> Would arch/x86/boot/startup/ or arch/x86/boot/init/ work? We can open
> up an efi/ subdirectory within it. (but flat would be fine too.)
>
> It would be an improvement to concentrate such code into a single
> place, I think.
>

Yeah, that would help a lot.

I'll go with arch/x86/boot/startup/ for now.

