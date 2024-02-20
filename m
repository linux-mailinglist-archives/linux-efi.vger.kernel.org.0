Return-Path: <linux-efi+bounces-596-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8E185BFBA
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 16:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD64D1C217B1
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9115D7605B;
	Tue, 20 Feb 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="WQBfuiQG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MRgjOTLs"
X-Original-To: linux-efi@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27BB7604D;
	Tue, 20 Feb 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442398; cv=none; b=J+me8vMaw5aPAtX1E4bMNkubowOzqiLAJMgWwhfXMDgCEZxoMpoS03UnIY+2Jbuif6/iZN9xj0z66lfG0wRcPsVsNYb5yYF/1o1mIswc8fKFLCuebNrRIRPrnwrXSdujWbKimX7ZLqGgOCAEDzi9GGjUOOMy9VQyof1gBj2hbVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442398; c=relaxed/simple;
	bh=u8+UcTSzoPV4fl7A6yp66Oh3coBzrIGAi35j9Hy2Dho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAWm7/G+UwS/iabHyyM8jD8w48acNJz9XRoxAUdPsz0u5LUE1BVxypQFtYUZ+RaZTLxXdGCltacDZxsTzzuw3qKM6nPhuve0xfn0zCSpaRKaeJGitg4cfeUi1bSz1HV5FQlrf1gU8SlljKUzHx1vjJtoCUjuq+Gbo/8fVlxE01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=WQBfuiQG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MRgjOTLs; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C6B4311400B6;
	Tue, 20 Feb 2024 10:19:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 20 Feb 2024 10:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708442395; x=1708528795; bh=KV9xIDxQIa
	soIS7T9R5mqDJyVkBqqdiMWOwKf0ycX9U=; b=WQBfuiQGoo/0ScBwgVNbzIJt97
	6XWJLakkF5lMHfna8H3rtHJM+16A2qskCrKplybrBHaOZ3PK5NbXLeK7eiTw94ln
	+6WIOBryFddEBS7iplKaugjHQGnp1hVHZ/HpVLbuJeGBWnPI5V7tRADXvKTP/tft
	abY47h8kLw9cJsRobPiNJ8wVGkZA8z6f3c/TsFAsA+fstPZjmafuIjry4fZlLWBE
	Hgt5VcLqti8o2EiVApIF1xEJDY9Z+7yuYcfBaj+Ow8AYuLZZ/S+5/6XV6Bxvc06S
	9hw8QOWTywDjdfVDB9U7EK+C4xq7wELYoMIll/QRoK4FMuoIa/hWuM221c/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708442395; x=1708528795; bh=KV9xIDxQIasoIS7T9R5mqDJyVkBq
	qdiMWOwKf0ycX9U=; b=MRgjOTLs8p4z3NzWamKbq2Jm/bqM01LQpH9MnNp9KJoB
	Ca7upMbzAf105iePr6kF+69nIqSaZMYBh3U8SN80QwpN6aqVg28Kj0GGO3nAQpdQ
	tsFG69XhVrsdARnz3Iy/HP5rHgRh4Oi41WtgflLyL0i2gKikJZOZPvkzAV02tXf+
	anrT+/NNNlcT/b2jSOiYVW9JH/W2hp22fjAGDZVJeF/JFP6ycpjd3CEOVFKRkNIf
	IrCTmvL9/GMm1nhM6tYa8BT50hIBEGw1mum+FneI7bfw9tJ0B3JeeB0Di5b78pJD
	LLKSECujPOyb/IonXD5mTbA1TwU0EZj48ZCg0/ZSDQ==
X-ME-Sender: <xms:G8PUZcBu3cTcdpr3o1aGdwPIJpBvIH6SEVx3DeQbnhArKRxnKhifkw>
    <xme:G8PUZejDvqQQ6nGM6egX5twfKIEtLD3xdVRok5-T8peASm95J-BJ20g0YOTTDZpzK
    Xfr5F7zPbki7w>
X-ME-Received: <xmr:G8PUZfkxfEpD_KOsXiByC5W1uP2MzIAjHgQxaLsJrkguQiur0GhFMj2p_x2iQ0vlfdGD1bhi2B6Nz--yjtfqH4aeqJRKi6jXYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:G8PUZSxpNpDJEfFFYLSVn-di9qwj-mshgom3iyOlvlGVHsMiiScoJQ>
    <xmx:G8PUZRQUfKJS6wrlbQ2HW1KP5_OmUo2JxW_aEWrbbikZxHJMyCM65w>
    <xmx:G8PUZdYgNQRINaryOCOdO9NsT9EaXHeQcfGWilWwzXkUKTp9XzwUPw>
    <xmx:G8PUZSIPU1dBdNDC1oC9tfDhWrrH_gFklHdtkcaIenmq9ttdjfHCFg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 10:19:54 -0500 (EST)
Date: Tue, 20 Feb 2024 16:19:53 +0100
From: Greg KH <greg@kroah.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>,
	linux-efi <linux-efi@vger.kernel.org>, jan.setjeeilers@oracle.com,
	Peter Jones <pjones@redhat.com>, Steve McIntyre <steve@einval.com>,
	Julian Andres Klode <julian.klode@canonical.com>,
	Luca Boccassi <bluca@debian.org>,
	James Bottomley <jejb@linux.ibm.com>
Subject: Re: x86 efistub stable backports for v6.6
Message-ID: <2024022045-eclair-twisty-250a@gregkh>
References: <CAMj1kXEGzHW07X963Q3q4VPEqUtKC==y152JyfuK_t=cZ0CKYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEGzHW07X963Q3q4VPEqUtKC==y152JyfuK_t=cZ0CKYA@mail.gmail.com>

On Thu, Feb 15, 2024 at 10:17:20AM +0100, Ard Biesheuvel wrote:
> (cc stakeholders from various distros - apologies if I missed anyone)
> 
> Please consider the patches below for backporting to the linux-6.6.y
> stable tree.
> 
> These are prerequisites for building a signed x86 efistub kernel image
> that complies with the tightened UEFI boot requirements imposed by
> MicroSoft, and this is the condition under which it is willing to sign
> future Linux secure boot shim builds with its 3rd party CA
> certificate. (Such builds must enforce a strict separation between
> executable and writable code, among other things)
> 
> The patches apply cleanly onto 6.6.17 (-rc2), resulting in a defconfig
> build that boots as expected under OVMF/KVM.
> 
> 5f51c5d0e905 x86/efi: Drop EFI stub .bss from .data section
> 7e50262229fa x86/efi: Disregard setup header of loaded image
> bfab35f552ab x86/efi: Drop alignment flags from PE section headers
> 768171d7ebbc x86/boot: Remove the 'bugger off' message
> 8eace5b35556 x86/boot: Omit compression buffer from PE/COFF image
> memory footprint
> 7448e8e5d15a x86/boot: Drop redundant code setting the root device
> b618d31f112b x86/boot: Drop references to startup_64
> 2e765c02dcbf x86/boot: Grab kernel_info offset from zoffset header directly
> eac956345f99 x86/boot: Set EFI handover offset directly in header asm
> 093ab258e3fb x86/boot: Define setup size in linker script
> aeb92067f6ae x86/boot: Derive file size from _edata symbol
> efa089e63b56 x86/boot: Construct PE/COFF .text section from assembler
> fa5750521e0a x86/boot: Drop PE/COFF .reloc section
> 34951f3c28bd x86/boot: Split off PE/COFF .data section
> 3e3eabe26dc8 x86/boot: Increase section and file alignment to 4k/512
> 
> 1ad55cecf22f x86/efistub: Use 1:1 file:memory mapping for PE/COFF
> .compat section

All now queued up, thanks!

greg k-h

