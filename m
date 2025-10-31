Return-Path: <linux-efi+bounces-5302-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B23EC25DA3
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 16:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18B1A34F537
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 15:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEF92D6407;
	Fri, 31 Oct 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AJLpB3Qx"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102392D7392;
	Fri, 31 Oct 2025 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761924849; cv=none; b=gwO9n+dSc4jBebvCfX+Mc+e7a/8L/qEt3ahxdr+wzwT8Ao0axTdfWfswbGPkzfTzLJH3puO4FjVufTufOc/pS7tPjJ3fw3cEudS5BlOLXAau309+CzMQO2wjePl5sB8R2Wo4v+0m0fsn6Tririe2gWvCtSV0XcxYOyG1hTubYGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761924849; c=relaxed/simple;
	bh=kJmRRnNeS1owqm0E/1djEGR1sOxq7Nu3f4G1MM+I2Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo1Y1ML4E9JlcPfjfEnG4expbWtNBDQANKlXxIsKaTekjBLzDQrbXikPsfWR3XjHwiNK+26DzWSBYVhKA1vOcRGmDhOaJcxZwR1u/OmVUjOi9Rw3V2d9pjem3TY1jX6o9GJaEinkumxgrmZfGZn1QgtKw5WVJVOYFQLtKPotDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AJLpB3Qx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A857840E021A;
	Fri, 31 Oct 2025 15:34:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QT8xxUEEt2T5; Fri, 31 Oct 2025 15:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761924840; bh=f00D3S5AR7vMTHGqzBoI83rNHDDKZCTG2jsuv9IM9Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AJLpB3QxqFudtVnzMYLQ7RmFM9EPdqwTV4njAwFElqSe+bdglxejFhwAWYDWWMzXx
	 4i5ir2ixnQ35wXxZYHjY7bCAriWWX8qZvkyu2yB9mMOsxItmEB0F+dNZCut/I17rGB
	 0PqRCSWxPm6SID2wgA04CsmyQ4Q4dHQHUXCXAaXITp+bwR7ynzX8lhlh9i2UZC0Rai
	 IyPdlwFRDQX7I3toF9J49V/vGYnv8OIBxD9oU0w9+zDwLAK4jzvh92GsVD//hb/3rs
	 fjsDnr0d1Qi6F8fWKeQjx0uCD3sh5e8obAVQFlVXK2LZj2dRVUeE9qFt0vE5W3Se/e
	 ubyRyV7+LuSK4Fjv31WWLhkBd37qpwEhjoIB8S7gaCjBGd4z90F8SGNNQOMiCVCP0W
	 uTQ0UuOED+PfAS+JC4nsqdq5WPFQQ9Dt0rx1sRWdJEsIebu4zuHEO6IlNGtnb1ayVA
	 jRgkwo56HVVJMrxGaNNJcZtSzkv3iE02PxNVxjpmLFtNbW2X/nNxQky+SZcW72XrGv
	 pmWcp0+sWJOHEX1GPqVu+Ybh7X4q61crkHof31kVqm/pKhSmP7POlvbnzgkH555rpP
	 RPxIbSTBkRXsiLbHkjXjpw5krf2M4ptPP81EygXYa/yzn0uXz1KVDe7pazDNHXOe7x
	 iBlzNF4Jd/GwxqV2J9rfg5b4=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 38CDC40E016D;
	Fri, 31 Oct 2025 15:33:43 +0000 (UTC)
Date: Fri, 31 Oct 2025 16:33:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, dwmw@amazon.co.uk,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	hpa@zytor.com, x86@kernel.org, apopple@nvidia.com, thuth@redhat.com,
	nik.borisov@suse.com, kas@kernel.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, kernel-team@meta.com,
	Michael van der Westhuizen <rmikey@meta.com>,
	Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH v2 2/2] efi/libstub: Fix page table access in 5-level to
 4-level paging transition
Message-ID: <20251031153336.GJaQTW0GUyWc1CZla4@fat_crate.local>
References: <20251028105637.769470-1-usamaarif642@gmail.com>
 <20251028105637.769470-3-usamaarif642@gmail.com>
 <20251031144002.GMaQTKQnpp2u493ZZS@fat_crate.local>
 <CAMj1kXEwfYqTG2R8m8+t=DLFsBY3wxSm1b70DyK2gu_TF-L4wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEwfYqTG2R8m8+t=DLFsBY3wxSm1b70DyK2gu_TF-L4wQ@mail.gmail.com>

On Fri, Oct 31, 2025 at 03:43:25PM +0100, Ard Biesheuvel wrote:
> This code should be using native_pgd_val() not pgd_val().

Seems to fix it, thanks.

I'll let Usama do more testing along with the usual build smoke tests - all
permutations of the below:

ARCHES=('x86_64' 'i386')
SMOKE_CONFIGS=("allnoconfig" "defconfig" "allmodconfig" "allyesconfig")

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

