Return-Path: <linux-efi+bounces-2393-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C71D9F7994
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2024 11:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229B61896A8E
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2024 10:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6107D222D50;
	Thu, 19 Dec 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrfUh7BC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37459222D44;
	Thu, 19 Dec 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603995; cv=none; b=R+lyGhlwRy+1+Z/VROVZpMbMd1p0YGPF4wahvOfYwXr2f0XECOrguROugrNMES906XqNIp0GXdRtXfXv33JbUl0AGTlN5TxjivDdn6Jfbs9YDp92Tw+rSGg+3m7RQ0oaZjpht+FynqUsLag3QAfZ1F2cYo7RDNZl8gYwAPIsAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603995; c=relaxed/simple;
	bh=V/LvbmXhr4PQumbo/yEFLI7Dz/+3vbbiDOhDZ+EYP2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSpsNLZDcDrGL1tqp41vqyFEb1AS3BRzD5CAULbgk4WiVn3jO6HKXu8ODJm+HCLySUEWJXtOWkwNSdGeGYfiMlLc+S14PFUZbCAYXKuv8SR4Ym3qGqxtD7czya7OGq08JvIxamyMrH4KZCuNI+iHPrN37BfMk62UxyLo7zhslqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrfUh7BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5AAC4CEDD;
	Thu, 19 Dec 2024 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734603994;
	bh=V/LvbmXhr4PQumbo/yEFLI7Dz/+3vbbiDOhDZ+EYP2o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NrfUh7BC000XbV5a8Eb6CVJ0Hg+wqtPpoOK3l0gChPZdiwYlRcdxu4lJp5CTcQUJe
	 R5ACYgla1MqoyTFMRbZXTP076MOkzCQYGbi9mx1c0zCKUIG3piqbu/3dFXHLEJzTIH
	 lm3+9yAbydaozwAAg+eFNciawF0qkxsRvPC4aBOPe00FFyrQ1ncZfb8wTqiP58GqEg
	 6EIUSNp6GzwYbQ/TnvIHRk97ScJMmbzaFdPYICkGc8UmMIE1pH1dzkLoQkhRxEhMIQ
	 5bQlL6U5ij9BZ6pFsv6cCEpK+6A/xn3uw/hQQAeiYrfeb5joVRAb2c7TiogMKtEM2o
	 SBWfoX1eM0IrA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-540218726d5so496404e87.2;
        Thu, 19 Dec 2024 02:26:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhZ+Q/WGDRcBbnMDaoV66nQwwuwb7f/F/+ma7gchB1ty6K4MADWsVBIpjQIcDO5OoKia8PLJ+YKXr/RTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+DVpGzRZbKUAdaLBoKklpkPqnrAa3D7bEjbTqoHC8gGOZ99f1
	cxDJOgTMqCVLCjjvOxEkp/ezSuPwHILYBwdFWmw+V1jAlz43aeaaEQRTOPNHGO99ZF194ZdFLOJ
	7E+TSDmwFgWelk5qmcc4DXrKV9yM=
X-Google-Smtp-Source: AGHT+IEFnkwlkJcjhhURezL8MYVQ6z4dd5Ea8uKH2gGNexkkH5+8L5fM88B3L3bU1xMahmHI5fnvGdF2312gDj0z1zE=
X-Received: by 2002:a05:6512:3c86:b0:540:21f1:e9e7 with SMTP id
 2adb3069b0e04-541ed8e4c9emr2587654e87.16.1734603992182; Thu, 19 Dec 2024
 02:26:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209182041.60286-1-hamzamahfooz@linux.microsoft.com> <CAMj1kXEnxgsy6LkyWGFmwDxVroDofeGYdUd2BvfJ=bNgj0TYVg@mail.gmail.com>
In-Reply-To: <CAMj1kXEnxgsy6LkyWGFmwDxVroDofeGYdUd2BvfJ=bNgj0TYVg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 19 Dec 2024 11:26:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHmB9RAwfCDZN+CDhXD4D6Z1sE6vg5HN3SUEZ+uLnEnWg@mail.gmail.com>
Message-ID: <CAMj1kXHmB9RAwfCDZN+CDhXD4D6Z1sE6vg5HN3SUEZ+uLnEnWg@mail.gmail.com>
Subject: Re: [PATCH] efi: bump up EFI_MMAP_NR_SLACK_SLOTS to 32
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-efi@vger.kernel.org, stable@kernel.org, 
	Allen Pais <apais@linux.microsoft.com>, Tyler Hicks <code@tyhicks.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Marek <jonathan@marek.ca>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 10:59, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 9 Dec 2024 at 19:20, Hamza Mahfooz
> <hamzamahfooz@linux.microsoft.com> wrote:
> >
> > Recent platforms require more slack slots than the current value of
> > EFI_MMAP_NR_SLACK_SLOTS, otherwise they fail to boot. The current
> > workaround is to append `efi=disable_early_pci_dma` to the kernel's
> > cmdline. So, bump up EFI_MMAP_NR_SLACK_SLOTS to 32 to allow those
> > platforms to boot with the aforementioned workaround.
> >
> > Cc: stable@kernel.org
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Allen Pais <apais@linux.microsoft.com>
> > Cc: Tyler Hicks <code@tyhicks.com>
> > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > ---
> >  drivers/firmware/efi/libstub/efistub.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> > index 76e44c185f29..e95ce6ae5c26 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -171,7 +171,7 @@ void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
> >   * the EFI memory map. Other related structures, e.g. x86 e820ext, need
> >   * to factor in this headroom requirement as well.
> >   */
> > -#define EFI_MMAP_NR_SLACK_SLOTS        8
> > +#define EFI_MMAP_NR_SLACK_SLOTS        32
> >
> >  typedef struct efi_generic_dev_path efi_device_path_protocol_t;
> >
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

I've queued this up for v6.14 now - once we are confident it does not
cause any regressions, we can backport it to stable branches too.

