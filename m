Return-Path: <linux-efi+bounces-653-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30196860DF3
	for <lists+linux-efi@lfdr.de>; Fri, 23 Feb 2024 10:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E111F21F4C
	for <lists+linux-efi@lfdr.de>; Fri, 23 Feb 2024 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD1C5C8E2;
	Fri, 23 Feb 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spY12Uxa"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928891642A;
	Fri, 23 Feb 2024 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680516; cv=none; b=bCJdLi17h5s6M7SMgUGlLKUwZhQiQiVC7TrGR3Wi4suhqzvNswrsnjf6OsGsvCAn2AvbW5O8zV5tMXCmpV3B35ttJSaDbNeYKWa/7Cd1cbT1/jhFEzvPcM3gh7ni5nJo2AZDi/PPLSzg8g0y/O1ExNISY/Lppyfm2jRCbBQ4zMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680516; c=relaxed/simple;
	bh=nBidOp/Sc51deSYITKjnb2FvBakVjMShqvr/vQHBD0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnLIMRMWwpkR+dD1u4txp4TGLCkhXAYwOhqtU3KcsL9QDY+hr8CzlexKVzTM4g6x684nxLwGRlcpCBEWVZ90ytVTbTufEqV0kFOzF4qh5Bq88tB2YCkNALtnQzYyW2fYVMntpf4SQ3dVlAm5dWE19MeTMRygVd2atSiu5/3rpPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spY12Uxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1A4C43394;
	Fri, 23 Feb 2024 09:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708680516;
	bh=nBidOp/Sc51deSYITKjnb2FvBakVjMShqvr/vQHBD0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=spY12Uxa31bVEpe562lmosV6WOxu7PVy93WPK+1XVPtSSUhtvx6GHOT1QJW1mAg/A
	 S8/GpdJNiEIiBNUGi6RUvoO22wCcHsBatXyztAN5YmLLv29MnjRUU8l4IKHBBFL87B
	 cqhxVQQZai0anlQ0TJmRADDUMEkOe41c6LAgALzU9mNanDHr0NpiI6+r5pYcY+zNax
	 yW4W5+dfm5srena21i4hTzvQpUS70Z5Vyy7bMJffv5KAhxb91LwkdyilX9p+ljpMko
	 V1t2eMChMgWsRiFWvDBYapIJoffKzivPh1B4BihrJVQ09g0/MgpHd0bp31Lj2yyfWF
	 YVH6u0vvzPSgg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so127820a12.1;
        Fri, 23 Feb 2024 01:28:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4NkZEpXSSuwMAAE4ArFeil6m7+2Nefi+JV9TD0JA6ZOFslNtXg9Zm73JCSB79199eblaGKZ2LN10y3eeqyxnoAQ50c4Fkl6LICgtpUxa9JQxsS4rDpNQGRLrw9dzIhJ1AiMQEpe439b70+JA/83zMBXBjvijPgqfNw+72IgHQW9gDuPSR6AtWZNJdFK5Ln1r52FM9YKxhMDirbqeBlLiNQaPWoJtuh+KzOQF8O8UFE3172v1n9kf0W147/OV+QshH
X-Gm-Message-State: AOJu0Yy2QrG5rJhaXbxUgPJ3dTmYAHysJhY3gaAo10a1Z4fIHFL3XZ9Y
	vOhH33FJJvOA+mrMh8dE2MXPJMOMeX7eRrg9B2ZeYpuGCPg4zM2Z7bEGZLxRBf49cItIz4h0/Ex
	5/rfhh0DYm0GdFkxYAn2ahY03GY0=
X-Google-Smtp-Source: AGHT+IEjrwBVKcv0S/1aJGS8Hf82d54S6yBBKB5Z13OVmnd4l6/l61nsjWbV93Sh/os1iRuVkffQtuNmyTWtlEJ5C5I=
X-Received: by 2002:a05:651c:221a:b0:2d2:4017:d79f with SMTP id
 y26-20020a05651c221a00b002d24017d79fmr1050276ljq.37.1708680502830; Fri, 23
 Feb 2024 01:28:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-7-ross.philipson@oracle.com> <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
 <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com> <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
 <1a8e69a7-89eb-4d36-94d6-0da662d8b72f@citrix.com>
In-Reply-To: <1a8e69a7-89eb-4d36-94d6-0da662d8b72f@citrix.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 23 Feb 2024 10:27:58 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEvmGy9RJo4s8tECsFj2dufZ8jBPoJOEtkcGUoj+x2qsw@mail.gmail.com>
Message-ID: <CAMj1kXEvmGy9RJo4s8tECsFj2dufZ8jBPoJOEtkcGUoj+x2qsw@mail.gmail.com>
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com, Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 13:30, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 22/02/2024 9:34 am, Ard Biesheuvel wrote:
> > On Thu, 22 Feb 2024 at 04:05, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> >> On 15/02/2024 8:17 am, Ard Biesheuvel wrote:
> >>> On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
> >>>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> >>>>
> >>>> The SHA algorithms are necessary to measure configuration information into
> >>>> the TPM as early as possible before using the values. This implementation
> >>>> uses the established approach of #including the SHA libraries directly in
> >>>> the code since the compressed kernel is not uncompressed at this point.
> >>>>
> >>>> The SHA code here has its origins in the code from the main kernel:
> >>>>
> >>>> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> >>>>
> >>>> A modified version of this code was introduced to the lib/crypto/sha1.c
> >>>> to bring it in line with the sha256 code and allow it to be pulled into the
> >>>> setup kernel in the same manner as sha256 is.
> >>>>
> >>>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> >>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >>> We have had some discussions about this, and you really need to
> >>> capture the justification in the commit log for introducing new code
> >>> that implements an obsolete and broken hashing algorithm.
> >>>
> >>> SHA-1 is broken and should no longer be used for anything. Introducing
> >>> new support for a highly complex boot security feature, and then
> >>> relying on SHA-1 in the implementation makes this whole effort seem
> >>> almost futile, *unless* you provide some rock solid reasons here why
> >>> this is still safe.
> >>>
> >>> If the upshot would be that some people are stuck with SHA-1 so they
> >>> won't be able to use this feature, then I'm not convinced we should
> >>> obsess over that.
> >> To be absolutely crystal clear here.
> >>
> >> The choice of hash algorithm(s) are determined by the OEM and the
> >> platform, not by Linux.
> >>
> >> Failing to (at least) cap a PCR in a bank which the OEM/platform left
> >> active is a security vulnerability.  It permits the unsealing of secrets
> >> if an attacker can replay a good set of measurements into an unused bank.
> >>
> >> The only way to get rid of the requirement for SHA-1 here is to lobby
> >> the IHVs/OEMs, or perhaps the TCG, to produce/spec a platform where the
> >> SHA-1 banks can be disabled.  There are no known such platforms in the
> >> market today, to the best of our knowledge.
> >>
> > OK, so mainline Linux does not support secure launch at all today. At
> > this point, we need to decide whether or not tomorrow's mainline Linux
> > will support secure launch with SHA1 or without, right?
>
> I'd argue that's a slightly unfair characterisation.
>

Fair enough. I'm genuinely trying to have a precise understanding of
this, not trying to be dismissive.

> We want tomorrow's mainline to support Secure Launch.  What that entails
> under the hood is largely outside of the control of the end user.
>

So the debate is really whether it makes sense at all to support
Secure Launch on systems that are stuck on an obsolete and broken hash
algorithm. This is not hyperbole: SHA-1 is broken today and once these
changes hit production 1-2 years down the line, the situation will
only have deteriorated. And another 2-3 years later, we will be the
ones chasing obscure bugs on systems that were already obsolete when
this support was added.

So what is the value proposition here? An end user today, who is
mindful enough of security to actively invest the effort to migrate
their system from ordinary measured boot to secure launch, is really
going to do so on a system that only implements SHA-1 support?

> > And the point you are making here is that we need SHA-1 not only to a)
> > support systems that are on TPM 1.2 and support nothing else, but also
> > to b) ensure that crypto agile TPM 2.0 with both SHA-1 and SHA-256
> > enabled can be supported in a safe manner, which would involve
> > measuring some terminating event into the SHA-1 PCRs to ensure they
> > are not left in a dangling state that might allow an adversary to
> > trick the TPM into unsealing a secret that it shouldn't.
>
> Yes.  Also c) because if the end user wants to use SHA-1, they should be
> able to.
>

The end user can do whatever they want, of course. Whether it belongs
in the upstream is an entirely different matter, though, especially
because we will effectively be forced to support this forever.


> > So can we support b) without a), and if so, does measuring an
> > arbitrary dummy event into a PCR that is only meant to keep sealed
> > forever really require a SHA-1 implementation, or could we just use an
> > arbitrary (not even random) sequence of 160 bits and use that instead?
>
> a) and b) are in principle independent, but we cannot support b) without
> SHA-1.
>
> To cap a PCR, the event log still needs to be kept accurate, and that's
> at least one SHA-1 calculation.  If you were to simply extend a dummy
> value, the system hopefully fails safe, but the user gets "something
> went wrong, you're on your own", rather than "we intentionally blocked
> the use of SHA-1, everything is good".
>
> And frankly, you need SHA-1 just to read the event log, if any component
> (including TXT itself) wrote a SHA-1 entry into it.
>
>
> To be blunt.  SHA-1 support is not viably optional today as far as
> Secure Launch is concerned.  If there's a suitable Kconfig symbol to use
> for people who want a completely SHA-1-less kernel, then we can make
> Secure Launch depend on that until such time as the hardware ecosystem
> has caught up.
>

Yes, this crossed my mind as well. There is a Kconfig symbol
CRYPTO_USER_API_ENABLE_OBSOLETE I added a while ago for a similar
purpose.

I am still disappointed that we have to go down this path, but I
understand the concerns now that you have explained them to me (again)
in more detail.

These considerations need to be recorded in the documentation or
commit logs as well, so that we can easily refer back to them without
having to dig through the mail archives.

