Return-Path: <linux-efi+bounces-3056-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0A8A6C13A
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 18:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2B63ADEF3
	for <lists+linux-efi@lfdr.de>; Fri, 21 Mar 2025 17:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561AD22D7AD;
	Fri, 21 Mar 2025 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0Iq/Lzu"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF91E492D;
	Fri, 21 Mar 2025 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577745; cv=none; b=Lo5OnzMjr+7CTxm1HEG0Lf/uGp7YyAp5+Ys6NOF0zKY0vjb62wQjunIHkn46Ix50Y6tBnMGyh2JeyzerNss7YI6AUskvguLn8BnK5OqwDzfEc3ez65m8mWI0IKlofeiWmDt88q6DQYSa8k/Yd41kWp185XAdMO8QyntPY6R5cig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577745; c=relaxed/simple;
	bh=Q/2cpfOpAi/WqpaXdWrKInZtwyOQwN+cMfoLexqZElo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9aEsVbjcIc6/+S3BkCTg7qJAgg91VjULn4H1E9LvgFpgNGod82t3308/x4X8gQTnEbyz9D3ezMFzdGGwNcVWg9zUPmNFWlc/XSBziuPisT20IOWv99qtDvtBESmOvo3yApSuj1+F7jQgMis446BKcI8PQJ2LCg2h9TQdt3V5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0Iq/Lzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414AFC4CEE3;
	Fri, 21 Mar 2025 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577744;
	bh=Q/2cpfOpAi/WqpaXdWrKInZtwyOQwN+cMfoLexqZElo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h0Iq/Lzu/fvBg6TikKkrUEV8vlYsZPsdOUVPaIxE9HNzmrMgjA1mEGh3tzqmFBb3Y
	 1QpS7lKxvUNGqXtIkGyFvV048zaYXK8QIbx+grS08m9+UdHAM/ZHpF+xk9GeKB4gBf
	 7mU/sCxeCxKNMvYfFYSWkNmHyWagXLz5T0d8ZSVTic1cgCi2U/TE3bjCO4s6rsEioZ
	 q/Ji5eCevxYQdXSlHE6J2gLAyDn0WYGWUY/b9VfFtGnHKZCrXU1GNATo2ZZVsGhReG
	 tzpIUwNGJBIwTnZJ0B7PAlPKKKsv45Tii8i2Yp/cEp/ypaGXqMeVXltf25OTaco4+P
	 S1gb9rbHh1g6Q==
Date: Fri, 21 Mar 2025 19:22:21 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
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
Message-ID: <Z92gTQj6QkedbH0K@kernel.org>
References: <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com>
 <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com>
 <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
 <1A222B45-FCC4-4BBD-8E17-D92697FE467D@oracle.com>
 <CAHC9VhTObTee95SwZ+C4EwPotovE9R3vy0gVXf+kATtP3vfXrg@mail.gmail.com>
 <EB757F96-E152-4EAB-B3F7-75C1DBE3A03B@oracle.com>
 <1956e7f9d60.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <A3A29FB9-E015-4C87-B5F0-190A4C779CB3@oracle.com>
 <CAHC9VhQMN6cgWbxdAgBNffpCAo=ogGdm4qBGS_kKdDmiT8b3cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQMN6cgWbxdAgBNffpCAo=ogGdm4qBGS_kKdDmiT8b3cw@mail.gmail.com>

On Thu, Mar 20, 2025 at 05:36:41PM -0400, Paul Moore wrote:
> On Thu, Mar 20, 2025 at 12:29 PM Eric Snowberg <eric.snowberg@oracle.com> wrote:
> > > On Mar 6, 2025, at 7:46 PM, Paul Moore <paul@paul-moore.com> wrote:
> > > On March 6, 2025 5:29:36 PM Eric Snowberg <eric.snowberg@oracle.com> wrote:
> 
> ...
> 
> > >> Does this mean Microsoft will begin signing shims in the future without
> > >> the lockdown requirement?
> > >
> > > That's not a question I can answer, you'll need to discuss that with the UEFI SB people.
> >
> > Based on your previous lockdown comments, I thought you might have
> > some new information.  Having lockdown enforcement has always been
> > a requirement to get a shim signed by Microsoft.
> 
> I want to address two things, the first, and most important, is that
> while I am currently employed by Microsoft, I do not speak for
> Microsoft and the decisions and actions I take as an upstream Linux
> kernel maintainer are not vetted by Microsoft in any way.  I think you
> will find that many upstream kernel maintainers operate in a similar
> way for a variety of very good reasons.

This is understood. If one takes a kernel maintainer role, one should
unconditionally disobey any vetting by the employer (even at the cost of
the job, or alternatively at the cost of giving up the maintainership).

And with you in particular I don't think anyone has any trust issues,
no matter which group of villains you might be employed by ;-)

> 
> The second issue is that my main focus is on ensuring we have a
> secure, safe, and well maintained LSM subsystem within the upstream
> Linux kernel.  While I do care about downstream efforts, e.g. UEFI
> Secure Boot, those efforts are largely outside the scope of the
> upstream Linux kernel and not my first concern.  If the developer
> groups who are focused on things like UEFI SB want to rely on
> functionality within the upstream Linux kernel they should be prepared
> to stand up and contribute/maintain those features or else they may go
> away at some point in the future.  In very blunt terms, contribute
> upstream or Lockdown dies.

Could Lockdown functionality be re-implemented with that eBPF LSM? I
have not really looked into it so far...

BR, Jarkko

