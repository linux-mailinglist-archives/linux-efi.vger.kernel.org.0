Return-Path: <linux-efi+bounces-5461-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21701C4C75C
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 09:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AB61885C11
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 08:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B68528CF49;
	Tue, 11 Nov 2025 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tqL0h8i4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42EF1F4CB3
	for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851049; cv=none; b=hnnKFqr32R+Pwq+O1057dHiHX9pQEnKhp1GF4TRRiaca1yp3IJuWodwAVhqPgLRIEJeOeEnnN/ya1aDH3ldKcr0X6ymdFwWPVt3xqMT9eHZaADtAiRK+LMOMS2OQisHuUr7aB+VnEf+xE7y0uu+dZ9wT16GEXW8xpbbkTx6/dUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851049; c=relaxed/simple;
	bh=8oJn+F4gp9gQnMSYljsNjq92hs5GdiNacc4G8cz3Ttc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gmBkb6gKlkNX7iBcfhD9LYCGTUIm/XKGqSusSdos18pGtuG79XCaq/daf2sEYqSGShVcuXJVsZD+JarNBloRzsyuz3LrH5DLZ0AhBEkEK9u1OA9fAcwYTNuXqSNrDyRy4+FoYuDLiAm0yky2+BeK1/NTvueZVqe1kFVmCS9/NtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tqL0h8i4; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-786a822e73aso42815237b3.3
        for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 00:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762851046; x=1763455846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y46zxO1C4o8WUqtj07jqBENmFGWJWEsozuquXurmpj0=;
        b=tqL0h8i47+3vNbr4bq5tJ31fevP/CsLBYDF8QPX//Iim+eY3KEoU8YJTl9vTjt3K2Y
         9yOa9dsob875C3OYFS5OtTtYC0tYuH+nubgloz4kdPpi/DyF6DGjR1hf9e06gz59Imfb
         mu9iYtvmxZw/iQJMHk7VPRwAByZgu9QaAvnVsUKVOjhRBBqJX9Xr8i5vSQ4ijibHYAIj
         +6CxyOC0e8OoZOLh487Nxno6ftvK9WIsQZzTwwgtP6kyPU5/kYAVm9UBM72YTbqq3hkZ
         wXNIqZtM5hxoiSzR6tbzbhcQyPkpfAEBgq2/aRXCghHjnMCnCDFCoBYFomxtGh+P+gWl
         kRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762851046; x=1763455846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y46zxO1C4o8WUqtj07jqBENmFGWJWEsozuquXurmpj0=;
        b=d59Vx0AVYTp41EtBgAwbN40o1zwCX+4Lgj1tPUENRnTiBTYe7fyi6ycPWJiVZUw00E
         8c6B8n2+rR2tStif1H7bECuh2csiLzY/4+9niacW6BEKD8J++CRAeRqlMz3QyXrfiP7I
         Q11vM4ra3nLRhMevS3i6vJLl8BlL9k4dIXv3t79tGUMot3sKd6hZaCWioXwLHc7yMzq7
         0SEFPXQu7dltdNK+0oq+89gHlyB864HsM6n4ljqJuaFbTyNTZ3aIfPxjH4fgHa1kfsrT
         DRRKa0q9joFsYrdF9xoicJ46EZ3ZoLM+9iIwRJ7e5hX6UD3IgIGEbzOSCNa9Lz9Z283+
         b6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCV4OFPYWHD+g7uaMLuf0mJA6mq1xEmIPY4BoDXLI+c/oryg+T8LRYH35dILT6O0uGAEMIyyHj9dKHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAt6vRK4rPoQukaHwUULQrIXCNiqu4ysEkG2I5C71NkQrpKfHr
	kqLHVUX/YuW9BTkvjUB05HtyvfZtsnkDyuE+1rn4v3VsdldChLcuJxOmXkf8eSnuFYzv3LLhQ4e
	26veuG6EwfdxtdDWVzKVXVGNBgTkx5g9KQtDwdoAHYg==
X-Gm-Gg: ASbGnctf20G9Gz3vXGYSyEe2eZNTuTQ49fy0wC4BSnpJyhhEBLzOfCVgO4q9W9WjB7U
	ZlCOl4OJgRdB9/KCHvKBEXfiEAmwQA35HK+ynMrc51LK3wJTc+YFswifuQbQsQ0Gaoccq79J5ah
	jZ96S30UXehF5gcV+joSisop6Fl60kxm6HCJ0VA/H4LA3PDDh7JgWH4CAGqMpwIBxRj4BbBz3P0
	ndHF3MxaBGRuV/x84JPuPIzLEzcnNK8HjJT/nSPOF7Ca59mw+Bwg++jy/H4x5Z6PhwoXwuB0+Zn
	cRQOlzhy356nn+KgPoTYtn4NOqzZCpvXv2mUmfPj
X-Google-Smtp-Source: AGHT+IFW04NMmm/DmGXKuNoocNXOW1P5E9RSrXkBfL6e/iKOHrJptvsyGLLUH1wJ5OdOEoN0Uvp2X+BW0+RpDBRk76Y=
X-Received: by 2002:a05:690c:688b:b0:788:c74:d038 with SMTP id
 00721157ae682-7880c74da71mr3427737b3.39.1762851045790; Tue, 11 Nov 2025
 00:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111060212.1963608-1-rdunlap@infradead.org>
In-Reply-To: <20251111060212.1963608-1-rdunlap@infradead.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Nov 2025 10:50:09 +0200
X-Gm-Features: AWmQ_bl9LggH2BnIOi8b_6HMwtRDi2PxmqidNChtL-tYmJN-Isc3DYSw2FH9LTs
Message-ID: <CAC_iWjKYBgjG=C7NgAFwn6uBSMS0t_WepazvcTQb-gPewL9ckw@mail.gmail.com>
Subject: Re: [PATCH] efi: stmm: fix kernel-doc "bad line" warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"

Hi Randy

On Tue, 11 Nov 2025 at 08:02, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Add a beginning " *" to each line to avoid kernel-doc warnings:
>
> Warning: drivers/firmware/efi/stmm/mm_communication.h:34 bad line:
> Warning: drivers/firmware/efi/stmm/mm_communication.h:113 bad line:
> Warning: drivers/firmware/efi/stmm/mm_communication.h:130 bad line:
>
> Fixes: c44b6be62e8d ("efi: Add tee-based EFI variable driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Is the fixes tag necessary here?
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks
/Ilias
> ---
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> ---
>  drivers/firmware/efi/stmm/mm_communication.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- linux-next-20251107.orig/drivers/firmware/efi/stmm/mm_communication.h
> +++ linux-next-20251107/drivers/firmware/efi/stmm/mm_communication.h
> @@ -32,7 +32,7 @@
>
>  /**
>   * struct efi_mm_communicate_header - Header used for SMM variable communication
> -
> + *
>   * @header_guid:  header use for disambiguation of content
>   * @message_len:  length of the message. Does not include the size of the
>   *                header
> @@ -111,7 +111,7 @@ struct efi_mm_communicate_header {
>
>  /**
>   * struct smm_variable_communicate_header - Used for SMM variable communication
> -
> + *
>   * @function:     function to call in Smm.
>   * @ret_status:   return status
>   * @data:         payload
> @@ -128,7 +128,7 @@ struct smm_variable_communicate_header {
>  /**
>   * struct smm_variable_access - Used to communicate with StMM by
>   *                              SetVariable and GetVariable.
> -
> + *
>   * @guid:         vendor GUID
>   * @data_size:    size of EFI variable data
>   * @name_size:    size of EFI name
>

