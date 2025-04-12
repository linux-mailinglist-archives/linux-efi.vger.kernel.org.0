Return-Path: <linux-efi+bounces-3301-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97006A86CDC
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 14:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6851898795
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C44B1C2335;
	Sat, 12 Apr 2025 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLphxu5P"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413391922E7;
	Sat, 12 Apr 2025 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460593; cv=none; b=I9oToGxOxqvX4zbvHIqdsT1kHzRK8O5KtTb7MJxOBxWqqwqjpkBj/hWCg3AniKsyNBodwy/u2HUJ3bflsIYfSZjxdqjm1RH6jhiK9EuawE8GfQZQMunLZRKmIyqz65edDX4Y08kHxNc4Cfhn8swfCdIWPeAwMAaMq+qp/ieoDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460593; c=relaxed/simple;
	bh=rCGXsclibXfHVBuI+pwG5d9Ht1uSZNvAreOP4bKx09w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7Wv5wVPRFOqh0aFQAnEiykFrJ7IYjFgR+jnRpHhOQ60R0VPCY/PPh+vFRxOnrq1nInGdnrzr2DQi04nEgliiRUEmkVXnysM/YX9HwSi0lP0qeMIjUkUR0++pMJsoPz8ccsG+wuL5NEcJY8V9tX8z9nR9OnZy3qjcb1+3sLq8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLphxu5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ACDC4CEE3;
	Sat, 12 Apr 2025 12:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744460592;
	bh=rCGXsclibXfHVBuI+pwG5d9Ht1uSZNvAreOP4bKx09w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tLphxu5PPCyba/Db+5zEJt8dhis6Rfgzl01UJ7Cb8aZ5isuHzZ+J9A3ou8Riw+ntb
	 6xjQc7p4h2Ll/r3deDcHccKm2LOHH3E+K4PqbotgHf4yW+vUlZA9AndLvKoRl97eai
	 A0iSsTDKCS+8uwMQYAbUumQt2GXyoAxnIGuN6p0wPy3VsLW0GhU0hPmBDlc6Lt+qj9
	 tynN0twQQiGQh8zqT1xOzBn5I3I5yP2TNWWGJdjuJmES3dysbnm+/lo3AjLhZZuOgs
	 aaeCQtKM+xLaG2FegXsWeGcBSsEAqbLK7r0wD2U1ax0kBR+wbLHJc4xrYKo2uvX+0f
	 RwVylJKicP0Lg==
Date: Sat, 12 Apr 2025 14:23:08 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v4 08/11] x86/sev: Split off startup code from core code
Message-ID: <Z_pbLAw56NIFo7yK@gmail.com>
References: <20250410134117.3713574-13-ardb+git@google.com>
 <20250410134117.3713574-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250410134117.3713574-21-ardb+git@google.com>


* Ard Biesheuvel <ardb+git@google.com> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Disentangle the SEV core code and the SEV code that is called during
> early boot. The latter piece will be moved into startup/ in a subsequent
> patch.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/sev.c |    2 +
>  arch/x86/coco/sev/Makefile     |   12 +-
>  arch/x86/coco/sev/core.c       | 1574 ++++----------------
>  arch/x86/coco/sev/shared.c     |  281 ----
>  arch/x86/coco/sev/startup.c    | 1395 +++++++++++++++++
>  5 files changed, 1658 insertions(+), 1606 deletions(-)

x86-64 allmodconfig build failure:

arch/x86/boot/compressed/sev.c:263:13: error: implicit declaration of function ‘vmgexit_psc’ [-Wimplicit-function-declaration]
|             ^~~~~~~~~~~
arch/x86/boot/compressed/sev.c:266:9: error: implicit declaration of function ‘pvalidate_pages’; did you mean ‘pvalidate_4k_page’? [-Wimplicit-function-declaration]
|         ^~~~~~~~~~~~~~~
|         pvalidate_4k_page

Thanks,

	Ingo

