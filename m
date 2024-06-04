Return-Path: <linux-efi+bounces-1163-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D98FBF48
	for <lists+linux-efi@lfdr.de>; Wed,  5 Jun 2024 00:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8D5281A30
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06E614C58A;
	Tue,  4 Jun 2024 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/M4pTAM"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE9E199A2;
	Tue,  4 Jun 2024 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541210; cv=none; b=FCRPJD/J4aBIp5K0VCZ0sPHR5dw6td+T0kL6yK8LhAqz9uBhGbjYM5doynxUVkglRqN1+/PhmafMO2Lg/i7u60DHpZkLVc7c0BVMSbhGEvpbvzWoJO0wntwToKZDv3NAVw0qZJN5mdLPYMPyL+V5NsDEPA3EBJ/xubh2kUd5e+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541210; c=relaxed/simple;
	bh=ObbnLVomG7LC8630jJzSGjNJGO+w2KG9eNNPYANJnj0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uL7Jxk+Oa7JGhxWZC9a3Fad4WtoqWXIQreU1pQiUo4/TUpBLY2QPU/CaBYP3NTuhb8KwsGGG5QLqlYbSkbvh77l+pLz5oUOKSdsNMsduEmsJIVg09nYb2rxEc4NOw/h/7vwx1s0iHZWq7Ch9N5UZFj9vMxTo7Hu6QkTVAkRAu4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/M4pTAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F9FC2BBFC;
	Tue,  4 Jun 2024 22:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717541210;
	bh=ObbnLVomG7LC8630jJzSGjNJGO+w2KG9eNNPYANJnj0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=k/M4pTAMFdu5Hv+tECjoZbb2qx5QG85dWrdxlikREB1N4Yrkfra+Xt/4tBwy9jBrN
	 6gvscFO/m0b46P3kR6b/x3NOD7+4Xw2JYwmG7UCgDzJJHNWonTsNyGxrVuP5VDgP+6
	 rvhBAAbSyJQHdIGWFSFstEqyRv0/W4twBgMFw/YVkcOYuuRqm9eSMKr4g29pIuZLSL
	 95ZyNhwUbmCgFG2JWqyOR7dzFKM3H3ydjE2eoZPt8JHOUNfskKNnOEFy9lPJ2L39D8
	 j7IkkqQEz8oaHIIrfa/bwaMpP6VT1SkuDa7wrMYbZHIa1VM0Mcj2kLboXvwaw+Ddir
	 K0tjSsn1vSETA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jun 2024 01:46:42 +0300
Message-Id: <D1RLJJY17T2J.I1BP34BUK2AS@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 10/19] x86: Secure Launch SMP bringup support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-11-ross.philipson@oracle.com>
 <D1RI46IG5GSA.17H7M0DIQGRQ0@kernel.org>
 <d95d73d2-c728-4da2-b68e-d2e39a518ae6@oracle.com>
In-Reply-To: <d95d73d2-c728-4da2-b68e-d2e39a518ae6@oracle.com>

On Wed Jun 5, 2024 at 12:47 AM EEST,  wrote:
> > static inline bool slaunch_is_txt_launch(void)
> > {
> > 	u32 mask =3D  SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;
> >=20
> > 	return slaunch_get_flags() & mask =3D=3D mask;
> > }
>
> Actually I think I can take your suggested change and move this function=
=20
> to the main header files since this check is done elsewhere. And later I=
=20
> can make others like slaunch_is_skinit_launch(). Thanks.

Yep, makes sense to me.

BR, Jarkko

