Return-Path: <linux-efi+bounces-5251-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF0EC1F814
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 11:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C38420626
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 10:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39176350D4C;
	Thu, 30 Oct 2025 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2Hq2ux2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1248D33B955
	for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819796; cv=none; b=DQSE18avcim6GSgjIX2wDQl41CF+yWwZdAs2dERcZ7xnjCi0EEhD0fm7njxWgAsDWinULVQf1OsDidC7BYAlRpUOK1kV1v79UXloDr+A4+2QpsrEXrvGwh4F8Pm9HBfuV0YTnlr6QvqN6vmJvZUqrF0px/a8gheO45BBxI5Y2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819796; c=relaxed/simple;
	bh=3PPcT52CUIUtGBb6h391cuWkN0HcI1uyMSEf1lpC1ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbzaD5pD60OeR8K+rlnHDE63EFDmnsfTLIUweDJ6AsDsuURCovVGLfpAJv1/keDiHnCvyiwa1Ls8fk0I7yDbcF+aq2ZzvY8h0oS0+OsFj6WePK3TBELdjwkr+Mv8lHZCO22R/2mG6ZGZ2kjiqXS+f9EeIYHVUNazJYTr10BQh5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2Hq2ux2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D452C4CEFD;
	Thu, 30 Oct 2025 10:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761819795;
	bh=3PPcT52CUIUtGBb6h391cuWkN0HcI1uyMSEf1lpC1ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2Hq2ux2aE2ZENt6Doa40MkV6AhEuOjBGlULJY1M5pOdPPA6VtAYBb4cjHYTTNtYs
	 2gGcoArLmDSQiYhXWKkwqloRrbtedZQ39m74J8mcqRWeXFObECSMig7epsE3mDTuZr
	 jMNzlfC5EhfdpVpwq5b4X2JdsOp8xFE4OqPUIBPfuwMlpcK9lm2FCz9XFrKJIKdGRN
	 Mg+LRiIKKaCV9Gq4qZIsJlcPPcBcMEQLnrqtIerTONNmsa6PyE8PDP2a4ATOOmdrNk
	 QMr1CJcbR5G7BioH34V5Pg1wDiCCkXNS1WuTEBWpfffoLCpHcp+w/TkQ9RSviv2kIk
	 L8bsRg8hnHQHw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8A357F40066;
	Thu, 30 Oct 2025 06:23:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 30 Oct 2025 06:23:14 -0400
X-ME-Sender: <xms:kjwDacuIbm0UVdKlKVzSPmonNk1qTKjBIQBDI0Q8jqi20Hq2bDDyjQ>
    <xme:kjwDaW2XmmLCflga8F7Qu4jM9han6UDTjda0CelQ9ipUeTvPyk8BAFdnO2XD856U9
    S5qH0wU4yVqOTVh2jp_EVwmeavYorZkYE5hUz4ez8SFdA3W3XBPcX0>
X-ME-Received: <xmr:kjwDaTxcPNNzWjo-QH1H2l1EmdebZTdJFsZ0y9lwa9GxFUYYx2GSEQ4R74ABgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheeikeeuveduheevtddvffekhfeufefhvedtudehheektdfhtdehjeevleeuffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepfeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehushgrmhgrrghrihhfieegvd
    esghhmrghilhdrtghomhdprhgtphhtthhopegufihmfiesrghmrgiiohhnrdgtohdruhhk
    pdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmh
    hinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnhes
    lhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhopeigkeei
    sehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kjwDaS6wq9yfMhelDeGtVaO5eN8nWmhzoMm5wlo88rfpjbJpxVCmBQ>
    <xmx:kjwDaYijZ8CihzfH88GZCSO2nz-u3LJDOvH59_TRlQF-w68BTcTgYA>
    <xmx:kjwDaX02jV7Hwc-2t_btDrWNpEbIYDEeWmZuitjGhF8LImduusX1Ag>
    <xmx:kjwDaZAX3p-AiHWjbEXZXdY6SG6cvIlqt0JMgRGNO5PK1dgFTFHw0w>
    <xmx:kjwDacEzfUsK_ofGRQoOvayHbotaLH4LMTlqE_1-naf9C5IHi9dHVBh6>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 06:23:13 -0400 (EDT)
Date: Thu, 30 Oct 2025 10:23:11 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Usama Arif <usamaarif642@gmail.com>, dwmw@amazon.co.uk, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	hpa@zytor.com, x86@kernel.org, apopple@nvidia.com, thuth@redhat.com, 
	nik.borisov@suse.com, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	kernel-team@meta.com, Michael van der Westhuizen <rmikey@meta.com>, 
	Tobias Fleig <tfleig@meta.com>
Subject: Re: [PATCH v2 0/2] x86: Fix kexec 5-level to 4-level paging
 transition
Message-ID: <e7h3mlj6x4k36e2ydsmbqkulh3ombhm3j4kvmw4pzlynoaaxjz@yrth4sw2tf26>
References: <20251028105637.769470-1-usamaarif642@gmail.com>
 <20251029204814.GHaQJ9jhw4u5SU1rNJ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029204814.GHaQJ9jhw4u5SU1rNJ@fat_crate.local>

On Wed, Oct 29, 2025 at 09:48:14PM +0100, Borislav Petkov wrote:
> On Tue, Oct 28, 2025 at 10:55:55AM +0000, Usama Arif wrote:
> > This series addresses critical bugs in the kexec path when transitioning
> > from a kernel using 5-level page tables to one using 4-level page tables.
> 
> Out of curiosity: what is the real-life use case for this?
> 
> Judging by the Reported-by's I guess Meta is doing some kexec-ing into default
> kernels which are 4-level so that they can work on any machine ...
> 
> Close?

Older kernels in our fleet run with 5-level paging disabled. The newer
one enables it. Machines need to switch between kernel version from time
to time for different reasons. Switching from the newer kernel to an
older one triggered the issue.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

