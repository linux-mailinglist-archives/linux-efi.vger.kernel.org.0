Return-Path: <linux-efi+bounces-3615-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E42F5AAC13C
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 12:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC8A1C26742
	for <lists+linux-efi@lfdr.de>; Tue,  6 May 2025 10:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A52750F8;
	Tue,  6 May 2025 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="t9laNfpO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VhWTbcbI"
X-Original-To: linux-efi@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B102750F1;
	Tue,  6 May 2025 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526996; cv=none; b=QvCVrFEbBlw+o2HWYDesh+gVLyv0YcGGNip07IPMRFT9u/+HZAuCAhJxZDLDm6eH/6qY2xrSYfiwXFDX0nG3ltNL7FsBessac3QKa89e8tCEBMQxJ7dszlc446tNpOuE5JyS8hw1Q5QlFuv69dwKf2T9Sr5PN87QathrTPbIkdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526996; c=relaxed/simple;
	bh=ufPIm0bQWPXgT/ISvj3F6tBKU4TGGEsrDy5DRKmXyTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smqgbOhHPIUAc2x2swy8qzaXWlV9NuVYEPj4gljJD/0wegk519r84fkWyjKx2THrx2x4ePX4d9PrItzab6++AtcY11Jyndzo1ohTfF18Nb5DzxQ4S2NE5IiZFWChJphTzwQk23nZIcxqHK0HbgShEVTDS2XOz1HvcGjrc9eiC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=t9laNfpO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VhWTbcbI; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 47CC411401C1;
	Tue,  6 May 2025 06:23:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 06 May 2025 06:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1746526992; x=
	1746613392; bh=98gmRsvCbFVOGYxJYzCbqyQEH25wrcIQxT9aYd2p6fA=; b=t
	9laNfpO3jUO3G7s379ic8qjoW7DaeY3AEH3IqlZJFOOMZZB9hAr4U59R+ktIWee5
	TRvqLJO3ve4YNBkF8x58qX9PVm2Uj0ZnqCTxDuxBtnNHoswI23xdVnkuqKaMci76
	Zj301rMwUrGGVBS/aT83JOBW9MwQqvzenEnkmMD16zU8+cQ81hgbftiEpMVCXNLb
	DrjAvZsauWEw6KB97kDvnmUAhD/WKAKUjR4cH6rg6SZj4qCfDuEXR5mnpYEcYKVz
	bhBfJdLL36x1FNhzuDPaH9gk5ajfJO7zX0wNcbIjAMg0yDHFjcn0nnTMBjrsChDV
	Gx2qgI2HM7lyuF4ZEF5GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746526992; x=1746613392; bh=98gmRsvCbFVOGYxJYzCbqyQEH25wrcIQxT9
	aYd2p6fA=; b=VhWTbcbIuxrLFcre+giObUABkIvfGIjxXofa+O5PQgz6NxpDPIQ
	cBl/8OMdy8oOLJWzc/M7qVtRa/FdaoqC4ox4sRU1ZRqUYsn8bNMObKL05Ty126hz
	wMPH2Hm24dgOIskG/CS2ApUzLUA7iwlzI1OFBE8kVKfWDZ6s8eP2lZKs3M7C6VHE
	syqqlQsJoiNogZCyMVA0enGwMXu2+B6BfEz1YMMHy2a4CDu4fr9LfOxh+XrKXIeL
	tANUrTgR6uUlwk+P6mI9h+iz+rxzM1DC/M3UV0yr1WpO4YKtL/S52ZGxPnn8zLNk
	rO9pmzATy6fznVOAiXgP739mjPxd7UtNYlA==
X-ME-Sender: <xms:D-MZaIxLuyyxQAik9_P6LB2gChIUUTAs4ps6EQswt6T_2f8gkHZtHw>
    <xme:D-MZaMQOpaa4mS_EGWFHy0CZFjaMrAeDb3WLA2uKm6Xi8fWKYVmcR-W1Z7zfC_l1h
    fiT7h4S3YZC4IpGmms>
X-ME-Received: <xmr:D-MZaKW5m8sKV_LcTTgWacudeo_2yc8FdBgDzoBVL_2U_ntfqgAAGgXkPB3D-hZldgoQNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilh
    hlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfh
    hfffveelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghm
    ohhvrdhnrghmvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegrkhhpmheslhhinhhu
    gidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqthhiphdq
    tghomhhmihhtshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhngh
    hosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhr
    tghpthhtohepugifmhifsegrmhgriihonhdrtghordhukhdprhgtphhtthhopeguihhonh
    hnrghglhgriigvsehgohhoghhlvgdrtghomhdprhgtphhtthhopehhphgrseiihihtohhr
    rdgtohhm
X-ME-Proxy: <xmx:D-MZaGi1Fxk_2fMQcnlUue1HCzOgrVFrlAVHmJixn2u3JJp4bzBqPA>
    <xmx:D-MZaKBxN6SNYscqSVwneba8oPWAUeEbXvgpCDdj_dq94_gFKa0_Lg>
    <xmx:D-MZaHK9F7x62YKyBDdB5YV3qd9k7yYi4an-5JTiBUa1OdbD66Oq7w>
    <xmx:D-MZaBCnBV78nem-VuaiIQjOvCSwJgVYmE2kNYWQBfjHjEr7VHYUqw>
    <xmx:EOMZaDRLjMEeRfiC5JxnVCRs6Xu3GUqYtFa5aVcwevsJ8lvcAyJCgaRT>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 06:23:05 -0400 (EDT)
Date: Tue, 6 May 2025 13:23:01 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Woodhouse <dwmw@amazon.co.uk>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Len Brown <len.brown@intel.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: 4067196a5227 ("mm/page_alloc: fix deadlock on cpu_hotplug_lock
 in __accept_page()") (was: Re: [tip: x86/boot] x86/boot: Provide
 __pti_set_user_pgtbl() to startup code)
Message-ID: <6xlb5o4fqzn6o3jojwvav7aln5uyiraox573zntxspjkwfbkzi@yx53iy4h7gw2>
References: <20250506092445.GBaBnVXXyvnazly6iF@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506092445.GBaBnVXXyvnazly6iF@fat_crate.local>

On Tue, May 06, 2025 at 11:24:45AM +0200, Borislav Petkov wrote:
> Fun stuff.

Ughh.. Thanks for digging into this.

The code around static_branch_inc/dec() getting way to complex for the
benefit that is only visible on microbenchmark.

Let's just remove it all.

I will prepare patches later today.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

