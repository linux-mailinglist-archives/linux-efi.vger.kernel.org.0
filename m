Return-Path: <linux-efi+bounces-3153-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D94FA776FC
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 10:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1929316A06A
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 08:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834701EB1BC;
	Tue,  1 Apr 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUgViqvB"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0921D7E52
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497793; cv=none; b=uer22l7Hd2RZg0xCAdfEgdC5Lh6ud+yNiHYCcx+xOeGerAAR099AM3CHigTBGksJ0ziplWQMcosE1jJpEF0MnFDpgrAJi7WHSYGiBFTQvwdN8PTySyPxd1lLUPnu1JYFAcKm2S1KyHfHIW4JFPPzvGvvPvYQ+LYbfxOj5L9Fc5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497793; c=relaxed/simple;
	bh=8ttBZDPCa+DoAs8lD1HpM5TuZH5f3g8Wl/5aSaIEEKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AATTe5Ry6XnVPqaWqZIXG44T+72PPa0n0IAvSEYhzFwXmCOU/Onj8StrQchRronN5tfL2yPT+X5qvF6JiMl5ypbvgDJ7hJMMq8awhTcnrmrCm6ZJ+uGcP7XHo/7K17SXTNL44OpHhAJONAWYhbUX7Dxi2UxPzQn7/J9QpGQJZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUgViqvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C627DC4CEE5
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743497792;
	bh=8ttBZDPCa+DoAs8lD1HpM5TuZH5f3g8Wl/5aSaIEEKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EUgViqvB+SdNZX6Duls506owGTmuYuTZJ0Z7b7nV3IAPhDINMXQFUpBiGHtT348Bm
	 fWjPnjkrNBpfNf34/PzOnOSAeR7fHctrsx0ytlCetXO05vTqkKxkr9jm3ZWjI0ky80
	 xFp0uJEg2PhZxHj0REsuStCAuBE33UlBsExZWkQhzLgzsDXKaVRfl5Gpx+0eOnPkik
	 tc/XWGlXQ/kEpELH8lpuuAHqRE1sZh9eEXlI+88C8NxOKO032axuv0QbqnXimlIfFS
	 bgfkO4sxVfTsXU3rbduR36WKMKu3HKH2VpOTTDrCswRPtWD7jbJPThhVZE3T7tNqrW
	 1BE3cv/QHoWUw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54963160818so5835218e87.2
        for <linux-efi@vger.kernel.org>; Tue, 01 Apr 2025 01:56:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIU13Zof7Z0ythG+qbQk3kHHFkcmIbujgRof1mQv58me9T1Xu4klxjhwd+tVKvPD4JXWorm5BSw/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzasLyGfzxnUhuOLlI7FyolonAZx9s2zkdpndGPHvDGGQ9pY416
	AKLXpEyp3+hf30kbvVrrF9PlLiAyOvPQIM+GKD1sfOQiFFN3UgTMwi/hrUnp2dJKW72hwCQrkAv
	DLvy3RjvRpIA6kF4tTt4+9VTqqLA=
X-Google-Smtp-Source: AGHT+IHTp+LLUslRQvIwP2togGKBaO40Wczxrhtlfdqh/n1abQ1sye2F8Yn1LiHtRl8aw6O4ZQZNG8yN4Nf0WvFgS0I=
X-Received: by 2002:a05:6512:6d6:b0:545:2837:17d0 with SMTP id
 2adb3069b0e04-54b10dc830cmr4819931e87.12.1743497791150; Tue, 01 Apr 2025
 01:56:31 -0700 (PDT)
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
 <Z-ukkz_83lAvm49n@gmail.com>
In-Reply-To: <Z-ukkz_83lAvm49n@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 1 Apr 2025 11:56:20 +0300
X-Gmail-Original-Message-ID: <CAMj1kXGyjJeFkzHhxm-UzRw_9N26MHY2NeAJVEzLRugkiShAMQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrNBj3Ssi19wsIidElZghxWdxzbET5RRijNec6gGkzqqbZDsdfn2sUKKA4
Message-ID: <CAMj1kXGyjJeFkzHhxm-UzRw_9N26MHY2NeAJVEzLRugkiShAMQ@mail.gmail.com>
Subject: Re: [GIT PULL] EFI updates for v6.15
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Apr 2025 at 11:32, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > > Look into arch/x86/lib/ and you'll see that EFI functionality
> > > doesn't really fit there.
> >
> > Again, EFI is only one aspect of this. The SEV-SNP startup code and
> > the early 5-level paging are used by non-EFI boot as well. But they
> > suffer from the same issue (C code that runs so early that it does
> > not tolerate ordinary non-PIC codegen with instrumentation etc)
> >
> > Should we maybe classify this as startup code? And put it in
> > arch/x86/boot/startup or arch/x86/kernel/startup?
>
> Yeah, so the canonical place for platform startup code is
> arch/x86/platform/, we could certainly open up arch/x86/platform/efi/
> there too, in addition to arch/x86/boot/efi/.
>

But what about code that has nothing to do with EFI? That is what I am
asking about.

I don't have a strong preference for any of these locations, as long
as they are suitable for *all* startup code, not just code that is
conceptually part of EFI boot.

