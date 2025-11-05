Return-Path: <linux-efi+bounces-5350-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF2EC347F0
	for <lists+linux-efi@lfdr.de>; Wed, 05 Nov 2025 09:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6B654F7C24
	for <lists+linux-efi@lfdr.de>; Wed,  5 Nov 2025 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D125A2C325F;
	Wed,  5 Nov 2025 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="AgGI8p9Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B01321CC6A
	for <linux-efi@vger.kernel.org>; Wed,  5 Nov 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331625; cv=none; b=W+szCD6ga0n+tjB08c7s8qE2R1IenmkBAyDfUHMtYMLSXZRMRrW1y6H6aUVk4U/ryz/lLeIoYHH+ciCO/OcIpcFtb8x/rUt2Oqr9ImbJpotZb8vXx6zsLa8HlimrvMD90u1p9VlOxh3Fu4Db4xWyIoENMKkTfXbsC3swwnh45is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331625; c=relaxed/simple;
	bh=BwPh3ox3ihF8gLYDzcrOK44f4OtqgF+2Fb0Dh0+BLJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lw85WHcT8hNctpPG8LODrk6Z1gHlz9mIn29fVYTh0hIMiQkMNc4ZDfSNOMvuKEqZNwYbELJ6B40OB+lWBGLK0wTRaoolL075NE09XruPVc8IZ9WoeD/YqykP2grEUhQuuUiCzTN3sl/lNCD5TFoK5nOeRobmR877we26biz77jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=AgGI8p9Z; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso4804773a12.2
        for <linux-efi@vger.kernel.org>; Wed, 05 Nov 2025 00:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762331623; x=1762936423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpTquQODFrk3k7PTmJWFoZkkIUY08cVx4+GYG+eKacw=;
        b=AgGI8p9ZoO0lkp3sUeJlqenPSg5AaDCGTgreHg2Fypt3zR4fdXAxkTUQL2HtEY3kQH
         57ClDalQu5wc2UEU4y7jbwwog7mF5cUdIJXJjl/6TOgbpDoEm7Ca3ZpfDuTguCfmlYd+
         1bJYFBUH3O0MvQbr/q+opt6OcHFdBViuKAeYQh5qhMWqd7cIayrsdd8JL+IJsQPnhuRY
         cloQ5dToDd6KN9KES4ph3w84e2PIso31rEoOlQXJ/e0oIwKtApwoDjHObQRq88mk7ck4
         D05fcFET+nQxOS/HHxjfNGh+2qG6y4MME/yfdkaHCN2+nNlP32Gc3xq90390Re0lhY7E
         DMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331623; x=1762936423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpTquQODFrk3k7PTmJWFoZkkIUY08cVx4+GYG+eKacw=;
        b=PJjhtfooKQI5qR7RGvIzum/4J6q+zs7jovaBhVmnLpaMqCHSX0q98jIyy8xxja7adV
         IkPcCs8BPVcvh15NvkeOAiZIXZV3O9HNI9/dzMQYS75xatqtXIZskOshJ9B7/osAS4W6
         mLGzu67Rx7Jr/6ABbrddig3VZnaxWonxRpY7p+24BaVmOjBpfOaDNSZ4S8MUA0DrY7fY
         Xb0X+qbqHNymOhi263ZcaBMgBaTfp+EBqj3CIyso43gA/n9p5+Zm9OeaqVvHNg05d3Ju
         ionjmFDXz+QhlWZoQPABOHP7mT8xkRItZoi9O+zBf3mEKpfD9I5he3Ubhs/hmF/1QFCu
         AYNA==
X-Forwarded-Encrypted: i=1; AJvYcCWd5SU8BGFyOO73fmpF17GKIJDw9oP9OLsxP7KrpGZbxLcg3+vkB08kgebwxxlV4YxKGI/hYrjq4KY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53RtNUMJCY97f7QA/Csld7yLc0l6ouMr333262whhqZ+q7UvW
	+aWd1I55ujhuh4IRkajBp49XIkQFPuBHGjFKRfrKpLNeiZMx2TELZxOACpuHG+YRmIA=
X-Gm-Gg: ASbGncu40IcqHTU+aYBxh4DNBPCz+2LblYF4NPQm/D3+upFwd5rGmouJCdmOy/W45vR
	FhErUNZzfRMhg++4NwPa8oT3MZlXmIs+gaFyesVOiBMOSkY00lPsyfbG5+80UUzErNXFwgRKuKD
	X5TEgs7CVhDrZcUnBPOeGeYrEaKMVD+3zLZI3xw4opoFyjDaB7qZoi9deUWaMj8yTJwlZ8XnSmS
	HUcFtggD0GsiRnO1QNh+pfx7mG6zDJ8EVQyZCbJvejB6oCH/JIefyF0mvlUANWWsA3pZkt+/6G8
	kfQCdU+MuzxDjCU2CkNYhbOIJ/jFNDwV8cKPCoFqxKG6blMpE8/bL6VED5Vnf2LlCYb+TaNAW8t
	JcB4Jbd00DxEP1Mh6DtCNdVYfoMCOhWxdVuoGH7tYoaujYC4uVUwXfiS8fcFIolCTnEp+ECBca3
	AJLTAUi/qnG4fj4yByIUeur2YycSvnccP6pkjQb/flH/biEg==
X-Google-Smtp-Source: AGHT+IHDFgcvO6z3yf7vgJuVKi/Izk8w235XWF6jlBUbkg3bEglTQPQvHCk60pfVQnoZVc+QCi6Lug==
X-Received: by 2002:a05:6300:800a:b0:34f:c83b:b3ec with SMTP id adf61e73a8af0-34fc83bbb89mr1922411637.15.1762331623396;
        Wed, 05 Nov 2025 00:33:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ae256df261sm1899131b3a.73.2025.11.05.00.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 00:33:42 -0800 (PST)
Message-ID: <15298563-967c-4609-9410-4bc0b6a75be6@rivosinc.com>
Date: Wed, 5 Nov 2025 09:33:30 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/10] acpi: Introduce SSE in HEST notification
 types
To: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, lenb@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
 robert.moore@intel.com, sunilvl@ventanamicro.com, apatel@ventanamicro.com
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
 <20251029112649.3811657-4-hchauhan@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20251029112649.3811657-4-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/29/25 12:26, Himanshu Chauhan wrote:
> Introduce a new HEST notification type for RISC-V SSE events.
> The GHES entry's notification structure contains the notification
> to be used for a given error source. For error sources delivering
> events over SSE, it should contain the new SSE notification type.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  include/acpi/actbl1.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 7f35eb0e8458..20b490227398 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1535,7 +1535,8 @@ enum acpi_hest_notify_types {
>  	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
>  	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
>  	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
> -	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
> +	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
> +	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
>  };

Hi Himanshu,

Looks good to me,

Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément

>  
>  /* Values for config_write_enable bitfield above */



