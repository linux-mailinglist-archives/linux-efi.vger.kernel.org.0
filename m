Return-Path: <linux-efi+bounces-2889-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58364A4F2B9
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 01:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77547168A93
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 00:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FA81E531;
	Wed,  5 Mar 2025 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPwVJp3g"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AA617548;
	Wed,  5 Mar 2025 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134558; cv=none; b=MnB5Jm4fpOkZjB4nFMALUKC5Bq9QHRCmva37dFHMfxaM5Q0/lfWEsbFyWKW4rKzYlL3berhBmnntcVbyR2ABQnnVQSMVgDgeqCeG3hPqyia/EZdNTWGcQIZhmAeiL3zHkMxCRzKbHL2xeHDAF/TXOtRfPVSM+4hkWzr8BT0e7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134558; c=relaxed/simple;
	bh=v4LFSDcbSZvz0tDH0vbM1o3jV3dG7EspXAJxw8uUJk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpaPTFU+SV6Jr9LAdZjxEW0JkA+DsOOlgE3V2sC27Cx7tTrwA0Z6wiNdE6hZIMgo345aKHYZDOvqN5otA/OI779SqTMX+NkMtZf3eSVgR5x9bwFGhroeOq5wQv2LH3XByJ8aYTFYbFqnBNFNbX8odTOlwVwdp9H9kvZT2U53hO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPwVJp3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18355C4CEE5;
	Wed,  5 Mar 2025 00:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741134557;
	bh=v4LFSDcbSZvz0tDH0vbM1o3jV3dG7EspXAJxw8uUJk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPwVJp3gVOxr5vkeZvGhr+JufYiRWINOpBadU50KWF9Cb0DE1wDsXvRj3BV3ReSwq
	 SD8gMy8hB/fvCjRq3rOA1+Dneetww9tJQDik2OxWFE9D5fWTPCU9vcWHz01MkAx4s0
	 89RmGTtmHEfLoEnuy//texnkqd3I6gg5zh8epMmC85dxxT8vd94GjPAv1hLrycAE1N
	 IqS710KEJi3BJqkaWGBgWC0uKhv7W/cJgaCtxvf+zvSh3yPYZwgZ7fw8MspFExGVzO
	 07MoSlxTfPFwcqC3fvkKnXTCCbtqkwReZDOfEL6wDEQTocPWw0dqevsJ2TW/NTEyLV
	 kXPnWtVFyNCZg==
Date: Wed, 5 Mar 2025 02:29:13 +0200
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
Message-ID: <Z8ea2TRPS6uMgXxG@kernel.org>
References: <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com>
 <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
 <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com>
 <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <Z8d9ulOirAeHmFJV@kernel.org>
 <CAHC9VhQC_bqZAFiABMUhTO6jTUFgHB8vjpb6-Eo7SA-2-5xfuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQC_bqZAFiABMUhTO6jTUFgHB8vjpb6-Eo7SA-2-5xfuQ@mail.gmail.com>

On Tue, Mar 04, 2025 at 07:25:13PM -0500, Paul Moore wrote:
> On Tue, Mar 4, 2025 at 5:25 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > On Mon, Mar 03, 2025 at 05:40:54PM -0500, Paul Moore wrote:
> > > On Fri, Feb 28, 2025 at 12:52 PM Eric Snowberg <eric.snowberg@oracle.com> wrote:
> > > > > On Feb 28, 2025, at 9:14 AM, Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Fri, Feb 28, 2025 at 9:09 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > >> On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
> > > > >>>
> > > > >>> I'd still also like to see some discussion about moving towards the
> > > > >>> addition of keyrings oriented towards usage instead of limiting
> > > > >>> ourselves to keyrings that are oriented on the source of the keys.
> > > > >>> Perhaps I'm missing some important detail which makes this
> > > > >>> impractical, but it seems like an obvious improvement to me and would
> > > > >>> go a long way towards solving some of the problems that we typically
> > > > >>> see with kernel keys.
> > > >
> > > > The intent is not to limit ourselves to the source of the key.  The main
> > > > point of Clavis is to allow the end-user to determine what kernel keys
> > > > they want to trust and for what purpose, irrespective of the originating
> > > > source (.builtin_trusted, .secondary, .machine, or .platform). If we could
> > > > go back in time, individual keyrings could be created that are oriented
> > > > toward usage.   The idea for introducing Clavis is to bridge what we
> > > > have today with kernel keys and allow them to be usage based.
> > >
> > > While it is unlikely that the current well known keyrings could be
> > > removed, I see no reason why new usage oriented keyrings could not be
> > > introduced.  We've seen far more significant shifts in the kernel over
> > > the years.
> >
> > Could we implement such change in a way that these new imaginary
> > (at this point) usage oriented keyrings would be used to create
> > the "legacy" keyrings?
> 
> I think it would be easier for them to coexist so that one could have
> an easier migration.  It's possible that even once everything was
> migrated to the new usage oriented keyrings it would still make sense
> to keep the existing keyrings in place and always link keys from there
> to the newer usage keyrings.

OK, so here I agree and disagree:

1. It probably does not port everything.
2. Still, we need to be sure that "can be done" condition is satisfied
   for the sake of robustness.


> 
> -- 
> paul-moore.com
> 

BR, Jarkko

