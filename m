Return-Path: <linux-efi+bounces-2870-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD05A4A7EC
	for <lists+linux-efi@lfdr.de>; Sat,  1 Mar 2025 03:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A06189B638
	for <lists+linux-efi@lfdr.de>; Sat,  1 Mar 2025 02:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5774A1EF1D;
	Sat,  1 Mar 2025 02:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJtj7E+Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618B23C9;
	Sat,  1 Mar 2025 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795560; cv=none; b=Pn5i6YivB0B/o4xAE2eNNA4xgCkuUW25iTHD+/IVY8SKZDjTDQ8aBWoKk+WAnJyW5l/uUcLEDuBnRXHPL87dCchL7FcKOeK/6OFK1YPdWhspuD9EMe1Ud7YO5Eqi2iUML3G8wlW9w3PX4RxK+OAjkZBYduaE8i2GxW3isua7cvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795560; c=relaxed/simple;
	bh=cP5LLog8QYA15qY6G6z2j9WolFBDsu0s1MuFuS0Od1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbeloH+ly+664/H0SJXBUmnGKrbDWJoYh8ANSuCry2MEKfC8b5eoIdbkfKEo8seuUHKm1V3om2aZ9krMbT/yX5WE7WObvU8dNdt+qV/ZVFG/Nk3oivREYkZpxU/l6QeaugM3ZV2JbG3/kCURYZSD8YUcR4e+kTTCHORRzD8IPfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJtj7E+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070F4C4CED6;
	Sat,  1 Mar 2025 02:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740795559;
	bh=cP5LLog8QYA15qY6G6z2j9WolFBDsu0s1MuFuS0Od1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJtj7E+Zts7tOwSbKzDGEguy9UOLMYZuKzFeX2/0wKbthGoAS2N3WemoJepw3toZW
	 Ghhjd1rdocrVUN4Ege5O3soyBGLjJIKxw3fVYs39er7ZuhONeFTbd7Pw2iCGOP4+QM
	 jWhc9aLCWc0l3tCEGNC0LaB28WMNOUOkr1rReITa4rblDx5gqlEubfwxybJvIcDPuf
	 38gBeOvXLOBNPi/RSeUabN20wcIfjZNX+li6VypxtDUHFSwZNlvGGJ0Z9c3Zai2AwZ
	 f2HnXVop7TycEbhDPALZUzUHM+YcLkP5ZBsO8nZwRB1ewctHThk6Dh3TMOs4kWnwhq
	 10AgW13Bu+iqg==
Date: Sat, 1 Mar 2025 04:19:15 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
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
Message-ID: <Z8Juo1NESOzK2j8s@kernel.org>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com>
 <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com>
 <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>

On Thu, Feb 27, 2025 at 03:41:18PM -0500, Mimi Zohar wrote:
> On Mon, 2025-01-06 at 17:15 +0000, Eric Snowberg wrote:
> > 
> > > On Jan 5, 2025, at 8:40 PM, Paul Moore <paul@paul-moore.com> wrote:
> > > 
> > > On Fri, Jan 3, 2025 at 11:48 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > 
> > > > Regardless, back to Clavis ... reading quickly through the cover
> > > > letter again, I do somewhat wonder if this isn't better integrated
> > > > into the keyring proper; have you talked to both David and Jarkko
> > > > about this?
> > > 
> > > I realize I should probably expand on my thinking a bit, especially
> > > since my comment a while regarding LSMs dedicated to enforcing access
> > > control on keys is what was given as a reason for making Clavis a LSM.
> > > 
> > > I still stand by my comment from over a year ago that I see no reason
> > > why we couldn't support a LSM that enforces access controls on
> > > keyrings/keys.  What gives me pause with the Clavis LSM is that so
> > > much of Clavis is resident in the keyrings themselves, e.g. Clavis
> > > policy ACLs and authorization keys, that it really feels like it
> > > should be part of the keys subsystem and not a LSM.  Yes, existing
> > > LSMs do have LSM specific data that resides outside of the LSM and in
> > > an object's subsystem, but that is usually limited to security
> > > identifiers and similar things, not the LSM's security policy.
> 
> Hi Jarkko, David,
> 
> Both Paul's and my main concerns with this patch set is storing policy in the
> keyring.  We would appreciate your chiming in here about storing key policy in
> the keyring itself.

Right so the problem here would be that keyring defines policy for keys?

Like in abstract "textbook sense" a policy should not live within in the
closure that it dictactes. And the most classic issue would be probably
circular dependencies.

Theory aside, in practical sense, can you spot an example from the patch
set where we could introduce issue by having Clavis as it is?

> 
> thanks,
> 
> Mimi

BR, Jarkko

