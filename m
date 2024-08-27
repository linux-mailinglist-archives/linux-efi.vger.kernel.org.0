Return-Path: <linux-efi+bounces-1610-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE63596168D
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 20:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE08B23BCA
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 18:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DDC1CE6F9;
	Tue, 27 Aug 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO9wZXRK"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136D64A;
	Tue, 27 Aug 2024 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782469; cv=none; b=QeNUD1inJ9Q33iwUkMW9DtpD6ClhiCwUJ9gvuilOejns4jukWrTcerzu9lDkfP7xG9VLXM7+U/bVynVgHCWQppZUlUuPe7MX1q2vxu3+yGnt/WQiZveKqhd3d7GOQEfBNjUFsf6A7pdnN+hA53NXDv+6DznIl2I4NP9mzMLSzxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782469; c=relaxed/simple;
	bh=m0KhuixhE94LpmqoQsm4UAltH48GcF8i8IXdiG38ZPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4dRea0Q8M9HFDmc+xTpywqohdnbEW2O3XLj9X1bgrEQ1kk4L78aWE9NjMA80fHqmD811dFGq3VZMbZF8hlMzHXmc5A2p+gJNP3zISzkZlPqYWSpf9iIrrOzooiP7+2zZe501FWrtdja8eDUJWKyrnF/Z1e9lEc8+zB98Jjb8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO9wZXRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B41C55DE1;
	Tue, 27 Aug 2024 18:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724782469;
	bh=m0KhuixhE94LpmqoQsm4UAltH48GcF8i8IXdiG38ZPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NO9wZXRK+c5+9o1RgEUXTMlPsLUkraQbJNjNWgnaiIsMVAj7HTDpigo1IKFqPjQSC
	 72aYl4ts3jLiWhPoHr5B+0XONuilwh2rVswBam14Vp2U84t+uzxlVMX80qsuYTUwMd
	 B03rCcpX2T0+wlO1mryM4OumGNDr3k3Oj8NO3Dc94a7lzqt6Vqdane7FRLa1U8xvd6
	 QIqoXi5N9u8S8mhS9/gA5VAQP+xy8shOYuVsU9PJsQmze3QJq57qFJCtarRBhpyAya
	 VTsHjCBQprW7P/+6l5j3vMcsypMc9D0XOKJ+pnsn9wnsg3+pJxbeIeF38mRpoBFf7O
	 XwDFH+Dkzul/A==
Date: Tue, 27 Aug 2024 11:14:26 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
Message-ID: <20240827181426.GC2049@sol.localdomain>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531021656.GA1502@sol.localdomain>

On Thu, May 30, 2024 at 07:16:56PM -0700, Eric Biggers wrote:
> On Thu, May 30, 2024 at 06:03:18PM -0700, Ross Philipson wrote:
> > From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> > 
> > For better or worse, Secure Launch needs SHA-1 and SHA-256. The
> > choice of hashes used lie with the platform firmware, not with
> > software, and is often outside of the users control.
> > 
> > Even if we'd prefer to use SHA-256-only, if firmware elected to start us
> > with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
> > the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
> > to safely use SHA-256 for everything else.
> > 
> > The SHA-1 code here has its origins in the code from the main kernel:
> > 
> > commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> > 
> > A modified version of this code was introduced to the lib/crypto/sha1.c
> > to bring it in line with the SHA-256 code and allow it to be pulled into the
> > setup kernel in the same manner as SHA-256 is.
> > 
> > Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> > Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> Thanks.  This explanation doesn't seem to have made it into the actual code or
> documentation.  Can you please get it into a more permanent location?

I see that a new version of the patchset was sent out but this suggestion was
not taken.  Are you planning to address it?

- Eric

