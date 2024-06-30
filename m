Return-Path: <linux-efi+bounces-1328-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1181691D1AF
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 14:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E11C1C2061A
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2024 12:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B87713C819;
	Sun, 30 Jun 2024 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZeltyVL"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C512DDA9;
	Sun, 30 Jun 2024 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719752339; cv=none; b=U2XGC9LQ0f73Ufn/YFLt0IEE+aa2Oy4AmJTeaWSZq6vFo+a6cvDyH/tB719Vn5ZuYGyI9G0zjUi/7a2vDZioLhlrOva2ucRYlntw0DtAk2hGQMrytq9hvLH43TscKf8MDVHwY18qOtrJEmGGE9uzEdhD9cGeOuURVunQ3UU7pCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719752339; c=relaxed/simple;
	bh=ksHzjSAOXrl1AQ92vQ01FSUeB9yDSgVhU7TgozQO0ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IE2ec+eOGiY3/hWNw+X05jmzaApPW5+Sq32YdvgivH9cp93K7HObXX145Fq2eWbPJXzD/sCkcHSGfDoL/9O2pCqsNIWWYZh4TccZDtbe+fAudmSSKQdmxeXZcvFwfPX8qFfNI4B8QOpvogaz2ZnBSUVYWN2AEBHfDgwAO0bQJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZeltyVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF9BC4AF0A;
	Sun, 30 Jun 2024 12:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719752338;
	bh=ksHzjSAOXrl1AQ92vQ01FSUeB9yDSgVhU7TgozQO0ho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UZeltyVLfi3Vo49LuB5Aj2sTpKzU0TUxkMQMbg3dXTEIIMyZavEfp/0H7luGYi7Yo
	 GqWI1ZNouZIVs20BulP90fk+Lya/Vx4JvsNN7qTORK+STrfjnLf3Hs1z2qV80RbTy/
	 zWZjVczlO+Sy2wRG+opfzCignE7rqh8Rq4K6rfEFcbVoT3ukoYcz0WnFRLEDfFUVEZ
	 dbpzoF1pmvfi+4zqQAB/VJkIWvMeAEELrz3oWJiAa8Hd7c3nyhL8M7HGg/WFGO21bG
	 wvySH0FiXHheMlwPMzGmwsmvoAoSQIqFuHHqW7t2oF+Hm+nH4+/xm3p+GuQ9awoaiN
	 ToK4BbBZAd6Pg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cd8897c73so2380900e87.2;
        Sun, 30 Jun 2024 05:58:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVQuExnoEBwtmRUXmrn9s/hL4S+EFLF22YVKR0HHI7dvUqk68uQ/sZVt7fgiS6MnNJU6sRIWqnpccFTeMbavb90G3unjYt5uxFbbQzBb/6879IbIgF2VF2sndcbmIa0jxF2/SYGHQM
X-Gm-Message-State: AOJu0YwkauktGtybWH29wUNcEdNfhBypvoYpAliX0JRqsqUyePt/00lZ
	VCuVbQZD9Snv5LiF3hSdzBioFW7U/BiIxklkPaLdLHBZbJfyLKDAivIw0QpQ80Cj52QFWt+ZtU9
	kgu2wG546JZGuCrYuqTkm/6vxKds=
X-Google-Smtp-Source: AGHT+IEptw6Pd/BwqDgoTXJArK00NdmD2hSrbm4WUtTlquXxXneAoZA6/UdXg1MKv1OH3QMEjVvqzrCBsPj9rj8cT4U=
X-Received: by 2002:a05:6512:2385:b0:52c:c9d3:a30c with SMTP id
 2adb3069b0e04-52e82690de4mr2126052e87.29.1719752337171; Sun, 30 Jun 2024
 05:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <EBE51900-DA87-4113-B389-80B9C9160F0F@live.com>
 <ZoERl1PWoc2xDGWz@wunner.de> <CAMj1kXFEQDir_VffzHZ0uBMjRqEReNdBZcEQs7kFhi=ipM+y9Q@mail.gmail.com>
 <MA0P287MB021713D8583D4D53C736F3D8B8D22@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MA0P287MB021713D8583D4D53C736F3D8B8D22@MA0P287MB0217.INDP287.PROD.OUTLOOK.COM>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 30 Jun 2024 14:58:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFucVCg39zJovVv2jzSJv-Wq6RvG9tvs5B4dvNHaCBnLQ@mail.gmail.com>
Message-ID: <CAMj1kXFucVCg39zJovVv2jzSJv-Wq6RvG9tvs5B4dvNHaCBnLQ@mail.gmail.com>
Subject: Re: [PATCH] efi: libstub: add support for the apple_set_os protocol
To: Aditya Garg <gargaditya08@live.com>
Cc: Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Orlando Chamberlain <orlandoch.dev@gmail.com>, Kerem Karabay <kekrby@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 30 Jun 2024 at 13:56, Aditya Garg <gargaditya08@live.com> wrote:
>
>
>
> > On 30 Jun 2024, at 4:59=E2=80=AFPM, Ard Biesheuvel <ardb@kernel.org> wr=
ote:
> >
> > =EF=BB=BFHello Aditya, Lukas,
> >
> >> On Sun, 30 Jun 2024 at 10:04, Lukas Wunner <lukas@wunner.de> wrote:
> >>
> >>> On Sun, Jun 30, 2024 at 04:42:55AM +0000, Aditya Garg wrote:
> >>> Commit 0c18184de990 brought support for T2 Macs in apple-gmux. But in=
 order to
> >>
> >> Please run patches through scripts/checkpatch.pl before submission.
> >> The subject of the commit is missing here and lines should be wrapped
> >> at 72 or at least 74 chars.
> >>
> >>
> >>> Based on this patch for GRUB by Andreas Heider <andreas@heider.io>:
> >>> https://lists.gnu.org/archive/html/grub-devel/2013-12/msg00442.html
> >>
> >> Please include his Signed-off-by and cc him.
> >>
> >>
> >
> > No. You cannot simply add a signed-off-by on someone else's behalf,
> > even if you cc the person.
> >
> > Andreas contributed code to GRUB (which is a GPLv3 project), and had
> > no involvement whatsoever in creating this patch.
> >
> > A signed-off-by is a statement on the part of the contributor (which
> > may or may not be the author) that the contribution in question
> > complies with the requirements imposed by the project in terms of
> > copyright and licensing. Linux is GPLv2 not v3, so this code should at
> > least be dual licensed in order to be reused directly.
> >
> > I did not look at the GRUB patch, and IANAL, but this code invokes an
> > Apple provided protocol (which is proprietary) in a hardcoded way for
> > interoperability purposes, and so there is not much to
> > copyright/license anyway. I would be fine with having just your
> > signoff on this patch, but you could ask Andreas for a GPLv2+3 version
> > of his GRUB patch if you are not sure.
> >
>
> I believe this should be GPL2 compatible since it's simple reverse engine=
ered Apple stuff and there are many kernel drivers with apple specific stuf=
f.
>
> >>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>> @@ -399,6 +399,8 @@
> >>>                            useful so that a dump capture kernel won't=
 be
> >>>                            shot down by NMI
> >>>
> >>> +     apple_set_os    [KNL] Report that macOS is being booted to the =
firmware
> >>> +
> >>
> >> Why the kernel parameter?  Why not do this unconditionally?
> >>
> >>
> >
> > Agree that this is suboptimal. If we need a command line param for
> > this, please make add it to the efi=3D list
>
> I'll leave this to you. If you are fine with a parameter, I'll add it. If=
 you have to be enforced by default, I'm fine with that.
>
> Or, maybe we add add a parameter that disables this so that in case thing=
s break, we can atleast get it done.
>
> >>> +struct apple_set_os_protocol {
> >
> > This should be a union not a struct
> >
> >>> +     u64 version;
> >
> > This should be unsigned long
> >
> >>> +     efi_status_t (__efiapi *set_os_version) (const char *);
> >>> +     efi_status_t (__efiapi *set_os_vendor) (const char *);
> >>> +     struct {
> >>> +             u32 version;
> >
> > ... to match the mixed_mode overlay which is u32. Alternatively, they
> > could both be u64 but the current arrangement is definitely incorrect.
> >
> >>> +             u32 set_os_version;
> >>> +             u32 set_os_vendor;
> >>> +     } mixed_mode;
> >>> +};
> >>
> >> How about declaring this __packed, just to be on the safe side?
> >>
> >
> > I don't think that is necessary. If the mixed_mode overlay is never
> > used, it doesn't really matter and you can use unsigned long vs u32,
> > in which case all struct members are native word size so there is no
> > padding issue.
> >
> >> Why "mixed_mode"?  Seems like an odd name given "mixed mode"
> >> in EFI context usually means 64-bit OS, but 32-bit EFI.
> >>
> >
> > This is how the x86 plumbing works for mixed mode. Every EFI protocol
> > is a union, with a mixed_mode member describing the 32-bit view. The
> > accessor macros (efi_bs_call, efi_table_attr) automatically do the
> > right thing depending on the bitness of the firmware.
> >
> > This means, though, that even protocols that are known not to exist on
> > 32-bit firmware need to be implemented in the same way, or the code
> > will not build.
> >
> So should I keep mixed mode or not?

Yes. To summarize:
- keep your signoff as-is
- drop the command line param and handling
- make the outer protocol struct a union
- use 'unsigned long' for the version field
- keep the mixed_mode inner struct
- reorganize the conditional in setup_quirks() so that there are two
nested if blocks, where the memcmp() appears in the outer if() and
apple_set_os() is only called on Apple hardware

