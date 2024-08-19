Return-Path: <linux-efi+bounces-1560-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EF795731F
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 20:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B0ACB23A82
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 18:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4D31891BD;
	Mon, 19 Aug 2024 18:24:34 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A6516A934;
	Mon, 19 Aug 2024 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.126.240.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091874; cv=none; b=on3hHwl56sRTjSy81xgszfaw3gv3fpj9F1cz7BwvxPa+vXkMNdQND+q+vGK7pBi6a9A9Xu5UigUGN+k6LlsnqJIKluO7ICaTOAEbfGhuQ71CpIlJORmVZjixvucGJ4YyH6qYgo243WTTWaMLOpV09YHNECr4UAKKpQIAFkneAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091874; c=relaxed/simple;
	bh=HHitbLQcODdjPuCSoJaZiVGwSe7pT6N18nHKmwnz0TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwLpxV0LMlwt1fd3DqH14qPuf3m3AgCqKVETARIlpZGGZlvE7Kggs0ojX5xdSy2ifsn9bQgco6g1F+8/Dw/d6r/uIqNfVMev2qeRgNXwvMxlrRQZPHTNyqmfvkb5jnoPZMLOd5jUg1XMtxFTuxZL+7KKTK5VppY9oJjCyibI1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=codon.org.uk; arc=none smtp.client-ip=176.126.240.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 2F2FF409FF; Mon, 19 Aug 2024 19:24:02 +0100 (BST)
Date: Mon, 19 Aug 2024 19:24:02 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, ardb@kernel.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
Message-ID: <ZsONwsWs3zCln70O@srcf.ucam.org>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <550d15cd-5c48-4c20-92c2-f09a7e30adc9@citrix.com>
 <D3HAP4O4OVS3.2LOSH5HMQ34OZ@kernel.org>
 <Zr+dTMYZNY1b9cRV@srcf.ucam.org>
 <D3K35VBCWZSW.2WCXJMW1HGGD5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3K35VBCWZSW.2WCXJMW1HGGD5@kernel.org>

On Mon, Aug 19, 2024 at 09:05:47PM +0300, Jarkko Sakkinen wrote:
> On Fri Aug 16, 2024 at 9:41 PM EEST, Matthew Garrett wrote:
> > On Fri, Aug 16, 2024 at 02:22:04PM +0300, Jarkko Sakkinen wrote:
> >
> > > For (any) non-legacy features we can choose, which choices we choose to
> > > support, and which we do not. This is not an oppositive view just saying
> > > how it is, and platforms set of choices is not a selling argument.
> >
> > NIST still permits the use of SHA-1 until 2030, and the most significant 
> > demonstrated weaknesses in it don't seem applicable to the use case 
> > here. We certainly shouldn't encourage any new uses of it, and anyone 
> > who's able to use SHA-2 should be doing that instead, but it feels like 
> > people are arguing about not supporting hardware that exists in the real 
> > world for vibes reasons rather than it being a realistically attackable 
> > weakness (and if we really *are* that concerned about SHA-1, why are we 
> > still supporting TPM 1.2 at all?)
> 
> We are life-supporting TPM 1.2 as long as necessary but neither the
> support is extended nor new features will gain TPM 1.2 support. So
> that is at least my policy for that feature.

But the fact that we support it and provide no warning labels is a 
pretty clear indication that we're not actively trying to prevent people 
from using SHA-1 in the general case. Why is this a different case? 
Failing to support it actually opens an entire separate set of footgun 
opportunities in terms of the SHA-1 banks now being out of sync with the 
SHA-2 ones, so either way we're leaving people open to making poor 
choices.

