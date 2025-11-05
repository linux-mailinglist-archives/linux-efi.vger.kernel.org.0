Return-Path: <linux-efi+bounces-5351-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE301C34850
	for <lists+linux-efi@lfdr.de>; Wed, 05 Nov 2025 09:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48A004E6ED4
	for <lists+linux-efi@lfdr.de>; Wed,  5 Nov 2025 08:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEA32D6E6A;
	Wed,  5 Nov 2025 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="cU/PL7RK"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9AF262FC0
	for <linux-efi@vger.kernel.org>; Wed,  5 Nov 2025 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332121; cv=none; b=HFcA+zmjXKVL09u6zdGgMUzdA8vCh0XcIlxltEK3csiTSe03xtGUiQKMayjI6Otqu2HPUHA7Nu13NzogtJTsptCJq5YxdMsnWURoyvgCu5s5YueHWhk88h/iF/QsOm2b/GtqiKhFrikroymtL21eMX481HTyqcH7RyKpepSk1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332121; c=relaxed/simple;
	bh=lycGLt/AmYhVMaxxlc2sFqXsptoJSH+28KSwY6rR74o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IR2LgYDBlm+DPzh/R7isL16AEgoukIcuxjCv9mEsa5LlX2y57yzSGjfeKz9LQjUuCkaE+vhjUAEBkG1HfKdMDA4aOVkbpXPkSqbmIFzSdQ68pbT4cOiWi2t0SttlFC6TZ6BRf1rWEl77fSosE7MzJanl3rcO9tI8XlfGcSUMmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=cU/PL7RK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2955805b7acso5807475ad.1
        for <linux-efi@vger.kernel.org>; Wed, 05 Nov 2025 00:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762332118; x=1762936918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUkopRdeDHdh9AWy0RMXnD+iemi5ZwANhUDqA8Z7pVY=;
        b=cU/PL7RKSR1tV5ZDsvSmMjojGUYiW1PGAZi8ZuBRs3hY3MqfiktLZKApdk79+Nw6c6
         +u84uc4YZbzgT0Fq4EF4yMmEm2klAoaNPE9tw/uNt9ONJ3X4zV2DimOJ7C/R2ALDVZk/
         Os2W39mDqB7QtMJezrRXz/CJhYOPo4HbZvXraFQuXN8N2E6VFj8XsVvSShE9drleVqYr
         BHUpCGby8BKjLY117vQ0bWnI9qj/nkl0+bWIDfIZv27NsT4HeeGNQNJW0GLTx2ZSCIK/
         f3RYBhTWvWpBLOhQ9LlqJFzdCYILKH50OXc1uJVV3s5qXTj7hD/NT3zrsHgKXxTzeTn3
         givA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332118; x=1762936918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUkopRdeDHdh9AWy0RMXnD+iemi5ZwANhUDqA8Z7pVY=;
        b=HwJ/vJYF6C+yWTWk/qcZu18Tl0bXZWE6++nqVd65Q9X0GWuFaJXjf/tk8+13BRLBar
         2zLVzfxZHU0rvGZPL9FaGU/s1LocASMZ78cwvAECB6NR3O3pgYDU8uNduOCPDqPLU3XU
         wfBXLS9TclbOhHkRd3IDy0kkK5Gm/DQ2PR1ea4/rP5TXROSon3v+mYrNRaTWewZvaBXJ
         /hIv8D8drp8OWFAZ95b9qssdVYZUxclD9sfRXaJh9gTtdj7/JvUYq0rlx6hGt4hIXMu/
         YqirW/Rk8CFgNSsRlgVGK5//DwZ0WkNt4i5PxKuLK4zrwBNyh91QuU1sNnFNWlybC3a/
         8Pww==
X-Forwarded-Encrypted: i=1; AJvYcCVUjOGCU7tTM8DGC/66BgEoga2A2rhMXFEto1usKs07IDt1HMj5f3jsC8dXF2CjsQWg7kJrtDMOZnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzok36qjyTRpyfYHJaLXzwqNHHsmzYxnXzk20W91iMJZ3wqSyhT
	PUKLtDKMHcOK7ujUdVf+ghtulR2GCv4OuJrq/RvN4UcJ+2qyWGFAvy4YBYMqgGExyUw=
X-Gm-Gg: ASbGncuMYAtAaKddefrxWo7pTgCawQ6MYDMRxgQYw4AYP46brCW5YYgfTdUkzK54aAJ
	BU49L5K2VJGDDVhrwVUdApRu8QcI73xiZueDquOjoZyLeQBD+KB3ddUTaNkXCSqVVnOZi6KEVvF
	eIpp6RJaA8+aWXVkFuEoBKhYStVf5qsO7De7fpqvHELNjQa44ih2dd7WhvaOvN6zEZ12t9g5CZB
	7hUXMBdqIVdCxPSawOkrgUf/rMsaTzOEYOKxVJq1VP4LhEeR+EnS3Jb54WmmS/6RoOGjfl7P90N
	m79lo2O7CdQWrRCNgaB52XMsx+xk5onIt/aDrg+JF/yV+7Ak0ghkjBJRgOdB2OLa9ZL0OKI3Jpr
	U5NX9W7q+vM0D8tVSIY24ZVaFJK7lc2hFcxI4sody0K9jnMle/WNtKQC6DOFXN7jlhCWENe0kvr
	auh9/36oT03EUPHbAcd+XVlxHy7WfIhCnlPRLd6LBs79Cdmg==
X-Google-Smtp-Source: AGHT+IH5fMD1INFs9eEGKYVtBDuuIJ1FKf0Z38BpsziCkXGqBqC8vDLl4i3lj3Io8I0ea2eccHNQTg==
X-Received: by 2002:a17:902:d48c:b0:24b:270e:56d4 with SMTP id d9443c01a7336-2962ad0fba0mr32538305ad.4.1762332118155;
        Wed, 05 Nov 2025 00:41:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a9fsm52542895ad.20.2025.11.05.00.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 00:41:57 -0800 (PST)
Message-ID: <913ad5f8-89cf-475f-8ab4-3fa5e21d2941@rivosinc.com>
Date: Wed, 5 Nov 2025 09:41:46 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/10] riscv: Add fixmap indices for GHES IRQ and
 SSE contexts
To: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, lenb@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
 robert.moore@intel.com, sunilvl@ventanamicro.com, apatel@ventanamicro.com
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
 <20251029112649.3811657-5-hchauhan@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20251029112649.3811657-5-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/29/25 12:26, Himanshu Chauhan wrote:
> GHES error handling requires fixmap entries for IRQ notifications.
> Add fixmap indices for IRQ, SSE Low and High priority notifications.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  arch/riscv/include/asm/fixmap.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 0a55099bb734..e874fd952286 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -38,6 +38,14 @@ enum fixed_addresses {
>  	FIX_TEXT_POKE0,
>  	FIX_EARLYCON_MEM_BASE,
>  
> +#ifdef CONFIG_ACPI_APEI_GHES
> +	/* Used for GHES mapping from assorted contexts */
> +	FIX_APEI_GHES_IRQ,
> +#ifdef CONFIG_RISCV_SBI_SSE
> +	FIX_APEI_GHES_SSE_LOW_PRIORITY,
> +	FIX_APEI_GHES_SSE_HIGH_PRIORITY,
> +#endif /* CONFIG_RISCV_SBI_SSE */
> +#endif /* CONFIG_ACPI_APEI_GHES */
>  	__end_of_permanent_fixed_addresses,
>  	/*
>  	 * Temporary boot-time mappings, used by early_ioremap(),

Hi Himanshu,

Reviewed-By: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément

