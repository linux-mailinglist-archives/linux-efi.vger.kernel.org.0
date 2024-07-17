Return-Path: <linux-efi+bounces-1451-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B551934363
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 22:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F42228269C
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jul 2024 20:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9201849C2;
	Wed, 17 Jul 2024 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRSOghDq"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02D81836D8;
	Wed, 17 Jul 2024 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249647; cv=none; b=HsusZkkUe552oKhfSWNsTfXqVc0FMiKhHAVcKxmYjtQ5V9rdC9vk+W+PmtVnZ/9e4OQc+KzBeVrqrxZTTdsYulvoZvFMiidMz0+84dGpui6v/4MzI/Y+72gUJHuFzX8FOwDrp40rrZxLMOmAbA1MxGZ11gxn5qL4vEK7X/MkBls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249647; c=relaxed/simple;
	bh=LQgVbRpm6mb1fd5XQrSWdfLDPptFikhXIOcnj34W61k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eq7INdkLypXAyquo4RGUgWv2QFM8YZf2Mn6+nKfUWs+TH/3EhDPLD3GBn6LNTrhjoU82hBHLQOB2RzT9zJfUm0l18KNV8tHWIM22T0lnoDyGeqy1B+2lzP3AcjkM4Vk1BKSHPSooRxiUxHIM+GL0v767xGRnGivuW4hLuZvRieg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRSOghDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5377CC2BD10;
	Wed, 17 Jul 2024 20:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721249647;
	bh=LQgVbRpm6mb1fd5XQrSWdfLDPptFikhXIOcnj34W61k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qRSOghDqp5ZPSbsLcXSjEtdHk5yDNYMQ9cbYB6yPotG/kdDJYxS0opC6KQpEwuY+a
	 Zl8T1Br6G85LChi7XXaRo0Wd8UwdbAFdRHVzz56VEP46fjtmdqygYfCwMx8DbVIb8G
	 Z8n/TIywH5AY8LAuEkkOCOHZaBiLh5oFEljpPtOr2TktRsiYbQBAf1cGVuQkZmtWWK
	 fR1sePGXB/CnkcENJCYHp/qCcCwWZqky6sTLLXzmc+3g2RmDEHTCmxoHvDVDZUmn/f
	 3C12V0ZyC3cd4/CjI81KsIIe4kudt+mc9Rl3CxmmFcU4vLlWC3mzKVb9UXOSuTwJWw
	 5KAYIUyBjznBw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eee1384e85so1616541fa.2;
        Wed, 17 Jul 2024 13:54:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvt0iO9sd9EZK+ICSMH15Qxc1dAJkTC5qd06K3aY7PdvbchMRCFZN07A3r2R1AUKao6PkHJZwgO/KYitHH2667f0L9Q8xOAZ4si/7W
X-Gm-Message-State: AOJu0YwoG8XXEYd/QlUNXCrmwQpePzjQUMbS8iXDqEA1QuImi9ItGqPy
	g6Rc7MGzRRp+bt+SgI8F8fqoMVM36wzMDJituXybLNaQMtNibIS9zMy2KIuGScW/8V68QSRZTDt
	ohRKB+LIwztmpiyCOCYV5P7QcEv0=
X-Google-Smtp-Source: AGHT+IGfSKOxW0XwxrFD4F3Dyol+8EvhtLcJkTgNYqBj5OJUR0/kq3g+5VmQA5LanbeVfmbbf0UIZ4+c13dY3q7KS5o=
X-Received: by 2002:a2e:9384:0:b0:2ec:507f:7319 with SMTP id
 38308e7fff4ca-2ef05d47668mr3839981fa.43.1721249645707; Wed, 17 Jul 2024
 13:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717070043.5537-1-maqianga@uniontech.com>
In-Reply-To: <20240717070043.5537-1-maqianga@uniontech.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 17 Jul 2024 13:53:54 -0700
X-Gmail-Original-Message-ID: <CAMj1kXGxDbALV=o+LRqB+X7ozcjfvCoGAJxihDavY=tRih8NJw@mail.gmail.com>
Message-ID: <CAMj1kXGxDbALV=o+LRqB+X7ozcjfvCoGAJxihDavY=tRih8NJw@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Fixed an issue with screen_info not being initialized
To: Qiang Ma <maqianga@uniontech.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 00:01, Qiang Ma <maqianga@uniontech.com> wrote:
>
> After calling uefi interface allocate_pool to apply for memory, we
> should clear 0 to prevent the possibility of using random values.
>
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>  drivers/firmware/efi/libstub/screen_info.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Thanks. I've queued this as a fix.

> diff --git a/drivers/firmware/efi/libstub/screen_info.c b/drivers/firmware/efi/libstub/screen_info.c
> index a51ec201ca3c..5d3a1e32d177 100644
> --- a/drivers/firmware/efi/libstub/screen_info.c
> +++ b/drivers/firmware/efi/libstub/screen_info.c
> @@ -32,6 +32,8 @@ struct screen_info *__alloc_screen_info(void)
>         if (status != EFI_SUCCESS)
>                 return NULL;
>
> +       memset(si, 0, sizeof(*si));
> +
>         status = efi_bs_call(install_configuration_table,
>                              &screen_info_guid, si);
>         if (status == EFI_SUCCESS)
> --
> 2.20.1
>

