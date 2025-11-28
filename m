Return-Path: <linux-efi+bounces-5719-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C80C91CCE
	for <lists+linux-efi@lfdr.de>; Fri, 28 Nov 2025 12:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97E1C34330B
	for <lists+linux-efi@lfdr.de>; Fri, 28 Nov 2025 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15313093B8;
	Fri, 28 Nov 2025 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jqPsd8CW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809AB30103A;
	Fri, 28 Nov 2025 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764329688; cv=none; b=aGRsXoSowy9ik9QKK2Vb1XiQdsvh+IoyZWQ1g0Xa437V4lGe9iFUrz46Fup+1kQg7rpdBGBIr8M3aqrAn1252KgGs1IUFsXTxHO+sD0IDlgzAHhmX4hiFn48HGAPNRKGiH4px2k2U4qnvUkRlQt+UXEA8SJ46M68c9OZZHSpX4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764329688; c=relaxed/simple;
	bh=vjKsNJcNLGuEthGr4lKZCht1+ua97+nPHkIJI8VIhAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE4EsQts15TcthOhC1A/lbZnZW1xMnNvJ7uRJi4mniS04eIxS+taQ/rd8MKoQPk+qkxvzSgzytEcWhCfLGODD7c1E/eN3P/0uYVPP2Lzlo8p+NE41ogmE+9xnlf7G1G2x9iPMUCpWxNrmoSPMpqNeVvjeWuCKXFLG+WFJhJLicU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jqPsd8CW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 97AD440E00DE;
	Fri, 28 Nov 2025 11:34:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RUR8aTs9spya; Fri, 28 Nov 2025 11:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764329674; bh=n03pb56uV/bng4zeqw0XDs9CYZXB2sMRKA0NowRt37o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jqPsd8CWkdP1sYlUop+5YOGjpjpKztitu/YqeuhptdC192Kr6sCl9pIdqWtUTTQ4d
	 RlzFfkaEAwP2Jgux2YS/9xQK4tpEHyFmzGUD+QrBOWQxg+1XDNupu2hatR408pAgX6
	 sYalciOLua+VUGjn9+zrJpYz73MCkaqISeJw6eBEYVZcVkAPpXeZY/F7HcoYvSInGp
	 Zb5d6b04IdxdrBeoFmY7H6VWcL/y/vJZ9F1xjMf3ubISmokhwuSQ4Z/bHPxEweId+w
	 xIrn4wDPIXpHxUgVw4U8MJNIf/ahF/3/V7LLjGQ2LAPE50hskEZnIJfAh1ylJwHuz/
	 098vVCxSaP5i0oitGnzamsx88hO+M5sYkYOaS2W4nr5n9NAAUldloZGZc32ljKNCfA
	 K6LgfpK0oLEpWWDVSBg/+VHbUlncNcO01dRD+ZZAEY2zuojrhGw94wqqAWQdyH0Jjm
	 SFFZPPZVDzyFIZjXPezuOfYJN+9FbGr/j5tFVprbuOTmffG44hYCmlrgtFFjw8VPP3
	 sNoHRlZsgOklHheNX5P27tvAb0fQBrFm2ViGYPGBw4o5wyTY7yplAJ9BZYyxjd4NMb
	 ZlgRTFo4Ffw2ZlplE66i5QqEvPvxpu0JWa/Hzf19uoi8efmaZOOStL/8yiJGshFyIG
	 e0rb7cPSvVzh/NQcSv0U0hGQ=
Received: from zn.tnic (pd953063a.dip0.t-ipconnect.de [217.83.6.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B1B2540E0217;
	Fri, 28 Nov 2025 11:34:17 +0000 (UTC)
Date: Fri, 28 Nov 2025 12:34:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, "Pratik R. Sampat" <prsampat@amd.com>,
	linux-mm@kvack.org, linux-coco@lists.linux.dev,
	linux-efi@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, ardb@kernel.org,
	akpm@linux-foundation.org, osalvador@suse.de,
	thomas.lendacky@amd.com, michael.roth@amd.com
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
Message-ID: <20251128113411.GAaSmIs0kSWGhCYkaA@fat_crate.local>
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
 <20251126223127.GIaSd_v7juUkaW4RTA@fat_crate.local>
 <m3l6gcjmbabudtnqwv6w67t7iz2mpmbjyrpnmiq5k2iyargn5d@nyf2zzxx7yme>
 <20251127181233.GBaSiUkaLzwANS_6WT@fat_crate.local>
 <beec5651-5c23-4f5e-a0a3-d1cc01a8490a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <beec5651-5c23-4f5e-a0a3-d1cc01a8490a@kernel.org>

On Fri, Nov 28, 2025 at 10:30:15AM +0100, David Hildenbrand (Red Hat) wrote:
> kexecing the same kernel is typically used for kdump purposes.
> 
> kexecing different kernels is used for all sorts of things (live-upgrade,
> grub-emu come to mind). It's quite common to kexec different kernels, or
> maybe I misunderstood the question here?

And my question is: since when do we enforce no-ABI-changes between kernels so
that we can kexec any kernel into any kernel?

By that logic I should be able to kexec 5.x into 6.x. I'll bet some money that
it won't work.

So unless it is written down somewhere, I think we should probably talk first
what we want to support and why...

Makes sense?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

