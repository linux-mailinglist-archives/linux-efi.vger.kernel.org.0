Return-Path: <linux-efi+bounces-1938-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B37F99B1CB
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 09:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD951F21FAA
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 07:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FAE12CDA5;
	Sat, 12 Oct 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZetIlvXa"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51972BA49;
	Sat, 12 Oct 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728719392; cv=none; b=tjs67+UlAcPe8PGFAy/qDl96kgCVIMhM1jF42YBqQaSFNiisHKjsIweLgQV7KT6ITLz5gbn8fUctAFVvUxmRF1zdtsxYloidwHZTK9cNQC3a2zF/tamtsjXJlZeutUE5c93UzmS8avAiZ8XBaPY+l7h4FJV5hGETc+6p1wvuCRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728719392; c=relaxed/simple;
	bh=9DjgFM3D8DR7YUJqG9fBK+1NGwwMXI//GrXEOQqO88w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6SAW7KGpwFvEa0Lkah97Z3wc0GlXt6Z6uZtxmJmXwz6D8yyL3qiCgqaABSYlbrAbGiTD6GDFXYALrugQdrxO1Shw44whyeszeA55xreh1pgQw26AMFkusQGhOXF/uhO3BNxyGRdIFHusKk0DfdqbDtpmbaZt5UJKzlKPG31KKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZetIlvXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9A7C4CECF;
	Sat, 12 Oct 2024 07:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728719392;
	bh=9DjgFM3D8DR7YUJqG9fBK+1NGwwMXI//GrXEOQqO88w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZetIlvXaYsrDyXPUqQea91nvxD0lmnvWDVz630MlZ0C0E1MLZIG4RAP1VLZJ+CB/p
	 PguPoVwnX5FOmQWFAnn6GT1/GYeOh6vQ8FRUeOANpzqRSGVJrzpItm/KirrrY4BufV
	 qoLS22XOM6/L10NzrL42kFjvWKdPp/PGiPC4ktaBDV+lRdgPsGzA7bScTC1sh7cxA8
	 7/vhhzUJLK+zjC4N1ieY/Uz2ORU6sQnX4RKzH7D74NfMKFA1xNP9G8+DV9bW7vBUJO
	 ydeIniKlYhDR5Du9uS5AFle3K7nEnyuHeqkKpUcP0EapWqPwrXamPAV6QAX7bxP13h
	 puyEDEeyvsQ4A==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fac63abf63so27648841fa.1;
        Sat, 12 Oct 2024 00:49:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbE8s7sTAx9WndWwgQkAIT1Se5hfV1IFp7GXxt3xPFCarAV1FNG4gmPbhpPVEX2vEgylFktia/NRVYBuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCja3XcUN/nu67Ghk5baDTLjYCHMlghyYBpi/0s6BoMuX4QbJ
	Bhbb5YmOMLtcRU4Vn13AAIp7CDK5/b8SlUuWkXPvUWVCfWAa2EPqBb3XFMVn7iI3j9mtn6oBkIW
	CvzNkP/msItIPzJbtKso8kEiNrE0=
X-Google-Smtp-Source: AGHT+IEQy6OOQZyMyQaySXJkLTCYd9EK5JrrLjvJYSmizjL0UaSdbSORhiA1myxMpm6Fm++VXdGNubZSaSO7flwrh3I=
X-Received: by 2002:ac2:4e03:0:b0:536:553f:3ef9 with SMTP id
 2adb3069b0e04-539da4e0b9bmr2453944e87.27.1728719390320; Sat, 12 Oct 2024
 00:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011224812.25763-1-jonathan@marek.ca> <20241011224812.25763-2-jonathan@marek.ca>
In-Reply-To: <20241011224812.25763-2-jonathan@marek.ca>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 12 Oct 2024 09:49:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFK_4KGtyeyfRvhV1KtbQgE6sHiDWpOzq=xZKb34mn4ow@mail.gmail.com>
Message-ID: <CAMj1kXFK_4KGtyeyfRvhV1KtbQgE6sHiDWpOzq=xZKb34mn4ow@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi/libstub: remove uneccessary cmdline_size init/check
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-efi@vger.kernel.org, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Oct 2024 at 00:52, Jonathan Marek <jonathan@marek.ca> wrote:
>
> efi_convert_cmdline() always sets cmdline_size to at least 1 on success,
> so both the initialization to 0 and > 0 comparison are unecessary.
>

The intent is to avoid parsing the empty string, so arguably, we
should test for cmdline_size > 1 instead. But if we fix
efi_convert_cmdline() instead, as I proposed in reply to 1/3, I guess
we can drop this patch.


> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/firmware/efi/libstub/efi-stub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index 709ae2d41a632..f166614ef8432 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -112,7 +112,7 @@ static u32 get_supported_rt_services(void)
>
>  efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
>  {
> -       int cmdline_size = 0;
> +       int cmdline_size;
>         efi_status_t status;
>         char *cmdline;
>
> @@ -137,7 +137,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
>                 }
>         }
>
> -       if (!IS_ENABLED(CONFIG_CMDLINE_FORCE) && cmdline_size > 0) {
> +       if (!IS_ENABLED(CONFIG_CMDLINE_FORCE)) {
>                 status = efi_parse_options(cmdline);
>                 if (status != EFI_SUCCESS) {
>                         efi_err("Failed to parse options\n");
> --
> 2.45.1
>

