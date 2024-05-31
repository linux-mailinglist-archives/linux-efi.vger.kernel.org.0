Return-Path: <linux-efi+bounces-1115-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E538D588D
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 04:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F91B234E9
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 02:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F1620DC4;
	Fri, 31 May 2024 02:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkaByAMr"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E84C6D;
	Fri, 31 May 2024 02:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717121819; cv=none; b=htacjHei9MURWTIIl7GEQgGhabsO7UwBiRSP03Ob9UfHiy4guG+5cv0UB81LpWmvchkM8puk0bPWZheogiXb0Xgu+kkrONa3kYG2zabNnQLtXBpRxpSQLBZYk6j2Kwmi7uNX54PwjMPcSoz/HfT3/rgh6YVE9u2Fc+tuld+aWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717121819; c=relaxed/simple;
	bh=P5d/0b92iEEWWrKJQ67tqG3rp+vdYxJZiUvaostorGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS65dhGE3Ncm1XPRHuXXGaRIeFSt4C+dVJhEsg2txL+S8/pu0kiz8Brmw4B4liC6jxwpnyz49+88sG0hZS9G+yHYBxSfn/fVhWsz9OY5XuBs8C6TAkx34n4Z/AmGJcRSHVW6n0UwUhibXhknCK7Z4q9MgbEYdo2np0Ij7mpBQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkaByAMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9C8C2BBFC;
	Fri, 31 May 2024 02:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717121819;
	bh=P5d/0b92iEEWWrKJQ67tqG3rp+vdYxJZiUvaostorGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkaByAMrS7s3R8mRhw3b+e4esv4ruad8pwZal97P7yPssH0JV1AZh/jIKAQTk6Tu+
	 JS1Bcf42qlwozPi845OchFKmaFQBRLqLd5IbpLo33CwKwmKGGFe4caWgrY+BF6I3Oo
	 lQvzd7s68N16zgT+eX1feCQkUFxpflo7srOsfgGO5Nuu3GlQXMIjaZH3HK4tB4440c
	 GoqHWACn0iwEfylTG+VXzj9wuwAN+hfKFtYP4YBMVwebVRc6/hx6mLpjLqG0qGlEEW
	 X+Fvudlzs2OvFvkw16SPZ8f9OE+vPr6XP+zhRE/XXACoJ4CmeoxbHv5oyuab8yZeqJ
	 3rAnt80rtWJDg==
Date: Thu, 30 May 2024 19:16:56 -0700
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
Message-ID: <20240531021656.GA1502@sol.localdomain>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531010331.134441-7-ross.philipson@oracle.com>

On Thu, May 30, 2024 at 06:03:18PM -0700, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> 
> For better or worse, Secure Launch needs SHA-1 and SHA-256. The
> choice of hashes used lie with the platform firmware, not with
> software, and is often outside of the users control.
> 
> Even if we'd prefer to use SHA-256-only, if firmware elected to start us
> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
> to safely use SHA-256 for everything else.
> 
> The SHA-1 code here has its origins in the code from the main kernel:
> 
> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> 
> A modified version of this code was introduced to the lib/crypto/sha1.c
> to bring it in line with the SHA-256 code and allow it to be pulled into the
> setup kernel in the same manner as SHA-256 is.
> 
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Thanks.  This explanation doesn't seem to have made it into the actual code or
documentation.  Can you please get it into a more permanent location?

Also, can you point to where the "deliberately cap the SHA-1 PCRs" thing happens
in the code?

That paragraph is also phrased as a hypothetical, "Even if we'd prefer to use
SHA-256-only".  That implies that you do not, in fact, prefer SHA-256 only.  Is
that the case?  Sure, maybe there are situations where you *have* to use SHA-1,
but why would you not at least *prefer* SHA-256?

> /*
>  * An implementation of SHA-1's compression function.  Don't use in new code!
>  * You shouldn't be using SHA-1, and even if you *have* to use SHA-1, this isn't
>  * the correct way to hash something with SHA-1 (use crypto_shash instead).
>  */
> #define SHA1_DIGEST_WORDS	(SHA1_DIGEST_SIZE / 4)
> #define SHA1_WORKSPACE_WORDS	16
> void sha1_init(__u32 *buf);
> void sha1_transform(__u32 *digest, const char *data, __u32 *W);
>+void sha1(const u8 *data, unsigned int len, u8 *out);

Also, the comment above needs to be updated.

- Eric

