Return-Path: <linux-efi+bounces-3130-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30521A758E0
	for <lists+linux-efi@lfdr.de>; Sun, 30 Mar 2025 10:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588E93AC5C1
	for <lists+linux-efi@lfdr.de>; Sun, 30 Mar 2025 08:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA9E42065;
	Sun, 30 Mar 2025 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFW8DAUm"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D611CAF
	for <linux-efi@vger.kernel.org>; Sun, 30 Mar 2025 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743322228; cv=none; b=mQT9zf76Qc89Q7G5dU/BkBV8+/dWf86b4ozDlCA1+A2bzu958PPgN/gY5E0mZT03t1HspezW8l7l+bDKtCZ72XlxpJ8rjwyVSzdXxczI/Sd/EQG/mD/uUALKkMK8v3dX3nMd8MDjdoqLlTySFF+Lq4dGZ6bw6tBEBDxhIdbMM4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743322228; c=relaxed/simple;
	bh=mLIVWBfQWjmCBEq3TUDo9tHDNW1GLHyGPO1SvTf1p7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugcVBFUzavCZuyOfmbwJ8mrCQdu2/3o0vRyU4eZ7oYwQih1C4uTvD+PwD+ZgV24rZm/dGkUYrUCWwa2n0p1whuT4T+/so3LX8hzIZjHJJ24RvvNLhiybOfBK2ahT82bmnX7cOJjJIZQLJ6fPCkPV4nYbF+HycLW0GPVkRvfDMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFW8DAUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E0DC4CEDD;
	Sun, 30 Mar 2025 08:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743322227;
	bh=mLIVWBfQWjmCBEq3TUDo9tHDNW1GLHyGPO1SvTf1p7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFW8DAUmGVv6LX03/cACpiXZHIwRt6gPljnTpwiwbwgWTfXpbxWE1oc3w8BH/Dh/6
	 mtiCQuJLU64XPNrWB+/2QU2gB0GCrxLliuy1WQVxgmM04aA2e+UGuOWMrGAffjpHu3
	 GTv4+zG50eA33BGinh7KiObww1SWM0D8YuQ8oRbM7GF3Wn9kukOaKk13i5KckVjBQk
	 ORjmW6ieV78drBMcYvpcSAbdav6aCAFnijtWQMRQkak8DOVY8fu08TpiTQuXKQHedG
	 zX+h5KwANigns4U7dmZKrFNiCbLlhXywSZfQ98qMWHJtKEsu1REdZ0sHIXlNcbUhZV
	 /SZ/dXYnsDHpA==
Date: Sun, 30 Mar 2025 10:10:23 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-efi@vger.kernel.org
Subject: Re: [GIT PULL] EFI updates for v6.15
Message-ID: <Z-j8b7Z5oja05cCI@gmail.com>
References: <20250328070525.2248563-2-ardb+git@google.com>
 <CAHk-=wjc-EAEtv02iUFGej6RZs9C7ALAMtuh4rFNYs5VUt+4UA@mail.gmail.com>
 <CAMj1kXF61PeyercrHdkevq+UdKvBsfJ4QV2RFJyXMWAYtJ95oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF61PeyercrHdkevq+UdKvBsfJ4QV2RFJyXMWAYtJ95oQ@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> (cc Ingo)
> 
> On Sat, 29 Mar 2025 at 19:46, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, 28 Mar 2025 at 00:05, Ard Biesheuvel <ardb+git@google.com> wrote:
> > >
> > >  arch/x86/boot/compressed/efi_mixed.S               | 341 ---------------------
> > >  drivers/firmware/efi/libstub/x86-mixed.S           | 253 +++++++++++++++
> >
> > I've pulled this, but I'm not super-happy about it.
> >
> > We have been pretty successful in keeping assembler files in the 
> > arch/ directory, and I really think we should strive to continue 
> > that.
> >
> > Do we have a few drivers that have arch-specific assembly code? 
> > Yes. But it certainly isn't something to make more common.
> >
> > And did we already do that zboot-header.S thing earlier? Also yes, 
> > but that one is afaik actually architecture-neutral and doesn't 
> > have any architecture *instructions* in it, it's just data layout 
> > afaik (and no, I don't know why it was done as a '*.S' file)
> >
> > IOW, I really wish you would move this back to arch/x86 somewhere. 
> > Please?
> >
> 
> Fair enough. Note that this applies to la57toggle.S as well, which 
> was moved in a patch that went via the -tip tree this cycle.
> 
> It doesn't matter that much where the files live, as long as they are 
> disentangled from the traditional decompressor. (For C files, it is 
> important that they are built using the EFI stub's C flags, but for 
> asm files, that makes little difference)
> 
> Does arch/x86/lib sound like a reasonable place?

So all of this is boot code (early EFI runtime calls), right? Please 
move anything fundamentally low level boot related to arch/x86/boot/. 
We can open up arch/x86/boot/efi/ or so, to decouple it from the 
decompressor.

Thanks,

	Ingo

