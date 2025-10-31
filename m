Return-Path: <linux-efi+bounces-5297-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC76C25017
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 13:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF5EF4F4B85
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667B8348864;
	Fri, 31 Oct 2025 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NAacxvQK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DEE348477;
	Fri, 31 Oct 2025 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913805; cv=none; b=ZAarUCKJ8S7e3soI+LpRro8I0SiRjxptUcUj4xMfuV6Iqn55irwgQROXWs+Up9DVvuberOHzJlOYKL2wXanh0zBn51PW6sEVoqpeZVVfHfOGZfKNkVNquwc1wLFicAuH66mFvNugXLPEYWLsmCErA1EY0OqItDj+dMBMx7RBQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913805; c=relaxed/simple;
	bh=ZfBeZeOrfeCfA4IySjbQEl56zVTIo3NBKvN2p8nK5EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVPyclRMg2u40YMiaH2mcOrHQPINz2JfkH+FuWxF3AUxgiKBrG2UGOssPm0aed+1IaSDsZpu23kdWXVIvABqjDwk+PIfhru8soe2tFs0c0neE55lLEm/VP+myn2uQmnurG6ryW4CoH9LbVHScl/Wz2c/rqqCs1MJlxwyspt8a1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NAacxvQK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B467A40E021A;
	Fri, 31 Oct 2025 12:30:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fTS8d06j1pil; Fri, 31 Oct 2025 12:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761913796; bh=5W8cFUSX+1C2+f7kJV0HMrg+JK7CQzCAJMjTC+oP5I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAacxvQKxHE0dPthBsBaPtsdILOOvIBJv67+sKLIEqUE44MpKgJnfJoLUKdYiUcXh
	 P/d0E+/sZv30I8IAq0vjqlXyyFhpHf/ZeZaSlpjDgcZZp8oqe9bXk/RCtOV9HBARv4
	 34NJnluqgwB3Ez+EnIf9mswJRyp8dZESsMxktoRJO2LeZmvVDRlth9QHUL7QhxcxaI
	 CMtrulPq6QIf9gSvelYg9VZoSoMXMjjEJP/dr5Z8kDtLaTkR3tMaHxQ2kjRnGbBuEP
	 uqIsK9G8K8aXmLdQ7qvy4jczlUKiJKPXSGFbc/gTG2FAMPbwDhk0h60/Nmnz+OdxaT
	 hCQpsnM158Btl2JA/zNqAqEEWMuSZynvwhQdn6iFsT3zHCDeOMjkcsdHYy4c5BA4HO
	 SyLkQfW/HOOA2bOlaD+/3RZWCVFSH+WhQkWQlgPEXKDikOvh7WaE/yUT+0mI6XMuGG
	 GHAkgCAkvFb0Ezs6yRAlKAANIOAaPQ1Uhpi/givOfq5JvheZ2sVvftbMWKm+0rJ+la
	 XmzJPzClpR1+TPPbwTA5/JOhOBIvr/hGDmTBm9LSLTKu1NYUSpbddFCzwsKR7EysDk
	 fqVL4Lp+EsuxMGZBqX7afwS4G9V/ajIC1FZR+k4eUAchhcZgKGTsHHXaq4fInM0Bf7
	 HAriFeBSCfkRn4T3SO9L/G+8=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0538740E016D;
	Fri, 31 Oct 2025 12:29:38 +0000 (UTC)
Date: Fri, 31 Oct 2025 13:29:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, dwmw@amazon.co.uk,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, hpa@zytor.com, x86@kernel.org, apopple@nvidia.com,
	thuth@redhat.com, nik.borisov@suse.com,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	kernel-team@meta.com, Michael van der Westhuizen <rmikey@meta.com>,
	Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH v2 0/2] x86: Fix kexec 5-level to 4-level paging
 transition
Message-ID: <20251031122938.GLaQSrsjuXOp6FA8p7@fat_crate.local>
References: <20251028105637.769470-1-usamaarif642@gmail.com>
 <20251029204814.GHaQJ9jhw4u5SU1rNJ@fat_crate.local>
 <e7h3mlj6x4k36e2ydsmbqkulh3ombhm3j4kvmw4pzlynoaaxjz@yrth4sw2tf26>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7h3mlj6x4k36e2ydsmbqkulh3ombhm3j4kvmw4pzlynoaaxjz@yrth4sw2tf26>

On Thu, Oct 30, 2025 at 10:23:11AM +0000, Kiryl Shutsemau wrote:
> Older kernels in our fleet run with 5-level paging disabled. The newer
> one enables it. Machines need to switch between kernel version from time
> to time for different reasons. Switching from the newer kernel to an
> older one triggered the issue.

Thx, makes sense.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

