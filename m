Return-Path: <linux-efi+bounces-1632-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3452C966B4F
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 23:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6681A1C21E0E
	for <lists+linux-efi@lfdr.de>; Fri, 30 Aug 2024 21:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D3416DC34;
	Fri, 30 Aug 2024 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpqsT6Fq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F034165EEE;
	Fri, 30 Aug 2024 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725053606; cv=none; b=O2szaRj2JelQyMnBcplQetq7e5GiNVu9NLYSMN9ja4A2xFPadzCSsQSg4z4xAX5lDcoJ42xlPLN9nM3M3Vd+PVvBLLQwjOSgjj2wnBcmPqCBIVW7v3zWq1/IMorH5IFYEYUojeIdW2lb3R+38ci6fLcOXM8AHb2O7vU2/bbsx2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725053606; c=relaxed/simple;
	bh=3hHh6QkwjX+ddtDXWIk8bS3LNqXLHCDM+UQ5tkrH/04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZoAQ2C9CSZnn3TeVATs8+iKqJIjzFHsVKj5w8A4DfY24C1o+MnEIDGxwp6V/5mr7+ev/0k8JEhUZLrLBD4CpqO37zkqcKAzL3VNxaBCfWpgzaXttuk8c79kSWOeowsQH0D3Zgwhi7fDBbOnA/L9Y3MXZswyAI9bOSMA6F4/MZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpqsT6Fq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42c7856ed66so919695e9.3;
        Fri, 30 Aug 2024 14:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725053604; x=1725658404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nES7xIJBc8m6VU/Qr8ew7rkXFFCnkrcppk+/bV6qTG0=;
        b=IpqsT6FqXoFIOco7n911zkOtlAjC+bXFrX0NXwN92jLY+2P6iK2G1uLdfpE+e99U/w
         5lmQ2nkBB+xrk7aKM0IOTb5UoSlp8cmwW3uYhuE9O9NZjYUDTRCaSZPdlUOwZy4Mcm2U
         QTsV+q5R2ra/0kDPQtFVJmmVgQqsCjRNBkO43ddcyTN5FVwr1pwV/441HNe0zRqNIgMC
         TyGyn4UpiHBpgcNNYb1zKmj9Zl/LGS4EhDGmHxtbS67J3CevGvgNBVxrb+QU1/LX6SD5
         FscJCNn2NAR+o4CcK1TurW/C1XE2l/pk33QjCkpNnfM+N8Z52qPw/V2seklVEP4n1RAo
         r4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725053604; x=1725658404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nES7xIJBc8m6VU/Qr8ew7rkXFFCnkrcppk+/bV6qTG0=;
        b=cO2qMVYQ9QQnZWzD+rQ0LrVWXxIcksVvM4IMsxhh23dFTObhLRFJ1DdHdEypNLy+0w
         paz2rzcVVJZeiZwByW+W4Nrs8kNhV2od+u0FYjmTERADtqAIoyO74oFMrVO87C76qgXq
         Y4fw2tbN3J+0sMPdSp6devzVKQrsQrTfTzjG3M40UtlPPwyhm6gyQ0a0aZ1g+vvaQ569
         qb7R3bqT+xhWfsHEHRwQIqQjvnqJFZRUS+q1fNhdGIPPJj4iK2ELth3VrTul4ZNi/LNO
         uhYHbBzKTXak0LzT1TTcLM+U4vmZPIc99OXt6I6C95CgXJ0Cw415iX5jyLYTOUkdrYhJ
         OJ/A==
X-Forwarded-Encrypted: i=1; AJvYcCXZlw341lUaOw6LQ2uI9zh3K+Qo4ldcRbNW92ugQ5cQuwpM/3MR1qHpNPOf3dDHpW6+5P3K0uvHDU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9woodvm7nxeYFFMf5KJXK2bUZ3kH78ba1jxAp+vXq22cCeYg
	mSY8ItinpSsYOokKtff/vA0lipko0oIO8ai8jNkQN1k+Y0/LzpcHxIaTdYGb
X-Google-Smtp-Source: AGHT+IEm/sX0ynE48i0egEp37W8hSbgFLtHGas9MHJUWTwbU+YcLNCyj8lF77xGp2rt1DRdOFszUXQ==
X-Received: by 2002:a05:600c:3d9a:b0:426:63ff:f763 with SMTP id 5b1f17b1804b1-42bb27bdffemr51771935e9.36.1725053602995;
        Fri, 30 Aug 2024 14:33:22 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:7600:c5:51ce:2b5:970b? ([2a02:6b6f:e750:7600:c5:51ce:2b5:970b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639687csm90360475e9.8.2024.08.30.14.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 14:33:22 -0700 (PDT)
Message-ID: <3f79211f-f82c-4e41-9b40-e0abcbb4bdf0@gmail.com>
Date: Fri, 30 Aug 2024 22:33:22 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tpm: do not ignore memblock_reserve return value
To: Gregory Price <gourry@gourry.net>, linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ardb@kernel.org
References: <20240830132303.6665-1-gourry@gourry.net>
 <20240830132303.6665-2-gourry@gourry.net>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240830132303.6665-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/08/2024 09:23, Gregory Price wrote:
> tpm code currently ignores a relevant failure case silently.
> Add an error to make this failure non-silent.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/firmware/efi/tpm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 9c3613e6af15..b6939a6d44d9 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -61,7 +61,11 @@ int __init efi_tpm_eventlog_init(void)
>  	}
>  
>  	tbl_size = sizeof(*log_tbl) + log_tbl->size;
> -	memblock_reserve(efi.tpm_log, tbl_size);
> +	if (memblock_reserve(efi.tpm_log, tbl_size)) {
> +		pr_err("TPM Event Log memblock reserve fails 0x%lx - %x\n",
> +		       efi.tpm_log, tbl_size);
> +		goto out;
> +	}
>  
>  	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>  		pr_info("TPM Final Events table not present\n");

This was not a proper fix for the issue, sent a bit quickly!

I have sent it here https://lore.kernel.org/all/20240830212852.2794145-1-usamaarif642@gmail.com/


