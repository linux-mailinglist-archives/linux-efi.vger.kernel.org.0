Return-Path: <linux-efi+bounces-5691-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AABC8975F
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 12:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E01AD4E3F3B
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 11:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D4931E10C;
	Wed, 26 Nov 2025 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahas3Q9R"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594B331E0FA;
	Wed, 26 Nov 2025 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155536; cv=none; b=vCcV9Fb77uBKVCzm/Fyq9PU3yQ68njT7kZpu7ItgSiFOnsDCSHXMYICh+ETksnHmITbYc7n0rfhP3GTy/qTrvBoN2ggosMj95v2M/shaGylx2DnIcJYxqDm7saYGqzvHC47pGeu+O9fAtsXCFFf/19P/2NsRjEla+ZM1iWdbd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155536; c=relaxed/simple;
	bh=5phfIDtqojfphtJHC0IyyK88IR5Qb0Al5LqeMavVjCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJPdsemPNph40BhDOVYjw5ly0+L4cMYfS1b02oV9Nnnu5/SRALhXjDWJtxKE0r323tTwBP7kD0e6DFLXGETUlZ1amQoodzPrCZeN63xRGj4KvAmf+nOiRt756WXyJCZcdblvJ+4OZAOKM3VAZRuoGupd5atlyxpx+pUa7Xm7WWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahas3Q9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50491C113D0;
	Wed, 26 Nov 2025 11:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764155535;
	bh=5phfIDtqojfphtJHC0IyyK88IR5Qb0Al5LqeMavVjCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahas3Q9R7vcSoOjtyH5xVKKoUfwGEdH9YMldDKqXq7mpjBVe/reDYQk7Rgzkj4e+s
	 TBIa+lBkRYJGxTRgrDpPfWyRv35mTXW5fWk9DgMd+XM6igQi6F+fwRaZOxbnmrCXYr
	 a09ZJ3S13BjHAStYY6A2tjPlghbu/LOoumFRrjgFt65256V45WJ+S+uuVdk6NfwCNr
	 d7FlobxPExcOh4NnQYVFm7NbSsKXXG42nfB6UH/INHjNpu1CuNWXRzpULftHLpU4OF
	 nEpaUs6QJ36yfubqngrXcfFa8768pBWmASIN295allbJG6nZI5Oono8+fhC/CmS7/w
	 4EXevleu9s31A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 94BB2F40074;
	Wed, 26 Nov 2025 06:12:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 26 Nov 2025 06:12:14 -0500
X-ME-Sender: <xms:juAmaY-bPQxSpO90AeZ11ay5E1II4KyzeP-auTctxsJsyfe8E6ERhQ>
    <xme:juAmaeNloSl5Oz3Rld8lU_p-bcUfLyTHkQfLufFM7sFemsug7VmlCZ5iobxMMWkHX
    q6XdRpgqKrzzJuBnzHzAaJBmgruoWypZ1PYHoqzCoMk6RlLvGhgBmQ>
X-ME-Received: <xmr:juAmaaFp-4zS2N67TEm6DLu-cw5C6ucRk0LqboOy0Q_Mb5plFPd5GChN7ZjKkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehprhhsrghmphgrthesrghmugdrtghomhdprhgtphhtthhopehlihhnuhigqdhmmh
    eskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtohgtoheslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgvfhhisehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhinhhgohes
    rhgvughhrghtrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggv
X-ME-Proxy: <xmx:juAmaVuHz4Q9ULWzJJUeST1UHoh03F3sIGKS5znoOrD4KIgaxwi6Dg>
    <xmx:juAmafvktU0ExlYil5wOkBt_9KuFRpW4x_r0K_ahKgKpZr1_VL6Cxg>
    <xmx:juAmaeG7L5E0ycU4wuE0iz1pFqA4px9-clJYEo19cBuLfVjKP-BV3A>
    <xmx:juAmaaK2w9R9Yt78YpWSRzvsz5mxG5QWTCrJalRDZsTdXL6CTZ9LXw>
    <xmx:juAmaWYb6hiZ2alAOSPn83_ldxz5MrrVXz7FSLLFWHIsvoMAmDw3uegM>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 06:12:14 -0500 (EST)
Date: Wed, 26 Nov 2025 11:12:13 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-mm@kvack.org, linux-coco@lists.linux.dev, 
	linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, ardb@kernel.org, 
	akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de, thomas.lendacky@amd.com, 
	michael.roth@amd.com
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
Message-ID: <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125175753.1428857-3-prsampat@amd.com>

On Tue, Nov 25, 2025 at 11:57:51AM -0600, Pratik R. Sampat wrote:
> The unaccepted memory structure currently only supports accepting memory
> present at boot time. The unaccepted table uses a fixed-size bitmap
> reserved in memblock based on the initial memory layout, preventing
> dynamic addition of memory ranges after boot. This causes guest
> termination when memory is hot-added in a secure virtual machine due to
> accessing pages that have not transitioned to private before use.

How does the hot-pluggable memory look in EFI memory map? I thought
hot-pluggable ranges suppose to be declared thare. The cleanest solution
would be to have hot-pluggable and unaccepted indicated in EFI memory,
so we can size bitmap accordingly upfront.

> Extend the unaccepted memory framework to handle hotplugged memory by
> dynamically managing the unaccepted bitmap. Allocate a new bitmap when
> hotplugged ranges exceed the reserved bitmap capacity and switch to
> kernel-managed allocation.
> 
> Hotplugged memory also follows the same acceptance policy using the
> accept_memory=[eager|lazy] kernel parameter to accept memory either
> up-front when added or before first use.
> 
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
> ---
>  arch/x86/boot/compressed/efi.h                |  1 +
>  .../firmware/efi/libstub/unaccepted_memory.c  |  1 +
>  drivers/firmware/efi/unaccepted_memory.c      | 83 +++++++++++++++++++
>  include/linux/efi.h                           |  1 +
>  include/linux/mm.h                            | 11 +++
>  mm/memory_hotplug.c                           |  7 ++
>  mm/page_alloc.c                               |  2 +
>  7 files changed, 106 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
> index 4f7027f33def..a220a1966cae 100644
> --- a/arch/x86/boot/compressed/efi.h
> +++ b/arch/x86/boot/compressed/efi.h
> @@ -102,6 +102,7 @@ struct efi_unaccepted_memory {
>  	u32 unit_size;
>  	u64 phys_base;
>  	u64 size;
> +	bool mem_reserved;
>  	unsigned long *bitmap;
>  };
>  

Again, this is ABI break for kexec.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

