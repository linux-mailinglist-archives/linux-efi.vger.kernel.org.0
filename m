Return-Path: <linux-efi+bounces-2088-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2499B8D4C
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 09:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE661F2301F
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 08:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4436D15687D;
	Fri,  1 Nov 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjR7OsFr"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0311F25757;
	Fri,  1 Nov 2024 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730451058; cv=none; b=tFDl+fHpLrqJj79ESeE7NY1dneiuxqNxtSRpRD8HL9u5ToimXLb7LvtlwhW3mAIEFgxqpMHOgQD8FvKJoZvmMDtPTw46E0bglK3l+FAaz6nH+nl/8jCxOZUwYZUUd2AZOCWjjbPlmFjHu6biJeOee5MHMCTHZuN5z0skhtMB0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730451058; c=relaxed/simple;
	bh=7Gv2CqzecQ8F4MJ4RrKkxM6klDrmuRMoDH8RdhY0ReU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkkMhn156Bi08QfVXvRZcu9FvKBe7cqIs0Vgt2ownosrQ4aCfdvbUONIJPNDp801Noz6C5XMs7edbSyIAwdV/azjsrJYVvJBZRj7jXtV+QscHvs/pgLWpiZIgtrB6cDZe47V9k4d17yCHOuv2HDv82Ky4KQ3X9fhZe+3sIg23vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjR7OsFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B174C4CED2;
	Fri,  1 Nov 2024 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730451057;
	bh=7Gv2CqzecQ8F4MJ4RrKkxM6klDrmuRMoDH8RdhY0ReU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qjR7OsFrdihA7dg0hpyjg9HMDJP61+hracN3Kea7Nu7/Azg1y4PBcP7U99Qkm9Vxk
	 Nn9ff/BEvmY8/t1ltJa0JUCnGcKqGs6hzn/SL10Rr5r4fWRDtAeJ9LXr5sGxyFRx2z
	 F1eIx16Rv+t4TGgSDM0/BtOY2XKAGOhVeoQfojY7DDcw9Hmxvvm7qUULsP1OuZsWPh
	 uShABLy+TSjvZDS+W6NjrA5RiEB2zLVbx89FubLEZdHrOMny0E5nvaJitx/BXfmTyz
	 GfIptvJ+7IXDsC7Oj9MCy6293wyoTHDKT+4Nc+naDTzxTZznrlXvbCTYWjcOJcQaDl
	 w/KVGbLEQtrNw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so18915221fa.3;
        Fri, 01 Nov 2024 01:50:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUu+ShiaB5ud1wTw/PiWICMEIZpDXH88Rd9jw0V35gehOMo/ZeY9eiUWs3C9EwJY1HxDt3GprF3MQAEvGTSpVVp@vger.kernel.org, AJvYcCVCS7wzBfUTGEiyTLArNiaVoanVqsUypYBSif4HKeLreRqYsOxBDY5XK0FdGDm9ydOTgmuIu2GAnk0TcdY=@vger.kernel.org, AJvYcCVH3Yi7A/nqGvVmbOjTz2KQ9ANEGwCI1nuUedZGSnIslzqDjJSyNqqzT2/3Xgut3kFrz15wSEn8/uhW@vger.kernel.org, AJvYcCXSjC+vwVwQoiypF+zN0lP40uweMsbRmb9JzuRfpGAJyYJKXIXMSahp8NSQiNr2IYg9zBo9iJPU1DjFbhEU@vger.kernel.org, AJvYcCXVDtdplsWeeT8artZWPUqf9G/T7UTd4GSMhM1v9CrespleFHK8nMI5b0XbJ5zmDivWbuZNmM9/ZG/K@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+vdgG12DalX3Uog9Z/eJgLa/fXO39JH8Ggk/LIWqrTnkcAUhe
	pVhFE8wPc7FG3Tfnclzqm9qLexP7w8Y+O75bZod43Ff1u7jCvss3RZ/1ug6xkMAlH0PVLnGBmBO
	z6x1yQDwJfvkhP1L6JSKhsfAKO7g=
X-Google-Smtp-Source: AGHT+IGq5KFbAI9S4x36ffXOC0opBJXf4wJXpPrXgnubpE+Mpoy/r4fbPNLJGcyf/oa8AjMSFwlnLkaspaUTNz8mWrE=
X-Received: by 2002:a05:651c:211b:b0:2fb:6110:c5cb with SMTP id
 38308e7fff4ca-2fedb7d9117mr14787541fa.34.1730451055747; Fri, 01 Nov 2024
 01:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <87wmhoulb9.ffs@tglx> <D5ACNMVX5LXB.1L0S9P2J3UDJH@kernel.org>
 <87ldy3vpjh.ffs@tglx> <D5AF4HY1I6AA.27WRBDDGLYH39@kernel.org> <D5AF9K79H8WO.PVW93P31GHMH@kernel.org>
In-Reply-To: <D5AF9K79H8WO.PVW93P31GHMH@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 1 Nov 2024 09:50:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHFDMKEH46MG3731FS043XyxHchoTJtDOst6kvfMezUuQ@mail.gmail.com>
Message-ID: <CAMj1kXHFDMKEH46MG3731FS043XyxHchoTJtDOst6kvfMezUuQ@mail.gmail.com>
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
	iommu@lists.linux-foundation.org, dpsmith@apertussolutions.com, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 01:40, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Fri Nov 1, 2024 at 2:33 AM EET, Jarkko Sakkinen wrote:
> > On Fri Nov 1, 2024 at 1:08 AM EET, Thomas Gleixner wrote:
> > > On Fri, Nov 01 2024 at 00:37, Jarkko Sakkinen wrote:
> > > > On Thu Oct 31, 2024 at 9:25 PM EET, Thomas Gleixner wrote:
> > > >> So this looks pretty reasonable to me by now and I'm inclined to take it
> > > >> through the tip x86 tree, but that needs reviewed/acked-by's from the
> > > >> crypto and TPM folks. EFI has been reviewed already.
> > > >>
> > > >> Can we make progress on this please?
> > > >
> > > > So TPM patches do have bunch of glitches:
> > > >
> > > > - 15/20: I don't get this. There is nothing to report unless tree
> > > >   is falling. The reported-by tag literally meaningless. Maybe this
> > > >   is something that makes sense with this feature. Explain from that
> > > >   angle.
> > > > - 16/20: Is this actually a bug fix? If it is should be before 15/20.
> > > > - 17/20: the commit message could do a better job explaining how the
> > > >   locality can vary. I'm not sure how this will be used by rest of
> > > >   the patch set.
> > > > - 18/20: I'm not confident we want to give privilege to set locality
> > > >   to the user space. The commit message neither makes a case of this.
> > > >   Has this been tested to together with bus encryption (just checking)?
> > >
> > > Can you please explicitely voice your detailed technical concerns in
> > > replies to the actual patches?
> >
> > - 15/20 looks like a rigged patch. I don't really know why it is done
> >   so it is hard to either suggest how "resolve it".
> > - 16/20 probably makes sense but if it is a bug fix or part of it is,
> >   the bug fix should have relevant fixes etc tags so that it can be
> >   picked up to stable kernels.
> > - 17-18/20: I'd speak about this as the "one whole" i.e. here the
> >   privilege to be able change locality during run-time is really
> >   concerning. Could the locality be figured out for the kernel
> >   command-line instead? The sysfs attribute can exist as read-only.
> >
> > So yeah, the way I see it 15-16 are the more trivial issue to sort
> > out (probably) but with 17-18 we have an actual architectural concern
> > for kernel overall.
>
> Further:
>
> 15/20: I can accept this without reported-by tag (or changed as
> suggested-by). It does not harm.
> 16/20: I'll re-review this with time. I'll try to get this done
> latest next week.
>
> So let's put focus only on 17 and 18. Can this problem be sorted out
> by kernel command-line parameter? In the case of locality we want to
> keep regular "chain of trust" i.e. boot-loader makes the decision,
> *even* in the case of DRTM. I would call this almost as constraint
> that would be wise to set.
>

Please don't add a kernel command line parameter for this - the code
running in the decompressor will be the one setting it and there are
better ways to pass information between these components (and the
slaunch stack is already doing that in any case)

Also, let's have this discussion in the appropriate place, i.e., on
the thread for each respective patch.

