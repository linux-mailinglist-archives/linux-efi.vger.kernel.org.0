Return-Path: <linux-efi+bounces-2822-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E384A410EA
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2025 19:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA6F37A2124
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2025 18:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7529570813;
	Sun, 23 Feb 2025 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nelr3CD6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4602E8C11;
	Sun, 23 Feb 2025 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740335648; cv=none; b=BWtUiftb/Pl46vWVrRobNkLvC2VSacNhTE4Dzt4tf2ktRA1emN82oeV/HyhmWPru0VCQS+ShH7FsP4Ubwd9jt5H09b5zVxOaefN8jN7F0XqlOBgD5RoLrko+HeYn4lvvstftPKCJYvlhP2OzGCZgWVTVZX9UKp5hHajyV+1syv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740335648; c=relaxed/simple;
	bh=0pSzTfWTwkHzlF+kAjOQWSUAirh8DuiwUvvvbBFi1sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBmKEiL+PJsm5MYJymfa1/sHaNsNLFpbF+blHFzz1zs6EtGo5cJB5lvczTUI7K5zJs3YwvB1dYenvlXGqaGifUfTrfseyAdsUaznoxSD2yufCbfW5inRGLWCa7jqZseJ2L4ef0BUgxtIJAalkju+G67cEf9jf9Oz4arigZ6hmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nelr3CD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB28C4CEDD;
	Sun, 23 Feb 2025 18:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740335647;
	bh=0pSzTfWTwkHzlF+kAjOQWSUAirh8DuiwUvvvbBFi1sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nelr3CD67d9LL4SO7tJkKJt5qfwIeku+GPQTSikN94GKUbcCyiyX5Ry3ZMtyjShy1
	 ZyvNC2WY9DrLURf9V6d/OQGwKNtO27HBdimPZmqbVI0xlPs6VM33ddmMiFdam7c1LY
	 7CI0a66sXI4letQjIgzKL59wY+L6jITKu/fMQ2KCRv/9L4q8yjq03FV8Ab35Jg4cc2
	 mWfk6D05RB8Ut+tGd7kEMn0MXMjdkyCQ5iZtrCQaAk/zSCPCFpv3nXTVpDEZAE3p2J
	 GKQNAq5QWlppuD7anD9/l/bj3IwpkKnFQzAdyaEbdaD3gK6xweX8AZlgyQVxlZN6Ml
	 W647zcNFDxEQA==
Date: Sun, 23 Feb 2025 19:33:56 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-efi@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] x86: Add CONFIG_KERNEL_UNCOMPRESSED support
Message-ID: <Z7tqFCo4smCysrfQ@gmail.com>
References: <20250121-kernel-compress-fast-v1-1-fa693b6167d4@google.com>
 <CAMj1kXF-GSB9Ty7X1h4u1uA6qhO1Y1UvVrNF=R+hk3PENRz7WA@mail.gmail.com>
 <CAG48ez2hVHk-C4XAGW2GieHZ9JAF0RrFfpZF7XhYc80pznMwbA@mail.gmail.com>
 <CAMj1kXFT6wkP=eRemR1Y=C-fk2VxNurLHMy74VRFLNmx6NkOAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFT6wkP=eRemR1Y=C-fk2VxNurLHMy74VRFLNmx6NkOAA@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> > But I wasn't sure how to wire that up in a nice way. I guess the 
> > nicest option would be to create a separate kconfig variable for 
> > the compression level to use for any cmd_lz4/cmd_lz4_with_size 
> > invocations in the build process; and then maybe only make this 
> > option visible if LZ4 is selected as kernel compression method?
> >
> > Another option would be to create a new option in the "Kernel 
> > compression mode" choice menu with a name like "LZ4 (fast)", turn 
> > CONFIG_KERNEL_LZ4 into an internal flag that is selected by both 
> > LZ4 variants shown in the choice menu, and duplicate some of the 
> > make rules, but that seems overly complicated.
> >
> 
> I didn't realise that KERNEL_UNCOMPRESSED already exists and you are 
> just wiring it up for x86. But I still think that we should avoid 
> that, not only because it is yet another bzImage format but also 
> because I still see a 3x size reduction even with the fastest 
> setting.
> 
> I think adding one Kconfig symbol that depends on KERNEL_LZ4 and 
> switches from -9 to -1 for LZ4 only is reasonable.

Maybe a CONFIG_COMPRESS_FAST option that maps to and enables the 
current fastest compressor? Then we can also add LZ4_FAST and map it to 
it. (And if a future fastest compressor is added it can change this 
mapping.) Or something like that?

And if there's still a measurable difference in total build time (say 
larger than 1%) from doing it all uncompressed, then I think we should 
go with Jann's original patch that hooks up zero-compression on x86. It 
doesn't look overly complicated.

Thanks,

	Ingo

