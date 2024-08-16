Return-Path: <linux-efi+bounces-1547-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A92D1955109
	for <lists+linux-efi@lfdr.de>; Fri, 16 Aug 2024 20:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7831C21A3E
	for <lists+linux-efi@lfdr.de>; Fri, 16 Aug 2024 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013DC1C37AB;
	Fri, 16 Aug 2024 18:49:29 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D821BDAA0;
	Fri, 16 Aug 2024 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.126.240.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723834168; cv=none; b=IAemLPGvBjJIqeu5l7fDb9OdlsTWftwOlqXFbnGny6NOepns49vsFd1c4yIoqqEMvUIDw94HQqXRXPjpqPMRrxRnrk37edsXWv2r1eUIu34Vncjjoxh8ltEoCNvR73hqf8aa/v9p/KwuqX0LdwOcPpQ+arA0hmJ4Fc7LjN7+UuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723834168; c=relaxed/simple;
	bh=cLs57Vs9MQ8D3e6i1jotFe7J+gYFAW+PDI+oQja9PhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErFN8G1t4jHQ7EPbFVs99IHFruCyrukA4d2Z6Q7EXyfvNlhk+4z5caZ8hvxTsPzrm0vziqQStkB4/ZUXxoEtbhkynjGwl7obAD0vD/ixkSJGQL8Mpl/NKlK/5KEIlOj+xqbV9sgsWGP56vgUEpisJSheZt8CWHDndS6b1S9ifv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=codon.org.uk; arc=none smtp.client-ip=176.126.240.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 61FBF40677; Fri, 16 Aug 2024 19:41:16 +0100 (BST)
Date: Fri, 16 Aug 2024 19:41:16 +0100
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
Message-ID: <Zr+dTMYZNY1b9cRV@srcf.ucam.org>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <550d15cd-5c48-4c20-92c2-f09a7e30adc9@citrix.com>
 <D3HAP4O4OVS3.2LOSH5HMQ34OZ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3HAP4O4OVS3.2LOSH5HMQ34OZ@kernel.org>

On Fri, Aug 16, 2024 at 02:22:04PM +0300, Jarkko Sakkinen wrote:

> For (any) non-legacy features we can choose, which choices we choose to
> support, and which we do not. This is not an oppositive view just saying
> how it is, and platforms set of choices is not a selling argument.

NIST still permits the use of SHA-1 until 2030, and the most significant 
demonstrated weaknesses in it don't seem applicable to the use case 
here. We certainly shouldn't encourage any new uses of it, and anyone 
who's able to use SHA-2 should be doing that instead, but it feels like 
people are arguing about not supporting hardware that exists in the real 
world for vibes reasons rather than it being a realistically attackable 
weakness (and if we really *are* that concerned about SHA-1, why are we 
still supporting TPM 1.2 at all?)

