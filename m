Return-Path: <linux-efi+bounces-1741-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 532CC97827F
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 16:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23B61F24FF8
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 14:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C10DB672;
	Fri, 13 Sep 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt74ZlSY"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B29945A
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237580; cv=none; b=s4mS+/7+seqG+xPHkv2ZnE8vuxDrc3DuEHx2l820DG2gl/s3izc3wb1xKWbUbfKscZigbNrRhtOcqPAwLr+Mij3yQ0jaJ/OzVqm24g0cigNWwutGYlVGiP9sAGU6eogqCMqs8CBTzNAKN+5p0LhxqIC53Bh+cmo3VxVnxyBYK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237580; c=relaxed/simple;
	bh=CMJLpX2CQmomFs8KMX/CRJvr7eP6glcQiSfHOW3HvZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmX5VdDCfXqWfLOEGV8/zrUvmfacU9EbH1UJA2XEhOgYw8WfqZ10JVsrJRHB5MN0yokuuREPPkbRgbrf9VX0zDVsSEx6EDnpC0hlTqFfl9CeaVsO9+1sdeF4gEAU2er6Hrbf8zYAYtJ+Lz9DeIyyBLvBDW1Gi8a3vlb7zVfN63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt74ZlSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A104C4CEC5
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 14:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726237579;
	bh=CMJLpX2CQmomFs8KMX/CRJvr7eP6glcQiSfHOW3HvZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yt74ZlSYH0/hH5jGdxeg17mfy/Dkw6lF1BDSfPDdTyrgJrmjNkUpg0gIUXHUxFQWz
	 fL9P3qJVtw1M9ICBHKAypuxlMSO5W+ImExfBhlGWryH+vgWbg0q48LiEXEhVuN14kb
	 Tjs3dyi6T4w7njKkiqnd6w0SLSTIDiPR0decae+Op05qfDdBsXerEK7IUftabx0gE/
	 6NzNgNF/Q4Nn7VwNYuhm3BoHXk/Td2C7qpFyQ3kfw8HAoFq7xMbgg0gh4HTHxcDUWb
	 A9wY8hMh+i89r5enb9mzVZfpo0+xcv7Rwgnn/Tcl+IcJN4zgiZHVp7BzrYl+5rx3S/
	 Yj6B4PRjphIbg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f7502f09fdso16521901fa.1
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 07:26:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YwFZnBeKxP47nAQpVqMh/BZFD/ICmTy3p7i+p808VlRZHR+ofhW
	fdKRoRUKWzCTcqW8IwFfKy/nDKYnqzzcSbegbIjRB9ff6KnkuAMlsUZeZlyeupivjHL/YEDBP3s
	2TsoemSUavg2d+F8b2gu7f4YXYQw=
X-Google-Smtp-Source: AGHT+IHrDYm6ljZl4roveu8opIijmr1gyVjfty+Y9HAZCLLuZPWOQxiuLfli5Dl8yjZgJs4HB/4EaZFM5y9a+ZhIBCk=
X-Received: by 2002:a05:651c:881:b0:2ef:5d1d:e68c with SMTP id
 38308e7fff4ca-2f7749ea04fmr50576851fa.13.1726237577888; Fri, 13 Sep 2024
 07:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903144115.2005448-1-lizetao1@huawei.com>
In-Reply-To: <20240903144115.2005448-1-lizetao1@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 13 Sep 2024 16:26:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEG_5cgDj3Cbb1svRrZB8S_FrtMJQnFP+X2Jah2hor41g@mail.gmail.com>
Message-ID: <CAMj1kXEG_5cgDj3Cbb1svRrZB8S_FrtMJQnFP+X2Jah2hor41g@mail.gmail.com>
Subject: Re: [PATCH -next] efi: Remove redundant null pointer checks in efi_debugfs_init()
To: Li Zetao <lizetao1@huawei.com>
Cc: linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 16:32, Li Zetao <lizetao1@huawei.com> wrote:
>
> Since the debugfs_create_dir() never returns a null pointer, checking
> the return value for a null pointer is redundant, and using IS_ERR is
> safe enough.
>
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/firmware/efi/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index fdf07dd6f459..70490bf2697b 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -349,7 +349,7 @@ static void __init efi_debugfs_init(void)
>         int i = 0;
>
>         efi_debugfs = debugfs_create_dir("efi", NULL);
> -       if (IS_ERR_OR_NULL(efi_debugfs))
> +       if (IS_ERR(efi_debugfs))
>                 return;
>
>         for_each_efi_memory_desc(md) {

Queued in efi/next

Thanks,

