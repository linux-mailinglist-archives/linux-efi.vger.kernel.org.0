Return-Path: <linux-efi+bounces-5789-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ECDCA0C07
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 19:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDC1E30155BC
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D65341053;
	Wed,  3 Dec 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSKksOq6"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B406634104C
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784977; cv=none; b=fDsoDTmkxIY2FIGof5xjThfViKGi7vdGX8gyxcXD7H8zYkOuaMM5Uc6ARJWh3lLdz9Gl5f+608xmCWnk+JRZl51VIQ+l9B9w2unCkgu5hd5HxXA1rExpGQfm0+VGmP+Wqq0bo0H2JiHc6NtBE9ErVElRB/+tic42HE+dGESAnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784977; c=relaxed/simple;
	bh=+v/xPS8BinNaQUJiCUoK+hTFkJtV9XTX8tCGOQIkgi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXiIgTWhxhgRXNGL12SociAWNhFnb3JC1aI05N3jqIBG1oXigqD5hV88gh2w3tmBRrumt3nckoMiBpe6lGVmTAXCurVwQmZOAmTq19NqBsjRKxOA9Qm4h5dEkP/IKrgj+A6meojJ3dern8dqWCzmo/1s2zX568fxJGRnemTHlGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSKksOq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA50C4CEF5;
	Wed,  3 Dec 2025 18:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764784977;
	bh=+v/xPS8BinNaQUJiCUoK+hTFkJtV9XTX8tCGOQIkgi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSKksOq6vdBViu1TJ/JFCO649aoQTql6lcwHO2pR91sxtrkr0BUn8O4WLST9iM97s
	 xst/7wK2IE7dHXDZnuizDEEeZmdLtmkYE/xD6u4/cIVRERmnAvXZ1gN0oR7Dd7MokF
	 Gt6Er2sz7cShhwWS5Q9bzVvfmYLlerTdnMYAN7mKiRs8tROItenuDaJWfaLDVvbJYm
	 R3lOCJDhHTBE0amhw6BpdJR2FkgiPhCFNcujrgHYrZOnx8w+0UDopEPVTQoicZb+29
	 Q9kC/jtRe3CpFeTUWV9rBhY0ajjqnbENyyaWkKvGjAe8CSj5QJs+8s/b6ZXm+XA4kB
	 VSbSASHQ2J/5w==
Date: Wed, 3 Dec 2025 10:02:56 -0800
From: Kees Cook <kees@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] lkdtm/bugs: Add cases for BUG and PANIC occurring in
 hardirq context
Message-ID: <202512031002.ED3098374@keescook>
References: <20251112175316.2841017-4-ardb+git@google.com>
 <20251112175316.2841017-5-ardb+git@google.com>
 <aR4ERqeHFbSWooZW@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR4ERqeHFbSWooZW@arm.com>

On Wed, Nov 19, 2025 at 05:54:14PM +0000, Catalin Marinas wrote:
> On Wed, Nov 12, 2025 at 06:53:18PM +0100, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > Add lkdtm cases to trigger a BUG() or panic() from hardirq context. This
> > is useful for testing pstore behavior being invoked from such contexts.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  drivers/misc/lkdtm/bugs.c | 53 ++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> 
> Kees, are you ok with this patch? Happy to take it through the arm64
> tree together with the second one.

With the small addition I just sent, yeah, this is fine by me. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

