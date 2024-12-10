Return-Path: <linux-efi+bounces-2338-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E23D9EAD78
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2024 11:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C2D1668A4
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2024 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A402D212D8E;
	Tue, 10 Dec 2024 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyQQvgut"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B790212D80;
	Tue, 10 Dec 2024 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824808; cv=none; b=ZKchZgZuCq65aMcxvUYzxqhgDUBPYfzp3ikKgYkN525js9Ke4n82NEsQoh6X3cItl21T1asQkYqhFpG9r+sWQpcjYtlhBc+fj2T+NSyiw9ivMsu40rvc+Z7OGs1psk3zzLGCgvipjOHng6fv+ReEzYKqW5qpVmyjaq6sHzzlwkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824808; c=relaxed/simple;
	bh=yDJ3Y0CQ1Zzxec55vnfNIZbtTZPxyflnGg8JzL2FZ1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbvcjGyuB+ivrp8sDPllfqrudpBDIzLXnErC/TvlIcsnFcMhEmoF/vpzSIAJCEwShbnQ/EtDHRkaO933yYMgurLhF/sbn86ltTJ7F8Pt5mcaexSrTRJpJKkNglxVlnk33ygxWySOWQiQBlKmgObS4DwCAaRCEbaPuL5hJEMtKmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyQQvgut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07874C4CEE2;
	Tue, 10 Dec 2024 10:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733824808;
	bh=yDJ3Y0CQ1Zzxec55vnfNIZbtTZPxyflnGg8JzL2FZ1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pyQQvgut2sQT7pkKgPppqPLEYyUx98FyzMV/z+DeXUB3g7zLz2eHCBVIk1s9GntpA
	 bMQwi6xX91MJ+5O/JX6240gXOalG0GMFaVOfWYjW+JqBd/AdHtZSJ2Z/S/GzzKRcXA
	 Pz96j1262YCWsHWY35e9JLpxcetqsKibI+nVwnyH2D4qQUYKne4fmkRMDb/zsnPWXv
	 SrVCoIAh6k/CKz+eujSumQ//l/4g/Y0Z49ZcSLy9oP5sRvRK/DBehqrK1/JzPc5tk8
	 QRkemTmC1AkSv8GyJUtuRHPVuwWAYahEYWbWNodEbt8ARNUv/LHomopjzCBfdC3PwZ
	 2Bn/bj1wmEvlQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so48593381fa.3;
        Tue, 10 Dec 2024 02:00:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWrGE9CKm6+aRpsUMTnpfsGkQScY/CKZ+FsDjcKCJlJ7WECAyqREb29iBbgsg/Z5eJ4gG+DkmdA/XfA00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+UN9PuaNrlnAURCeKjR8fNKwznQ/SyvFTSGNzweB5hV00ikSu
	O0xlHepvgx6drpn4eSWe/hJ+xSHnMm6TgYqEj8Rqp0HX0CLgzLsC2EP8RbjAcQkVE1/oZCffrqT
	0I45N0Rd/4+PIEffaLi9dRHqdULo=
X-Google-Smtp-Source: AGHT+IFSCLO1ka++DkAz9IMfQBoTMj5q6DboeP/rPFyJAVEPmRkEfNV18wimpRcX28lLOVMIzt1ZtWXRFxaf8wONWPg=
X-Received: by 2002:a2e:bcc4:0:b0:302:2a23:cf5 with SMTP id
 38308e7fff4ca-3022fd42dd5mr13476071fa.19.1733824806347; Tue, 10 Dec 2024
 02:00:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209182041.60286-1-hamzamahfooz@linux.microsoft.com>
In-Reply-To: <20241209182041.60286-1-hamzamahfooz@linux.microsoft.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 10 Dec 2024 10:59:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEnxgsy6LkyWGFmwDxVroDofeGYdUd2BvfJ=bNgj0TYVg@mail.gmail.com>
Message-ID: <CAMj1kXEnxgsy6LkyWGFmwDxVroDofeGYdUd2BvfJ=bNgj0TYVg@mail.gmail.com>
Subject: Re: [PATCH] efi: bump up EFI_MMAP_NR_SLACK_SLOTS to 32
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-efi@vger.kernel.org, stable@kernel.org, 
	Allen Pais <apais@linux.microsoft.com>, Tyler Hicks <code@tyhicks.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Marek <jonathan@marek.ca>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Dec 2024 at 19:20, Hamza Mahfooz
<hamzamahfooz@linux.microsoft.com> wrote:
>
> Recent platforms require more slack slots than the current value of
> EFI_MMAP_NR_SLACK_SLOTS, otherwise they fail to boot. The current
> workaround is to append `efi=disable_early_pci_dma` to the kernel's
> cmdline. So, bump up EFI_MMAP_NR_SLACK_SLOTS to 32 to allow those
> platforms to boot with the aforementioned workaround.
>
> Cc: stable@kernel.org
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Allen Pais <apais@linux.microsoft.com>
> Cc: Tyler Hicks <code@tyhicks.com>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  drivers/firmware/efi/libstub/efistub.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 76e44c185f29..e95ce6ae5c26 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -171,7 +171,7 @@ void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
>   * the EFI memory map. Other related structures, e.g. x86 e820ext, need
>   * to factor in this headroom requirement as well.
>   */
> -#define EFI_MMAP_NR_SLACK_SLOTS        8
> +#define EFI_MMAP_NR_SLACK_SLOTS        32
>
>  typedef struct efi_generic_dev_path efi_device_path_protocol_t;
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

