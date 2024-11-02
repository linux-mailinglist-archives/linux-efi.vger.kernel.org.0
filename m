Return-Path: <linux-efi+bounces-2114-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55909B9F13
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 11:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50C4B21A03
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 10:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD04417085C;
	Sat,  2 Nov 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK6SLEGG"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920E623CB;
	Sat,  2 Nov 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730544737; cv=none; b=B7vHvWPYcZIqzfZnESy79f+6wOUyLnq4osnxIfelK0XOxlmuHbNqy6I4O5noEWUJBU9/3sx7IW3jsD3E9LFa2zZuJ08rFcvQnJzNEGop8D5QXgF0N9lWslwI7zomBlLhbJWCl10X2V32FnynFSd4pIouW6d+80JXYnUb5A4+k7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730544737; c=relaxed/simple;
	bh=BNs0vMT9okoG3ctz2ayg1gJ18NykgP8pjbU3xi9lAVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffwLc+2JEzB2n9go+PAJUFhn4HHoCVtuNdJrNY/CwfDPX6uv69qV4IQb72jd+89/f0V/U5gabxBEyUW0kSQLQATr+6WO7QR6Xp1Ik4e8L6HXZWu4bMDI1tlszr0E05lQQQeKHauNPtQLVYGomynevqrSqRdLVUYNmf4hXpdBfTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK6SLEGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225B3C4CEDC;
	Sat,  2 Nov 2024 10:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730544737;
	bh=BNs0vMT9okoG3ctz2ayg1gJ18NykgP8pjbU3xi9lAVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dK6SLEGG9PayZ9NB+yOQuKF8a3NnL6Y0fIfORpLa9E298aTBP5OUL6VMVh4iN851Z
	 q6m1AS2LNLmZtz82eBXbkqwmHhgRVGWkl0fQfg285Eoh1GljmfPdmo6+dkui06WP43
	 e3zzoNVilyvT8Hhki3HEVDpyw1CM/LcI8+rX4XRCp61aDnYae7ysCURJH8WqEYeAUu
	 p0YmO+QMj5j+ytAF/odZNigrvZlRGsoyi8r8YmH48uOmNKHoyTRqwweJxgTGuh1c1u
	 QwDbNWV0qnLsOV+lWadWQo0T3rVCOCpdnUtokbDMJ40gsPNnBL9sS2uqCfWm5HeKI7
	 31UpiW1YXO8ZQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f7606199so462605e87.0;
        Sat, 02 Nov 2024 03:52:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIWa9us/zcLxsOFZERdaHVfCLkZFmD/4Ath7QeGwLKeqQggTpNt9wR82bxPJ5LfeK/gb8uGOjpIvdQ@vger.kernel.org, AJvYcCVsw+JccEG1faV2DFUow34k3KZYuUDKrhLlvc6pZqVq9r6DlrVWYMrQsddQKNLAbPhHp7yrxdadm5Zq7ezi@vger.kernel.org, AJvYcCWBjNcHcbOY0g16mb+ffPzQSm7SDBS4/JxbK8Opo2sjM9HVR1+/9Phq517v+NXE/plw3OVyDVGtTZjn4dw=@vger.kernel.org, AJvYcCWogYYVq4Wv/GqsGNSAg5lUOqTrc4k3TM0QXKqzjNPwchfiOuBumujDPluljp3ixqPQGOeSU8DgBF3g@vger.kernel.org, AJvYcCX4rp4Bgogqr3UzfODNg464e5IyLZ6phT6FYM7P/aODB0CkacIqo6wEFl+fc6877trDKuY8loz9eJ1s/mg71rzp@vger.kernel.org
X-Gm-Message-State: AOJu0YwFDzqlGHWT9FSZ9GUuUVgDD/wpIZODHc6xc6EFq3Mwf6gBIRG3
	dzqyZ+0XjZ0UB+XcJ1qVLvt1se43V2kX1StJiJnkW7vuIQvLzRsalXcaGVnvuK5e5nqgyyC8Av9
	DTuylpCOFZVyE0m3tvx1Xq8yamYg=
X-Google-Smtp-Source: AGHT+IGKIsyFNydotRxNbkfDFdnL87m+LkWPywtfpMYouXaEqYk6mvq/ex/9DjHC7TO0PtB9vxAygAsd35XhXmCRUnk=
X-Received: by 2002:a05:6512:1086:b0:539:8c02:64d5 with SMTP id
 2adb3069b0e04-53b7ecf213cmr7778977e87.27.1730544735380; Sat, 02 Nov 2024
 03:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org> <20241102062259.2521361-1-jarkko@kernel.org>
 <D5BHBW3NUS5C.293GUI03HMTCF@kernel.org> <CAMj1kXGk8y=rZiNiDcD-8mDKJB5HkTowM7g+kjO6616MGdTQaQ@mail.gmail.com>
 <D5BMMJYMVWKJ.3MIGB8KW34PR2@kernel.org>
In-Reply-To: <D5BMMJYMVWKJ.3MIGB8KW34PR2@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 2 Nov 2024 11:52:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXExMWBAx7geuU8Uwp9CQLpJyTgYmWUw2CtKd3xT8mMFsg@mail.gmail.com>
Message-ID: <CAMj1kXExMWBAx7geuU8Uwp9CQLpJyTgYmWUw2CtKd3xT8mMFsg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] tpm, tpm_tis: Introduce TPM_IOC_SET_LOCALITY
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James.Bottomley@hansenpartnership.com, andrew.cooper3@citrix.com, 
	baolu.lu@linux.intel.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	davem@davemloft.net, dpsmith@apertussolutions.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, herbert@gondor.apana.org.au, hpa@zytor.com, 
	iommu@lists.linux-foundation.org, kanth.ghatraju@oracle.com, 
	kexec@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luto@amacapital.net, mingo@redhat.com, mjg59@srcf.ucam.org, 
	nivedita@alum.mit.edu, ross.philipson@oracle.com, tglx@linutronix.de, 
	trenchboot-devel@googlegroups.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Nov 2024 at 11:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Sat Nov 2, 2024 at 11:02 AM EET, Ard Biesheuvel wrote:
> > Same for the ioctl() [as well as the read-write sysfs node]: looking
> > at the code (patch 19/20) it doesn't seem like user space needs to be
> > able to modify this at all, at least not for the patch set as
> > presented. So for now, can we just stick with making the sysfs node
> > read-only?
>
> Short answer: I have no idea. I would not mind that but neither
> the commit message for TPM give a clue on this. Actually, I *do
> not care* if it is RO and RW but I'm neither good at guessing
> random shit.
>

You were cc'ed on the rest of the series, no?

Shall we clarify this first, before proposing patches that introduce
new ioctls() and kernel command line parameters to a security
sensitive subsystem?

My reading of 19/20 is that the secure launch module sets the default
locality, and given that it can be built as a module, setting the
default locality needs to be exported to modules (but as I indicated,
this should probably be in a TPM internal module namespace)

If setting the default locality from user space is a requirement down
the road, we can discuss it then. For now, let's not go off into the
weeds and derail this series even more.

