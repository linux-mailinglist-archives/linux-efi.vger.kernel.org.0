Return-Path: <linux-efi+bounces-5690-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8034C8970C
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 12:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0EAE4E4BF0
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 11:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1676B2FFDDC;
	Wed, 26 Nov 2025 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGRTa2n1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B72FD7D5
	for <linux-efi@vger.kernel.org>; Wed, 26 Nov 2025 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155289; cv=none; b=EQWBUQdpuOIziSWGEiVynztqq0NEk3jJhwEaR7tAJU9ppJnusH8+za1249/99PEO2tkCk60+6S/eXkB43a7OJeoufnP+rN9QI5fCCHWYWNKOIwIHk0kWbVJ83oxkLwjM3Hmbt0MzmNeFINCUxIkakweQIv/ZSBadpjjAICcdGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155289; c=relaxed/simple;
	bh=z0HVZNX9ipGoX+NtBCrTvCMPi4qEm2pGno5N+3U1Uqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6ETlGBang+ipYFEg3xMrM7ygCF0MHvvkWBpSULPUqPYs5PpglqTR2qXTIDktmuCTN3jSL52y2sGASI5GCncve74tl1eKDO73R8kSfOkDpo1CnjWecm6H/P7xxHCRQFZQyCrYrT+cMOmEN1AKWNOz1pn+9VyzItq4FPGJoZKj9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGRTa2n1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC85DC116C6;
	Wed, 26 Nov 2025 11:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764155288;
	bh=z0HVZNX9ipGoX+NtBCrTvCMPi4qEm2pGno5N+3U1Uqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGRTa2n15T67J6SBtu/zIF82k2tIrva5M96eaYBYmX99P1xifS9kYtg6NNAF8uzmG
	 LcUgE3MprhitmOZOpWTXUMdPKhYi1q3agrG5clqvSC8zU4QVW/qto6plJP78WD/Z0I
	 9TEsVhVTic6NC4CcoVr0s156uAzG8PRJb6f7eh5IYm2jSQD8jEnGzdciI/a9xVSuXR
	 pufUiTSULdVPMaKrHWEKRKPbDyR/w7cGozbNdSA5Qq2Ms/VDf1Q7MCwZcLUA80HDiQ
	 B8Xar37YLoLzyPm4IL8zY/apG+rMCQinb4zzQrurjY2aYAaU3Q+b5sZolzLBjtN6cA
	 EEVh3M8O2M3EA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0C4D6F4006A;
	Wed, 26 Nov 2025 06:08:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 26 Nov 2025 06:08:07 -0500
X-ME-Sender: <xms:lt8maXAXrrkTnd5BrfEbde_jz-s_LGbj6x2MXZibPkNMeXdq9zSE2g>
    <xme:lt8mabBKPmMVQn0TQIgw-Irs0KMYEH0R6GKzQhhBxkBfa5NgdvUfSIB0AYiVU5Vd4
    HovznX3G4mZhaMtE5O-UFFPC0aL0vRdypPI-aooZghqrmtxdDIG0g>
X-ME-Received: <xmr:lt8maeoCVb13vICXsQjz6Llq19NWgyj588DtvUYIgqL-koU9OAHqwsJp9-eYMg>
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
X-ME-Proxy: <xmx:lt8maXBh-TdVnxahrIRppeVe1AAnlUyrmgTHmGY0Zv8ZjJdUU_IizQ>
    <xmx:lt8maeyd0nHHhIT06tMzmiSMV3ySOBRu4rVfgTsw8kyZI-HV7BzW-A>
    <xmx:lt8maX4Avzs5fFa7ZD6otWJZ-yCyPlNYOLT3uFBRcw02isjxRMh5Rw>
    <xmx:lt8maXv7JJI8EZafBSRks7Crji1eSN83RvMaX7lrk53d9wz4TJYkhw>
    <xmx:l98macthO8VOHM4IrzlSPdWQGPrqHQJ5tz5OHTh46gScmq7m9xmQDSHU>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 06:08:06 -0500 (EST)
Date: Wed, 26 Nov 2025 11:08:05 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-mm@kvack.org, linux-coco@lists.linux.dev, 
	linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, ardb@kernel.org, 
	akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de, thomas.lendacky@amd.com, 
	michael.roth@amd.com
Subject: Re: [RFC PATCH 1/4] efi/libstub: Decouple memory bitmap from the
 unaccepted table
Message-ID: <phywn74ghpsqncoqsgdqjoxeqdxskibzt3yltn6bmtc25sm46g@emad5n6wp5l2>
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-2-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125175753.1428857-2-prsampat@amd.com>

On Tue, Nov 25, 2025 at 11:57:50AM -0600, Pratik R. Sampat wrote:
> Memory hotplug in secure environments requires the unaccepted memory
> bitmap to grow as new memory is added. Currently, the bitmap is
> implemented as a flexible array member at the end of struct
> efi_unaccepted_memory, which is reserved by memblock at boot and cannot
> be resized without reallocating the entire structure.
> 
> Replace the flexible array member with a pointer.

Well, it break interoperability between kernel before and after the
patch. Consider kexec from kernel without the patch to the kernel with
the patch and then back to older kernel. It is ABI break.

Is re-allocating the entire structure such a big pain?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

