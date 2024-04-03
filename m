Return-Path: <linux-efi+bounces-919-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB294897549
	for <lists+linux-efi@lfdr.de>; Wed,  3 Apr 2024 18:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0BE1F28645
	for <lists+linux-efi@lfdr.de>; Wed,  3 Apr 2024 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A46F099;
	Wed,  3 Apr 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW0wEMDg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673B147C79;
	Wed,  3 Apr 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161947; cv=none; b=uqiCzyp7uWZFwIiRZrfcqtOkAkzhDoCG+n3w/JpzZVdSCuYnwwB3XNqAC9YmnhiZWu5b/qiC0FKT2um+mTAM4Zi1Y5YjFpJGfE2zF+LA6wLkO5Er93iZEbG7Xg9KqQh9tVa/10R+esUOQZ5boLKQ9RychDDVxjEgqw0UOQzzSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161947; c=relaxed/simple;
	bh=0XnUl7dj6Ea6m99gt6Fm1hxbMTZDNcxsfZFaaTdkK5c=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=bgsIb4RWa875sCyUeyQYSPziT6n/qlhAMpBP4NQchd8AcKuk4/9gGZzCIEs6XVfYwNChl4DJ7uM0iB96JdbZLr63vSokKfEQaiWYY0J4x/boqDd9OTBr87Im7+6MRKzhM+kK0Ya3khmMeTcHw9esdWLW4kCd6/vCqKFO5pY3JWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW0wEMDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C6DC43390;
	Wed,  3 Apr 2024 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712161947;
	bh=0XnUl7dj6Ea6m99gt6Fm1hxbMTZDNcxsfZFaaTdkK5c=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=QW0wEMDgMWUZ79xdJoYkLiIHXuRzTAb74DDl4+KTGBNms5tjbS3/Dq+NcDc/zM9pO
	 6ZMVHRwU4f/KsH8hhp8YWGgsPfB2hJNE/zW10M9fNJGwioTTI5RXj9LCK+4kHdpVm7
	 56pe0foBhqSV/IedS0ZRo0OM98CPRLAZ0exUkyl4t19cXWE+Na+N4g157rMIWwR/+a
	 Jcd3P4AfBQbMfSwsNHWa4ynpqUPezzrEo0T5J8uagcJ/oCtRjq5w5FwG4qL0dwkbtX
	 JqxgjIMslOOZNAxqEP/MmDLPJKxFjR8PAcnLi14nzPRradUx/1PaspPsqJ02egM7eE
	 u7cRF7RLttn6g==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id F06881200066;
	Wed,  3 Apr 2024 12:32:24 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Wed, 03 Apr 2024 12:32:25 -0400
X-ME-Sender: <xms:l4QNZnVTcmmcBj3cETMIjQPFeKyW216HWK1kyHvk5ak3_YuBQfomfQ>
    <xme:l4QNZvnCeko_j7aVMCevTqwRM7_fqcU20j_wDEsVTZHCnw-dG_YTuNPcHDSTz9Ieb
    ylCWq3tLYhNGdj3CNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:l4QNZjYSXaRfEAGTNz9O5uebk2fHJnste73pfQtv3vctGbwaC10s2w>
    <xmx:l4QNZiWxqHyVWKJiF4QUUEAo6lm2WIE1scUUV-YakZ7XqTXsCRovhg>
    <xmx:l4QNZhlvWkMn1SVoZn4CWHqQr0aqpqET5Ga7LXEkXKUWMws0gzMLpw>
    <xmx:l4QNZvdfRIc7OON-ak6PhAoHg4sCtKcl0fcLZQFhY7peszixkio4Ng>
    <xmx:mIQNZpOteF69teRpNuPDyBpLmH21WrVMM4syyjzPzuEhN6UyjV9zI2Zh>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0360131A0064; Wed,  3 Apr 2024 12:32:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <10db421c-77da-4a1c-a25e-2374a7a2ef79@app.fastmail.com>
In-Reply-To: <20240223183004.GE1112@sol.localdomain>
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
 <20240223183004.GE1112@sol.localdomain>
Date: Wed, 03 Apr 2024 09:32:02 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>,
 "Andrew Cooper" <andrew.cooper3@citrix.com>
Cc: "Ard Biesheuvel" <ardb@kernel.org>,
 "Ross Philipson" <ross.philipson@oracle.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "the arch/x86 maintainers" <x86@kernel.org>, linux-integrity@vger.kernel.org,
 linux-doc@vger.kernel.org,
 "Linux Crypto Mailing List" <linux-crypto@vger.kernel.org>,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org,
 dpsmith@apertussolutions.com, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Matthew Garrett" <mjg59@srcf.ucam.org>,
 James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org,
 "Jason Gunthorpe" <jgg@ziepe.ca>,
 "luto@amacapital.net" <luto@amacapital.net>,
 "Arvind Sankar" <nivedita@alum.mit.edu>,
 "Herbert Xu" <herbert@gondor.apana.org.au>, davem@davemloft.net,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch early
 measurements
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024, at 10:30 AM, Eric Biggers wrote:
> On Fri, Feb 23, 2024 at 06:20:27PM +0000, Andrew Cooper wrote:
>> On 23/02/2024 5:54 pm, Eric Biggers wrote:
>> > On Fri, Feb 23, 2024 at 04:42:11PM +0000, Andrew Cooper wrote:
>> >> Yes, and I agree.=C2=A0 We're not looking to try and force this in=
 with
>> >> underhand tactics.
>> >>
>> >> But a blind "nack to any SHA-1" is similarly damaging in the oppos=
ite
>> >> direction.
>> >>
>> > Well, reviewers have said they'd prefer that SHA-1 not be included =
and given
>> > some thoughtful reasons for that.  But also they've given suggestio=
ns on how to
>> > make the SHA-1 support more palatable, such as splitting it into a =
separate
>> > patch and giving it a proper justification.
>> >
>> > All suggestions have been ignored.
>>=20
>> The public record demonstrates otherwise.
>>=20
>> But are you saying that you'd be happy if the commit message read
>> something more like:
>>=20
>> ---8<---
>> For better or worse, Secure Launch needs SHA-1 and SHA-256.
>>=20
>> The choice of hashes used lie with the platform firmware, not with
>> software, and is often outside of the users control.
>>=20
>> Even if we'd prefer to use SHA-256-only, if firmware elected to start=
 us
>> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
>> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in or=
der
>> to safely use SHA-256 for everything else.
>> ---
>
> Please take some time to read through the comments that reviewers have=
 left on
> previous versions of the patchset.

So I went and read through the old comments, and I'm lost.  In brief sum=
mary:

If the hardware+firmware only supports SHA-1, then some reviewers would =
prefer Linux not to support DRTM.  I personally think this is a bit sill=
y, but it's not entirely unreasonable.  Maybe it should be a config opti=
on?

If the hardware+firmware does support SHA-256, then it sounds (to me, re=
ading this -- I haven't dug into the right spec pages) that, for optimal=
 security, something still needs to effectively turn SHA-1 *off* at runt=
ime by capping the event log properly.  And that requires computing a SH=
A-1 hash.  And, to be clear, (a) this is only on systems that already su=
pport SHA-256 and that we should support and (b) *not* doing so leaves u=
s potentially more vulnerable to SHA-1 attacks than doing so.  And no SH=
A-256-supporting tooling will actually be compromised by a SHA-1 comprom=
ise if we cap the event log.

So is there a way forward?  Just saying "read through the comments" seem=
s like a dead end.

Thanks,
Andy

