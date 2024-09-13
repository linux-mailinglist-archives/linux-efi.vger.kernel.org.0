Return-Path: <linux-efi+bounces-1722-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F8B977913
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 09:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB080B23263
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 07:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28704185B7D;
	Fri, 13 Sep 2024 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0qN/Puc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6D9142E9F
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726210995; cv=none; b=H/A5dxxQzekRzYnY5zuDz8yx2F4nLfDgDBqG5H0MmFDLfxYdojQRYshX8k34NohiTQOOWKFII39NEKFbAEnAFMrBpdvkKJp2sZCXSzBckfF4M909Sg6QxvOLZgobBgqvPTv6Q/PuECrO0H/pCZvFMvcwvSVvXhiLGY4BjO07n1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726210995; c=relaxed/simple;
	bh=Pcxc+EYTY/Zox/ijAp5jY27pQLDu+ZiYXpSY++OkQ/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5dlyuGAAHHKMP7Kj2/xKjD7wXscpOswG2eR4XgMNOUa92tTk+g7QYGdIrRL3Ox7xrQa4d0OTVWQdCcK245hGkNExm168B95/BhsXA//3uJcKeoFrQtpWm4yKrq+xRbKAkELAqoPQ9NETH6IVAzCHfo6MsGJ9DRO/HKkIBUkI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s0qN/Puc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-719232ade93so540498b3a.2
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726210993; x=1726815793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j5e2APrvIr0iBdhPUANMRU+/4M8viwko7EsgvUm5WX0=;
        b=s0qN/Puc8JdEXh7vGiJaPN10UqXa7b/3VwovD9Dny+jak+GaXN0YlQytIyV3101qmk
         qZLAmumL/FFDcAwT2NLthbBE+rSbVXAaNJYE6+oLawdfSnWLNCB2k8GdrX47MGdzWfAp
         re5IN8HBZkwoO81zqptan5NHoURmwwwHAcjwUeKDyvyVqQ6U22bngJo+cAKMpybTMxfg
         0NBjlZPSKM1wrN2PCavkx0w9BaCvbXhtMLBxn7ImSIOm+8pH1t1WeQJ6HhPtWMPHdhxc
         130jfiUh4qvzLj/NyklAkPi6ELoXLnxneR5q+ZwxKpwJW5pEkeuck1bCLNA6106sVcxh
         IrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726210993; x=1726815793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5e2APrvIr0iBdhPUANMRU+/4M8viwko7EsgvUm5WX0=;
        b=Daowcr4w6ljvl6j/bOa4gA1XCZYfYXaD8sc6vQhLMAedbBq/ebODxMj2RJnRppe6j6
         5W9tGeZRLn0989OmJ20K8J7rYXMhA4MnsccRtqG7+AyGKrKv8uwIZgTOB/PJ0i6YcU6O
         b4SA8V+fSwXNpsLsrOhUP2DmS5oEpjgJQzpKxyBSpWaUhR7XdwGvgFkFz7HKGqsO3MK6
         TenUKIepSojXap4iYe/nCc7jpWMdAOIAvqw16u5mqLHaTNkT74Kp4Y1PDj3GQxBYKcU2
         7Nupt2gYk1A3cfKrIkyIk83BkJiHc98CLR42vNMkwDH8hKHLx029F/OGic83/3IHgulP
         lUmA==
X-Gm-Message-State: AOJu0YxqovE1hOR+bZfWQ1Lmj64P0BB5kTYEo6afxcZm9cfW+r6yKeSR
	Wxz7cqGm2MxU1f8OECY5f+ODVa+8wtoje4ntKyxAr9Juf+kqT/q0ROf6GUP9So7sbeR08APRR1t
	tR8F38W9Z64qLI6nX52dHV6CdxBTpyJ0+QBiqd5KzbwInmWsV
X-Google-Smtp-Source: AGHT+IFhKBfHCLTcdF96fnJQ8ermuXuYfnTgJ0TMseCuYjTqXM+6WuATSh9HMOgGDabIf59nSEaJTHpjDm3iEFsC3hU=
X-Received: by 2002:a05:6a00:2d17:b0:717:9483:5887 with SMTP id
 d2e1a72fcca58-71936a4b6a0mr2799151b3a.8.1726210992805; Fri, 13 Sep 2024
 00:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906202745.11159-1-gourry@gourry.net> <20240906202745.11159-3-gourry@gourry.net>
In-Reply-To: <20240906202745.11159-3-gourry@gourry.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Sep 2024 10:02:32 +0300
Message-ID: <CAC_iWjK6EXf1g-CwBALTFmhhnRJaHcrdCS787aDDksdhSJxJTA@mail.gmail.com>
Subject: Re: [PATCH 2/6] tpm: do not ignore memblock_reserve return value
To: Gregory Price <gourry@gourry.net>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, ardb@kernel.org, 
	leitao@debian.org, usamaarif642@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Gregory,

On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
>
> tpm code currently ignores a relevant failure case silently.
> Add an error to make this failure non-silent.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/firmware/efi/tpm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 9c3613e6af15..6e03eed0dc6f 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -61,7 +61,11 @@ int __init efi_tpm_eventlog_init(void)
>         }
>
>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> -       memblock_reserve(efi.tpm_log, tbl_size);
> +       if (memblock_reserve(efi.tpm_log, tbl_size)) {
> +               pr_err("TPM Event Log memblock reserve fails (0x%lx, 0x%x)\n",
> +                      efi.tpm_log, tbl_size);
> +               goto out;
> +       }

ret is going to be 0 here. I haven't followed the rest of the code and
where this function is used, but you probably need to return -ENOMEM

Thanks
/Ilias
>
>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>                 pr_info("TPM Final Events table not present\n");
> --
> 2.43.0
>

