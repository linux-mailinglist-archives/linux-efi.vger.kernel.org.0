Return-Path: <linux-efi+bounces-2492-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0EC9FEF0C
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2024 12:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE1A3A2B0E
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2024 11:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4D9199FA2;
	Tue, 31 Dec 2024 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anddroptable-net.20230601.gappssmtp.com header.i=@anddroptable-net.20230601.gappssmtp.com header.b="iaFbzOnR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84991191489
	for <linux-efi@vger.kernel.org>; Tue, 31 Dec 2024 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735643531; cv=none; b=UY+vDgpx4CuGNJZJa1R7pru7r5CBV5p9q0wiKIFXMksMDBDRLPFXzI2VhKgtis49s4ZO9trGU7eR7/cDuXk8AgMSo16zaegFiffhaBY5cif1JS0Qg5j+nKY/G2FPxvakbZYU4pNztHbvPUQ9EpQo0ZPucqO8ZoUKHjP593abiYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735643531; c=relaxed/simple;
	bh=eoy7KlN2nZulEcCLBvzynREC7fQuY7DWhEjDpY3VeFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiV3idq35w2fa5mqrH4wQgSo1quDeSIMn/Yp7hC+p0S5WVTtxXMrdCNru3z3ASduje2QkT9z6w2TwPzzkjhby4XMZvgW44s6ksQ6O2ZAZosy5fwjP/kBPBfJdPuW8UqEQKb63NZQEnRU6BZdf5LQGDmPnxgAULwmFDpohPnB+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anddroptable.net; spf=none smtp.mailfrom=anddroptable.net; dkim=pass (2048-bit key) header.d=anddroptable-net.20230601.gappssmtp.com header.i=@anddroptable-net.20230601.gappssmtp.com header.b=iaFbzOnR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anddroptable.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anddroptable.net
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aadb1so14172104a12.0
        for <linux-efi@vger.kernel.org>; Tue, 31 Dec 2024 03:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anddroptable-net.20230601.gappssmtp.com; s=20230601; t=1735643527; x=1736248327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OazyZGE82+EsRX8rZcVE7f+UeK2wjIFF4qO4tdXbTQ=;
        b=iaFbzOnRQ0IG5eXFitXBbgu/n+SMDVJ64g7vj2QcxjVXExfDBsvLbYDEsuIZVXoIYa
         lu4oklC2xfVNWDNSSC9SxzyKFB+9v9PhNy88ow0LNhInq4Yn6v4GvniSuSi1+BtttUSI
         sNU0Prc/MCH/7xeRx12QEkUYy5kZ8KzOF13IMFJ4pbRKEZF6aDb6FWustnQ9HNgUTTVV
         4sXEumaMQZYLafAEBwEhx9okFJZ13RkiRlqi/b7lh0z9JT6S5l3QnPG4Rm/+BgItTaAQ
         ykVJecOm7R9TFfyOglMWdTfT+A24VIa97DmXPS0Y3ZqIUDPrJeM2dT6+DIejQGslb1Px
         mNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735643527; x=1736248327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OazyZGE82+EsRX8rZcVE7f+UeK2wjIFF4qO4tdXbTQ=;
        b=kMUKNvpCRL+55tuQbkYVSUwTqosSs3LYKFipSpQsd81EVDkPZv9jy9BdOTGH06raxO
         n89b8YKUPhSUuYE6Q74tg1iA/ozC6nNXEctx+jqAgE3EFMYLWPTNjKJoyrxcMm6NO8dA
         wSYDnForDL2pMeG2wCpdaXt0VMBryvLdDWa9s0AwqtCYWDboWV7vkBIAFngeV9R6ulbn
         2hdwkBWFcHxarLCJ5b9ymydSvS3eFJ0tTl5sfZGRcDF8Q5HQ4cKHeIzBQQw8mY4JvkQ7
         mVTae4c8ep6uFBU4pj+sxDMi3TxLsHJcHEHFE40fV3iFlhltynNX11L/eFJ+KXr7DONX
         lmYA==
X-Forwarded-Encrypted: i=1; AJvYcCVxDvushOtNh0zo7wYaMMQdHQbld8PUdCJ3cB7pI4UUMNm1AvsTVY78/szQ3NpyhF2jehez8PPFmVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvwd63/p0WgUF2A534+brQkWty/RJAlICyAz8gFUdqcRiNFqID
	ptMYoPAbuZ6D+Mb+fQsbRc/AUZ/Jh5Z7107Bq2AAICkaGNDox5jkpPhSrZJGKCVcnQREFrBmLOC
	ezQgyEsnsgaC3JUovS1/02eTGRv9zdsJFbjJZHQ==
X-Gm-Gg: ASbGnctD3DDzWEquZadYeJxb/B35AD8CLeB8KA8V/iq9nr3en4F+A14Foe+PgGQoB8Q
	sYDlC3GVfh/kyYpK2M69olT9pwYed2rjN8h1sw8jFGUXqwz53A397lbzn3xEYJlVxUZyHFw==
X-Google-Smtp-Source: AGHT+IHADWj45thsaBAHJaGVL6/JGwvPclCzvR4AgbcJaeEktZ7Q8XX4JExc4mgs0nkxDgjLu98JWMHW1ZkeJiLkV6s=
X-Received: by 2002:a05:6402:4011:b0:5d0:b040:4616 with SMTP id
 4fb4d7f45d1cf-5d81de17fa4mr40941550a12.28.1735643526683; Tue, 31 Dec 2024
 03:12:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209182041.60286-1-hamzamahfooz@linux.microsoft.com>
 <CAMj1kXEnxgsy6LkyWGFmwDxVroDofeGYdUd2BvfJ=bNgj0TYVg@mail.gmail.com> <CAMj1kXHmB9RAwfCDZN+CDhXD4D6Z1sE6vg5HN3SUEZ+uLnEnWg@mail.gmail.com>
In-Reply-To: <CAMj1kXHmB9RAwfCDZN+CDhXD4D6Z1sE6vg5HN3SUEZ+uLnEnWg@mail.gmail.com>
From: =?UTF-8?Q?V=C3=ADctor_Gonzalo?= <victor.gonzalo@anddroptable.net>
Date: Tue, 31 Dec 2024 13:11:55 +0200
Message-ID: <CAGRPHEJuJfJ+k72bDKVt=MgbKi3O1e-Zf+9kFTm2aN2naEzbDw@mail.gmail.com>
Subject: Re: [PATCH] efi: bump up EFI_MMAP_NR_SLACK_SLOTS to 32
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, linux-efi@vger.kernel.org, 
	stable@kernel.org, Allen Pais <apais@linux.microsoft.com>, 
	Tyler Hicks <code@tyhicks.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Marek <jonathan@marek.ca>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El jue, 19 dic 2024 a las 12:27, Ard Biesheuvel (<ardb@kernel.org>) escribi=
=C3=B3:
>
> On Tue, 10 Dec 2024 at 10:59, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 9 Dec 2024 at 19:20, Hamza Mahfooz
> > <hamzamahfooz@linux.microsoft.com> wrote:
> > >
> > > Recent platforms require more slack slots than the current value of
> > > EFI_MMAP_NR_SLACK_SLOTS, otherwise they fail to boot. The current
> > > workaround is to append `efi=3Ddisable_early_pci_dma` to the kernel's
> > > cmdline. So, bump up EFI_MMAP_NR_SLACK_SLOTS to 32 to allow those
> > > platforms to boot with the aforementioned workaround.
> > >
> > > Cc: stable@kernel.org
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Allen Pais <apais@linux.microsoft.com>
> > > Cc: Tyler Hicks <code@tyhicks.com>
> > > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > > ---
> > >  drivers/firmware/efi/libstub/efistub.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmwar=
e/efi/libstub/efistub.h
> > > index 76e44c185f29..e95ce6ae5c26 100644
> > > --- a/drivers/firmware/efi/libstub/efistub.h
> > > +++ b/drivers/firmware/efi/libstub/efistub.h
> > > @@ -171,7 +171,7 @@ void efi_set_u64_split(u64 data, u32 *lo, u32 *hi=
)
> > >   * the EFI memory map. Other related structures, e.g. x86 e820ext, n=
eed
> > >   * to factor in this headroom requirement as well.
> > >   */
> > > -#define EFI_MMAP_NR_SLACK_SLOTS        8
> > > +#define EFI_MMAP_NR_SLACK_SLOTS        32
> > >
> > >  typedef struct efi_generic_dev_path efi_device_path_protocol_t;
> > >
> >
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> I've queued this up for v6.14 now - once we are confident it does not
> cause any regressions, we can backport it to stable branches too.
>

Hi. I had this issue three years ago, suggested the bump and then
missed the reply.
We bumped it to 16 and have not had any issue or side effects in three year=
s.

