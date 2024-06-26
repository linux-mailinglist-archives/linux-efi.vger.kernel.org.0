Return-Path: <linux-efi+bounces-1294-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EBA917ECD
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jun 2024 12:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F177286E4F
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jun 2024 10:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6659E184103;
	Wed, 26 Jun 2024 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="E0lfL2/B"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D211836F5;
	Wed, 26 Jun 2024 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398842; cv=none; b=glmD4ndSUMP9isoatwa8bp5MCm45ryBrOQr7Vh6sYG4A7q19wh17puPU5Gg8ujxb92AT6fGmXHp26HBywifF5g/4d+PQuUEwqAhnS62sMv6Rjw3FGGdibbse8KG8qBKRjRbbCUtPyeRL77pjdNnYSW7crd+CYLhtdmNLRhefUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398842; c=relaxed/simple;
	bh=wxrHq8YLOler5eJNVHa07AdcBpDkGb2s0gSKy1Rcjoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJpquqyiCCNTHQHWXFrF+uvSyLqKYObkmwBc+BFOABTRsKPhEIhrvBUbqNmZJP096l0vwbn11+LGKwqOQ7FK+dmhv3StN2/TvEkiZmgDqlAZoccVrRGWli1tEcULR6NIgRnDNERiGOzCVWEEZNU5/XhA26e8fGs/qC9u/3E8c5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=E0lfL2/B; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BC8B940E0219;
	Wed, 26 Jun 2024 10:47:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u6vXT4yo2Han; Wed, 26 Jun 2024 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719398833; bh=WFvhoSaR1JtMQwa6oAWZalZtdUwtVYaRIDSM12z6668=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0lfL2/BBVkVTmkEBV7alMhc1su4/ZLeX1SFNPMZ4JLvhE7JYT+f3JDK2Iuq7bNko
	 oBA4tVP5Zqxm0CBxD+nVbds4qFVhhDuA6lQXO2fPtIst8uMYeVsmcB/hvyxbLdAy0M
	 G6hjxA+ZczZ6sEKxeUGfLeGOhWMWpLkp5nEhmZOVKBr7O4BDTBvr1ry07TUvrNqxg2
	 dPyso8Cf+u2Cg1XUB0xq8QQ6c8nP127PAaDl+mYdA7qEWCHKExL/TpDAj4kKo9cR8G
	 3ieIX3DPKnxVTMURj1dWp6nVQY74oSIpQoZn+8k/5cSQ9Sc0p+Or9RDxtCPd/tktn8
	 FmSmTuM+D4FmAwHx21yGWUaMPj7zFEjpC+gRe8LzdMN0n8wd7ufYMNaDyVhifSDwbu
	 a+Ly6O0OVQ30v5O6aI3CHCmOSt8ptNbGTM1n8o8nzVaNmucm5owU0Hz331w8OgyKic
	 aVTJxD5EE8K/X0rKQvSOd7MNZnO3vV5GKztZ2GZ+YZSTOVZh82jmcZfVBTDCVraejs
	 ZQX26dUf04gLfwZKqqCPNStFRQntgoGi/gAZnSB/2zXaQucM/SQLsle1vGnCJsk+E2
	 hB44Y2sjfuB5ORBLJeumIDuUJyfxjIlMgsqAD7zAC36/O6qQKXiShc52n5rrXI7GFL
	 6LYed0pRX+/acDeWA/R/qxeM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3D22840E0218;
	Wed, 26 Jun 2024 10:46:49 +0000 (UTC)
Date: Wed, 26 Jun 2024 12:46:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: lkp@intel.com, ardb@kernel.org, brijesh.singh@amd.com, corbet@lwn.net,
	dave.hansen@linux.intel.com, hpa@zytor.com, jan.kiszka@siemens.com,
	jgross@suse.com, kbingham@kernel.org, linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, luto@kernel.org, michael.roth@amd.com,
	mingo@redhat.com, oe-kbuild-all@lists.linux.dev,
	peterz@infradead.org, rick.p.edgecombe@intel.com,
	sandipan.das@amd.com, tglx@linutronix.de, thomas.lendacky@amd.com,
	x86@kernel.org
Subject: Re: [PATCH] x86/64/mm: Make 5-level paging support unconditional
Message-ID: <20240626104648.GBZnvxmMXCZbEhoqls@fat_crate.local>
References: <202406260735.rkb4c8N7-lkp@intel.com>
 <20240626102624.1059275-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626102624.1059275-1-kirill.shutemov@linux.intel.com>

On Wed, Jun 26, 2024 at 01:26:23PM +0300, Kirill A. Shutemov wrote:
> Both Intel and AMD CPUs support 5-level paging, which is expected to
> become more widely adopted in the future.
> 
> Remove CONFIG_X86_5LEVEL and ifdeffery for it to make it more readable.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> ---
> 
>  v2:
>   - Fix 32-bit build by wrapping p4d_set_huge() and p4d_clear_huge() in
>     #if CONFIG_PGTABLE_LEVELS > 4

Is the 0day bot smart enough to detect separate v2 fixups like that and
re-test using them?

If not, you can push your tree to your repo so that it can chew on it again
and report any other potential breakages...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

