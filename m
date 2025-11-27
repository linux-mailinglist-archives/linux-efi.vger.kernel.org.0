Return-Path: <linux-efi+bounces-5714-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1ADC8FDFD
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 19:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EF23A9EFE
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 18:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA282FD7CE;
	Thu, 27 Nov 2025 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AgAPsYSW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51DE2FD7CD;
	Thu, 27 Nov 2025 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764267186; cv=none; b=ZYphlVcOj0DYeNWHa7W977dxzsOU5fwiTbN1zzTz5vVKEDhg8L0DuJXohA+TRS04hRsnXwkiGVxzdLv2QK/5/PVdvjfwRC3DysqXHOAQWn4bfIAG9A25zxk6aTnSN9fJaUparY78iYR2mSEJ07HJ2y44+l/CBoAQrMeb3EOGkEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764267186; c=relaxed/simple;
	bh=l4st/do5PSp4dZem/x0fzQYPMaR8BW/0B6gXYjRptQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRP3yEhws+x0hsaaKUy3TbGOsO9Y9nC9PE8511I+GJS/FWpME37LbYcyz1QL0M9PDAPjCTvg0w9RljkFx7q4g73k7XlNxdpjy7hlzHk2N3RCUrrA+pVUVcEWq6wI61L1TBtDYRBTebRtovIoW2DwDTvKubnmP0dWVZz5DR8zAr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AgAPsYSW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7A0F140E01A5;
	Thu, 27 Nov 2025 18:13:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ckcqr7l0S_Dv; Thu, 27 Nov 2025 18:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764267175; bh=toswCiccfDRgBMXp1RMWgi8nHKTH1DMLdV5VQ3k89kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AgAPsYSWeoSvOEjCZ/RC1kmrOolDLgjFKbUf58BJahK47BfcR/dpL8Qq4OEjJqM7p
	 PeQ0HMqmkd7uQDwbkSgRcAQ/8APE7BBnnkcluh9p0I0m2WsDoof6kSZ80Uqcesykva
	 MzTRX/uO386yMYGQItgx1EMzVRAScZAZV4rRZxffke0N/3HUuHw1Pn5fDMtZM9af9j
	 s0VNj0ej+J3FcDwJ3Ym0T1yNRvt+zxl/hyghcoRnsJoy+ArHRbawYMENXWgrAzMv8r
	 3MG9GrE6cfB+vv+XCaRk15W6oE9RfF/B5dJSONLYgz+f6n2Yn8IeS+Xexcljx/Aw+7
	 73gGxb/3fzzb1hY7otKRfvPyI0C6xIA3BmeudLZrjYpb02Br5v2JxDXSG+iM88NyxO
	 kBUyj2Fpu2IA4w0vxFSrruAXnNU+YDviw26+PhjPo0bMgpze8bEdi+TJHBemOh5ktE
	 Gt/uIba18w6pIQWKqGuRftGPrCFBBGJE4SMENnD/EewdVggp5ixuBJqEVF0opaLcR/
	 uJNlP9UaK6kE/rdmeEAeIkBAHd44neUJiCiL2sWM1COCGCeDAX6/uF395HNoDaIZRV
	 esdbutJTzk+C5rWbFGLpaLkPzIAc28sBOHHVOc6d780i6AZEaOarGsvPykPAXnC6jq
	 LMo7njMcEIx8ddyTdXpvS/ZU=
Received: from zn.tnic (pd953063a.dip0.t-ipconnect.de [217.83.6.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4191940E016C;
	Thu, 27 Nov 2025 18:12:39 +0000 (UTC)
Date: Thu, 27 Nov 2025 19:12:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: "Pratik R. Sampat" <prsampat@amd.com>, linux-mm@kvack.org,
	linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, ardb@kernel.org,
	akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
	thomas.lendacky@amd.com, michael.roth@amd.com
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
Message-ID: <20251127181233.GBaSiUkaLzwANS_6WT@fat_crate.local>
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
 <20251126223127.GIaSd_v7juUkaW4RTA@fat_crate.local>
 <m3l6gcjmbabudtnqwv6w67t7iz2mpmbjyrpnmiq5k2iyargn5d@nyf2zzxx7yme>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m3l6gcjmbabudtnqwv6w67t7iz2mpmbjyrpnmiq5k2iyargn5d@nyf2zzxx7yme>

On Thu, Nov 27, 2025 at 05:35:57PM +0000, Kiryl Shutsemau wrote:
> > ABI break for kexec? Is that a thing?
> > 
> > Since when do we enforce ABI compatibility for kexec and where are we
> > documenting that?

I'll take that as a "no".

> The whole purpose of kexec() is to switch between kernel versions. This
> struct defines format we communicate information about unaccepted memory
> between kernels. The mismatch will lead to boot failure.
> 
> The structure is versioned. Ideally, we should know the format of the
> structure the next kernel supports and act accordingly in the first
> kernel. Like, we can accept all memory before kexec on mismatch.

None of that matters if you kexec the same kernels.

IOW, for some reason you want to be able to kexec different kernels. The
question is why do we care?

AFAICT, nowhere do we say that there's an ABI between kexec-ed kernels...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

