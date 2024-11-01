Return-Path: <linux-efi+bounces-2096-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0519B8F2B
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 11:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2089C28316E
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 10:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8036166308;
	Fri,  1 Nov 2024 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dp17+hLh"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C01C160783;
	Fri,  1 Nov 2024 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456923; cv=none; b=mU8LHtEPoK95EASrcuPCKpQBARf862Jd7zPpGsxwOeoD5iZCPZv/5tllSMrvsOmhMczQQMynZtvrZFtKjjKH2SZWYZ/9Rh7V9YOOUUbqk18FKCwiYQ20hyISSiNRQOtZlLTClYbJJa6Z21XP1/mbecoy1TieSk9yGyDuAn+a3GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456923; c=relaxed/simple;
	bh=mSFWh3r0scHZ1FR2DYIx0Tc2V6UZfNOyeDKa23YOOmQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Oti4BDohuQvNKzBY3gUG1Ha5F/4lewH1QnZlvuGQPqzRenKDNxo7iaJv+7ro3p+hCJbsmSYxuTIKXbFjSAokZJnbLeo2286RrvF1cKvLLxDI1vcrcOGQNvk8VmfvaKVGr/HV/mphtmDgn0JTCoUN7HuMBPWRzYmc9LPd9ZV787g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dp17+hLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FEBC4CECD;
	Fri,  1 Nov 2024 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730456922;
	bh=mSFWh3r0scHZ1FR2DYIx0Tc2V6UZfNOyeDKa23YOOmQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Dp17+hLhUwjK7Vwhq5YmGk2Rk/Vmsz7lB3wJrvj8hnCTYk50wdScvildLCtA4iBAO
	 6eA4s5JD6uE23Qn4gAlSnK9KxBlBRbni3VS+RIg95V3ZR/azVJqcizrcu6XMMtwJAS
	 Mvjp40ENNcaw476FxBKgo0TQsqFR++HZ6ibnCwrrM//1IzgoZzHcNk39p6ZsvxZJ7S
	 /6ePK9AoJdXCSJrtoWkjNiKAf21Y79MeAo+g1X290rINW5gItxttGySRNYb2V1w5wM
	 LSIpd6L/3kNBbY9n6PC3N3wVb1ZkATqlA0IZVVOaZZ7pzVAgK9/bqmoMGP2MRUsCT1
	 ME7TUSxuYp0XA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Nov 2024 12:28:38 +0200
Message-Id: <D5ARS5Y7EATS.2GVNSARKXKIDI@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
In-Reply-To: <20240913200517.3085794-1-ross.philipson@oracle.com>

On Fri Sep 13, 2024 at 11:04 PM EEST, Ross Philipson wrote:
> The larger focus of the TrenchBoot project (https://github.com/TrenchBoot=
) is to
> enhance the boot security and integrity in a unified manner. The first ar=
ea of
> focus has been on the Trusted Computing Group's Dynamic Launch for establ=
ishing
> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root=
 of
> Trust for Measurement). The project has been and continues to work on pro=
viding
> a unified means to Dynamic Launch that is a cross-platform (Intel and AMD=
) and
> cross-architecture (x86 and Arm), with our recent involvment in the upcom=
ing
> Arm DRTM specification. The order of introducing DRTM to the Linux kernel
> follows the maturity of DRTM in the architectures. Intel's Trusted eXecut=
ion
> Technology (TXT) is present today and only requires a preamble loader, e.=
g. a
> boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation =
has
> been present since the introduction of AMD-V but requires an additional
> component that is AMD specific and referred to in the specification as th=
e
> Secure Loader, which the TrenchBoot project has an active prototype in
> development. Finally Arm's implementation is in specification development=
 stage
> and the project is looking to support it when it becomes available.
>
> This patchset provides detailed documentation of DRTM, the approach used =
for
> adding the capbility, and relevant API/ABI documentation. In addition to =
the
> documentation the patch set introduces Intel TXT support as the first pla=
tform
> for Linux Secure Launch.
>
> A quick note on terminology. The larger open source project itself is cal=
led
> TrenchBoot, which is hosted on Github (links below). The kernel feature e=
nabling
> the use of Dynamic Launch technology is referred to as "Secure Launch" wi=
thin
> the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will be =
seen
> in the code. The stub code discussed above is referred to as the SL stub.

1. I don't see any tags in most of the patches so don't get the rush. This
   includes also patches for x86. Why I would care to review TPM patches
   when there is over a dozen unreviewed and untested patches before it?
2. TPM patches have been in circulation in and out of the patch set
   for some time now with little or no improvement.

Why the sudden buzz? I have not heard much about this since last early
summer.  Have to spend some time recalling what this is about anyway. I
cannot trust that my tags make any sense before more reviewed/tested-by
tags before the TPM patches.

BR, Jarkko

