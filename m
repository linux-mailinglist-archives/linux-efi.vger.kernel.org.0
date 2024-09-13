Return-Path: <linux-efi+bounces-1742-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6B29784C9
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 17:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2693A1F27E7B
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AE8383A2;
	Fri, 13 Sep 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zslma9Bb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C31F5FE;
	Fri, 13 Sep 2024 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241141; cv=none; b=czLxbpUYKyNcu43fCe31oTc765T+cRZ6kYo6ipOiEpXLDt2AON9L1PaE7wW/LD1t1/UMCniZMF6khuhePgLGlzHOpCHt7tUoKfKkwSjHu8yKrm6AhT7MVRUq5rApjtcxI5M3VrRKmQPgYNwFlwtJjn6+qjMQ/uc9LJ3rFZGu3cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241141; c=relaxed/simple;
	bh=XgjTcZB/joHvG88LwfYUyBpeQjgR2rJH09fvAF160QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNe7eRwGIyhallesePxLoJoj/u906mIsF3d4CPuVvU64XcUjs6hWW3gprhqST/qXcNIAZDhaWNU0QGt9mfOdNT8NR2/oAVUeUx6Fo3yx38B9c9sgmAZO4qPQy3C2UPz2VX3LQNMgdf0/RI9xQAv8javjdUgKxidQx4fgy2f0H98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zslma9Bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1BF6C4CECF;
	Fri, 13 Sep 2024 15:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726241141;
	bh=XgjTcZB/joHvG88LwfYUyBpeQjgR2rJH09fvAF160QI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zslma9BbJPeopyi9lsxHgwLeAg0apkkzQc9TLrHDNvYtX7htREULs3KQUTjPsuE7e
	 qO7vz16l6qHxPqSVFDGzrgPGikKAXAaLEuo8a8a7bpjz2AvpyWvN4z3r6gbcZN0evM
	 D86uWeTuWlCZ8xQtiTMSvx1b5f5E9Aev3U6laNJgoUY2aVZHvaLLhrDco1XSScaRwR
	 e71nzePlOExIGdTvmsSWawmTIZy3H0eWb+xkgtKg22wrHUlRYp4U2sL9eHtQSYWrem
	 EKSO/Ocaasfwv4e4ZdcwjltgACHK4bAhfkEajbFEvNsf9wx0fmMjh1yP89a+d9kz6L
	 b3lEa0F/wTPEQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f74e613a10so17308181fa.1;
        Fri, 13 Sep 2024 08:25:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUf3Evrug9OLogBn84uwnEhLtsEnTM03aEpoR2kmWBuiJ/xdmnklxLCyqL4HVMqVoYSNADR1RlHnVm5mhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjHvXFpT8cYRyVcdeAopncS3a+VBTK1rBPj4YM4aItc/qY561q
	iXa6LUzGi7DXXzqn07jp8GYB2Lsey1y/P4Y72rQXfRjuf94F4tCBWbiBdF/pAbCZWJRuWuX9sep
	ZOA4q+ptz0QA1SVYDkrNNPV15UjA=
X-Google-Smtp-Source: AGHT+IFfv1a79Z6scFWVcSLcB5+aOzc39UPeqhu0O7rc5XO4iyk+7VrV/X1VQQxoqEwhb8uF16pC4m39oVgVCtctcjU=
X-Received: by 2002:a2e:be04:0:b0:2f3:cb70:d447 with SMTP id
 38308e7fff4ca-2f791b664afmr29619191fa.40.1726241139297; Fri, 13 Sep 2024
 08:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906202745.11159-1-gourry@gourry.net> <20240906202745.11159-7-gourry@gourry.net>
In-Reply-To: <20240906202745.11159-7-gourry@gourry.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 13 Sep 2024 17:25:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHRkDCnUCjBR17jSCwceGT8fyE_WdERmVpYY7c6eBsgFA@mail.gmail.com>
Message-ID: <CAMj1kXHRkDCnUCjBR17jSCwceGT8fyE_WdERmVpYY7c6eBsgFA@mail.gmail.com>
Subject: Re: [PATCH 6/6] libstub,tpm: do not ignore failure case when reading
 final event log
To: Gregory Price <gourry@gourry.net>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org, 
	usamaarif642@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	ilias.apalodimas@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 22:28, Gregory Price <gourry@gourry.net> wrote:
>
> Current code fails to check for an error case when reading events from
> final event log to calculate offsets.  Check the error case, report the
> error, and break early because all subsequent calls will also fail.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/firmware/efi/libstub/tpm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> index 4f9f0e049a7a..c71b0d3e66d2 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -124,6 +124,10 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
>                         event_size = __calc_tpm2_event_size(header,
>                                                    (void *)(long)log_location,
>                                                    false);
> +                       if (!event_size) {
> +                               efi_err("Invalid TPM Final Event Log Entry\n");
> +                               break;
> +                       }

I don't object to this in principle, the only problem is that these
log prints are not recorded anywhere: they are printed to the EFI boot
console by the EFI stub, which may not even be visible, and is
definitely not captured by the kernel logging routines.

