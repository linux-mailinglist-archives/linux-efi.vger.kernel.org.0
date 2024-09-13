Return-Path: <linux-efi+bounces-1719-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1199778CE
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 08:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09CB5B23149
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 06:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292021B9849;
	Fri, 13 Sep 2024 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5o8ga0h"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A3A224CF
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726208895; cv=none; b=ComGn7mjTa6uFJZNPgpTuUCPZmcoUD+K01QfJjGxA4ft6B05R0UYbIxrChFi7dk0OkAljOJDMT913LGwcwWRAZ8EA98gYBq+T11S7dafnZZpC1CZKP6cUsa82zhGjZ0ujIo0K2eFo0n2zFgmJJITdpjAdFoSc2TmPGMbjXAZqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726208895; c=relaxed/simple;
	bh=x/Az8mOIx6xCh9QaWyogQuSUaXizbzH8pdV2aJhLse0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxvYxlPy4RwUXrY9aHv5GevDQfIj1sgexqljD41XR30YnNx6H8jNHNP4GIKD8nKunvX9Y8WPrhJuNeuOIQKOxMbcP59ClDUMuNgEWNaW5H6Ds0kvSRNnrxImulGQvD9gGtnnyCnPbrajHPeAKxy2fz45oOWXW8V1fqSjTeeNhOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c5o8ga0h; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4fbe62bf5so325297a12.0
        for <linux-efi@vger.kernel.org>; Thu, 12 Sep 2024 23:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726208893; x=1726813693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+aurCislgZb8sZalAgSWWZjYMecXAeXVb8GYqztcliU=;
        b=c5o8ga0how06UFh+QCW1/SfHXXC3dq831sSk1dpM3omFmL4XchjihCtZ89kIQzgrfP
         HwKr4TV2pAOmH6jkR+xcmrQAmHu5m57wHVLdXonIoPO2KWcNSIvzCUsfkMeacZnEx5Nq
         UXySasbP6xjyAANkKacNc1NNfXKBlvr6bxbIkaPv15GYoKj/Wtsqgtb+Z9niBRVEl7lI
         TkJLh3TeJd9FO9OsBkKvTnWxk2aJ9WFf8SLYgn1fthFtvbPeBMg1NWyx6Ov8pKDEe68A
         DhC5N1JJ5jMlg/1cucoDh59g26ScvPiWZs0LzCDOqLV6IFKgXZKvo2zOrrnoNMSwmRJN
         0Lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726208893; x=1726813693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aurCislgZb8sZalAgSWWZjYMecXAeXVb8GYqztcliU=;
        b=uTvvO5U6Zf8K2EiNxe3GVyWF37e3IbWMbFnTgLOEVd9MAjPAH0zTejXhwLaYZn+Gmf
         xbBc5kewDSCWnyoxo3cFnQZXl9nOGbV0JXFIzbKaF7o0Dk9Dv7j6qfa+k8YbM+YmdlaB
         G16n9G0L8mIqemvdQi0NgpVMp2uQbPu6NeBgEQGn/DEd8qUXgnHnKknJ21aNcXJUzovm
         8HzAc8Eo96VOfYJ56wGtsUZyubUbpfA9fe0QTjYyzxpHhGJHxgY6PfbKrigVlsjBHc0E
         LrNTQSE4DtFsSgwS/Lc3BjColn9U0dISC/+F8ajnR0M8VriM5RJBCOb7MQdbRVZ4S1S9
         EQRw==
X-Gm-Message-State: AOJu0Yzlz0JpRVLKJO3XOboQeQxuprh8ZOyoX2jFREs6QHVAl7I139rc
	0c4F9pJqfCIxrMtXKbJmenrn5pI9Yt6CLfvwHO7dAd3jT7ds19y3RTX/YQ/Co9gLzZSXB1bAu6a
	r0iO6PrXoROTEan2UrPrQ3RM3RQ3WocgxLXrrSA==
X-Google-Smtp-Source: AGHT+IHZLlzD3eQuo84QD3nKDHwfqVrbh6iCWwwh4mJK8NL8ynrj7arJaVAk3bzgxxOkNZduZMot64FtEDU01bvcGnU=
X-Received: by 2002:a05:6a20:4394:b0:1cf:2988:c34c with SMTP id
 adf61e73a8af0-1d112db26e6mr2866959637.22.1726208892551; Thu, 12 Sep 2024
 23:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912155159.1951792-2-ardb+git@google.com>
In-Reply-To: <20240912155159.1951792-2-ardb+git@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Sep 2024 09:27:36 +0300
Message-ID: <CAC_iWj+0pXoRwUeGuuGXZJ-sFhtuxBFidyZJpAOB+Do4-PKXgQ@mail.gmail.com>
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org, 
	Breno Leitao <leitao@debian.org>, Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 18:52, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The TPM event log table is a Linux specific construct, where the data
> produced by the GetEventLog() boot service is cached in memory, and
> passed on to the OS using a EFI configuration table.

an EFI*

>
> The use of EFI_LOADER_DATA here results in the region being left
> unreserved in the E820 memory map constructed by the EFI stub, and this
> is the memory description that is passed on to the incoming kernel by
> kexec, which is therefore unaware that the region should be reserved.
>
> Even though the utility of the TPM2 event log after a kexec is
> questionable, any corruption might send the parsing code off into the
> weeds and crash the kernel. So let's use EFI_ACPI_RECLAIM_MEMORY
> instead, which is always treated as reserved by the E820 conversion
> logic.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: Breno Leitao <leitao@debian.org>
> Tested-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/tpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> index df3182f2e63a..1fd6823248ab 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
>         }
>
>         /* Allocate space for the logs and copy them. */
> -       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> +       status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
>                              sizeof(*log_tbl) + log_size, (void **)&log_tbl);
>
>         if (status != EFI_SUCCESS) {
> --
> 2.46.0.662.g92d0881bb0-goog
>
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

