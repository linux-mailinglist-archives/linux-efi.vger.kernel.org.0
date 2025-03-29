Return-Path: <linux-efi+bounces-3123-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD8AA755DE
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 12:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596FD16E051
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 11:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466DE1B4138;
	Sat, 29 Mar 2025 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6G6IxKL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09870A935;
	Sat, 29 Mar 2025 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743247939; cv=none; b=HhEPjn5nE7+BWt2PqEir7If3eluwop6b1iB4crvYAosCT7DSIxDqVf5vlKQAjq1CK6Bx7wKXO1tIniDBkKTcWMFJFtuJnqBQ4QBWF7vqkFKlnboHrbRv0y/IrKvbTf868H2/Nt0Pr+INeRAt2PvHjbt8rC11pn0pueiEmpPb4F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743247939; c=relaxed/simple;
	bh=9RzsQ0E7jdjbegvxUHbO7Zp0Kd0W8S0YBOdd9DVrMNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqUyX5hjBo36njXu+ZDQxhTOkicb+CW14Oz2dSe80Zk+JIZ6Qj6Rw7HaAFF9S8t/mEpJZxtmUymbtRiXodUS9mR0xl3d+0lItoT3yc84KWRE7/uKCnck2T6sGsYkc5/3f4zKUdML4gcODAsUbAI9O2Bz2vNCloQ+C5wZ20BUC9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6G6IxKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA013C4CEE2;
	Sat, 29 Mar 2025 11:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743247938;
	bh=9RzsQ0E7jdjbegvxUHbO7Zp0Kd0W8S0YBOdd9DVrMNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6G6IxKLKe9hJQRP5obm7C+Bsx6BjbjFbTN9ToLSW109SDDApPb39G5lt813QpmWy
	 mXGhYzBds4KV7JLlx1K4yg7gfzUkypFskWjvIAR/pg+65EqDEcHa2Zudc9FvGvDl+n
	 VapJdc3R+A4ZvWi9mdujrbAIWypcR6QH04SAszPTh8Qwnh08Z0YFUyWdp9rZHR+QFK
	 56/hgrPY0KF64o4KS/oV532kWBSClS0FI9mSWMQwh27o4YP7EaejfEsCfv8z3E67W/
	 lmCsLCu/fNFubXa8xUHT4OG0VeUtA69O0k3XeDvUGvZLvx24q3fNRl0z6SxEzMs2Aw
	 p47ZlCf1+qJcg==
Date: Sat, 29 Mar 2025 13:32:13 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux.dev,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v13 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
Message-ID: <Z-faPSIlZV91j_Z0@kernel.org>
References: <20250328230814.2210230-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328230814.2210230-1-ross.philipson@oracle.com>

On Fri, Mar 28, 2025 at 04:07:55PM -0700, Ross Philipson wrote:
> The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
> enhance the boot security and integrity in a unified manner. The first area of
> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
> Trust for Measurement). The project has been and continues to work on providing
> a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
> cross-architecture (x86 and Arm), with our recent involvment in the upcoming
> Arm DRTM specification. The order of introducing DRTM to the Linux kernel
> follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
> Technology (TXT) is present today and only requires a preamble loader, e.g. a
> boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
> been present since the introduction of AMD-V but requires an additional
> component that is AMD specific and referred to in the specification as the
> Secure Loader, which the TrenchBoot project has an active prototype in
> development. Finally Arm's implementation is in specification development stage
> and the project is looking to support it when it becomes available.
> 
> This patchset provides detailed documentation of DRTM, the approach used for
> adding the capbility, and relevant API/ABI documentation. In addition to the
> documentation the patch set introduces Intel TXT support as the first platform
> for Linux Secure Launch.
> 
> A quick note on terminology. The larger open source project itself is called
> TrenchBoot, which is hosted on Github (links below). The kernel feature enabling
> the use of Dynamic Launch technology is referred to as "Secure Launch" within
> the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will be seen
> in the code. The stub code discussed above is referred to as the SL stub.

I did a quick recap of TPM patches and still looks good as far as I'm
concerned. Not actively reviewing these anymore but I'll do a sanity
check per patch set version.

BR, Jarkko

