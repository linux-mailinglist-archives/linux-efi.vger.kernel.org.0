Return-Path: <linux-efi+bounces-3152-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A86A77675
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 10:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228C13AA6CB
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E031EA7C9;
	Tue,  1 Apr 2025 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcdK8lEG"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE3194080
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496343; cv=none; b=ev9+r5gUjmterUoHgeQD5ry9d3El07sBmJgGK1nw5jasDB6k2IjKmKlG3mvHkusIf1x8zIbUEgcvX6PrnFqdWnNUGPQRnTlAI0lcT9caYLUiaMCPQIx58Q6YX/cBa0Vy9H2SCWOSx3+bAF9eBrRmCJB7NZYS+3D9jbfVsUbCLa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496343; c=relaxed/simple;
	bh=MUBwciYMr3Mv1LACBRSzzjsjK5BB9yV6kmtQR9K3beA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKnzyF+xUgSVchbkdS19BxTSxqkkDnY7UNNRVifkeEdmcFcw3tE4E+BCMCjFRXE9e5yen/ocvxQ/HGco4AAq4izK7fZ4+hUINNavh8/Z979Lw4q/lMjrqZZK5lM/1BP67apOGm7ZJ0ruQbSvZB8hIsXqIEC6a620fQfvMkhsTzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcdK8lEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897ADC4CEE4;
	Tue,  1 Apr 2025 08:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743496342;
	bh=MUBwciYMr3Mv1LACBRSzzjsjK5BB9yV6kmtQR9K3beA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcdK8lEGZXfkR9Jk2QqR7mqiqzFpvqB6I7CfPELr/8UfQCFsj0fmMNTQgGbVmQ4b5
	 glrMsBgfM+tVsFZhW3b2L/I5PTcRk3qaYEByaJr0+mMUI/RGj5710G9Mo70xyRmOso
	 uG5ZX0knSv1vpqsmbZRVXqlvXSRIhKIxs2pIEnGr9pFA9tQYKnRJc2Gql75SEIvG5x
	 rVkopxC8/HFVVagj3DuNkjgg+1fexHpJ4QGntfZcQ1hbh6Nly5nI1U7HKTB2nLnSJe
	 tGLl6j59aGr+95ySdw+ZjzhOKl3ygS2qCh/+kvskgbSfVjmncPjQQGXOVDQ9E3IRuQ
	 hdg8OOTkYfTYw==
Date: Tue, 1 Apr 2025 10:32:19 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-efi@vger.kernel.org
Subject: Re: [GIT PULL] EFI updates for v6.15
Message-ID: <Z-ukkz_83lAvm49n@gmail.com>
References: <20250328070525.2248563-2-ardb+git@google.com>
 <CAHk-=wjc-EAEtv02iUFGej6RZs9C7ALAMtuh4rFNYs5VUt+4UA@mail.gmail.com>
 <CAMj1kXF61PeyercrHdkevq+UdKvBsfJ4QV2RFJyXMWAYtJ95oQ@mail.gmail.com>
 <Z-j8b7Z5oja05cCI@gmail.com>
 <CAMj1kXEpYG7LFgDiM2g4VsBVy1-+8pPxSwy6Xc9DS5u9f8aQZg@mail.gmail.com>
 <Z-rJESxkzhg438vo@gmail.com>
 <CAMj1kXFEgLz2LCzOVZ=+V9aESJEReWr2mguDJzV=roTKQpZccg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFEgLz2LCzOVZ=+V9aESJEReWr2mguDJzV=roTKQpZccg@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> > Look into arch/x86/lib/ and you'll see that EFI functionality 
> > doesn't really fit there.
> 
> Again, EFI is only one aspect of this. The SEV-SNP startup code and 
> the early 5-level paging are used by non-EFI boot as well. But they 
> suffer from the same issue (C code that runs so early that it does 
> not tolerate ordinary non-PIC codegen with instrumentation etc)
> 
> Should we maybe classify this as startup code? And put it in 
> arch/x86/boot/startup or arch/x86/kernel/startup?

Yeah, so the canonical place for platform startup code is 
arch/x86/platform/, we could certainly open up arch/x86/platform/efi/ 
there too, in addition to arch/x86/boot/efi/.

Not that it's enforced consistently or historically: in principle we 
ought to have an arch/x86/platform/pc/ directory and move a lot of 
arch/x86/kernel/ there.

Plus the line is a bit fuzzy: as the system is brought up, exactly 
where is the line between boot loading and platform setup: everything 
up to the start_kernel() call is boot code? I don't think that's 
strictly true: for example x86_early_init_platform_quirks() is called 
before start_kernel(), and it's clearly platform setup code.

But in general, platform specific startup and runtime code's best home 
is arch/x86/platform/.

Thanks,

	Ingo

