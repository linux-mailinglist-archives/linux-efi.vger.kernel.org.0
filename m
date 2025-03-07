Return-Path: <linux-efi+bounces-2928-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD252A571D1
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 20:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD0A1898CFA
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 19:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86462459D6;
	Fri,  7 Mar 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBHdUwuM"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3452221DB9;
	Fri,  7 Mar 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375849; cv=none; b=aLokCw7olrjAul7qlVRX/im0Vy5EL4/0EcMZslHGP7um2E2pSTKkt+tj8AaJpjHSqZd6pSo53QE9Ra9c6Rz38aE16kRd/USZtIRnbhOFKLIkydhoCv/S85ktISRKHlBUk6QoglMOLF87B88WqKxoezOekdNpY1P39So7iqFNetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375849; c=relaxed/simple;
	bh=Mm9dkH53vQFmbsvTLUOCgmTJngIQCXH0JJidFARo+KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObwFYXdQ5wxR4xSaDO7deXyoekK+Ir29hWVhCnuqcha5djugh4IFghSTJGp3JgiOlsNGJdrk02p6XNA0tKx/hSxwO4gGU0M/f5FbCNbY5nTBPYYJG05EQGOsXbamqx84wTB0GE+NLXMy/kDzzPnIiClvRXhHoIF87EbVRV7y2R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBHdUwuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F2DC4CED1;
	Fri,  7 Mar 2025 19:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741375849;
	bh=Mm9dkH53vQFmbsvTLUOCgmTJngIQCXH0JJidFARo+KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBHdUwuMqbFRLDoTflKN+B3coXembP6ABjnuxzjaoQgyuW4Cyav/rS7U8CckTWGfg
	 lHvXLlXLguS8WmCOy5pTEJAbs5TWKQOAkwFu0wbXyaHcIQgcCzazWZjUWt2x3m5G2y
	 1q+cpdjKTUDPxuKjK7/c828rrUMfNZ/y9sRvHQAVhABFzusm97WiuUV486m/XIZqJg
	 aRKWpaZeucqLbvfUDT3M1aA2H0PDK9XF9N1rGxl/f4IVRqTk4CwaWffBJXefXrmZ84
	 lRgM0mrIpXkbvA1h7YMjTslrtbDi5l4/abLdXxwOP10/Gf847iDF/nBwKDFIR27zsV
	 mbQMHH2ypOmHQ==
Date: Fri, 7 Mar 2025 21:30:44 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: ross.philipson@oracle.com
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v12 03/19] x86: Secure Launch Resource Table header file
Message-ID: <Z8tJZBl2Nh4RJGDS@kernel.org>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-4-ross.philipson@oracle.com>
 <Z8qE1B47InxE7n-v@kernel.org>
 <de143ab2-44b3-4609-a575-63c47d99ea09@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de143ab2-44b3-4609-a575-63c47d99ea09@oracle.com>

On Fri, Mar 07, 2025 at 11:22:02AM -0800, ross.philipson@oracle.com wrote:
> On 3/6/25 9:32 PM, Jarkko Sakkinen wrote:
> > On Thu, Dec 19, 2024 at 11:42:00AM -0800, Ross Philipson wrote:
> > > Introduce the Secure Launch Resource Table which forms the formal
> > > interface between the pre and post launch code.
> > > 
> > > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > 
> > Is this interface kernel specific or uarch specific? I'd just
> > explicitly state the context of the formal interface, that's
> > all.
> 
> It is specific to our DRTM solution (i.e. Secure Launch). It is meant to be
> extensible to accommodate future architectures that have DRTM support
> available. Not sure if I am getting at your specific question.

OK so:

1. It's software defined set of data structures with no ties to
   the hardware architecture.
2. It's essentially an API maintining backwards compatibility.

I have nothing against that definition. It is just that speaking about
formal interface between pre and post launch code does not provide
explanation on what are the constraints of the interface.

So what I was not getting was the specific definition (i.e. *the*
specific formalism under discussion).

BR, Jarkko


