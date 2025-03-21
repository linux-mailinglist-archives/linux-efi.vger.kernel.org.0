Return-Path: <linux-efi+bounces-3055-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390ADA6C0E2
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 18:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AFD174A6E
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EB122D4DD;
	Fri, 21 Mar 2025 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDTu5oS3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36332F43;
	Fri, 21 Mar 2025 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576915; cv=none; b=JGihhlkPCitBVKOZdWmIrK6W9fVQwrAfEZRb+VoMqyE6qEF/s/Lf8ke2of91axnRgkhJYf654kIu2FMxihmyH2u7kn8yBrDdlif8vUBA/aTXrqgnDnEbvHjUcoLWOnKPo9xpdsDSILPYfqGEp90BVHGxSRa0mAFb0qFxhicVA1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576915; c=relaxed/simple;
	bh=1NgC7WYxjVqQXoN0hz/U33WN/j1JXyX9+hiBoc78bd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCr29PxA75xC07ILrPnU1DOrTeRBZqt7wKSaeC0XGsWijBLWeMtPmq/EcTQbM7eYXniGZk0LIgLFo/FMMGkAix3ElxSjsH0Sk1ohzn2aD8668JQgUIvzyKMAIKSs5YSpWiU9tMSymrDZVc2Ou2wWNitQ3HyLRJKOApuDC8Nwlg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDTu5oS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082E6C4CEE3;
	Fri, 21 Mar 2025 17:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742576914;
	bh=1NgC7WYxjVqQXoN0hz/U33WN/j1JXyX9+hiBoc78bd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDTu5oS3ogEDl/QCQwW3/iBgnFdqP5u6Q939YLryrfrOrgy2xdjcG2CMeBORC7SSM
	 8HUgiF6AqPtxFzntp0mYL+YKvDzxftGUNxDR4L88V9YRCv3aV3w1vZU17oY3At5ckA
	 tZRSrPR4Gm7tWM/h5RQVxhBc+MnYYG5qjPSwLZC3Z3Zwz4+LYB/WxlESwvyIU1OvVz
	 7YBIEsrXk4UkqOeG9uY5nCREPIUoKUo1npt0UGPa3GmPr8uHnAcG0VS9+0jYZX+5wZ
	 vUYhsDQkdjfVrGIPcB6hNUeReKDEUbYrzc8S08J7g1Zy0pBvIwOQB6xHA+7aCy1ACP
	 uUXxU402YUGqQ==
Date: Fri, 21 Mar 2025 19:08:27 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	"casey@schaufler-ca.com" <casey@schaufler-ca.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"ebiggers@kernel.org" <ebiggers@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
Message-ID: <Z92dCwEDNmESjPAs@kernel.org>
References: <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com>
 <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com>
 <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
 <1A222B45-FCC4-4BBD-8E17-D92697FE467D@oracle.com>
 <CAHC9VhTObTee95SwZ+C4EwPotovE9R3vy0gVXf+kATtP3vfXrg@mail.gmail.com>
 <EB757F96-E152-4EAB-B3F7-75C1DBE3A03B@oracle.com>
 <1956e7f9d60.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <A3A29FB9-E015-4C87-B5F0-190A4C779CB3@oracle.com>
 <95e7a43a2dd675615a146c56a10abf6921f955f9.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95e7a43a2dd675615a146c56a10abf6921f955f9.camel@HansenPartnership.com>

On Thu, Mar 20, 2025 at 06:40:55PM -0400, James Bottomley wrote:
> On Thu, 2025-03-20 at 16:24 +0000, Eric Snowberg wrote:
> > Having lockdown enforcement has always been 
> > a requirement to get a shim signed by Microsoft.
> 
> This is factually incorrect.  Microsoft transferred shim signing to an
> independent process run by a group of open source maintainers a while
> ago:
> 
> https://github.com/rhboot/shim-review/
> 
> If you actually look, you'll see even Microsoft has to obey this
> upstream process for their Linux distro:
> 
> https://github.com/rhboot/shim-review/issues/427

I did not know this. Thanks for educating!

> 
> Regards,
> 
> James
> 

BR, Jarkko

