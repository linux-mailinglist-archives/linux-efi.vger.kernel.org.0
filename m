Return-Path: <linux-efi+bounces-658-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A23A0861AF2
	for <lists+linux-efi@lfdr.de>; Fri, 23 Feb 2024 18:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F981F28520
	for <lists+linux-efi@lfdr.de>; Fri, 23 Feb 2024 17:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492E2142647;
	Fri, 23 Feb 2024 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLDmk0vY"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144FB13A88E;
	Fri, 23 Feb 2024 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710892; cv=none; b=ndX5K2g9auAh9UGwwacaxuyprEonD9brJC8lv05H3hNbfWowmcINO4rX9G/3/xPWUeDOPaXHpZE2KLmqKAuT6/ulQ0wDvSfYSEUw5/iKkYHAZysa+/vOLDyGcoLo5Jx3OCCZfZyrGKMPq2S8vRXmInJ3tiygMHjFs8sAwD/e2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710892; c=relaxed/simple;
	bh=QDQLjwhGjrv6J0gGJFn9+fBtaCu989tCcvRM0N4xN5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAZQEvjYOhoJ8QS9BHtW52RSgJJWEVa3Cv+meX4LZDVgfylYDclRR1Wv/fPOhpgYdS6fRV/RYiLzx/UuuW3EPEs27N3ApnL1w2KnVFgaz/I53BvO/YZ9S/EWjxJg78nBFlgxx+cF8rjMoY+kzwafolDiPIC/BQf/cs5j39i6zwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLDmk0vY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C556C43399;
	Fri, 23 Feb 2024 17:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708710891;
	bh=QDQLjwhGjrv6J0gGJFn9+fBtaCu989tCcvRM0N4xN5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLDmk0vYspblgOXAoC1hDGtndhtEX5ClQrqv4HwBrmPOeqoDPmCoH9QecDEkw4k+b
	 le+AJCfHgTBFu7ME44ZsdGBgrPxx1XDntVzq7JqVKDEOoFe7olbmg8/Mlx14w0aKX4
	 3u2OB28AFlNz0RHygrPBtUvDPALSu+g3uUh4LE/RJbkhBQEe4R9IHYfaoPygrWlBkr
	 x0UQuR43gmgaTidqfHdUjdCr9FiQFhBf9jBVPN6Dhm7K/Wnvc11ns7eAbOUh04bbb/
	 GIMVyqki0yi5QhPsaSZUOq/tLrKFAzL4NndRsVCcGlq6gjsrZFsKE8F/it6IfkWKaw
	 4h/c916YgvLHg==
Date: Fri, 23 Feb 2024 09:54:49 -0800
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
Message-ID: <20240223175449.GA1112@sol.localdomain>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-7-ross.philipson@oracle.com>
 <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
 <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
 <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
 <1a8e69a7-89eb-4d36-94d6-0da662d8b72f@citrix.com>
 <CAMj1kXEvmGy9RJo4s8tECsFj2dufZ8jBPoJOEtkcGUoj+x2qsw@mail.gmail.com>
 <431a0b3a-47e5-4e61-a7fc-31cdf56f4e4c@citrix.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <431a0b3a-47e5-4e61-a7fc-31cdf56f4e4c@citrix.com>

On Fri, Feb 23, 2024 at 04:42:11PM +0000, Andrew Cooper wrote:
> 
> Yes, and I agree.  We're not looking to try and force this in with
> underhand tactics.
> 
> But a blind "nack to any SHA-1" is similarly damaging in the opposite
> direction.
> 

Well, reviewers have said they'd prefer that SHA-1 not be included and given
some thoughtful reasons for that.  But also they've given suggestions on how to
make the SHA-1 support more palatable, such as splitting it into a separate
patch and giving it a proper justification.

All suggestions have been ignored.

- Eric

