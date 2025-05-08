Return-Path: <linux-efi+bounces-3642-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491B9AAF87B
	for <lists+linux-efi@lfdr.de>; Thu,  8 May 2025 13:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE794A628F
	for <lists+linux-efi@lfdr.de>; Thu,  8 May 2025 11:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0D81DF725;
	Thu,  8 May 2025 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Mzcw+JE+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCB213635C;
	Thu,  8 May 2025 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746702508; cv=none; b=M2d19dDOeZqekV1yYEswLY0pHyLUw7ZSyQJpwI81zeuzTc0sgPxSImuWSvS+quKZEQ8mPND1VzS/dCHLMWfxE0smL9rM4aXt3oNKfyksFcusdbgxT1r5BaFYNYgOg5z0vV40bnuX8ER1INa4sj8n1O6FjjjaC2IFjJtXl/Adspg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746702508; c=relaxed/simple;
	bh=kYJinZHDzRBMzRpZ/ZhtHefkd8XDgb0so/P4yZh5UN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsoEFlLe3UUVNM+fq6dpdVvEsN1Z+t+dbESZQvZOIOF7P4+D4XADKu29IiEQweIHWDYcMyJ88k0dEQHEQZTJ581pHjt1JV85erEbYy7kFV0cgIljK2frlYTOE+jcSawKz8Olla+E3wP9/Z5H0I2jAYvPA74jl4wiMvk239gdIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Mzcw+JE+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AA2EF40E0173;
	Thu,  8 May 2025 11:08:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2TtfHcqTrfOa; Thu,  8 May 2025 11:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746702495; bh=Cf70QTsIARuMemv9zsF9Ki7KkR3GHpV3j5Skee7GThM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mzcw+JE+KDBi7MGjJgPITwnJWe4Lr/jOIeHEBdCqCX/12W0zRAb0G/bh8yO61YkBb
	 X9LM7XWOMPi+UOBSp61JC2vQXW579ppASJDu2H4I+48XyLxqax2Jow6LzEg3vATfG6
	 E/gI6mlvLVU6yoPyymqL6YwXSP6YpWpmGXDzMgExqA4Ub14w12JKiA7Qi7a1C0MAHj
	 U3a1S8Oo9+qVsaNhY2Ii8zsrA8pTsozVVa3qpZ1iH28SCvrl9Jrquqb0ou2kBnAQKb
	 C38YHhWsOMXujvd8Zop4qxl0+ZKtgKslXxmVbrH0Lx0LUkNcuul14aBdxpH7FnU3nw
	 lYe7k1+eWOK9ESRxPHOj1Y01WT2QgPHhbk2ciA5vDz4XMtCcwlb4g0XHq0rgDohep/
	 0/jaLOX7qihE4grPYXCfEPNbRW3cg+UI3o9+Q43FIAjmezUl3l59W2k4DJ1++CspJH
	 +zsZatkMVexKT9SuuOb2jycX4dYHF8bEbiRdWlv8O+tom5b8mP4Rvyyh+YeQXdJKgA
	 6FY0kaI/qdQdrwVJ0FiUjv07n/CzJTwhOkdaeNUhMYoOqUhqf5Yobdj8SWuberA8by
	 cnMVVL9dL+W2j+YmGVMaTNE7jOqj98OxInO5B/e3NwqBZiAgfVrleh9mcLcD5RJJFn
	 ms74f2LyPWghvrjkkGBqzlhE=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB01F40E015E;
	Thu,  8 May 2025 11:08:05 +0000 (UTC)
Date: Thu, 8 May 2025 13:08:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v2 05/23] x86/sev: Move instruction decoder into
 separate source file
Message-ID: <20250508110800.GBaByQkJwmZlihk6Xp@fat_crate.local>
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-30-ardb+git@google.com>
 <20250507095801.GNaBsuqd7m15z0kHji@fat_crate.local>
 <CAMj1kXEpO3bip+Zyi9x4WN_=qy+oBQ+PpJRw-Je=roQcRt3KsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEpO3bip+Zyi9x4WN_=qy+oBQ+PpJRw-Je=roQcRt3KsA@mail.gmail.com>

On Wed, May 07, 2025 at 01:49:19PM +0200, Ard Biesheuvel wrote:
> Sure, I can add some more prose. I'll add something along the lines of
> 
> "Some of the SEV code that is shared between the decompressor and the
> kernel proper runs very early in the latter, and therefore needs to be
> built in a special way. This does not apply to all of that shared
> code, though - some is used both by the decompressor, and by the
> kernel proper but at a much later stage. That code can be built as
> ordinary, position dependent code with instrumentations enabled etc
> etc.
> 
> The #VC handling machinery and the associated instruction decoder are
> conceptually separate from the SEV initialization code, and are never
> used on the early startup path in the core kernel. So start separating
> it from the SEV startup code, by moving the decompressor's copy of the
> instruction decoder to a separate source file. In a subsequent patch,
> the shared #VC handling code will be moved into a separate shared
> source file, which will be included here too and no longer into sev.c.
> That way, it no longer gets included into the early SEV startup code,
> and can be built in the ordinary way."
> 
> Does that help?

Yap, definitely.

So the logic is, everything in startup/ and everything that startup/
*includes* is going to end up being PIC and the rest is ordinary.

I guess that's one rule to separate it on.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

