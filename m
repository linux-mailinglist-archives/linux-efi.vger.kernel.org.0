Return-Path: <linux-efi+bounces-3650-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ECDAB0EE3
	for <lists+linux-efi@lfdr.de>; Fri,  9 May 2025 11:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED91C1888E4D
	for <lists+linux-efi@lfdr.de>; Fri,  9 May 2025 09:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5191021CA16;
	Fri,  9 May 2025 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlFBitMb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293C4223DD8;
	Fri,  9 May 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782672; cv=none; b=Dt1bDb4jUWk/yTU7LP9rOVzFgip35YTWvEj2Cltv+E+VN/DGLyibi7IBIhNM6SjU2JrE/+t2eFMSLZFLxxZDnf8D2B3MivVPDwPBGXIEZ4h8xZjhwbfxWm33PGJZTPTqDxaQD0jXDUAPPz/fdCb7II4YNAsowVw2Vskcr02FXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782672; c=relaxed/simple;
	bh=4DvKzVNoKVKyOtUHOXV9XYF3JlWsVbXzdNd8rdXpgSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUp1ROAT10pSAgYgfEgTtmEigHh86wgddv1/LTp/D5G/9EHNoQ6VFDSZbnP0hG87kgVTXBWOL4zML7qJJ5QiW+RXm1uOqw1xitKrLMx8aFnwHHpSFJfL3gugqdaUexxJeUbX/KOe86KNp0YTRvNYXej6eW0hZ/EvKvQUfPJuFRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlFBitMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9844AC4CEE4;
	Fri,  9 May 2025 09:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746782671;
	bh=4DvKzVNoKVKyOtUHOXV9XYF3JlWsVbXzdNd8rdXpgSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mlFBitMbw7RD/UeXl/ow9UyEoPhKxfNr7E+Qcz8GHrWwLo5V9pQQ0Rca+O3tKhp49
	 kzfLkRd2tQY9ozWrEB9ObXu0ohxyvjGHjOx1F2iL5GTJXRMFEjMYZWJf4PN5GrF7Ku
	 qLHacg0BTv+iKk3TbL7roTIomv+B5PoNpDwk2GspsjAuZkLaBTsSGFwGFSZM+dqlsW
	 0Vdjo+1CCYC/MLAd0s/ms38JkIiR1pJsT7VHYXDBSiGqPHC0uNxT5hLf8kncS7+Iaf
	 qz9NffudZi05hl802GTnurpno/cOTwqLOYdlySwlwLvuQunLW8GztxfSupDqI+4ly+
	 5lQQ1MGHDybww==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54e7967cf67so2335551e87.0;
        Fri, 09 May 2025 02:24:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVoAmPJ+RJrsRp1RLRRGfH4nVIcef8Rdf0oWuUSlpoNX13U70L0bvI30joSkfyV9WPF2qNxdD//rI1S+2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyea8p51z6L2mi1okwSfNUjCENk0q1LCxn71dicKdU0VN1IX9eK
	k3wjL64Ad/IHK5vzjVbHeOPbW+NFU/FpClLVyDrIk2TiPikJRpdqQ5Ffe7hxFfL6RQhAcSC+xKi
	vN45ZEBuCKtXWkABMC0Dv8kBa0og=
X-Google-Smtp-Source: AGHT+IH2xIVVqeXRqhoquiqWL+LJMXwlUYezxMp6DE9GB8BV2ZmzzRlgaZPndbpR5na3Zx2UGfhDDhVBfiz0QBWNEnw=
X-Received: by 2002:a05:6512:450a:b0:54f:bf5c:d4a9 with SMTP id
 2adb3069b0e04-54fc67e4756mr692930e87.37.1746782669990; Fri, 09 May 2025
 02:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506163111.272149-1-18255117159@163.com>
In-Reply-To: <20250506163111.272149-1-18255117159@163.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 9 May 2025 11:24:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGFJd=zsq6OD0M9b_RKyQAcT0kAhX-L3Bx4QaruHVCarQ@mail.gmail.com>
X-Gm-Features: ATxdqUEWrPqqYM9j9CvKqKUJYMdRd2ILzeDmI7kLWVwfUwDHBm5kwSjy7p2E_As
Message-ID: <CAMj1kXGFJd=zsq6OD0M9b_RKyQAcT0kAhX-L3Bx4QaruHVCarQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Describe missing 'out' parameter in efi_load_initrd
To: Hans Zhang <18255117159@163.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hans.zhang@cixtech.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 18:31, Hans Zhang <18255117159@163.com> wrote:
>
> The function efi_load_initrd() had a documentation warning due to
> the missing description for the 'out' parameter. Add the parameter
> description to the kernel-doc comment to resolve the warning and
> improve API documentation.
>
> Fixes the following compiler warning:
> drivers/firmware/efi/libstub/efi-stub-helper.c:611: warning: Function parameter or struct member 'out' not described in 'efi_load_initrd'
>
> Fixes: f4dc7fffa987 ("efi: libstub: unify initrd loading between architectures")
> Signed-off-by: Hans Zhang <18255117159@163.com>

Queued in efi/next - thanks.

> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index fd6dc790c5a8..7aa2f9ad2935 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -601,6 +601,7 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
>   * @image:     EFI loaded image protocol
>   * @soft_limit:        preferred address for loading the initrd
>   * @hard_limit:        upper limit address for loading the initrd
> + * @out:       pointer to store the address of the initrd table
>   *
>   * Return:     status code
>   */
>
> base-commit: 01f95500a162fca88cefab9ed64ceded5afabc12
> --
> 2.25.1
>

