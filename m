Return-Path: <linux-efi+bounces-5712-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 283ADC8FB7E
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 18:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DCBD4E0405
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 17:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7432E0902;
	Thu, 27 Nov 2025 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHrXJqvn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C462D592F
	for <linux-efi@vger.kernel.org>; Thu, 27 Nov 2025 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264960; cv=none; b=Qn+nImXwtHim0N1IO+Ktw+pmequyWSIzf/54mtvcgMfGAuUzlhlC8vjDJSeJcT+cYm1eGclKRTwHCxTWbT9dVDbMnh2Zf/RpYcUH4KI7hzKuBxBN6NpIzB1DS9zsscCIuVD5tQSWSmI3dhPtf7EXwtWLZznLzlQ+WszO0uiQLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264960; c=relaxed/simple;
	bh=1bKaUQJjk7onHAJ7LM9S6djrYU/YUN9thAsdh7lkx1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq5g9skFJkoIzLNBqp2HY9U0Lh4UnQDvoz/3Lo1XgVXH4GY9ixThNojQKvmmAzyWex9/AG2XXho623ZT1+oC/23UJGYUjXE0YBUCJIq3wLI8jdfLEOTus583ehBGCvHvQPLdtuUzGxonv6RH5AxFa2CFyNf8p9kgf3b98FtWIfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHrXJqvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D02EC113D0;
	Thu, 27 Nov 2025 17:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764264960;
	bh=1bKaUQJjk7onHAJ7LM9S6djrYU/YUN9thAsdh7lkx1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHrXJqvnv3VYvDhVdinf852sfed/TyNbIGnhrgloxH8o+ch+KKmChROix4wQrQTON
	 6HQUW36nzZBlGd7Wdt6rkWbDKjr7GTofUJa1Tsd7yUQuM5shfiep2cQ4F0vft1wPaG
	 KJXvdJK3EIrVqa4E3/RVw4DNpUvo6TTfAMo6wgf26MVq2JxEtR/MHDAskB8vDNnj11
	 Qajim3LgpnBYnLowG8eoEjufKhTDk4cXrTuldHlHcPj0whhB4ir/jBDm3dWdppebyc
	 9lF9PK575yRc3JmKQwZwpCa5LSVTf423V24UaDvHd4wVn8NenYCc7yeZp9d+X782rt
	 ZxNirgxlq2Vpg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B4FC4F40075;
	Thu, 27 Nov 2025 12:35:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 27 Nov 2025 12:35:58 -0500
X-ME-Sender: <xms:_osoaQwWPaEieY1br7DZkeVphjqMCBSEtgP6-Le93aV3X2LmOULmSQ>
    <xme:_osoaRzbsHN_dgyG6RpwUE_kgYvBGvJxCFpqsYhpzINhcyNB9zi_LU4khX-vETWI9
    7ZJ0qvaK8lcH3wzJiP8ZZSoWY8Gzrm-CPCyU2YvRAEuDxJSzxuSNw8>
X-ME-Received: <xmr:_osoaeaIbXfvF2FB-G3B7qcQmAb1234r4WCi9mttgI8X1MhqkxlVVZRgTUEoiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeejkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehprhhsrghmphgrthesrghmug
    drtghomhdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphht
    thhopehlihhnuhigqdgtohgtoheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtth
    hopehlihhnuhigqdgvfhhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    giekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhho
    nhhigidruggvpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:_osoabzVGoneUI9bcGJpOEKwo-4Kyoc7Pp4k_O66__SSZgVrhQOH3g>
    <xmx:_osoaUhqnSkooMnXFxuH3Wgxv20PIKkfYihKsVwfWiBcjpW_V9tqVQ>
    <xmx:_osoaaqrgt2vnUA_Mpduv6oyYvQUpmujbNtzg1hVLFYlKAAlklnljA>
    <xmx:_osoaTdlzjKaVIDPRlENYBvpOcia0uFb3pRE82NtnPX6FLAjI8PgLA>
    <xmx:_osoaddOrOMRw4zNiHP37WyO6uX5UemRRCtkTWhj9mk6TNbwTw1PWnzN>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 12:35:58 -0500 (EST)
Date: Thu, 27 Nov 2025 17:35:57 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Pratik R. Sampat" <prsampat@amd.com>, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, linux-efi@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, ardb@kernel.org, akpm@linux-foundation.org, david@redhat.com, 
	osalvador@suse.de, thomas.lendacky@amd.com, michael.roth@amd.com
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
Message-ID: <m3l6gcjmbabudtnqwv6w67t7iz2mpmbjyrpnmiq5k2iyargn5d@nyf2zzxx7yme>
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
 <20251126223127.GIaSd_v7juUkaW4RTA@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126223127.GIaSd_v7juUkaW4RTA@fat_crate.local>

On Wed, Nov 26, 2025 at 11:31:27PM +0100, Borislav Petkov wrote:
> On Wed, Nov 26, 2025 at 11:12:13AM +0000, Kiryl Shutsemau wrote:
> > > diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
> > > index 4f7027f33def..a220a1966cae 100644
> > > --- a/arch/x86/boot/compressed/efi.h
> > > +++ b/arch/x86/boot/compressed/efi.h
> > > @@ -102,6 +102,7 @@ struct efi_unaccepted_memory {
> > >  	u32 unit_size;
> > >  	u64 phys_base;
> > >  	u64 size;
> > > +	bool mem_reserved;
> > >  	unsigned long *bitmap;
> > >  };
> > >  
> > 
> > Again, this is ABI break for kexec.
> 
> ABI break for kexec? Is that a thing?
> 
> Since when do we enforce ABI compatibility for kexec and where are we
> documenting that?

The whole purpose of kexec() is to switch between kernel versions. This
struct defines format we communicate information about unaccepted memory
between kernels. The mismatch will lead to boot failure.

The structure is versioned. Ideally, we should know the format of the
structure the next kernel supports and act accordingly in the first
kernel. Like, we can accept all memory before kexec on mismatch.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

