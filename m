Return-Path: <linux-efi+bounces-2522-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2F5A038DB
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2025 08:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0196B1886568
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2025 07:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7784B154C15;
	Tue,  7 Jan 2025 07:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXFDF/JI"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5FC14F70;
	Tue,  7 Jan 2025 07:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235414; cv=none; b=YCmqHKRszzT5ZaW5Te9TPZFVrHbq+cMsgfFNT/0ufPjE5mv34VT7O2msDvoES00sd/yaLnBptHmr94jZq5+r6YSLNdOIfY6otqkCpjYSULlVzqBGpUUU8BWWPgjPjdV4qZzU7XRYSji4bvSRHFFVAy/61CBhJWLc2i/zmzqqqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235414; c=relaxed/simple;
	bh=450lMuau3ge71dUQh/4nnXDvWTEzOSz2lqm5heD5NXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQHoFyqdqdrXszqovjrCehwKRLgbof/INZnhyGcm0D6XErzmx7rZK+x4pUL89rOYa/YVDPR2MMz5OZqbY5UX/Lm0fxbjGllFqDy0aGmr/eKYoDTEcKBvLVfRECobYozGyLMFmMdl6f348yDJ3HqR0FTT/8UMXUeJt052WJ3FnJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXFDF/JI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AE7C4CEE0;
	Tue,  7 Jan 2025 07:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736235413;
	bh=450lMuau3ge71dUQh/4nnXDvWTEzOSz2lqm5heD5NXU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qXFDF/JIz2XSgZeT3m2q4hKxvacYMW8Rb+rqakeaKD+QTSPp+ZPVOF+1NCWw4H/p2
	 5o4/p/aL3F+YEdLgYBrmXUjlbbLhJOiTup8x6fojrZRnRQMPTF6eBO89uhxx/H7sLu
	 b6Rq8ibhc6pfIoR2/OIY0H39JX7SLZC0olqne5haEiXxwuv/VAZCfN2NfOHzu+Y/Oh
	 5j/WHN+sv9L23Ut8vK+EIB8ZQeqhTtD3k/ZXMG2NKth+g1jtocEwctXageXQX5mKCd
	 21xmNV9nb09xZzIFKPYG14YjomLCuHvYny4qZSUS3AJWGXqTeLj7HfgyKZ8MQ873Qi
	 HZ+huqFzrLGbg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401bd6ccadso15127024e87.2;
        Mon, 06 Jan 2025 23:36:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpc4LCXH+PFvx2r+R5mDkJuf9W38OObphlPRgjURzn9pRq+NL0B1JQCgsleu+1AjeDkkMEtOi7vH4=@vger.kernel.org, AJvYcCWez2sxeC3VXkXzO7tU4YJ0sANUZ88yYbzTDJSGs5XFPcdS74BUDLmAYXexLYkacsjo/I3YeTHyRbuRrXS4@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWmIMDNy9ou/Uttljz6ZpCtpGzEohtWI/LfNAhf8wGTRZhRwK
	nmS2i/ZPcW+p6/FrjgO7FFQVadL2GuEZDxjb8dRK3fgNiuyLHDnWEjqCMTrbLSz87SF07OkiPLv
	/2gKoOOOUmsThOl/OiVZpWu60feA=
X-Google-Smtp-Source: AGHT+IGPUosH6afU/CZKDhPOuZ+SIz9KInC8qNvf/oURLrED3KVV2AgUAPTeAHmJBvVuNOaVOZp7aHHY5/DxTMlRZzk=
X-Received: by 2002:a05:6512:3a90:b0:542:249c:2156 with SMTP id
 2adb3069b0e04-54229530077mr19659517e87.15.1736235412131; Mon, 06 Jan 2025
 23:36:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209182041.60286-1-hamzamahfooz@linux.microsoft.com>
 <CAMj1kXEnxgsy6LkyWGFmwDxVroDofeGYdUd2BvfJ=bNgj0TYVg@mail.gmail.com>
 <CAMj1kXHmB9RAwfCDZN+CDhXD4D6Z1sE6vg5HN3SUEZ+uLnEnWg@mail.gmail.com> <CAGRPHEJuJfJ+k72bDKVt=MgbKi3O1e-Zf+9kFTm2aN2naEzbDw@mail.gmail.com>
In-Reply-To: <CAGRPHEJuJfJ+k72bDKVt=MgbKi3O1e-Zf+9kFTm2aN2naEzbDw@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 7 Jan 2025 08:36:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHrNXdXHCF9vVOA3jsLTkcxRB3dX6SL8BbPbECugPsbLQ@mail.gmail.com>
X-Gm-Features: AbW1kvbpRcLM9TDPqiwYiln6YAzNs7ZWzSMO1Ma3fWdYJ7IGa-8KF30Lm4psnRY
Message-ID: <CAMj1kXHrNXdXHCF9vVOA3jsLTkcxRB3dX6SL8BbPbECugPsbLQ@mail.gmail.com>
Subject: Re: [PATCH] efi: bump up EFI_MMAP_NR_SLACK_SLOTS to 32
To: =?UTF-8?Q?V=C3=ADctor_Gonzalo?= <victor.gonzalo@anddroptable.net>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, linux-efi@vger.kernel.org, 
	stable@kernel.org, Allen Pais <apais@linux.microsoft.com>, 
	Tyler Hicks <code@tyhicks.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Marek <jonathan@marek.ca>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Dec 2024 at 12:12, V=C3=ADctor Gonzalo
<victor.gonzalo@anddroptable.net> wrote:
>
> El jue, 19 dic 2024 a las 12:27, Ard Biesheuvel (<ardb@kernel.org>) escri=
bi=C3=B3:
> >
> > On Tue, 10 Dec 2024 at 10:59, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Mon, 9 Dec 2024 at 19:20, Hamza Mahfooz
> > > <hamzamahfooz@linux.microsoft.com> wrote:
> > > >
> > > > Recent platforms require more slack slots than the current value of
> > > > EFI_MMAP_NR_SLACK_SLOTS, otherwise they fail to boot. The current
> > > > workaround is to append `efi=3Ddisable_early_pci_dma` to the kernel=
's
> > > > cmdline. So, bump up EFI_MMAP_NR_SLACK_SLOTS to 32 to allow those
> > > > platforms to boot with the aforementioned workaround.
> > > >
> > > > Cc: stable@kernel.org
> > > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > > Cc: Allen Pais <apais@linux.microsoft.com>
> > > > Cc: Tyler Hicks <code@tyhicks.com>
> > > > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > > > ---
> > > >  drivers/firmware/efi/libstub/efistub.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmw=
are/efi/libstub/efistub.h
> > > > index 76e44c185f29..e95ce6ae5c26 100644
> > > > --- a/drivers/firmware/efi/libstub/efistub.h
> > > > +++ b/drivers/firmware/efi/libstub/efistub.h
> > > > @@ -171,7 +171,7 @@ void efi_set_u64_split(u64 data, u32 *lo, u32 *=
hi)
> > > >   * the EFI memory map. Other related structures, e.g. x86 e820ext,=
 need
> > > >   * to factor in this headroom requirement as well.
> > > >   */
> > > > -#define EFI_MMAP_NR_SLACK_SLOTS        8
> > > > +#define EFI_MMAP_NR_SLACK_SLOTS        32
> > > >
> > > >  typedef struct efi_generic_dev_path efi_device_path_protocol_t;
> > > >
> > >
> > > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > I've queued this up for v6.14 now - once we are confident it does not
> > cause any regressions, we can backport it to stable branches too.
> >
>
> Hi. I had this issue three years ago, suggested the bump and then
> missed the reply.
> We bumped it to 16 and have not had any issue or side effects in three ye=
ars.

Thanks for the data point.

