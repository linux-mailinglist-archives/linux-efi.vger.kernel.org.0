Return-Path: <linux-efi+bounces-5713-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 744A6C8FB8A
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 18:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 332CB4E2485
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 17:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BCD2EA756;
	Thu, 27 Nov 2025 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6KAeKYH"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8AD27874F;
	Thu, 27 Nov 2025 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265227; cv=none; b=BrjUs+84Y1sUZHCAWgj/fa6AKjPDwD2gXFBGk2mWs+YBWq9KYmo2pVK35tj3R0dilgOmM8ldiA8840vj9Ev4VPoFBAdB44BqY/Cd3C0gAnktO1Paf6TVipqduWZtKmg4m6z/6PydvdxO3neF6Qc83LzVoIIddrPKiyu42d6aceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265227; c=relaxed/simple;
	bh=9fFK8uSNyFugEtT3snd0Du4kcqgnaKPZIsCUJy+1QZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJlvK/zbdSK1FoD0/TFPwR1drb1tUlI2QexT73M+mmoFi3n0p8pl2nT0ZX8y0UNWCDeEXgvoWiPrW7lEyp8G+5Qz6YJsYTxHYnIJVQt16alnA0GaRgL2QLhJ/Uu8ACnkM0BkO/9QNdjP81Ucrt4jHmjBSYocJaakcKBlGfxJfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6KAeKYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40580C113D0;
	Thu, 27 Nov 2025 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764265226;
	bh=9fFK8uSNyFugEtT3snd0Du4kcqgnaKPZIsCUJy+1QZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6KAeKYHBPaFNr9lkiGFlrREU/yBUfh+robz08P/eZf9eqBRYMT9LzVOrLOCb6pEE
	 n7iUJDN+VjA1MBuP2u+IhMEWGbxodUo8CZ+/Xx8LH7lhVhWzDQvO0e48NGspPBhd8v
	 o/Xk8JvzgBClSRjPZlcHld32oo4Xu/WOvQhFPJjI97eu2vbSneM+6mkdeBdoiOgeay
	 GxU9SEjXrrNijEtfjXMmJk5dnQXr7sM01nEP37ENZr3s/iemu4q4bnCWRz3l6kwO23
	 amwSAIpWdxoh889s2QDGP3ua0UkDQpi3O8QmaodwxyIXVd36OD/sFeg3G8V2uEk/Hz
	 iSwKx14MM7vxw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 83329F4006B;
	Thu, 27 Nov 2025 12:40:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 27 Nov 2025 12:40:25 -0500
X-ME-Sender: <xms:CY0oaQIiDrhEv_K-RbyPcD6HXu2gYPKwiyag62XA2nc8bTx-NeAW9Q>
    <xme:CY0oadr2OVZivmTKbSy5KaW73OLe-1w2RxdW3oFJVJUg2VsGcdgOnQ1tbM0Rur-Y9
    RY6KHVbMDJnSp5wRCFOEvmStZwDl19e9fInVP5oBkiK29LQw8aNkeY>
X-ME-Received: <xmr:CY0oacwM43GT6XbezS8e9t0SScyPcUCzHw2UwZb-zIjec399H1KDpGY9puXWag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeejkeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:CY0oaaqirM3EjJG4FTKCafXOIhSssiROrKOwiMwloed9df-GSH-vAw>
    <xmx:CY0oaZ5_N6lDtaSFUA5XpmUb8Gmh8_PFEvm2LzK2YExCdtohIzp0VA>
    <xmx:CY0oaUgFkeAYmET-buxhAOiKHTYGYVgEoq9BpbypAa2VIkaHrV4ofA>
    <xmx:CY0oaX2BFgbqjRkgEZ36rbhLKK0g0NljSv7Nubq5vET8zsRcqy19Dw>
    <xmx:CY0oaaU8T2fr7mCRIn-AAnQ27DtjClC1SuHN-RdidgsyrmR4fuQOvHkQ>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 12:40:24 -0500 (EST)
Date: Thu, 27 Nov 2025 17:40:24 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-mm@kvack.org, linux-coco@lists.linux.dev, 
	linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, ardb@kernel.org, 
	akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de, thomas.lendacky@amd.com, 
	michael.roth@amd.com
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
Message-ID: <dy65eupwalp5wsljetlto27l6tjjvoygeotjd3n7mk7zjc4dma@jf4hzsy6rtcd>
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
 <14df1d99-7df0-4982-8029-e66dfb140399@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14df1d99-7df0-4982-8029-e66dfb140399@amd.com>

On Wed, Nov 26, 2025 at 04:27:29PM -0600, Pratik R. Sampat wrote:
> 
> 
> On 11/26/25 5:12 AM, Kiryl Shutsemau wrote:
> > On Tue, Nov 25, 2025 at 11:57:51AM -0600, Pratik R. Sampat wrote:
> >> The unaccepted memory structure currently only supports accepting memory
> >> present at boot time. The unaccepted table uses a fixed-size bitmap
> >> reserved in memblock based on the initial memory layout, preventing
> >> dynamic addition of memory ranges after boot. This causes guest
> >> termination when memory is hot-added in a secure virtual machine due to
> >> accessing pages that have not transitioned to private before use.
> > 
> > How does the hot-pluggable memory look in EFI memory map? I thought
> > hot-pluggable ranges suppose to be declared thare. The cleanest solution
> > would be to have hot-pluggable and unaccepted indicated in EFI memory,
> > so we can size bitmap accordingly upfront.
> > 
> 
> I'm not quite sure if I fully understand. Do you mean to refer to the
> EFI_MEMORY_HOT_PLUGGABLE attribute that is used for cold plugged boot
> memory? If so, wouldn't it still be desirable to increase the size of
> the bitmap to what was marked as hotpluggable initially?

I just don't understand how hotpluggable memory presented in EFI memory
map in presence of unaccepted memory. If not-yet-plugged memory marked
as unaccepted we can preallocate bitmap upfront and make unaccepted
memory transparent wrt hotplug.

BTW, isn't virtio-mem a more attractive target to support than HW-style
hotplug?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

