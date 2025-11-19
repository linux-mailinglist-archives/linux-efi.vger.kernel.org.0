Return-Path: <linux-efi+bounces-5614-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C926C708E9
	for <lists+linux-efi@lfdr.de>; Wed, 19 Nov 2025 18:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8E34346026
	for <lists+linux-efi@lfdr.de>; Wed, 19 Nov 2025 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782C030DEB7;
	Wed, 19 Nov 2025 17:54:28 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7752F5A3F
	for <linux-efi@vger.kernel.org>; Wed, 19 Nov 2025 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763574864; cv=none; b=NUcaRmTxkzGJzXsXzeHxv0JpVWON3O/T99zzKH+4zOExWND6pcz0I2WEWyY6RQfQyNUW425CUZFZNMzpMS4mdKiR0qxrdwEW5+eoy0y04JCSS61RrPHog0QAwzDGpHrMeBzBAx9e9/ONSNrnCTrLZk8FAfCgYmHPzZGOp0tEkE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763574864; c=relaxed/simple;
	bh=cEajJf22aFgAbLC5pB2W91orNCjuwaazptUJL1PT2tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE8suzLfCgZ4fwWRbSTvTJyxnnsXjZdptz91y5th/gOtbIXYJp+sDhqCcZE4XWl1skBGBLRLwLERkwSnM4DmN8FlT65TKSyP1JqttYlsPja0GZ9L+y3UlrOtTzdKPbDMQIXD9efMeptv9PlLXcIGlwr7VdyFFWyf4dKZy5fxtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18411FEC;
	Wed, 19 Nov 2025 09:54:11 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3204A3F740;
	Wed, 19 Nov 2025 09:54:17 -0800 (PST)
Date: Wed, 19 Nov 2025 17:54:14 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ardb+git@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] lkdtm/bugs: Add cases for BUG and PANIC occurring in
 hardirq context
Message-ID: <aR4ERqeHFbSWooZW@arm.com>
References: <20251112175316.2841017-4-ardb+git@google.com>
 <20251112175316.2841017-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112175316.2841017-5-ardb+git@google.com>

On Wed, Nov 12, 2025 at 06:53:18PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Add lkdtm cases to trigger a BUG() or panic() from hardirq context. This
> is useful for testing pstore behavior being invoked from such contexts.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/misc/lkdtm/bugs.c | 53 ++++++++++++++++++++
>  1 file changed, 53 insertions(+)

Kees, are you ok with this patch? Happy to take it through the arm64
tree together with the second one.

Thanks.

-- 
Catalin

