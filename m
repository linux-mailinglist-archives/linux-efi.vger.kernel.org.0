Return-Path: <linux-efi+bounces-1778-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6FF978D34
	for <lists+linux-efi@lfdr.de>; Sat, 14 Sep 2024 05:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0950F2869DF
	for <lists+linux-efi@lfdr.de>; Sat, 14 Sep 2024 03:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D462117BC9;
	Sat, 14 Sep 2024 03:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="vR7au40n"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832EA175A1
	for <linux-efi@vger.kernel.org>; Sat, 14 Sep 2024 03:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726286261; cv=none; b=WRkIKLPfGk+0vZrScreK7A7jwIJWGT/ze2mZAPrg3U/tMyM+ALEAFdA7NNpavwCIIwNRKQIVjzqZz/KqdLWcms+1vnyREc3GnJe2TeDW2rLq0OySduG402ooGdRztlsFE019fBq5L5f3wg4Fe4sKPsK+bLunqHjDAUXnP3htmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726286261; c=relaxed/simple;
	bh=aRgmPo7f3AmEdTXRKPcw6X/eIdDGPE6hhYHHXau80y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQ8AxnSXqTgLYGIBQmx1pAGJPqbmctEDzxRCbVFZneLhjZZuydJs4rnqBs7yhPjxWkCoUaN8ZOXkq6Zjri+XOkuUWQt1H8Uco5XZ/U1mXzoN+4HnAKhMJG+6wCQUgo3eXRy9fK3pSzDv02h+6lZH+f3Mxn1dDFtIhX0cgCoh0Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=vR7au40n; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso359034766b.1
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 20:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1726286255; x=1726891055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frVOq4/VrOFSBx4qkzHXmRGBdSpABDY2CbvRjZSeHl4=;
        b=vR7au40nmoUd/bkD7oG92swR6jeZzYrEWFeuOpib874KEJjSh8Gd7DVfXzyI4HBdBg
         bzafgWsfDS3ZzMkRVJwfSWZKx5EvsyhsNcCGZZPKynmy08389hcSYbXNvpW5vZEx3p+A
         Q+rQ/+kQQ/dRqtsCtVPbmsam00uJsXdRIDe5KwOPA3/VwNLbV1wKxIqKUL9dgJrERAXR
         M9VwXlGTgOugrKPh/BFsL0ip6wGbXni7FGxRgg6Y2Y1+zMYxdHU1EZfrmNbAxBfAmdFI
         DOCu1YHaTn4ycrXnQGWwrIphBSklLaK0mu1TixbHgLkNub9pdCqyhmqDqD4t1bKgVCEN
         uexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726286255; x=1726891055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frVOq4/VrOFSBx4qkzHXmRGBdSpABDY2CbvRjZSeHl4=;
        b=FL9iUfqahENxwDvQYZjtYVU5zxyrt24OawlVCgJRWSiBskPXICokRc89NBYM92p4ir
         xo+BmcJCCuv0seEaeG6XOfL+NlHBjOtDVRmaB54mC3/D4GeDNI98Q0n5WDFvQfVEysWN
         YJj4no6Hj3SiaNnfel87dUuYtQWw209VwqRWoj94SDlDuNvUDkd7xqEqS4q/ubSn+S8a
         RDFoZLHJ3i3Ue+qZPLCmV1kcbNtFHd3c4Op2D3edDyOygLaPhvFaxeg9dT+VrEukKHYH
         isxyYcDq/tEjxQ811XrXNJI6r2pevnOGrdRK6E59ltmwCAws/GmO/BtxF/Xffb0hCQNj
         2GcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA2d1vKxkOoo0AIHBuga99dgauNP3sgod9QmnTbq7zfXZKRbpK2TwpxBy8ey6qgGkobGWV+Ti0QLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMzoNJRLYuwwxnkUNCOG9SP4+kwB08zvWByH/ENkEuzxr2Swz
	uoZr71IOdL5rlnKDWC+Ggu6RVhb/89XS1XkescCoC2IKgfNlrkOf1JOwiv2jAP+Wmz9fZFNdkYO
	3gSQVlg41lAkMSV7Iu5g4MT5PkJ/03/ZpuOBq
X-Google-Smtp-Source: AGHT+IFF2MbJ6XCRo0MrZkYw3trl3AWEems+cbTpyeTHsgyTn4kgHQumH79FhKTJSbYKsaxyQDqJvjTVXWhQXbeHEQ0=
X-Received: by 2002:a17:907:e2a5:b0:a8a:926a:d012 with SMTP id
 a640c23a62f3a-a9029490673mr781104466b.26.1726286254571; Fri, 13 Sep 2024
 20:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com> <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org> <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com> <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
In-Reply-To: <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 13 Sep 2024 20:57:23 -0700
Message-ID: <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Eric Biggers <ebiggers@kernel.org>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
	iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com, 
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 5:34=E2=80=AFPM Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
>
> Hey again,
>
> On 9/4/24 21:01, Daniel P. Smith wrote:
> > Hi Luto.
> >
> > On 8/28/24 23:17, Andy Lutomirski wrote:
> >> On Thu, Aug 15, 2024 at 12:10=E2=80=AFPM Thomas Gleixner <tglx@linutro=
nix.de>
> >> wrote:
> >>>
> >>> On Thu, Aug 15 2024 at 13:38, Daniel P. Smith wrote:
> >>>> On 5/31/24 09:54, Eric W. Biederman wrote:
> >>>>> Eric Biggers <ebiggers@kernel.org> writes:
> >>>>>> That paragraph is also phrased as a hypothetical, "Even if we'd
> >>>>>> prefer to use
> >>>>>> SHA-256-only".  That implies that you do not, in fact, prefer
> >>>>>> SHA-256 only.  Is
> >>>>>> that the case?  Sure, maybe there are situations where you *have*
> >>>>>> to use SHA-1,
> >>>>>> but why would you not at least *prefer* SHA-256?
> >>>>>
> >>>>> Yes.  Please prefer to use SHA-256.
> >>>>>
> >>>>> Have you considered implementing I think it is SHA1-DC (as git has)
> >>>>> that
> >>>>> is compatible with SHA1 but blocks the known class of attacks where
> >>>>> sha1 is actively broken at this point?
> >>>>
> >>>> We are using the kernel's implementation, addressing what the kernel
> >>>> provides is beyond our efforts. Perhaps someone who is interested in
> >>>> improving the kernel's SHA1 could submit a patch implementing/replac=
ing
> >>>> it with SHA1-DC, as I am sure the maintainers would welcome the help=
.
> >>>
> >>> Well, someone who is interested to get his "secure" code merged shoul=
d
> >>> have a vested interested to have a non-broken SHA1 implementation if
> >>> there is a sensible requirement to use SHA1 in that new "secure" code=
,
> >>> no?
> >>>
> >>> Just for the record. The related maintainers can rightfully decide to
> >>> reject known broken "secure" code on a purely technical argument.
> >>>
> >>
> >> Wait, hold on a second.
> >>
> >> SHA1-DC isn't SHA1.  It's a different hash function that is mostly
> >> compatible with SHA1, is different on some inputs, and is maybe more
> >> secure.  But the _whole point_ of using SHA1 in the TPM code (well,
> >> this really should be the whole point for new applications) is to
> >> correctly cap the SHA1 PCRs so we can correctly _turn them off_ in the
> >> best way without breaking compatibility with everything that might
> >> read the event log.  I think that anyone suggesting using SHA1-DC for
> >> this purpose should give some actual analysis as to why they think
> >> it's an improvement, let alone even valid.
> >
> > I would say at a minimum it is to provide a means to cap the PCRs.
> > Devices with TPM1.2 are still prevalent in the wild for which members o=
f
> > the TrenchBoot community support, and there are still valid (and secure=
)
> > verification uses for SHA1 that I outlined in my previous response.
> >
> >> Ross et al, can you confirm that your code actually, at least by
> >> default and with a monstrous warning to anyone who tries to change the
> >> default, caps SHA1 PCRs if SHA256 is available?  And then can we maybe
> >> all stop hassling the people trying to develop this series about the
> >> fact that they're doing their best with the obnoxious system that the
> >> TPM designers gave them?
> >
> > Our goal is to keep control in the hands of the user, not making
> > unilateral decisions on their behalf. In the currently deployed
> > solutions it is left to the initrd (user) to cap the PCRs. After some
> > thinking, we can still ensure user control and give an option to cap th=
e
> > PCRs earlier. We hope to post a v11 later this week or early next week
> > that introduces a new policy field to the existing measurement policy
> > framework. Will add/update the kernel docs with respect to the policy
> > expansion. We are also looking the best way we might add a warning to
> > the kernel log if the SHA1 bank is used beyond capping the PCRs.
>
> As the attempt was made to lay in the policy logic, it started to become
> convoluted and unnecessarily complicated. Thus creating more risk with
> all the bookkeeping and yet sha1 hashes still have to be sent, the null
> hash in this case, since the TPM driver will reject extends that do not
> have hashes for all active banks. At this point, we have opted to keep
> the logic simple and add a section to our documentation advising of the
> potential risk should one choose to incorporate SHA1 in their
> attestations of the platform.
>

I've read the TPM standard a bit, but it's been awhile, and it's too
complicated anyway.  So, can you remind me (and probably 3/4 of the
other people on this thread, too):

What, exactly, is your patchset doing that requires hashing at all?
(I assume it's extending a PCR and generating an event log entry.).
What, exactly, does it mean to "cap" a PCR?  How is this different
from what your patchset does?

With that answered, it will hopefully be easy to see that you're
making the right call :)

--Andy

--=20
Andy Lutomirski
AMA Capital Management, LLC

