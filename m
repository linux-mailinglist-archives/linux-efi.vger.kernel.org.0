Return-Path: <linux-efi+bounces-1605-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31439960756
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 12:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B1F1C22AB0
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4524C13B588;
	Tue, 27 Aug 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCbejBgA"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF949450;
	Tue, 27 Aug 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754184; cv=none; b=HpPgMtyERMfdk0nZCR7y+T0OnVFS2oKmSM+AEXyYqPxTE8TOWZwCxOwgtwAumLkRAXNKSmU654Lwra+8dFHzTLZPl++qB+g6e/SJ0Ohvh/tSMvmcMWmUFFaT+PlJhgrXLTEe1CYlBZc/bMEokHL448eUXsieD24kFCmAzBFeQpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754184; c=relaxed/simple;
	bh=PZWA9dMZRkWiOjNZ34ghUxLFh9mlerV4I1x8U/SXokU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ytv7qurwJg2pHLyVhjBIpNvpd+du87vZgYFAnzzU7i8KEZqTAFjo8JQtFM/HEHOkNE9orf+E7D4J/GVmDrX991Eq+HJPjOPyly9ujuUW5KD9JIQEKDPIKoHJugSTvhQxbG8eHQc9s+GX+M5/UwzcykJlTxFsNbeXWcSqwEvsmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCbejBgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981A4C8B7AA;
	Tue, 27 Aug 2024 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724754182;
	bh=PZWA9dMZRkWiOjNZ34ghUxLFh9mlerV4I1x8U/SXokU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OCbejBgAVLZLgfESNBhGkirwZSdNCEbU0Gc/gNmhdYQhrFQsYF5ABw1UWnOKfLPY+
	 CILD8niR9bsahElZOLndqeWzMB/xp010Rpjq8vSLo869LKYio8Y0B/ZYpix3VqrP2l
	 C/OvqqHF+vMnY2zimCUEv8y2qKCHcN5WuCm7s4OinCrcxzd6REyX+HgxGnlDlJKkl5
	 pq5OV1yxraVRz0Iu9TryWHHCrUpImmAClCfCUZ2RGXxirC4PYlD8lskypkPlukGHMK
	 3k6isocoCN2w1kHPEGaej86KyMC41Ui8aNoXjbGKMZItZBPzLN+hMFBgW0pFwcpPam
	 SFE2FSnZUkk3g==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-533496017f8so7066287e87.0;
        Tue, 27 Aug 2024 03:23:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXWO157jVnOc5lY8fcxu7kUmpK0+/posuHtHTYk4JSrlWCWxJdJrEXCOWYDIwZVJodqefnokEvbS+xW3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzejrvTLCrWq6zCGQgLbP53508Z+WlN1o/167ZHuzCpw8J8fSb
	KvkRpkLh+jJI3n4Cb3zDqjQxOywy7cgxsTkxXwkfWOV3AUVDANfFkqAHNDsCTTDzmcuPvOvijU5
	5Swqs+pTHH8iKFVXCn4tTeFth83s=
X-Google-Smtp-Source: AGHT+IEzFJfNowtLSWUOXcqfxHX0ozETw17DR3Fa5hMuHo06uZDoojt05hba89hE4dpZVcX7PsYzYP0TP0Ye4/UiCzk=
X-Received: by 2002:a05:6512:baa:b0:533:4668:8b86 with SMTP id
 2adb3069b0e04-5343885f620mr10360856e87.41.1724754180905; Tue, 27 Aug 2024
 03:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808140554.2498398-1-yuehaibing@huawei.com>
In-Reply-To: <20240808140554.2498398-1-yuehaibing@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Aug 2024 12:22:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF=e-kdp2TfjuP-0230uxEgQWAoGZ40f_RQUUaW2G6VEw@mail.gmail.com>
Message-ID: <CAMj1kXF=e-kdp2TfjuP-0230uxEgQWAoGZ40f_RQUUaW2G6VEw@mail.gmail.com>
Subject: Re: [PATCH -next] efi: Remove unused declaration efi_initialize_iomem_resources()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 16:08, Yue Haibing <yuehaibing@huawei.com> wrote:
>
> Since commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture"),
> this is not used anymore.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/efi.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 6bf3c4fe8511..e28d88066033 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -764,8 +764,6 @@ extern int efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md);
>  extern int __efi_mem_desc_lookup(u64 phys_addr, efi_memory_desc_t *out_md);
>  extern void efi_mem_reserve(phys_addr_t addr, u64 size);
>  extern int efi_mem_reserve_persistent(phys_addr_t addr, u64 size);
> -extern void efi_initialize_iomem_resources(struct resource *code_resource,
> -               struct resource *data_resource, struct resource *bss_resource);
>  extern u64 efi_get_fdt_params(struct efi_memory_map_data *data);
>  extern struct kobject *efi_kobj;
>

Queued for v6.12 - thanks.

