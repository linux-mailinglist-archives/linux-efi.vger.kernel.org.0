Return-Path: <linux-efi+bounces-1378-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3B692A13E
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 13:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52B9B27D4A
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jul 2024 11:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529F97F484;
	Mon,  8 Jul 2024 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fRX2I3a0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E7178C71;
	Mon,  8 Jul 2024 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438388; cv=none; b=qEtIbTW9OQ4knCTld/9DnigiIeOPvSgCkfb6Ss2ET3xrs0bQyhPoHot6nSok3puw7dGjY6RLpLZN2ZnfjM7/bVmxLaxTm+6vX/BXYyoNxqJTguyAEg6jaMMQxHA/gsxzuogovowVTVfoNf1WaYGLtrrtDxUqmaJb9/WtEp686wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438388; c=relaxed/simple;
	bh=dFFJJG9Tv0yV8hLsrWcb1qsk+IDaWZR+WQxuHjFGonY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoK6/krTeN2Zqz4ZidD/3O7K8r7SYeo1gZnlVDqvqchsMwb6S3KljpA6KnmnE20nrWzSiS2rVyb1AAiAcacb3KHiGEh5MK+4JXhQbjqn3pHPqo4PJlTD7O2RggmdleYj1cz93YoIwp6m8+9baELQg+6tQKcJ9TXYBHRPT9FlFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fRX2I3a0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4D1BE40E019C;
	Mon,  8 Jul 2024 11:33:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id voEHiw6jkDoV; Mon,  8 Jul 2024 11:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720438378; bh=G5jHbispPX02n3p90WHOG32tsmDkm7uX+JrmT88T9+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRX2I3a0D5ejzfoJtSDRDB6WUlG9gBmRdARteRbHN2PCbBrYqaOf3IhB5gh+f2oBn
	 eD0p9Q0qTdiAGMnJQPQ2WWeogfJpw93wnh2kXPMHnYVy5qZBbkvUitIVS2N5EKzivq
	 R6kbrbVuKBuwktrAQ7akOprkDseiC66wSdHVPXF7UTEJtm18LpAp2+3pZphbgn1yPX
	 ljztvbAwL5sD36u2plJooTfYXEd2WVhxWsf9Q+VgSHFKXzt+HxhC/oQKhXgCjHct+a
	 5Aj3gPLQigG9RnlTODvQXKP8KmAjRLXVFL9cpFn3njaKvW39MwyRP3adbHGivvUatz
	 oXE/ceNJo32cqCU6JhzSv2smnwvt0Lyqyui3n3K6OaIobcZrZyN8n5Cx/rA0J6Ecme
	 ZgfUEHwPqSat6AnON6RHFib/dyQuu4pSA00rFfzKmnmYVwdLZ5dsya03VH44LtnXuB
	 rJ8hkRlPRF9a6/A5ZHBVvP6Kfc5L9uBVFL1C4+4YXwAABOzDy3XB5eFntucSwaXgpi
	 nk21tl2O+5Mp9VF66bQr0KJPE7LLLqzA8jHym3bjL/wNplSB4M0GuhBADOENmWiLsS
	 seSQXUagZTd/q6UDnPcvjA/milU/SfmBISDNJi/jhFE0nZuq+9uQIj2xpO/b60x3Ct
	 KI3DhxSuSFtws89WfNoUaxZg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B28640E0192;
	Mon,  8 Jul 2024 11:32:40 +0000 (UTC)
Date: Mon, 8 Jul 2024 13:32:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	Daniel Ferguson <danielf@os.amperecomputing.com>,
	Ard Biesheuvel <ardb@kernel.org>, James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] RAS: ACPI: APEI: add conditional compilation to ARM
 error report functions
Message-ID: <20240708113234.GDZovOUgjXFt2XoNg6@fat_crate.local>
References: <cover.1720436039.git.mchehab+huawei@kernel.org>
 <f520f2529bb27d452a2dee762b6968939df42f45.1720436039.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f520f2529bb27d452a2dee762b6968939df42f45.1720436039.git.mchehab+huawei@kernel.org>

On Mon, Jul 08, 2024 at 01:18:10PM +0200, Mauro Carvalho Chehab wrote:
> From: Daniel Ferguson <danielf@os.amperecomputing.com>
> 
> This prevents the unnecessary inclusion of ARM specific RAS error

s/This prevents/Prevent/

Avoid having "This patch" or "This commit" or "This does <bla>" in the commit
message. It is tautologically useless.

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

From Documentation/process/submitting-patches.rst

> handling routines in non-ARM platforms.

Ok, this does "something". Why does it do it?

Otherwise it won't build on other architectures or is it going to cause code
bloat or why are we doing this?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

