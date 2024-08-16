Return-Path: <linux-efi+bounces-1546-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C0C9547F5
	for <lists+linux-efi@lfdr.de>; Fri, 16 Aug 2024 13:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0EE1C229F6
	for <lists+linux-efi@lfdr.de>; Fri, 16 Aug 2024 11:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67BC1917F1;
	Fri, 16 Aug 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jveqprc1"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61313C9A7;
	Fri, 16 Aug 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723807328; cv=none; b=E/Swq4SwjhCOE26Gvi+tDc4yOjzxENeJzQicavF+qKGTjKpdFA/AA36ynomqXrOiTi96dWxfFBAMytc60v4RufBfSpZ/Oe5ezIz/pAndQKCyFM/Qzcu98ofh90GbrSiCGyGdpO3BkjgM1B2ebX+ubvC9VZMVXD0Fo/5bnUUVeIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723807328; c=relaxed/simple;
	bh=gV2PqQerkGgy/+HK5ajdWorgprSPCXQyQAoB8oo88rk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rtTYSyJVnnb34eh04BYe0VnNJIn9GbuUZHTB+2ebUuB/zib896abeynYXNnfxwyHyJdxEg4xDPi8S/8nVKIvHD59a+FW1HIf+qk7s9xVY3yEoDsBZ6QdWar9E9jm9AXfnNi+Ez5CGKKIeLy3Atq+3lZF6196MJldnzmO4V7df08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jveqprc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB10DC32782;
	Fri, 16 Aug 2024 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723807328;
	bh=gV2PqQerkGgy/+HK5ajdWorgprSPCXQyQAoB8oo88rk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Jveqprc1i1LHYV6qtBL08bsdgzXefjlh1drYspRjo3Pc7kIhjw730W/Iilznig37j
	 sq74l0Xoy31GXwIYvl7EKsDZAUsuczbJnDgPgKwDIhvExKHkFhvimJz5DX8cVHjHOn
	 u8WZojYei71O8DMGl0XY1Rx8fcPCZkZxSnURmusIwH2MP4BxFZrJuvT3wwmoIcnwE0
	 5HLzLypWYmiiTzxn02IS63nfb2IJCzOx/tyCeqBQFHcwTgUCt2N62+tqZKdTn/4t/q
	 XA0ADrVDyHSsZuS8Mskt+KlNGNbfliJV3QAz3l/mfwjyjpULNA6rRhMtBak9LNwx/1
	 DTzeAYYEHOMoQ==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Aug 2024 14:22:04 +0300
Message-Id: <D3HAP4O4OVS3.2LOSH5HMQ34OZ@kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Andrew Cooper" <andrew.cooper3@citrix.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, "Eric Biggers"
 <ebiggers@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <550d15cd-5c48-4c20-92c2-f09a7e30adc9@citrix.com>
In-Reply-To: <550d15cd-5c48-4c20-92c2-f09a7e30adc9@citrix.com>

On Fri Aug 16, 2024 at 2:01 PM EEST, Andrew Cooper wrote:
> On 15/08/2024 8:10 pm, Thomas Gleixner wrote:
> > On Thu, Aug 15 2024 at 13:38, Daniel P. Smith wrote:
> >> On 5/31/24 09:54, Eric W. Biederman wrote:
> >>> Eric Biggers <ebiggers@kernel.org> writes:
> >>>> That paragraph is also phrased as a hypothetical, "Even if we'd pref=
er to use
> >>>> SHA-256-only".  That implies that you do not, in fact, prefer SHA-25=
6 only.  Is
> >>>> that the case?  Sure, maybe there are situations where you *have* to=
 use SHA-1,
> >>>> but why would you not at least *prefer* SHA-256?
> >>> Yes.  Please prefer to use SHA-256.
> >>>
> >>> Have you considered implementing I think it is SHA1-DC (as git has) t=
hat
> >>> is compatible with SHA1 but blocks the known class of attacks where
> >>> sha1 is actively broken at this point?
> >> We are using the kernel's implementation, addressing what the kernel=
=20
> >> provides is beyond our efforts. Perhaps someone who is interested in=
=20
> >> improving the kernel's SHA1 could submit a patch implementing/replacin=
g=20
> >> it with SHA1-DC, as I am sure the maintainers would welcome the help.
> > Well, someone who is interested to get his "secure" code merged should
> > have a vested interested to have a non-broken SHA1 implementation if
> > there is a sensible requirement to use SHA1 in that new "secure" code,
> > no?
>
> No.
>
> The use of SHA-1 is necessary even on modern systems to avoid a
> vulnerability.
>
> It is the platform, not Linux, which decides which TPM PCR banks are acti=
ve.
>
> Linux *must* have an algorithm for every active bank (which is the
> platform's choice), even if the single thing it intends to do is cap the
> bank and use better ones.

For (any) non-legacy features we can choose, which choices we choose to
support, and which we do not. This is not an oppositive view just saying
how it is, and platforms set of choices is not a selling argument.

>
> Capping a bank requires updating the TPM Log without corrupting it,
> which requires a hash calculation of the correct type for the bank.
>
> ~Andrew

BR, Jarkko

