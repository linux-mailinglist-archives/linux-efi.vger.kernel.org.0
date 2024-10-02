Return-Path: <linux-efi+bounces-1880-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 310FC98E100
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 18:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62DEEB26431
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2024 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581761D0E12;
	Wed,  2 Oct 2024 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbkNbOSH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838C747F
	for <linux-efi@vger.kernel.org>; Wed,  2 Oct 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886962; cv=none; b=sN5fvGkxY3kdohHHTqR4UcAf7CtC00l5XAFN2d4hr+XayWMFqDkdwu0IlqlZPbSh2G4O0tmmnCeEG18zh/t6xfXYk63pu5WMl4x4JjfA0y4Xhyzkbkwcc9XEN1nE9U5MXLjiCWDCM6zyasaHhb1x7P/rBoGAkpuWUW5iWRw6AD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886962; c=relaxed/simple;
	bh=OteMVYu/eAlpO3mCPBdXLNFwwpgsesSj1NLyNgnP1Qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6G8DzP6T91alwFPqT+8E/4uLvxLi54YpAs16MC05BT/QXZUkg6kwea79SUbwETSNUESTENo/uTKFlYeUgXraKg13uZ+NiGRl5A2We3xFDpgawaqtE6EIvYlch+tOyc4B1XxMOO4v7FZCtJC4st6s1vB5/kGyidbEQbYtwQlK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LbkNbOSH; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2781cb281abso35565fac.1
        for <linux-efi@vger.kernel.org>; Wed, 02 Oct 2024 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727886959; x=1728491759; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NrEePqC+zxablffowRXVrxTiYP0IGJ5nCAMXr6eVE8g=;
        b=LbkNbOSHl95QoijTPiOjgpdB40lusj8ygTmXExNX2HV8B7a26Hf9CQGkefdPXdJvZ/
         VO1zhZUlxS+qNlNTv0q1og3SODqoUAl5LzWq/rNtCLuXogcLKEZldyZ0Wnf1pWbsCx8w
         Xobahi5m+/ogLEjr3ELVbYcwAtNGV+2/MX5MIfY3PJ7NeAXp/QbPbTFR/bsoFh+7icPl
         DaYccuyp/3qdyo0uZcr6d9ouA30ysYXZNasMshEu7X2CkQ6g7cW8O5vgDsujM7WMqd22
         FP7ZRJR9ApaME6p01/V9OI4OQ/IqZWPeEVpPjbY567TqNeTdcYP1RI4eIjTP9kznRtP3
         /QIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727886959; x=1728491759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrEePqC+zxablffowRXVrxTiYP0IGJ5nCAMXr6eVE8g=;
        b=u7iplSCzq+5vS2MQ4xXo1tsHgeQ6Z7UQXuIRs5E51h7PGR2ik+JLXhJZFwrKHLetlO
         PiB4Qk1iQGr0grB0Jh10IPAg6rIS3Q/ru9etNhpvf1AV3B/pDo2BjnINOwaeT29sApmV
         IAeMoQhlnWJLZWCgAEZZ5IBSDFx5B1ahYkAm6lwvt+/Xy59MEug0xtEjVvpX1Tv2BZvG
         ESWrohrcp5aid4JMhEnaPzLJDeiuutJPIqq0y1V1QqaHHE84eR3MlqxMiNAcudFVy1c1
         3YiRxZbAYL8woTkSDXXFAKPrmA4i5luDLKYtEXofYsxL/jbnRfWfo/aQThVkReE2BV6+
         Mywg==
X-Forwarded-Encrypted: i=1; AJvYcCVvS/Bu4+RLs430t/dCZ60S9qYf0GZI/+VWVLO5UvuIdrd4K9KkiuMcBMfdUa/+yXo3LDD7qeqiHac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpYMqrOCk2MTyUcFXbEDb392CdNVnGfxxrvzlxKJK2nE9aEAw
	askgaTdFgeG7QJOIFJIgHq3n0lLR7clJqkZnx6jhkIeIuETvx/axTanS0qRVtpHrA/rBaccNeML
	1efsxKei367eefJWYnmIOmsgXj0JLjX/KEFCSuQ==
X-Google-Smtp-Source: AGHT+IFPnzSFMBW+g+M1gHE/5y1WDFlBnF+Bl2pDAUtJkq+p2umiY59jy9BtlOZkvneNszTMDu5XVgB9OpMxDVVTJZA=
X-Received: by 2002:a05:6871:e294:b0:277:d360:8971 with SMTP id
 586e51a60fabf-28788f2a861mr2388094fac.43.1727886959303; Wed, 02 Oct 2024
 09:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001032028.483199-1-jeremy.linton@arm.com>
 <CAMj1kXEwsB2JZeE451Qf=tad7mapWATu_-ty+r7fcMTcxQ=StQ@mail.gmail.com>
 <CAC_iWjJH8JwdPbL9Et6xNLf4vV1AQDm8ZZh8zYVkb+VFLXedTg@mail.gmail.com> <0bed3801-47c0-439a-8b46-53c2704e9bb0@arm.com>
In-Reply-To: <0bed3801-47c0-439a-8b46-53c2704e9bb0@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Oct 2024 19:35:22 +0300
Message-ID: <CAC_iWjLo3j73J1x1Bw01szxN4uHUU+tPstWkYk3=+7t7DziHpw@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: measure initrd to PCR9 independent of source
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, bp@alien8.de, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jeremy,

On Wed, 2 Oct 2024 at 18:37, Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> Hi,
>
> On 10/1/24 2:19 AM, Ilias Apalodimas wrote:
> > Thanks, Ard
> >
> > On Tue, 1 Oct 2024 at 08:59, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> (cc Ilias)
> >>
> >> On Tue, 1 Oct 2024 at 05:20, Jeremy Linton <jeremy.linton@arm.com> wrote:
> >>>
> >>> Currently the initrd is only measured if it can be loaded using the
> >>> INITRD_MEDIA_GUID, if we are loading it from a path provided via the
> >>> command line it is never measured. Lets move the check down a couple
> >>> lines so the measurement happens independent of the source.
> >>>
> >>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >>> ---
> >>>   drivers/firmware/efi/libstub/efi-stub-helper.c | 9 +++++----
> >>>   1 file changed, 5 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> >>> index de659f6a815f..555f84287f0b 100644
> >>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> >>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> >>> @@ -621,10 +621,6 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> >>>          status = efi_load_initrd_dev_path(&initrd, hard_limit);
> >>>          if (status == EFI_SUCCESS) {
> >>>                  efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
> >>> -               if (initrd.size > 0 &&
> >>> -                   efi_measure_tagged_event(initrd.base, initrd.size,
> >>> -                                            EFISTUB_EVT_INITRD) == EFI_SUCCESS)
> >>> -                       efi_info("Measured initrd data into PCR 9\n");
> >>>          } else if (status == EFI_NOT_FOUND) {
> >>>                  status = efi_load_initrd_cmdline(image, &initrd, soft_limit,
> >>>                                                   hard_limit);
> >>> @@ -637,6 +633,11 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> >>>          if (status != EFI_SUCCESS)
> >>>                  goto failed;
> >>>
> >>> +       if (initrd.size > 0 &&
> >>> +           efi_measure_tagged_event(initrd.base, initrd.size,
> >>> +                                    EFISTUB_EVT_INITRD) == EFI_SUCCESS)
> >>> +               efi_info("Measured initrd data into PCR 9\n");
> >
> > Back when we added this we intentionally left loading an initramfs
> > loaded via the command line out.
> > We wanted people to start using the LoadFile2 protocol instead of the
> > command line option, which suffered from various issues  -- e.g could
> > only be loaded if it resided in the same filesystem as the kernel and
> > the bootloader had to reason about the kernel memory layout.
> > I don't think measuring the command line option as well is going to
> > cause any problems, but isn't it a step backward?
>
> Thanks for looking at this. Since no one else seems to have commented, I
> will just express IMHO, that both methods are useful in differing
> circumstances.
>
> For a heavyweight Linux aware bootloader like grub/sd-boot the
> INITRD_MEDIA_GUID is obviously preferred. But, for booting strictly out
> out of a pure UEFI environment or Linux unaware bootloader (ex: UEFI
> shell),

I am not sure I am following on the EfiShell. It has to run from an
EFI firmware somehow. The two open-source options I am aware of are
U-Boot and EDK2.
U-Boot has full support for the LoadFile2 protocol (and the
INITRD_MEDIA_GUID). In fact, you can add the initramfs/dtb/kernel
triplets as your boot options, supported by the EfiBoot manager and
you don't need grub/systemd boot etc.

I don't think you can do that from EDK2 -- encode the initrd in a boot
option, but you can configure the initramfs to be loaded via LoadFile2
in OMVF via the 'initrd' shell command.

> the commandline based initrd loader is a useful function.
> Because, the kernel stub should continue to serve as a complete, if
> minimal implementation for booting Linux out of a pure UEFI environment
> without additional support infrastructure (shim/grub/etc). So, it seems
> that unless there is a reason for divergent behavior it shouldn't exist.
> And at the moment, the two primary linux bootloaders grub2 and sdboot
> are both using the INITRD_MEDIA_GUID. Given the battering ram has been
> successful, it isn't a step backward.

I am not saying we shouldn't. As I said I don't think this patch
breaks anything. I am just wondering if enhancing EDK2 to load the
initramfs via LoadFile2 for more than OVMF is a better option.

Thanks
/Ilias
>
> >
> > Thanks
> > /Ilias
> >>> +
> >>>          status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, sizeof(initrd),
> >>>                               (void **)&tbl);
> >>>          if (status != EFI_SUCCESS)
> >>> --
> >>> 2.46.1
> >>>
>

