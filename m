Return-Path: <linux-efi+bounces-1133-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A04F78FBB68
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7961F2265F
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 18:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4694414A09A;
	Tue,  4 Jun 2024 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7dcQ/XJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF41149009;
	Tue,  4 Jun 2024 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717525133; cv=none; b=b2odLni8eBgnI8jky5y4X7oSLMf5B9wked7tFHyjKSs2WErMUrAMpouYnn5iUiIVpjFmS+Or5Vt/X4fltZGTaoGTNxJDNtoP5Buw2Smlok/jg9BZ/guJALIsGpgpscF3jv2znDP+w/8MUKvNNKs23wj7OCJ858bum3jz+f0fkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717525133; c=relaxed/simple;
	bh=tLjjYFY5sCNOwFACQ2wDYtXISD6b1TLmfsdB964Sstc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YxR4axpYwLTD4mQe/iKd0r4tXuScUqccCI+/hT7xWQYWdzsQoBrix2s5VmiRMihsnnTi4ss6Ang4IUH4+mtKdLu6ILh/f0OQDPmYhFVicE5DT4vLpCDMuKMVJ7tJRmBVNDeYkVwcKRhdOee+VZdqlaOeVq0bgwOziVf9BcU8kTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7dcQ/XJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B45C2BBFC;
	Tue,  4 Jun 2024 18:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717525132;
	bh=tLjjYFY5sCNOwFACQ2wDYtXISD6b1TLmfsdB964Sstc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=n7dcQ/XJbYOrNgCq5ESQZ59Xa+8dYD9+SB2DAU+OfLA8+DJ598KJLqQiqzrIkhh0g
	 UKXoqmVVDSu94Mt+rn6Kt5IiGUIlnhjkHcBKGhkcGrtM0QGZQCWFjn9oN0jIncG0fp
	 0QlSaaAm4hwabRgHQVI9d18LWhK5wr2VVpmu2KdVihNlW73A86ZY77EafzsRt2QQ3r
	 B5ZE8GI052OZDh6CpZHFKpgpvDaWVst//+JGORQKi6AkRNZ1/NhSToLX/ckeeFOkdO
	 Q/yaIOC0UjL6j/KnhlbnzaO6guYALvwQyNR8Mk8553jwwkWCwCeyZlOfimTruQ5bse
	 XlUy3IHVbRpvA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 21:18:44 +0300
Message-Id: <D1RFUDSAJJKJ.2MF9OSQAJGBRW@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 01/19] x86/boot: Place kernel_info at a fixed offset
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-2-ross.philipson@oracle.com>
In-Reply-To: <20240531010331.134441-2-ross.philipson@oracle.com>

On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
> From: Arvind Sankar <nivedita@alum.mit.edu>
>
> There are use cases for storing the offset of a symbol in kernel_info.
> For example, the trenchboot series [0] needs to store the offset of the
> Measured Launch Environment header in kernel_info.

So either there are other use cases that you should enumerate, or just
be straight and state that this is done for Trenchboot.

I believe latter is the case, and there is no reason to project further.
If it does not interfere kernel otherwise, it should be fine just by
that.

Also I believe that it is written as Trenchboot, without "series" ;-)
Think when writing commit message that it will some day be part of the
commit log, not a series flying in the air.

Sorry for the nitpicks but better to be punctual and that way also
transparent as possible, right?

>
> Since commit (note: commit ID from tip/master)
>
> commit 527afc212231 ("x86/boot: Check that there are no run-time relocati=
ons")
>
> run-time relocations are not allowed in the compressed kernel, so simply
> using the symbol in kernel_info, as
>
> 	.long	symbol
>
> will cause a linker error because this is not position-independent.
>
> With kernel_info being a separate object file and in a different section
> from startup_32, there is no way to calculate the offset of a symbol
> from the start of the image in a position-independent way.
>
> To enable such use cases, put kernel_info into its own section which is

"To allow Trenchboot to access the fields of kernel_info..."

Much more understandable.

> placed at a predetermined offset (KERNEL_INFO_OFFSET) via the linker
> script. This will allow calculating the symbol offset in a
> position-independent way, by adding the offset from the start of
> kernel_info to KERNEL_INFO_OFFSET.
>
> Ensure that kernel_info is aligned, and use the SYM_DATA.* macros
> instead of bare labels. This stores the size of the kernel_info
> structure in the ELF symbol table.

Aligned to which boundary and short explanation why to that boundary,
i.e. state the obvious if you bring it up anyway here.

Just seems to be progressing pretty well so taking my eye glass and
looking into nitty gritty details...

BR, Jarkko

