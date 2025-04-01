Return-Path: <linux-efi+bounces-3154-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29AFA7773B
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 11:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BED716A22F
	for <lists+linux-efi@lfdr.de>; Tue,  1 Apr 2025 09:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373E11EC00D;
	Tue,  1 Apr 2025 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEeK5gCM"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0D1EC009
	for <linux-efi@vger.kernel.org>; Tue,  1 Apr 2025 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498493; cv=none; b=XiDqlKlf2Bez6qeHS7rEleoT9Oc0kUNp4Z4obtgjwVLvsmtvwEZcuGEeNghEqkz4X/zNKmakUntKE5I9DkzX+eA5WfNw5mAJCoHswTimXqUHglrRFqeMcpBzGocwBnean8P0Y2FPx4E8S8RCQaqecw0xN4aH5N0h0wlaR5AzrVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498493; c=relaxed/simple;
	bh=ywMfVZONBIix5F/njEsdUc863hABMZFh97L4a3b8F7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZLcBSnv9IbpwsRSyPYEKfkBhEN0EvxT60SOy77WIHIFJl+hdVGfBY5rDqahLg3vSZKWrSL3J6YWF+SG7ROCGSxOwzM/LdIu3+mtx1mHa2SFwValGA7ZTNhABgICCdDwpKoSxmEzRude6XrwGSjno5GMwPkz78+r2SAldiTK2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEeK5gCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843DFC4CEE4;
	Tue,  1 Apr 2025 09:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743498492;
	bh=ywMfVZONBIix5F/njEsdUc863hABMZFh97L4a3b8F7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEeK5gCMg1Qx3yx/TtcCEWwaJNPUIw6VyW38kLVEmr8maHo3OExwa7Uf2oWRnqHlB
	 Av+4r07L9b8DnXOoqoEzydIL7p9vDEWxLV5N+WDCWw8bOmi5LOV9+qlwglAL8z9qZ8
	 ET9/0yjPRcAi3raplk+QV/SJaDD1/bT5R+cTf+Wm8ffU2iYAckkhAdR0GRl3pgaI+F
	 FbnTEpHD6m/8dYFRMhqZqx8Ov2/CUAZAmYgbmTn2dYX9jbGQeCPUYmgrwZTx7J4IL5
	 ADRlvhWQ5Hya6VuskqOBL+58CFn5N53Uak+0j6GTxNaRTOwq3zE+kwVlOn+rY5FgE2
	 Bkk46GrYY846Q==
Date: Tue, 1 Apr 2025 11:08:09 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-efi@vger.kernel.org
Subject: Re: [GIT PULL] EFI updates for v6.15
Message-ID: <Z-us-SG96wJ0BQCv@gmail.com>
References: <20250328070525.2248563-2-ardb+git@google.com>
 <CAHk-=wjc-EAEtv02iUFGej6RZs9C7ALAMtuh4rFNYs5VUt+4UA@mail.gmail.com>
 <CAMj1kXF61PeyercrHdkevq+UdKvBsfJ4QV2RFJyXMWAYtJ95oQ@mail.gmail.com>
 <Z-j8b7Z5oja05cCI@gmail.com>
 <CAMj1kXEpYG7LFgDiM2g4VsBVy1-+8pPxSwy6Xc9DS5u9f8aQZg@mail.gmail.com>
 <Z-rJESxkzhg438vo@gmail.com>
 <CAMj1kXFEgLz2LCzOVZ=+V9aESJEReWr2mguDJzV=roTKQpZccg@mail.gmail.com>
 <Z-ukkz_83lAvm49n@gmail.com>
 <CAMj1kXGyjJeFkzHhxm-UzRw_9N26MHY2NeAJVEzLRugkiShAMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGyjJeFkzHhxm-UzRw_9N26MHY2NeAJVEzLRugkiShAMQ@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Tue, 1 Apr 2025 at 11:32, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > > > Look into arch/x86/lib/ and you'll see that EFI functionality
> > > > doesn't really fit there.
> > >
> > > Again, EFI is only one aspect of this. The SEV-SNP startup code and
> > > the early 5-level paging are used by non-EFI boot as well. But they
> > > suffer from the same issue (C code that runs so early that it does
> > > not tolerate ordinary non-PIC codegen with instrumentation etc)
> > >
> > > Should we maybe classify this as startup code? And put it in
> > > arch/x86/boot/startup or arch/x86/kernel/startup?
> >
> > Yeah, so the canonical place for platform startup code is
> > arch/x86/platform/, we could certainly open up arch/x86/platform/efi/
> > there too, in addition to arch/x86/boot/efi/.
> >
> 
> But what about code that has nothing to do with EFI? That is what I 
> am asking about.

Would arch/x86/boot/startup/ or arch/x86/boot/init/ work? We can open 
up an efi/ subdirectory within it. (but flat would be fine too.)

It would be an improvement to concentrate such code into a single 
place, I think.

Thanks,

	Ingo

