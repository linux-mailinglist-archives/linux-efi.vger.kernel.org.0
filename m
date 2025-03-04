Return-Path: <linux-efi+bounces-2885-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F66A4F040
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 23:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5753E7A5A10
	for <lists+linux-efi@lfdr.de>; Tue,  4 Mar 2025 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7048A278103;
	Tue,  4 Mar 2025 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0WFhpkn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352191F03D7;
	Tue,  4 Mar 2025 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741127103; cv=none; b=rc4zDm9ryxccmXJvsIrLT5cS/X4le5aCFlqGQKaD/L8ZlgZsxVSPhQPSu2hy8ACWv7EQGjQktIzmlVYExQmC/qGBe6yaP/V/DkHnWfzKNDcgJwzc+0XFBEvQNztWC4qM+nbwHaKzdadNn3nmuaOo9FwHzzrN7KaKpa2lJbo501U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741127103; c=relaxed/simple;
	bh=0+/9utZ9Ftp9xnO55BpJlM6f0mOe8fIs9GJvBVmZITk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AegxbHOszA5k06k723MxcsNidFbLSkTcyPKLdhvxbvqQDk2GctRl0nyrtp+WX0MJt84GHJEWMlyrJWqBOVKqJ0Sh96PNz+2L+LdU2C0Aka69zAWvc/isqI7LVl/Ia1rGJUksHKDxLT9zjsKOKxRsdnl7NMwtbV8kjJcnJnyWeoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0WFhpkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2EFC4CEE5;
	Tue,  4 Mar 2025 22:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741127102;
	bh=0+/9utZ9Ftp9xnO55BpJlM6f0mOe8fIs9GJvBVmZITk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0WFhpknFwe00UPXpOJYc/hs7CmG0pQXTXXpLKYxAe3NhDpNbWU9mKpO6aKD/vmIr
	 KbBPUSgUayaNkK5jIEfWx22v4wwNfz1yhPY422ZfN+WfJHGyc5Z/uy0DCwOyLTzQIj
	 +pfeK8SVY0SDSYCNXDxyga2WqrNyWsmCI0Q2PVGOO+9C424j1HSRoSw1qeTPCgxpne
	 xI85EmF39tWrVpqTepxyQGCzlar3aS2yiqC/tqu6Abuq923ZoOsuz+SKiHznVDd5ej
	 BW/aRZ4wO6sFWsTr+5vOkuoquA6rlzYX22yV/eDzXNNMrQZNySVlqUvgKMBheyCZSy
	 m731TrXzhW6sw==
Date: Wed, 5 Mar 2025 00:24:58 +0200
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
Message-ID: <Z8d9ulOirAeHmFJV@kernel.org>
References: <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com>
 <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com>
 <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
 <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com>
 <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>

On Mon, Mar 03, 2025 at 05:40:54PM -0500, Paul Moore wrote:
> On Fri, Feb 28, 2025 at 12:52 PM Eric Snowberg <eric.snowberg@oracle.com> wrote:
> > > On Feb 28, 2025, at 9:14 AM, Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Feb 28, 2025 at 9:09 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >> On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
> > >>>
> > >>> I'd still also like to see some discussion about moving towards the
> > >>> addition of keyrings oriented towards usage instead of limiting
> > >>> ourselves to keyrings that are oriented on the source of the keys.
> > >>> Perhaps I'm missing some important detail which makes this
> > >>> impractical, but it seems like an obvious improvement to me and would
> > >>> go a long way towards solving some of the problems that we typically
> > >>> see with kernel keys.
> >
> > The intent is not to limit ourselves to the source of the key.  The main
> > point of Clavis is to allow the end-user to determine what kernel keys
> > they want to trust and for what purpose, irrespective of the originating
> > source (.builtin_trusted, .secondary, .machine, or .platform). If we could
> > go back in time, individual keyrings could be created that are oriented
> > toward usage.   The idea for introducing Clavis is to bridge what we
> > have today with kernel keys and allow them to be usage based.
> 
> While it is unlikely that the current well known keyrings could be
> removed, I see no reason why new usage oriented keyrings could not be
> introduced.  We've seen far more significant shifts in the kernel over
> the years.

Could we implement such change in a way that these new imaginary
(at this point) usage oriented keyrings would be used to create
the "legacy" keyrings?

> 
> -- 
> paul-moore.com
> 

BR, Jarkko

