Return-Path: <linux-efi+bounces-1653-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8264C96B86A
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2024 12:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A86B27AE6
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2024 10:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192381CF5ED;
	Wed,  4 Sep 2024 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WwgnAhF6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215AF1372;
	Wed,  4 Sep 2024 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445559; cv=none; b=RlTXUdfyO23KYAGCSAkELydC8Kn0QBW3qjRepnN6mmoKf2SSeMNdg8XJG164fyjs6dXULKUQBZhJ7tSUk9hp99jBJlJ/vww/JUG+Wf5yEoRvoODp227u15l3BbJibkn5AXl5xLD44zrFYWZgWAW0dEz0gELgy2rxjJvShofF72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445559; c=relaxed/simple;
	bh=py3rZr5xnwwStoz/LPOpWcBjqtNnORIgKAA6EXkYBKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwghsnvh9EfKcxO0yZtmS6YqdIC+7B43hWAQNa0FnK+79wVhY84DwUhzUJ8K25IzEJXI8RisbUX2ThwHLm2eFlcAu3jsw+BG8yDE1hNgBXbLC7staJWmzQjcEqYHIeD/JV19MsWsupxwR+ta1RV7xP1GE+G9IfTZqhO0I85g8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WwgnAhF6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B164540E0191;
	Wed,  4 Sep 2024 10:25:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IzrP_jv4yo8w; Wed,  4 Sep 2024 10:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725445550; bh=IaYPSh9xjyFgyW628fViW+lh2mlbqwKw5jDlUwUgSqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WwgnAhF6BFpo4L3iAK48soqSLpApm20jxY/Pd90bXBo4WAQyZ51vKTbDH663gVZeE
	 etArLmEcLvZF4Ucr+lgiKbHTjJeHdT5dYuVX9ItjjPB10SC6paBwtEObe1k0oczRkO
	 BhwMo7Fu1lZdZZHK2Io61y2zm/+s7xRNB7W75dFdq1xyJUGPaeuLeepNbIdWUDs6zU
	 NBn5366mJwQiSXSEnpi0aItZYsWQON3stRO/zgdd1iXUMeedp0qFymVIzvfySNaH56
	 VyHivakG7AILKKN4pKjY2rNLJQKxl5tAHGslFeJYKtGwS3vSJOK9VQMyV9cyU7NTME
	 sFWL1z0sgFFF2SjFgN0dWC8DMzFmHEsFiW0R8fxF2IyKYsHbtSn58WOk4c8r6f6pSq
	 sL7QHxivIYqRgkmcr/e4YzjOk/IpaaJu1DvG/D/rXkmjAh7Dn4dManDPix2QW28yry
	 GMGQl12Jv7ILjbFqIC489DbUooCHPn8vxNDtBXe+BRmPrO3KgrhpJNUjRcQqykrEUO
	 Bzc0L00B5EH4dORy2Hjjpbai1ag6oAEsVpnQxpsiaKGHlY6NrJxuB4CHH5XqtXXBPD
	 TMVxpO1u6jkpaIdcJMsDqoJmNYwPxlzcaU7J2GmTFdO6HdSyE3bU8jMiM5wOGJHfZe
	 Q0pknEE7gzHdq2KNhDhYoyug=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 62FA740E0275;
	Wed,  4 Sep 2024 10:25:32 +0000 (UTC)
Date: Wed, 4 Sep 2024 12:25:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Shiju Jose <shiju.jose@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Ferguson <danielf@os.amperecomputing.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] efi/cper: align ARM CPER type with UEFI 2.9A/2.10
 specs
Message-ID: <20240904102526.GBZtg1lgguu4YvxqnV@fat_crate.local>
References: <cover.1720679234.git.mchehab+huawei@kernel.org>
 <1ca1274f57fac69eda2f193de53077e8254a70fe.1720679234.git.mchehab+huawei@kernel.org>
 <20240902152755.GFZtXZe5FPSfjRa9u3@fat_crate.local>
 <20240904064549.0bddeaab@foz.lan>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904064549.0bddeaab@foz.lan>

On Wed, Sep 04, 2024 at 06:45:49AM +0200, Mauro Carvalho Chehab wrote:
> It was tested on ARM, together with QEMU error injection code I'm working
> there. Currently, only GPIO and SEA notification types are supported, so
> no x86 support yet (I'm trying to add SCI too, allowing to test on x86
> as well[1]).
> 
> It sounds that bitfield.h is indirectly included from
> arch/arm64/include/asm/sysreg.h when compiled on such arch.

Before you send patches, make sure you *at* *least* build-test them on the
affected architectures. I don't have to tell you this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

