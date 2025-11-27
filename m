Return-Path: <linux-efi+bounces-5711-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D2AC8FB0D
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 18:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E235A3AD39A
	for <lists+linux-efi@lfdr.de>; Thu, 27 Nov 2025 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D802ECE9D;
	Thu, 27 Nov 2025 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5DsguCG"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC22EBDE3
	for <linux-efi@vger.kernel.org>; Thu, 27 Nov 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264583; cv=none; b=POzRoTWiImo8bsSq3fc6hspGsSF18jioXYGLVQGiwbm1Ufh7TMHte0aEaBUgki/qdz5nRSQLOfMgXMFfzCR7aqFEO+OltHjelm90+tQjiD1U8z+hlbiJJ6fdvxNGpcu08as7I+LmdAtGM0H2UwBNXDMBND+vaCIE81PGGzSJK/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264583; c=relaxed/simple;
	bh=nB4fj1qSwqt+nXUD6T8fItX7qNQnaNO9Nn1wmWp2EB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uofAw4AmE4ZKPQAgcRGAHPb6P3+qmtoqncp/xaaSSb8bZ1qU8I0NVOMRqplPS3sh/yPz7omDEhZ19Niz3PfvvpakO6gvYolAafBy8V0n6nVohYd0j/dn2H5CXq+tz4s0vNYa/pvX9UsmJCBeCIT3+J1tXuFIbUoJsvvTh/up5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5DsguCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43863C4AF09;
	Thu, 27 Nov 2025 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764264582;
	bh=nB4fj1qSwqt+nXUD6T8fItX7qNQnaNO9Nn1wmWp2EB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5DsguCGSx6lJRFcfXOOkiUMxXVeq2+FKS9DGpaSe+2ii8+ftz3gDSYEY0LXNJ+p7
	 uFlLnNB641IAaAHPyX0RoWoJIbHvIxMeQJOm+epTUxeE6bCNO/5OuREbRugrrT7GmI
	 jgEVv7ylwxJj9eNzp3pGABTQYUFRzwmLEZeUR+EcGH0cFxiiAzpryuewilZiJo0dBx
	 NQwPRpb7fMu1X4Zmiu+sQGVi1IOHMauD3BIYnOUPOUwTAdzKJlwUY6S2eADsXgdAPD
	 NSK94NVaxinaCaZapap2Q/beSQI6/cJak04qaKRuPfRbA7t4RWeBqJYu60t88nUJLj
	 mxBt0ow+zwILQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 63FBAF40073;
	Thu, 27 Nov 2025 12:29:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 27 Nov 2025 12:29:41 -0500
X-ME-Sender: <xms:hYooaU2MFXml_ayJbmvN4vHCHF4bFDekthdZJpyqJx03xE515b-8wQ>
    <xme:hYooacmaBTcw4nNPaj1JlCq0IijnTPptoEBGTuKV8ZKCCWIiLVnvbbq8Ig-yaFzy9
    RgDvRzMjDUtTAX9YxfA2jIl9weCz0Lmsc6LaLWs9NdHaWbuSczENrw>
X-ME-Received: <xmr:hYooaY-TNIC5q5wZ6eDFjViaCpW6ruv03skSm-hivJ6RmV2DkZvMG2e5hpvheA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeejkedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:hYooabE1OnuULuM3qMb_acv78iF0fEDkV85Cx00gDbBgQS02Y1D07w>
    <xmx:hYooaZljC10kOgd7iTK6RIGmZ6CdYN46iHFJ4cd0vqm3g97L6dTr6A>
    <xmx:hYooaSeZAKaBZ58tMU3dfBYzeUZSrKWGjgJoaq-2Syq9sFXB8EWbag>
    <xmx:hYooaXDRBgnAKBlFE4tnCp83QaXK8pRvx5UyrwTMUrcGYefMASP2_Q>
    <xmx:hYooaRyZef22Bk-p78L4jLx0tuaaVdfTXC5kFGuadh7s3SiXfmv4YQ1V>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 12:29:40 -0500 (EST)
Date: Thu, 27 Nov 2025 17:29:39 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-mm@kvack.org, linux-coco@lists.linux.dev, 
	linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, ardb@kernel.org, 
	akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de, thomas.lendacky@amd.com, 
	michael.roth@amd.com
Subject: Re: [RFC PATCH 1/4] efi/libstub: Decouple memory bitmap from the
 unaccepted table
Message-ID: <v7ocifp2adtdptkbzjmvrhqgjjbzug3a5dqspw54kmfmpauwdz@fuwlvrnjhpcm>
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-2-prsampat@amd.com>
 <phywn74ghpsqncoqsgdqjoxeqdxskibzt3yltn6bmtc25sm46g@emad5n6wp5l2>
 <e66ef586-0e19-4e53-af34-129ed28675c7@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66ef586-0e19-4e53-af34-129ed28675c7@amd.com>

On Wed, Nov 26, 2025 at 04:27:19PM -0600, Pratik R. Sampat wrote:
> Hi Kiryl,
> 
> Thanks for you comments.
> 
> On 11/26/25 5:08 AM, Kiryl Shutsemau wrote:
> > On Tue, Nov 25, 2025 at 11:57:50AM -0600, Pratik R. Sampat wrote:
> >> Memory hotplug in secure environments requires the unaccepted memory
> >> bitmap to grow as new memory is added. Currently, the bitmap is
> >> implemented as a flexible array member at the end of struct
> >> efi_unaccepted_memory, which is reserved by memblock at boot and cannot
> >> be resized without reallocating the entire structure.
> >>
> >> Replace the flexible array member with a pointer.
> > 
> > Well, it break interoperability between kernel before and after the
> > patch. Consider kexec from kernel without the patch to the kernel with
> > the patch and then back to older kernel. It is ABI break.
> > 
> > Is re-allocating the entire structure such a big pain?
> > 
> 
> We could do that. My concern is that we would then need to protect the
> entire table instead of just the bitmap, which may add an additional
> overhead?

What additional overhead? The main contention is going to be on binmap
anyway.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

