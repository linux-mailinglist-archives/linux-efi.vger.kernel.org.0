Return-Path: <linux-efi+bounces-2871-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B1AA4A7F7
	for <lists+linux-efi@lfdr.de>; Sat,  1 Mar 2025 03:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7F2189CECD
	for <lists+linux-efi@lfdr.de>; Sat,  1 Mar 2025 02:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187B9135A53;
	Sat,  1 Mar 2025 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCWp+p7j"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ACC23C9;
	Sat,  1 Mar 2025 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795652; cv=none; b=FOvxZe9g/LGbo/1tU+YGpbH2R4wYqkv359xXUO9fNa6D9VcERXZxcbWjZ+zPitVrPByfW8/kPmg2pekvEcQgckeeOZKz1sBbwIIdEf7VJ9ZHXjBbbPkBmQnWU9MqIpleozvM2fgUsYfbVzf9lNEAoyK3LSOPysPp2WJqgI3q94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795652; c=relaxed/simple;
	bh=wrT0/PVw1RCAufMyi3hB7XHBapGeT8dsQ2+k7DkFsLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBsQlTI9b4ajryalF1eMRy6nJChKj97D+UqI3m8V9WCKEjIgUWyvjPl2yJ4sgQYZDg2lAANYZKkR2ErmDYHQsmy4FQ6ZEsag5fTimFQtaCE5huOo0fisQnGjFFCUoYImH5Fa6s/au8yIRihBXEW2VNnPQtTXtALC70Sl0pWA+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCWp+p7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B563EC4CED6;
	Sat,  1 Mar 2025 02:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740795651;
	bh=wrT0/PVw1RCAufMyi3hB7XHBapGeT8dsQ2+k7DkFsLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lCWp+p7jm+5O/IKdY1grBUS9ZC9DB0ba/CqRyLpa76Ug4mjY/kS+tc9NsMhOr5ciX
	 WTpLn4PYXCiEYG/u+m66GszCnWqXAjfCo8XhZqhEdqm2LrEwiu0wcmGLeK4gE7CxQ0
	 gk+49rIx59510uDm4MO2AH6jM0uZYMFU2wgKqi2S7ObvfvRWXklVF/Tk4jlCTm+KeQ
	 yoX2iU0SabKwJ7hm1/R3OV6CJEt1zkPiW+2T9Vyv7Vprvuv+LdA/2j8X3w0gVqxaDa
	 3BpwMmngcTeJl06nAqhMPrXjT5YKN8i3tvKq35NAK4qQtBYvcWtSqccvB5oooxyfZl
	 /l5EdpJ+SnvgA==
Date: Sat, 1 Mar 2025 04:20:46 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
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
Message-ID: <Z8Ju_j8XSIsAu0XA@kernel.org>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com>
 <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com>
 <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>

On Thu, Feb 27, 2025 at 05:22:22PM -0500, Paul Moore wrote:
> On Thu, Feb 27, 2025 at 3:41 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Mon, 2025-01-06 at 17:15 +0000, Eric Snowberg wrote:
> > > > On Jan 5, 2025, at 8:40 PM, Paul Moore <paul@paul-moore.com> wrote:
> > > > On Fri, Jan 3, 2025 at 11:48 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > >
> > > > > Regardless, back to Clavis ... reading quickly through the cover
> > > > > letter again, I do somewhat wonder if this isn't better integrated
> > > > > into the keyring proper; have you talked to both David and Jarkko
> > > > > about this?
> > > >
> > > > I realize I should probably expand on my thinking a bit, especially
> > > > since my comment a while regarding LSMs dedicated to enforcing access
> > > > control on keys is what was given as a reason for making Clavis a LSM.
> > > >
> > > > I still stand by my comment from over a year ago that I see no reason
> > > > why we couldn't support a LSM that enforces access controls on
> > > > keyrings/keys.  What gives me pause with the Clavis LSM is that so
> > > > much of Clavis is resident in the keyrings themselves, e.g. Clavis
> > > > policy ACLs and authorization keys, that it really feels like it
> > > > should be part of the keys subsystem and not a LSM.  Yes, existing
> > > > LSMs do have LSM specific data that resides outside of the LSM and in
> > > > an object's subsystem, but that is usually limited to security
> > > > identifiers and similar things, not the LSM's security policy.
> >
> > Hi Jarkko, David,
> >
> > Both Paul's and my main concerns with this patch set is storing policy in the
> > keyring.  We would appreciate your chiming in here about storing key policy in
> > the keyring itself.
> 
> I'd still also like to see some discussion about moving towards the
> addition of keyrings oriented towards usage instead of limiting
> ourselves to keyrings that are oriented on the source of the keys.
> Perhaps I'm missing some important detail which makes this
> impractical, but it seems like an obvious improvement to me and would
> go a long way towards solving some of the problems that we typically
> see with kernel keys.

I get the theoretical concern but cannot see anything obvious in the
patch set that would nail into practical concerns. 

> 
> -- 
> paul-moore.com

BR, Jarkko

