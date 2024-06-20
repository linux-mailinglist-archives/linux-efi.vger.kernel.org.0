Return-Path: <linux-efi+bounces-1248-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C31890FA2A
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 02:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1682B21719
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 00:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EBE816;
	Thu, 20 Jun 2024 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UogrS+kY"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B864C;
	Thu, 20 Jun 2024 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718842702; cv=none; b=S9p2/dGyD53x+ZlC8EQR9rpT8Je0s9pxNaOcRUEnxKUf7CzmJdw3rGj6tHU8zqM6nZxPI9xgGTa/7HHqp/MqU3akcS7ZDFRm24O4EJINpsWeJft6vf7Hgdl8w9tIgbKBorklSnUnoa3JsIuvnStqkbq4o5vFx8oEU2zs+eRDU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718842702; c=relaxed/simple;
	bh=AjGTuPtk95NLEx+Fq4Qq+oorb0yiuLhFVoBTD7HosbQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eqfDJZqwmfoDguIfImZIFmZAmC4iz84+6VaoU8/hIHRY3h62tTeO/3ShNeBuisrUk4ugAuoVwLQqz44WCMeqzvEGykPS0EhADS1Pg2vEOGuV6P7+ruOfxlbGYtGDELliUOdUMcy+sQH0jkpRS/dZHpm4/to/tHwlxEs+qO1FQJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UogrS+kY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9158FC2BBFC;
	Thu, 20 Jun 2024 00:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718842701;
	bh=AjGTuPtk95NLEx+Fq4Qq+oorb0yiuLhFVoBTD7HosbQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UogrS+kY7AH+DCLQ2wu6155VpA9xgKIzKNs1kx36Stt7xUroWQHkFKlsg7gLvh04C
	 WmHYDyOFcZMT+C7jB9qW/cwh6GvuDZ0CHnWikBphf5WzbbjTEYvgIcezIVstgcxpGz
	 g55DDyXE8tISgnVjX6fsOhEDASTPuRJOJLd/1CLuINQscuxncHUPHapZQF/2x1ogPy
	 pP+eK0/dLHoE1IOgvxEWxJx1cr3ErS5E+oQU9/qTm7EScqv8rHl1eD7wfppOXyvl4Z
	 PiIDDwqP3Q+qbBZoPySZ8JhqIZ0jj+ObaVp+Y/iZSIA5WPh1I3R0HG/CB6VsVEfJho
	 jXU8QWoU/wyLA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Jun 2024 03:18:13 +0300
Message-Id: <D24EVSK6GUPH.1P44T5NNBWORU@kernel.org>
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
 <D1SPFVXS6FOG.IQQB3INFYEF2@kernel.org>
 <23961b5b-a52a-483c-876e-e5e39d9e6c01@oracle.com>
In-Reply-To: <23961b5b-a52a-483c-876e-e5e39d9e6c01@oracle.com>

On Thu Jun 6, 2024 at 7:49 PM EEST,  wrote:
> > For any architectures dig a similar fact:
> >=20
> > 1. Is not dead.
> > 2. Will be there also in future.
> >=20
> > Make any architecture existentially relevant for and not too much
> > coloring in the text that is easy to check.
> >=20
> > It is nearing 5k lines so you should be really good with measured
> > facts too (not just launch) :-)
>
> ... but overall I get your meaning. We will spend time on this sort of=20
> documentation for the v10 release.

Yeah, I mean we live in the universe of 3 letter acronyms so
it is better to summarize the existential part, especially
in a ~5 KSLOC patch set ;-)

BR, Jarkko

