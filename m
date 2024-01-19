Return-Path: <linux-efi+bounces-420-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A9D832913
	for <lists+linux-efi@lfdr.de>; Fri, 19 Jan 2024 12:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2A01F22502
	for <lists+linux-efi@lfdr.de>; Fri, 19 Jan 2024 11:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F94EB27;
	Fri, 19 Jan 2024 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtfLfUcg"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C983C486;
	Fri, 19 Jan 2024 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705664558; cv=none; b=LLc2jaa7/bdHYTP92HJyfe2e6PMZLTshbWhBi6S+3eO4bpwuUJvG38RWXfpbLElRs0QCDPAaBzyOAOBDdWLEPzNdHNDFUA+aIHY+fYX1N51S8/wpMib0/2Ft9QcwtOkf9zoPiTaKN5SoSwnnyX8vwtYKkQKO3iSD1SvgG8uCPvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705664558; c=relaxed/simple;
	bh=LC9COPXQo2VIEyQXnhD9uXez/gy3eKAmfhHuEx89nQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRm1IHVCIHzufgY0LuNm8BJWnvAmVsBx4JZNFMp+vNckQigVk48Eus22gOEhjfVKwjqqkiIUpA2hZhxDb0v/+pHAofpAUZx2/yRD2Atn78g2DpVFE3oBeyKeP9OqoGVe97FWTQIvDch77RhFvFclTHzZtKLIv/cRLaOGQfoxKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtfLfUcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBDBC433C7;
	Fri, 19 Jan 2024 11:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705664558;
	bh=LC9COPXQo2VIEyQXnhD9uXez/gy3eKAmfhHuEx89nQU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DtfLfUcg0p8Gg1qJ+XZdJTCe3+0A67GF4OJfJCBegbnsCCk6kC4jcj2DAtF+vAN6Y
	 l16iqgFCxXCINnmjHHox/1h6a6JEQPP+rKLwGh23MvQeZd7ejZ8dydVlz6A6eVTt/O
	 Eo+Hs4U7eKuZGnjQCVmhLcpK1Kfj3eq4aP+9lJIR3ByAAHzYltoqtR+ogCHiYlLqlq
	 BMcVep+ZFdPeqJCuSrVH3nIxQWgZsxtmuJyesT9y9ZjhrNtf3eK+w/04lRJ4WKCNZJ
	 vOX8R4qSows/X9XiCLu2CIgCtXy4uD2W5bN5Uqfo5NyMiFPCiGnMy9wlqWT4ipcfJk
	 5rPH4t7mg14gw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cdae52d355so6503671fa.2;
        Fri, 19 Jan 2024 03:42:38 -0800 (PST)
X-Gm-Message-State: AOJu0YyJbV5ymMZFEEFo8c1oW+n1JPKWdbbAVHpQnqPaz3kt3SQjc35t
	ahCb7ejoYX6dvcCRNH1NkTe0WefYMiiJQ1FePhOZao6+tGjdR0QWHgHl7Y+Z27LtQ5XUsrt/pzc
	mbMwNFveR2vYfg6ShMTVLa0n9N7w=
X-Google-Smtp-Source: AGHT+IFKsuEjMZk6Jd5v6V2D44ibCGIvPNx7v2vxnA1wTx8x71FAIDINQVSliMTeTGGqKLWZI73KivT1NnJtDeRsqak=
X-Received: by 2002:a05:651c:c8b:b0:2cd:fa5f:d7b7 with SMTP id
 bz11-20020a05651c0c8b00b002cdfa5fd7b7mr1404652ljb.79.1705664556417; Fri, 19
 Jan 2024 03:42:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119100635.12333-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20240119100635.12333-1-yang.lee@linux.alibaba.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 19 Jan 2024 12:42:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEZ3M-RM7i=KkMp8YnDYmamdpZr+MjdHnR2HuNXUYC4KQ@mail.gmail.com>
Message-ID: <CAMj1kXEZ3M-RM7i=KkMp8YnDYmamdpZr+MjdHnR2HuNXUYC4KQ@mail.gmail.com>
Subject: Re: [PATCH -next] efi/libstub: Add one kernel-doc comment
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 11:06, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Add the description of @memory_type to silence the warning:
> drivers/firmware/efi/libstub/alignedmem.c:27: warning: Function parameter or struct member 'memory_type' not described in 'efi_allocate_pages_aligned'
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/firmware/efi/libstub/alignedmem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
> index 6b83c492c3b8..8ff51c6a2aa1 100644
> --- a/drivers/firmware/efi/libstub/alignedmem.c
> +++ b/drivers/firmware/efi/libstub/alignedmem.c
> @@ -14,6 +14,7 @@
>   * @max:       the address that the last allocated memory page shall not
>   *             exceed
>   * @align:     minimum alignment of the base of the allocation
> + * @memory_type: the type of memory to allocate, as defined by efi_memory_type

What is 'efi_memory_type'?

>   *
>   * Allocate pages as EFI_LOADER_DATA. The allocated pages are aligned according
>   * to @align, which should be >= EFI_ALLOC_ALIGN. The last allocated page will
> --
> 2.20.1.7.g153144c
>

