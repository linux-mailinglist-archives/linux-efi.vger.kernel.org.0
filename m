Return-Path: <linux-efi+bounces-1176-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8998FDE6D
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2024 08:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5E41C21151
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jun 2024 06:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA66938DE0;
	Thu,  6 Jun 2024 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmLynZHb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E38821;
	Thu,  6 Jun 2024 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717653768; cv=none; b=tp0dkdqCZqvm3hfJBBZw1GwZDbFLvxy5/8B+sZMLm7CQ5sA4e1QLdpIIrm1w5ob1ko6i/K/yH2SKO1dP4qohN3BwWps5D/8jHJSOZ0+hmy+dK3x+tOu6lE20gm24t2Wp5C1LvRM8uHrZGwIENd0Jl9moWMYTKCeyuKyKKf8pT9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717653768; c=relaxed/simple;
	bh=+N73ZoMcTU2eT6S1zwH3KuWbb697R2JF/05UDlnStFg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OMfZD5R4DfDjBhp1qXw7CkgBO1rS4HyVckVeX+3uou26oE6iLXHoBUIzG2hWabf8yIUyPN8LCuBy+yPgxj/CAtOVJH9LpuVoD5RScqNgrS7NOrkEVuBgKQxs8NEBdTIsh2dG7D5FjDI2lGhSrsBS76wq7baricMvEyNTXW/uoQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmLynZHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9185C2BD10;
	Thu,  6 Jun 2024 06:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717653768;
	bh=+N73ZoMcTU2eT6S1zwH3KuWbb697R2JF/05UDlnStFg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZmLynZHbI6+wxCoH1qsyPjAEaqVNs7ObvEwVHIw3vJZfJHIwRxJfcf9FU3FL6NEEi
	 g9yD4HLhAw0LoywOGsYjq7bj/p6fVvb66y+JJBELnB9P9WEGYvqEaCXlDEachSbGHA
	 FRaf5sPKiic7EiwGrHG5hgacpnqiYn4ByHic1mk3NhtPrm61IpuUiVVO4X4U7s04ud
	 GWGcjFMk85/3uLd6E8wEDOs9t3QNJ7LCJGI6cZyTTZ7CLOmIbPrLmc0PYZ3FpQL6R4
	 mmbSZBbf9uHeBP9BxtYYUfhCFOxhy9eo/RtlsfNXBCA7SAb0aoSLB7LZDYGzuDJ59Y
	 n/Am9dYvkU9Kg==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Jun 2024 09:02:39 +0300
Message-Id: <D1SPFVXS6FOG.IQQB3INFYEF2@kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 04/19] x86: Secure Launch Resource Table header file
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-5-ross.philipson@oracle.com>
 <D1RFWFIJEYWL.2FC7V79321264@kernel.org>
 <1eca8cb1-4b3b-402b-993b-53de7c810016@oracle.com>
 <D1RLBMTUKRFN.34KQXEFZTBA08@kernel.org>
 <249a9b27-c18d-4377-8b51-9bc610b53a8b@oracle.com>
 <D1RNKV4JIE5L.1LNG82UAC916M@kernel.org>
 <f66de08f-4905-48d6-8bcf-5b1ab847492f@oracle.com>
 <D1RSB1PB5XGS.2X032M0E1VMJW@kernel.org>
 <a865a25c-336e-47de-9718-de4cb957e6c2@oracle.com>
In-Reply-To: <a865a25c-336e-47de-9718-de4cb957e6c2@oracle.com>

On Wed Jun 5, 2024 at 10:03 PM EEST,  wrote:
> So I did not mean to imply that DRTM support on various=20
> platforms/architectures has a short expiration date. In fact we are=20
> actively working on DRTM support through the TrenchBoot project on=20
> several platforms/architectures. Just a quick rundown here:
>
> Intel: Plenty of Intel platforms are vPro with TXT. It is really just=20
> the lower end systems that don't have it available (like Core i3). And=20
> my guess was wrong about x86s. You can find the spec on the page in the=
=20
> following link. There is an entire subsection on SMX support on x86s and=
=20
> the changes to the various GETSEC instruction leaves that were made to=20
> make it work there (see 3.15).
>
> https://www.intel.com/content/www/us/en/developer/articles/technical/envi=
sioning-future-simplified-architecture.html

Happend to bump into same PDF specification and exactly the seeked
information is "3.15 SMX Changes". So just write this down to some
patch that starts adding SMX things.

Link: https://cdrdv2.intel.com/v1/dl/getContent/776648

So link and document, and other stuff above is not relevant from
upstream context, only potential maintenance burden :-)

For any architectures dig a similar fact:

1. Is not dead.
2. Will be there also in future.

Make any architecture existentially relevant for and not too much
coloring in the text that is easy to check.

It is nearing 5k lines so you should be really good with measured
facts too (not just launch) :-)

BR, Jarkko

