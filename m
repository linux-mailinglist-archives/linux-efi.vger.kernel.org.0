Return-Path: <linux-efi+bounces-2923-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F634A56C11
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 16:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BE41774D8
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364BF21A92F;
	Fri,  7 Mar 2025 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQX20m4h"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B376101F2;
	Fri,  7 Mar 2025 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361381; cv=none; b=XmNA9n+v3lVI04XEx4dEWETA+x2PFG9kZrsD0QSKXmbXTHsq0VJjJV/XEnypOAYLTrqOZId8A5EBkGyg+gIaHTeweikXr/drWHDw9DnNK9U1+tGWZ+oapReYvqO2cZ5RgZL+TmSoZaHOyjqA4TXXGolg/mcejILhGwn6Kc97p24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361381; c=relaxed/simple;
	bh=OVYgn7sTdg7b2Qz2oqIeNU3hmx4tLKKNi4bak4KlLCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVq/zmOl7mVjksoXe+KkNR3mmnjnaPT6Sqh7tHM36Ft3jd5J9Jf9BBZSRIXNB5pdRhsWcfthg0NBz14gwzzF4d1GtjePca7GtMYACg3LAUiKEwySK9KL4e2KgaT4t/WdUYpkmlMWQOvuntBvCP8AW/P28ggNFyc96HNTzZ3yhm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQX20m4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85462C4AF0B;
	Fri,  7 Mar 2025 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741361380;
	bh=OVYgn7sTdg7b2Qz2oqIeNU3hmx4tLKKNi4bak4KlLCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qQX20m4hYFuSwC4GAie0bewLjjfEykwE0M9+fbEJCyx2MJzBkSF3vuwqhsK0dCqCb
	 FA9GVEHLfOHLqkxxA37je7p7+rox8dYX5yVRvBlqLTB9sJjCLg7/mk7rf9YGnTtwNg
	 /heVySwAzPMCuAbFFlQ0ej8IPPwWIgj+10L2tTE/ufuv7uyaC8yBb0l19Ys/H4V0zZ
	 VhwIDRlAToE2lfedi29k/O6EIy+rnRoR5vRuP1YrW43wftFSRKIShuGwRBSIa89a+d
	 BveNCGNnTSvtHJllC8lu6SCAYwBjjzJpSM8Mv/uywOroWevyzYZ1DgdMM5c9dm4ZBm
	 hKL/IMM0xvTeQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-543d8badc30so2269350e87.0;
        Fri, 07 Mar 2025 07:29:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTZq0HEYrH8oRyfMWnGO8dMZjCZojq9mNdmozH8hxXyJzlW4qFOBjs1hy4/vD6wrDC8NxpTFtZhKQkkD0d@vger.kernel.org, AJvYcCXEtJPz82/Xm+k3xDftJqF7u/31cbmHaecF+5lxpmksnk3nT+aGcjUj95MojPANXE3S1+xcQJbX8IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPdiGzptcodDdzMyQzacH94rFGH6PjYbRXTC7v9mcDcBj07Yu
	Heav6q7yScsMT5fMEuWiPTDK6oGHOCJvIYIgP+wq2dheQjBn8qC7F7O3MLva3PKadGNb/9Gq+4c
	Hz7FqvcMiYPLtek3anEYllOLbe/A=
X-Google-Smtp-Source: AGHT+IHi7AAipiWJZbWUnrNEZ+MjSumx8myk6hE639Fbe7pVnBcNlelHiWjF+IhiWl74QBDImhUMcsQDjsuq+NrhS/8=
X-Received: by 2002:a05:6512:39c7:b0:545:54b:6a05 with SMTP id
 2adb3069b0e04-549910b7c1bmr1849388e87.45.1741361378837; Fri, 07 Mar 2025
 07:29:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305101744.1706803-1-vkuznets@redhat.com> <CAMj1kXF-c46Bdw_cmLK-TckxukefqkpAYkOhg3jzfvW6YucDog@mail.gmail.com>
 <63vy4xc4mpm5tttdqz5vfzwyriqlminjdiffrbuamxcubmpuur@nxszi7xzxa6a>
 <CAMj1kXHQydeGHTa3Jd-ZByMntdqRp4f74ow6Uc0GLwjmejCSbw@mail.gmail.com> <885FB3F6-B085-45DE-9710-10563322B61A@zytor.com>
In-Reply-To: <885FB3F6-B085-45DE-9710-10563322B61A@zytor.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 7 Mar 2025 16:29:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF7Qs=9COU63k8651uEtSh9soOHddSo=Dqdn1kHTuuzoA@mail.gmail.com>
X-Gm-Features: AQ5f1Jp4AgXJchgu2kQ_4krEgLZap1qJbPvt_J4Xw9sczpM3dEWa9AM7PMnp-nw
Message-ID: <CAMj1kXF7Qs=9COU63k8651uEtSh9soOHddSo=Dqdn1kHTuuzoA@mail.gmail.com>
Subject: Re: [PATCH RFC] x86/efi: Add a mechanism for embedding SBAT section
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org, 
	linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
	Emanuele Giuseppe Esposito <eesposit@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Luca Boccassi <bluca@debian.org>, Peter Zijlstra <peterz@infradead.org>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 15:52, H. Peter Anvin <hpa@zytor.com> wrote:
>
> On March 7, 2025 6:15:27 AM PST, Ard Biesheuvel <ardb@kernel.org> wrote:
> >On Fri, 7 Mar 2025 at 14:29, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >>
...
> >> The crc32 is not clobbered.  The signature is simply appended and
> >> wouldn't overwrite the crc32.  But if software expects to find that
> >> crc32 in the last four bytes of the file then yes, that assumption does
> >> not hold any more for signed kernel binaries.
> >>
> >
> >The crc32 is a CRC over the entire bzImage. Whether or not it lives at
> >the end is irrelevant, as signing the bzImage will necessarily [*]
> >break the CRC, and subsequently regenerating the CRC will invalidate
> >the signature. (The CRC lives at the end because that is the easiest
> >way to generate an image whose checksum including the CRC itself is
> >~0. However, there are also other ways to achieve this)
> >
> >> Who uses that crc32 and how?  If it is useless anyway, can we just drop
> >> it upstream?
> >>
> >
> >I tried but hpa objected to that. [0]
> >
...
>
> I don't remember who it was that asked for the CRC32 long ago. It wasn't for Syslinux; it was for an embedded boot loader which didn't have a file system.
>
> I don't know what would break, and it is obviously a mess that the signing protocol didn't take that into consideration, but that is water under the bridge, too.
>
> We could try zeroing out the CRC field and see if anyone screams...
>

If dropping the CRC is on the table, we might also consider my
original patch, which gets rid of the build tool entirely, given the
fact that generating the CRC is the only thing it is still used for.
(Either change can easily be reverted anyway)

