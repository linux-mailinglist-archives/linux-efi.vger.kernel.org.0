Return-Path: <linux-efi+bounces-643-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4326E85F475
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 10:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6747A1C229C6
	for <lists+linux-efi@lfdr.de>; Thu, 22 Feb 2024 09:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0375C39AE1;
	Thu, 22 Feb 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jcncjh+y"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1DF381B8;
	Thu, 22 Feb 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594477; cv=none; b=JIJOSI6gqesvyLcLjtXUdf5Jv/V6W7py8gT8WMeX/fX0HDxlC5QdLJFQunvvsC+XWoh+hRX34Fw53i7g4yUo03C/6gSXrHskyYaPS1RNLCnXwUGc9yH0bzZLEagQWWaElWH/FXZK0sbGGmSPyqEsIvQ5p31S6a+j8sBajtNrDuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594477; c=relaxed/simple;
	bh=twL/O1XH0IQ5h96lKQERqeU1tJQqEQZBVZgUwRHwFlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rgl7GoSuYLRHYuqMBR7WgcaBEuK0sdzC/p0irirQ1u5TTKkS6YLQEeGbyG64vo1EMKGJcRYpxF9WyXeq0fQ8OPsftYzCZyMh10zjBDyzg8T245/lSa5hNVj4uYRFxNQoJjBPlumiJkLKl+eoJmAwza91NItDZ2Iyxj8Z1NVLsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jcncjh+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EEBC43141;
	Thu, 22 Feb 2024 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708594477;
	bh=twL/O1XH0IQ5h96lKQERqeU1tJQqEQZBVZgUwRHwFlE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jcncjh+y1tVYMLld1ZQCZGfPYyIJx2iPpfQCPBbIimujG7o+Rsyys/8gzP/O+f8fV
	 XOw/s6eUtIWCcllKyiMXgacGO5soYfbkHQ0+NEEZ1gf3hemDhVJMrG2sP09NaH4g7F
	 zIT9AVu3pe4nydblV2OzqtI7v3ecEuxyolBXXh7dv59kcBCbNk743kWTeJpm7gbrhf
	 aSNV0DhaTVcL7JmzUO3hEtIFNjBvGVXrv1o51RaGkEDegP1D8rP4jybV2Zb51efNJ/
	 AfOCtZWZEd7T9tbA94bHp6B457qYv3iIAGeOTxTd+X6rzol00H4VwsfSOeaQmwWuO/
	 U/sJm+TlQIz0g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512bb2ed1f7so5312002e87.3;
        Thu, 22 Feb 2024 01:34:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQ22YKiAVOxtggukaswkT77pnt1EJZZz6x97G8M6UBZ6FHZnRuhmSQncU1xpSkcit4Vt3XhL++5WQl+hbknI+MhTEiGBGDOtcZB3l5Nu98qIQvPOwcDlss4xDoChdKRhnb/iLfAfaj2lJUI0COSfhPGvvBsl5DdmY+c56gBUQ2aXqcE77TmpxenpgYMnRtzCZ+mnrsZxFDrVvOVhhGqL+E+WjU0o+hm5eHzqSW3Dlc146WpEtR1QVspCS/4m8ehKP0
X-Gm-Message-State: AOJu0YyE6cNzBIH8VHs9iqbW9H9uBBn/HEuHwXYL5mTt92wH8EqW+pPz
	4d0yWFTwt0qX09rLGuIW5abbynHmYobuY9+osvDu0Pl/tUqXgyf1T1H1NIKq2KRKQZQo7QxJAe/
	VLFrB+awZsnz0TD0GuMwr1A48/80=
X-Google-Smtp-Source: AGHT+IFgnHge1ffZxf+MbWd8mZJewYby/ooDbKKmh7V38xeDaM5XPDlRS942sAJqjVoJxG0ZgpzQmoetZB69KZLL9/Y=
X-Received: by 2002:a05:6512:b0f:b0:512:d5ca:eb2f with SMTP id
 w15-20020a0565120b0f00b00512d5caeb2fmr3086686lfu.52.1708594475263; Thu, 22
 Feb 2024 01:34:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-7-ross.philipson@oracle.com> <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
 <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
In-Reply-To: <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 22 Feb 2024 10:34:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
Message-ID: <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
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

On Thu, 22 Feb 2024 at 04:05, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 15/02/2024 8:17 am, Ard Biesheuvel wrote:
> > On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
> >> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> >>
> >> The SHA algorithms are necessary to measure configuration information into
> >> the TPM as early as possible before using the values. This implementation
> >> uses the established approach of #including the SHA libraries directly in
> >> the code since the compressed kernel is not uncompressed at this point.
> >>
> >> The SHA code here has its origins in the code from the main kernel:
> >>
> >> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
> >>
> >> A modified version of this code was introduced to the lib/crypto/sha1.c
> >> to bring it in line with the sha256 code and allow it to be pulled into the
> >> setup kernel in the same manner as sha256 is.
> >>
> >> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> >> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> > We have had some discussions about this, and you really need to
> > capture the justification in the commit log for introducing new code
> > that implements an obsolete and broken hashing algorithm.
> >
> > SHA-1 is broken and should no longer be used for anything. Introducing
> > new support for a highly complex boot security feature, and then
> > relying on SHA-1 in the implementation makes this whole effort seem
> > almost futile, *unless* you provide some rock solid reasons here why
> > this is still safe.
> >
> > If the upshot would be that some people are stuck with SHA-1 so they
> > won't be able to use this feature, then I'm not convinced we should
> > obsess over that.
>
> To be absolutely crystal clear here.
>
> The choice of hash algorithm(s) are determined by the OEM and the
> platform, not by Linux.
>
> Failing to (at least) cap a PCR in a bank which the OEM/platform left
> active is a security vulnerability.  It permits the unsealing of secrets
> if an attacker can replay a good set of measurements into an unused bank.
>
> The only way to get rid of the requirement for SHA-1 here is to lobby
> the IHVs/OEMs, or perhaps the TCG, to produce/spec a platform where the
> SHA-1 banks can be disabled.  There are no known such platforms in the
> market today, to the best of our knowledge.
>

OK, so mainline Linux does not support secure launch at all today. At
this point, we need to decide whether or not tomorrow's mainline Linux
will support secure launch with SHA1 or without, right?

And the point you are making here is that we need SHA-1 not only to a)
support systems that are on TPM 1.2 and support nothing else, but also
to b) ensure that crypto agile TPM 2.0 with both SHA-1 and SHA-256
enabled can be supported in a safe manner, which would involve
measuring some terminating event into the SHA-1 PCRs to ensure they
are not left in a dangling state that might allow an adversary to
trick the TPM into unsealing a secret that it shouldn't.

So can we support b) without a), and if so, does measuring an
arbitrary dummy event into a PCR that is only meant to keep sealed
forever really require a SHA-1 implementation, or could we just use an
arbitrary (not even random) sequence of 160 bits and use that instead?

