Return-Path: <linux-efi+bounces-660-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED23F861BA5
	for <lists+linux-efi@lfdr.de>; Fri, 23 Feb 2024 19:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B341F2781D
	for <lists+linux-efi@lfdr.de>; Fri, 23 Feb 2024 18:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA6F128811;
	Fri, 23 Feb 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbO0L3o5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A22E3FF1;
	Fri, 23 Feb 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713007; cv=none; b=Frx2sd9TrEhcZIL/fREyQR2cJiYvyi5fpMGJzqKXqpcBVRrMntQgB6tD7OCn3lLrRd53pHgk0F3T0sNhuYk0SyOYlmEOrwXNITGyaW6Cz7N2FPN7k2MKqH9+I6uj4yCQ/vE6SOpXMCh31qLcmfYv9qGALlapNdNVqGeToe3/93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713007; c=relaxed/simple;
	bh=h4pO3Tgr1PTkYatoEkKrET/MjLlwGSker91U7kqaO1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBFUyTsE2Yhkqv02timKASG0rTN14cU/pqC/LjDnoMRgzWmlcMG94jSztEIL1sQZzKXsLHc6JeotO5utv6OR0oo0JCR3lnZv26sh4T7AylOO9aq3an2phwa9Zm9dM5X7yuNHvHIwruSwVPMV9T46q4iOqZdjAMyJvSjLum1ATTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbO0L3o5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFCDC433F1;
	Fri, 23 Feb 2024 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713006;
	bh=h4pO3Tgr1PTkYatoEkKrET/MjLlwGSker91U7kqaO1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbO0L3o5nidphoFvFp61Tw3dg+tZlos4tvnVsxt3LBum2bv9S4cTfrRbYtCdgcpk8
	 2K3+Bqs4WAKaIaUXuBtYuzhcR3M9qhvTbIwBIFPCyZaItSaQjQrr8Jd56PmZEqrQZb
	 acEwsL077wp13g1v9RpB2z0nSaHiOLwmaOr9HiFeBHfwJxnAsJU8yhUiKDdA+zvn9n
	 RHBDNQixtUS8LsYmrCB85aI7TzZ//EdZ8jMmeSMNGs5bSkm8fzONPNSAGQWnNkLgVx
	 h4oof10cHJMT7hRlxo70kTubFphVQMWuM+RE2weKDWruUnrzxYplMjxaZS63eqxuam
	 ++gfEOXUOc9gQ==
Date: Fri, 23 Feb 2024 10:30:04 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <20240223183004.GE1112@sol.localdomain>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-7-ross.philipson@oracle.com>
 <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
 <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
 <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
 <1a8e69a7-89eb-4d36-94d6-0da662d8b72f@citrix.com>
 <CAMj1kXEvmGy9RJo4s8tECsFj2dufZ8jBPoJOEtkcGUoj+x2qsw@mail.gmail.com>
 <431a0b3a-47e5-4e61-a7fc-31cdf56f4e4c@citrix.com>
 <20240223175449.GA1112@sol.localdomain>
 <e641e2f1-16cf-4717-8a1f-8afac2644efe@citrix.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e641e2f1-16cf-4717-8a1f-8afac2644efe@citrix.com>

On Fri, Feb 23, 2024 at 06:20:27PM +0000, Andrew Cooper wrote:
> On 23/02/2024 5:54 pm, Eric Biggers wrote:
> > On Fri, Feb 23, 2024 at 04:42:11PM +0000, Andrew Cooper wrote:
> >> Yes, and I agree.  We're not looking to try and force this in with
> >> underhand tactics.
> >>
> >> But a blind "nack to any SHA-1" is similarly damaging in the opposite
> >> direction.
> >>
> > Well, reviewers have said they'd prefer that SHA-1 not be included and given
> > some thoughtful reasons for that.  But also they've given suggestions on how to
> > make the SHA-1 support more palatable, such as splitting it into a separate
> > patch and giving it a proper justification.
> >
> > All suggestions have been ignored.
> 
> The public record demonstrates otherwise.
> 
> But are you saying that you'd be happy if the commit message read
> something more like:
> 
> ---8<---
> For better or worse, Secure Launch needs SHA-1 and SHA-256.
> 
> The choice of hashes used lie with the platform firmware, not with
> software, and is often outside of the users control.
> 
> Even if we'd prefer to use SHA-256-only, if firmware elected to start us
> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
> to safely use SHA-256 for everything else.
> ---

Please take some time to read through the comments that reviewers have left on
previous versions of the patchset.

- Eric

