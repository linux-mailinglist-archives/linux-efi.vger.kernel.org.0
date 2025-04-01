Return-Path: <linux-efi+bounces-3149-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54FBA774A8
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 08:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFA43A9717
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 06:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5A51E520B;
	Tue,  1 Apr 2025 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV3JNy3Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4701E5206
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489882; cv=none; b=YS/i/gljeW2uYj6qDDZgLPLJ2/IJHzacFXrM5ApEGwQr+IFTmaGCLDIUZZogXrKpgunQDANEbL3kUkhupaQBzImmhpUjvVpGk1BAWLlkP8JI3ihwcClGkBeUyYCcQsFyQ2T5I+HNk7ChpEg7ra2zq0mlg3xxOHOJPrDlRY+Z4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489882; c=relaxed/simple;
	bh=iXPpOVS3zyefCMEUb8FrlnmS7g5rp6frzlaCqVkPN8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F85XdzQYuZaneIcPW0QQ0H3WaG+u3YAJUhcrTmWWyxy1ePThyCfjisk6bf22x8qHT2htHeB46T8FwSAiYACetOsrHBnYln4ArBwhMXtTO47eH858F7Rmtm/t2oTlawLeZHIDmU1tOXtZ59OpLPI6vQNn9PIGaIeNAzymKtT1KHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV3JNy3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5F6C4CEE8
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 06:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743489882;
	bh=iXPpOVS3zyefCMEUb8FrlnmS7g5rp6frzlaCqVkPN8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lV3JNy3ZdtYHljPjGjvEu2P7vU7bymHCFAslMFlvCNMCfvhraXxla7Wf1NgrJ+PWP
	 Am74DlEpIptWae7wkOW124K5idbgizbyzUGoQN4F6olcCo+AzZw3U1id3UpWqDlrQv
	 nZ6oBVDE24XnV8SuYbiZNnQFzx4hU/XtgWRAwfBvoLxwSJWRniXtK45REit3VzxSOY
	 G6UDie/vmOL9rFYDf1so56oyxRHcsiqEHDKycJBoyjuvCqZqe2wS1ALxlJDnYZbrUN
	 1OyZpTCAeEGhdTk4dGGxKnnrxQPfsKYyZRdCXHMHZORowNCJAdUX2GNMP4dgoSXrvE
	 LQVOlNv3h7iBQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-307c13298eeso58976241fa.0
        for <linux-efi@vger.kernel.org>; Mon, 31 Mar 2025 23:44:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfHg2tqqjPVW0pkFF+rzL46QzFZurfnquL+ACnPdR2CB0LQXQCzZ0/5WefiPkAKnK/yVWrwMdZh90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjOvFBHXWHuweAkN/IN9NR1rAbSxC4StrmgdGiD8Gp+B9LeHXh
	k6wrdHArWrgT+TY2PjpNvizzeVpFwN0pP9ZYU8W1oXztgDQAKTAPzDH34mFSQn8uPsayeRaUjph
	S3/7AmhwxnIXa5i3K9n8JKc2mMHk=
X-Google-Smtp-Source: AGHT+IHDsUg8nSeRVl0ArHJC5ULHb5OYh4l3ftfk7kVYJrYZMZeAdi9IStI1w5UyujrcIn2cLKE8ekrdb5UoWogBi5A=
X-Received: by 2002:a2e:a416:0:b0:30c:432c:5f36 with SMTP id
 38308e7fff4ca-30dd3fd6c59mr52225151fa.5.1743489880668; Mon, 31 Mar 2025
 23:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328070525.2248563-2-ardb+git@google.com> <CAHk-=wjc-EAEtv02iUFGej6RZs9C7ALAMtuh4rFNYs5VUt+4UA@mail.gmail.com>
 <CAMj1kXF61PeyercrHdkevq+UdKvBsfJ4QV2RFJyXMWAYtJ95oQ@mail.gmail.com>
 <Z-j8b7Z5oja05cCI@gmail.com> <CAMj1kXEpYG7LFgDiM2g4VsBVy1-+8pPxSwy6Xc9DS5u9f8aQZg@mail.gmail.com>
 <Z-rJESxkzhg438vo@gmail.com>
In-Reply-To: <Z-rJESxkzhg438vo@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 1 Apr 2025 08:44:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFEgLz2LCzOVZ=+V9aESJEReWr2mguDJzV=roTKQpZccg@mail.gmail.com>
X-Gm-Features: AQ5f1JrtpS_4psgY1lpjN7nkLbKZQhXUUzLq7pBXQnTx-KWLLLQbWxK0BX2kduI
Message-ID: <CAMj1kXFEgLz2LCzOVZ=+V9aESJEReWr2mguDJzV=roTKQpZccg@mail.gmail.com>
Subject: Re: [GIT PULL] EFI updates for v6.15
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 18:55, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > So what I would like to propose for this arch/x86/boot/<something>
> > subdirectory is to move all these source files there, and build a
> > static library that can be pulled into the kernel proper as well as
> > the decompressor, using C flags etc that ensure that all code it
> > contains is safe for execution from the 1:1 mapping. This is how the
> > EFI stub static library is built, and also how the code in
> > arch/arm64/kernel/pi/ is constructed to ensure that it can safely run
> > from a virtual mapping that doesn't match the one the linker used at
> > build time.
> >
> > How does that sound?
>
> Sounds fantastic, related code should be together, like friends around
> a campfire.
>
> Proposed locations, if it's 99% boot/init code (SYSTEM_BOOTING code):
>
>         arch/x86/boot/efi/
>         arch/x86/boot/efi/lib/
>         arch/x86/boot/efilib/
>         arch/x86/boot/lib/efi/
>
> ... or if there's a substantial runtime code (SYSTEM_RUNNING code):
>
>         arch/x86/platform/efi/   # <--- already exists
>         arch/x86/kernel/efi/
>

It is all boot code, along with some lower level plumbing that may be
shared with the runtime code, but that shouldn't matter
(Alternatively, we could have two copies but let's only do that when
needed)

My primary concern is that some of this code is used by non-EFI boot
as well, so perhaps an efi/ subdirectory is not the best place.

> I'm a bit against the arch/x86/lib/ location for the simple reason
> that the x86 library functions are usually simple self-contained
> regular-runtime facilities in C or asm with very little magic, which
> the EFI boot/stub code is as far away from as technologically possible.
> ;-)
>

Fair point.

> Look into arch/x86/lib/ and you'll see that EFI functionality doesn't
> really fit there.
>

Again, EFI is only one aspect of this. The SEV-SNP startup code and
the early 5-level paging are used by non-EFI boot as well. But they
suffer from the same issue (C code that runs so early that it does not
tolerate ordinary non-PIC codegen with instrumentation etc)

Should we maybe classify this as startup code? And put it in
arch/x86/boot/startup or arch/x86/kernel/startup?

