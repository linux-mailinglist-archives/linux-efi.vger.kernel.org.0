Return-Path: <linux-efi+bounces-5784-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F3AC9F55A
	for <lists+linux-efi@lfdr.de>; Wed, 03 Dec 2025 15:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 74E673000580
	for <lists+linux-efi@lfdr.de>; Wed,  3 Dec 2025 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1663C30101B;
	Wed,  3 Dec 2025 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meskB6cU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C173009D8
	for <linux-efi@vger.kernel.org>; Wed,  3 Dec 2025 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773187; cv=none; b=DStvjn8ntXm4wviykalNpO2XReLBh1rKT4pkWhbYr5WV8uzPXfJk/WI9Q6X1ln171+qRrleyF4CxHhwhDmhbGAM0pd0OS6XsNMAhiRfN5mrmywdJYNe3mA06eLczxMUe8A2fV49iMqOG1P3U7sG/kogeEJ/PU3TF4P+9c9qi47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773187; c=relaxed/simple;
	bh=jM/ow1A9leA7Y9bLZ+XmYp9O4P74p8od6dKc69m+yVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQtkYN3AlFyLb++wuUdVA9oNANDhHEJt1yDlfVIxKl4SdjjOZMZvZDP5L4/n/As6V4Q7lMvTDGdwzF/9/Hy/77com6SeeoPlVR0QfgZt8pCIeuAs5rS1zsNW/MaQ+nKYc+v6WCChBwVRlP9zKAeyTylfgUMLuxse2z4YimSK/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meskB6cU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4807C116B1;
	Wed,  3 Dec 2025 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764773186;
	bh=jM/ow1A9leA7Y9bLZ+XmYp9O4P74p8od6dKc69m+yVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=meskB6cU1n1VE+PIMLR/sLS4SpNTq+aY/SdiWd8UYCXrunUwa+UTSrlkDIOxgBk/I
	 73HFYFwmmOc8vU51t9m8vQj+rwyd0/mBCvBWdKJyjPKGyYbZHYOTDyfokJhQCdVg83
	 Oj9VcE640ATvCXvFehLWfejcg+RIQfcdCPvQrw1vY9LRhgm6pxWjnRXjeawrjQ7Jhp
	 o3z2wFWRSfcF0Abor1FKS7h2YxwB6l8Uq4X8at8QUfxiqcgrR0BjWxlmC4hqHNw56w
	 U1X6yf9NQ2MB7WRZjCnFBU/PI+4WeL0E3EO8LeGuKgL/vf2qiUcbogv9H9PQFrv4sW
	 mg2hTNL2EDLmg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id E87B2F4006A;
	Wed,  3 Dec 2025 09:46:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 03 Dec 2025 09:46:24 -0500
X-ME-Sender: <xms:QE0waS_3NGTJK-w6vURM7E1_c0oPRA2gEmQAkQzacNL0DC18I7dDjg>
    <xme:QE0waQFwdThNb4Pe9tNpgJCKk7VoecODKSOpsY5fNZ-F5IvEIghG6yPsqzuVCYEbG
    sM9kCYH1Cw0HRK4s5uRIFWTJ7KHvA5zp48VelPhfUWyj6YkKOiUiW8k>
X-ME-Received: <xmr:QE0waUCLb4CS2A7weFkB0y6cMGB78HKPFOyqZ3u_WCfpax7Au_p1iTLPVaUo7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcuufhh
    uhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilh
    hlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheehqddv
    keeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrg
    hmvgdpnhgspghrtghpthhtohepfeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegurghvihgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhgusgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepphhr
    shgrmhhprghtsegrmhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtg
    hkrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghotghosehlihhsthhsrdhlihhnuhig
    rdguvghvpdhrtghpthhtoheplhhinhhugidqvghfihesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QE0waeJMZGc9bkDKe62Qoo9fBpsyqxxPkzUp4WeqJtR4ada39767Lw>
    <xmx:QE0waSwUvDspi7RHZn2deYxPPwH6dDnPAhqKzCq8XNK32YFfDkdy6w>
    <xmx:QE0waVGE5M2S2aPwbYJuJ-x21zAawCQQqesCN0No31Z8PhrMhShurw>
    <xmx:QE0wadSyZg_sWFO8lEFq-k1f-C8JJ_0pd70qS0rbx-WXJvbFew_LMQ>
    <xmx:QE0wabVn1p6LrnsP3Lzve-NVE9Y11l5XvZ3uzU3D6dliGMsA8mXyXqhA>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 09:46:24 -0500 (EST)
Date: Wed, 3 Dec 2025 14:46:23 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, ardb@kernel.org
Cc: Borislav Petkov <bp@alien8.de>, "Pratik R. Sampat" <prsampat@amd.com>, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, akpm@linux-foundation.org, 
	osalvador@suse.de, thomas.lendacky@amd.com, michael.roth@amd.com, 
	torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
Message-ID: <etd7r45wmnuoftpckrzkzithr443ru6akgwqjgzw2vgmzqi7cs@camfecdmef74>
References: <20251127181233.GBaSiUkaLzwANS_6WT@fat_crate.local>
 <beec5651-5c23-4f5e-a0a3-d1cc01a8490a@kernel.org>
 <20251128113411.GAaSmIs0kSWGhCYkaA@fat_crate.local>
 <47927c25-a317-488a-823f-ac0588f4eee4@kernel.org>
 <20251201111201.GAaS14AX18qeHN20xf@fat_crate.local>
 <052d7f47-edb6-4978-bc9a-c7eae469720f@kernel.org>
 <20251201191036.GEaS3oLBY8PEuE91Ap@fat_crate.local>
 <dcccdc4b-b7d7-47c4-b1b1-a6c70edb20fa@kernel.org>
 <20251201202507.GFaS35o7WtLJOM0_jh@fat_crate.local>
 <420865fb-34cc-43a8-820c-b15b5f24a27c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420865fb-34cc-43a8-820c-b15b5f24a27c@kernel.org>

On Mon, Dec 01, 2025 at 09:36:58PM +0100, David Hildenbrand (Red Hat) wrote:
> On 12/1/25 21:25, Borislav Petkov wrote:
> > On Mon, Dec 01, 2025 at 09:10:26PM +0100, David Hildenbrand (Red Hat) wrote:
> > > Just to be clear, I don't think it exist and also I don't think that it
> > > should exist.
> > 
> > By that logic if it doesn't exist and someone sends a patch, I should simply
> > ignore a review comment about that patch breaking some non-existent ABI and
> > simply take it.
> 
> Well, we can always discuss and see if there is a way to not break a
> specific use case, independent of any ABI stability guarantees.

There is also the #1 Kernel Rule: "we do not break users."

Booting a different version of the kernel is a core functionality of
kexec. It is widely used to deploy new kernels or revert to older ones.
Breaking this functionality is a show-stopper for most, if not all,
hyperscalers.

This specific change may not be a show-stopper as CoCo deployment is not
widespread enough to be noticed yet.

The notion that nobody promised that you can kexec into a different kernel
is absurd. It is used everywhere.

> > 
> > Well, it certainly works for me.
> > 
> > Unless you folks come-a-runnin' later screaming it broke some use case of
> > yours.
> 
> Heh, not me, but likely some of the CoCo folks regarding this specific use
> case (kexec in a confidential VM).
> 
> > And then we're back to what I've been preaching on this thread from the
> > very beginning: having a common agreement on what ABI Linux enforces.
> 
> Right. Maybe Kiryl knows more about this specific case as he brought up that
> these structures are versioned.

I am not involved in the deployment of CoCo VMs, but I don't believe it
is specifically about CoCo or the kexec ABI. I think it is more about
the boot protocol. Kexec is one way to boot the kernel.

Should we consider the EFI configuration tables format as part of the
boot protocol? I believe the answer is "yes," at least for some of them,
like LINUX_EFI_INITRD_MEDIA_GUID.

I also think LINUX_EFI_UNACCEPTED_MEM_TABLE_GUID should be considered in
the same way.

Ard, do you have any comments on this?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

