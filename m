Return-Path: <linux-efi+bounces-4304-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD789B035AF
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 07:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214873A6FBB
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 05:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D661FE444;
	Mon, 14 Jul 2025 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyTYApNw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76BC1DF963;
	Mon, 14 Jul 2025 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470797; cv=none; b=jvFlLVOnpD9JzjWRvemm3ZBVACEvIwRnqm54LOoDAAIRDovdkMIRvsWwaAZQHqjryjcmtqtpjRFsrbmouz4nmXdS9URpOnTy0Op0x+ohdqnh1xhfdVie6Br4d66fy3Q5fz/xrZR9zyEQKnfZEIkAvsjcM73JVyAvaOrSxOuZK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470797; c=relaxed/simple;
	bh=+YD2xPUzuD70jmjIVVAHxEBS+CGZKObCvB8tH4bcPPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H43/F1c0DP+P81ysd0zfYDV9IMXqzJGoclQwBgmacS5/JL4UAzecoNozpqmKBu/8YFEj5brAbjOwMGf+LeVwWWlFIfrrJwwXqRAqSKJcRXBQj3esgU5sNjidQ7LpbYtE1IxxYPHNIHTYJ8bvKOM2dw8rvB7vcaeyGiG6v+mNecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyTYApNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1CAC4CEF6;
	Mon, 14 Jul 2025 05:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752470797;
	bh=+YD2xPUzuD70jmjIVVAHxEBS+CGZKObCvB8tH4bcPPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JyTYApNw4vW0uT/9iTe09qMoF4mjZ0A/ksxlVlh3PymGPyfowmYE0IXFPUJXNDWdd
	 rB+goce/o4UU/KiRBGXSCi3jn+WWqE84IGFKjkqFYXQu5m89xPRq+icOX3y6sZem52
	 395EXKFoqUUhUyYTWJ5ifxruAvaXaaQ6hkO58wjqqiGg+6hfV0lpPASGi4F1rT7HWL
	 NsdbBeSw1he8FkvJ8OzzYSHrr/sBbjlbB0HwSRVaEIPh8S3PgjEbBAFXTgTzhVn8mR
	 JISXihKiYRqAhMoVNhxiQ35b8TeAZyAk0BFMLmM5IXuX7Ozqe9Et2lbwP+SXQEriie
	 0I66W58wNv2WQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553dceb342fso3493668e87.0;
        Sun, 13 Jul 2025 22:26:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmM1nbUHFZwTijvcP4DMbvsf+fLwBFk1RcI4y5CtDh1OPmBUbGghNfJaw0TvCw0gKM6WyyDxds/9E=@vger.kernel.org, AJvYcCW7IlzJq4wCwiVaey6+zadIbqD7mq6YlocKCtvWWxOeJhNCBz1MagJct7Kr31guAWxDxRBtJ/m6S1WrnhxP@vger.kernel.org, AJvYcCXrRyHDiWLZBj4RUhlZKI1lAbPrezTpC6HiTN5ACwqfysKqjNdMV1e8Ii/o5sHmW6n6faTSadeV@vger.kernel.org
X-Gm-Message-State: AOJu0YyvIzsIzJEfkV1BPv3jGLWMtWowTQGu219C3n+0iIfhoY4Gp2mm
	3FVU/PMw1nDEcTt0PN0iwSvDb5qssDcybM/MXsKyY0MoOyoLVGv3oe4GblSCds1cF+AXTMUPjaI
	oEgeSsylC73hEf3MkalSyAQUisdEd+3c=
X-Google-Smtp-Source: AGHT+IFWJcY5F4n7NTOkaJxHA3LUZv9nxFS6nHZJN3f0q7VyVFRR8RV1ztE5fC1mOEiedbqtI95Nj+UC2n4FSz5rbc4=
X-Received: by 2002:a05:6512:3b10:b0:553:5148:5b69 with SMTP id
 2adb3069b0e04-55a04608eadmr3201545e87.36.1752470796044; Sun, 13 Jul 2025
 22:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1752290685-22164-1-git-send-email-yangge1116@126.com>
In-Reply-To: <1752290685-22164-1-git-send-email-yangge1116@126.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Jul 2025 15:26:24 +1000
X-Gmail-Original-Message-ID: <CAMj1kXFxFoB3942U1SQBhGwMMh8GMy558CY3UspncK1DsEtWPg@mail.gmail.com>
X-Gm-Features: Ac12FXwXeCsLDvmmkZYe3eRWj_LtxomV3Gh2WhrcAFXoWNEv9gmvrc0aRCDisy0
Message-ID: <CAMj1kXFxFoB3942U1SQBhGwMMh8GMy558CY3UspncK1DsEtWPg@mail.gmail.com>
Subject: Re: [PATCH V6] efi/tpm: Fix the issue where the CC platforms event
 log header can't be correctly identified
To: yangge1116@126.com
Cc: jarkko@kernel.org, James.Bottomley@hansenpartnership.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, ilias.apalodimas@linaro.org, 
	jgg@ziepe.ca, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Jul 2025 at 13:41, <yangge1116@126.com> wrote:
>
> From: Ge Yang <yangge1116@126.com>
>
> Since commit d228814b1913 ("efi/libstub: Add get_event_log() support
> for CC platforms") reuses TPM2 support code for the CC platforms, when
> launching a TDX virtual machine with coco measurement enabled, the
> following error log is generated:
>
> [Firmware Bug]: Failed to parse event in TPM Final Events Log
>
> Call Trace:
> efi_config_parse_tables()
>   efi_tpm_eventlog_init()
>     tpm2_calc_event_log_size()
>       __calc_tpm2_event_size()
>
> The pcr_idx value in the Intel TDX log header is 1, causing the function
> __calc_tpm2_event_size() to fail to recognize the log header, ultimately
> leading to the "Failed to parse event in TPM Final Events Log" error.
>
> Intel misread the spec and wrongly sets pcrIndex to 1 in the header and
> since they did this, we fear others might, so we're relaxing the header
> check. There's no danger of this causing problems because we check for
> the TCG_SPECID_SIG signature as the next thing.
>
> Fixes: d228814b1913 ("efi/libstub: Add get_event_log() support for CC platforms")
> Signed-off-by: Ge Yang <yangge1116@126.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


> ---
>
> V6:
> - improve commit message suggested by James
>
> V5:
> - remove the pcr_index check without adding any replacement checks suggested by James and Sathyanarayanan
>
> V4:
> - remove cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT) suggested by Ard
>
> V3:
> - fix build error
>
> V2:
> - limit the fix for CC only suggested by Jarkko and Sathyanarayanan
>
>  include/linux/tpm_eventlog.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index 891368e..05c0ae5 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -202,8 +202,7 @@ static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *ev
>         event_type = event->event_type;
>
>         /* Verify that it's the log header */
> -       if (event_header->pcr_idx != 0 ||
> -           event_header->event_type != NO_ACTION ||
> +       if (event_header->event_type != NO_ACTION ||
>             memcmp(event_header->digest, zero_digest, sizeof(zero_digest))) {
>                 size = 0;
>                 goto out;
> --
> 2.7.4
>

