Return-Path: <linux-efi+bounces-3096-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63408A71AEE
	for <lists+linux-efi@lfdr.de>; Wed, 26 Mar 2025 16:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FAC71890374
	for <lists+linux-efi@lfdr.de>; Wed, 26 Mar 2025 15:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5F11FECB4;
	Wed, 26 Mar 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tql2Tv4G"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD921F874C;
	Wed, 26 Mar 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003481; cv=none; b=fjbLqSc1+Kx/SfBmdZD+Xk6gYv5N4tGdSloYSO+u3DouW/CE4rTutNq4XSaHt+nX6WBxTLYUFELx95xNf26bsf0BuR7J28/SqHXaXOMPXuGKmkEVByUGuiVVibomaEtLMpzMrONvGofFt3gUzAplOvqnJgrNgO0pT/1UVEsqjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003481; c=relaxed/simple;
	bh=kqyu7iIKKcrq0py45Bc1ihHEX3l7PlNXupd3mSuHM/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgllUPtih0Srs1YE7peG/CmQbwFXpk5LaJVxmYJ1KcgwgOFwG4bFUvxwNX8qGwARsrFkkEb4XscbwI1TlupCVy9n5W45yuVFyvj5gAIifmma11G5bA7frHCG13vh11rhE2PkVqifDl1CVkIw8A0wXJVsPL7l8yOfysBZMJn1vQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tql2Tv4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AE0C4CEE2;
	Wed, 26 Mar 2025 15:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743003481;
	bh=kqyu7iIKKcrq0py45Bc1ihHEX3l7PlNXupd3mSuHM/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tql2Tv4Gvc5tL9W7/XKvSDorRJIiOp4xBj+KE2MMa/4GrTt6HbTJGlVchnzqVa/6k
	 06ldhRv0vT8+AB3WiP5cGsjlVnqK4RJM5+o//bCBu5/MstN86ywFP3zUcVqLj0w3m0
	 rBmaSkLj9TA+foV0N6r1Fv6PX6bqOl8qCt2h7m8o2GE314d3FuNDzYRfrEWn3yWw1r
	 m/2MIRKyagwpNP0AtdTBET43WSsYwmtDbXo3Qjwr0F9innFqpiQN6r2xXrUZQFQzUf
	 cOlPEDVngqgPJ9fog10wX5zL2UlCja6iOo/RiPMDZ95mCLfsjuhFDEA47+aeWQWDAv
	 5KRPAupo96keg==
Date: Wed, 26 Mar 2025 08:37:56 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] wcslen() prototype in string.h
Message-ID: <20250326153756.GB1105284@ax162>
References: <20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org>
 <20250325-string-add-wcslen-for-llvm-opt-v1-2-b8f1e2c17888@kernel.org>
 <Z-LXHssrcpdtFqqn@smile.fi.intel.com>
 <20250325165847.GA2603000@ax162>
 <Z-LiWDbrEvVaTLZU@smile.fi.intel.com>
 <20250325214516.GA672870@ax162>
 <20250326003303.GA2394@ax162>
 <Z-PCCCAPS4uvL3jZ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-PCCCAPS4uvL3jZ@smile.fi.intel.com>

On Wed, Mar 26, 2025 at 10:59:52AM +0200, Andy Shevchenko wrote:
> On Tue, Mar 25, 2025 at 05:33:03PM -0700, Nathan Chancellor wrote:
> >  #define _LINUX_NLS_H
> >  
> >  #include <linux/init.h>
> 
> As I just replied to your previous mail, consider fixing this list as well
> by adding module.h and types.h.
> 
> ...
> 
> Overall, can you browse the Ingo's series [1] for the stuff related to this,
> if any?
> 
> I would avoid doing double efforts or different approaches if we already have
> something ready.

In Ingo's last fast-headers tree [1], nls.h only has export.h and init.h
included, so it does not look like anything around this was changed from
what I can tell.

types.h is going to be included via the new nls_types.h and while it
does definitely look like module.h should be included, I do not really
have the time and build capacity at the moment to incorporate testing
that change into this series. I will stick with these two changes for
now then I, you, or someone else can revisit cleaning up nls.h later.

[1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/tree/include/linux/nls.h?h=sched/headers

Cheers,
Nathan

