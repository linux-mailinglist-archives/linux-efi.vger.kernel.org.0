Return-Path: <linux-efi+bounces-1709-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F955976B48
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 15:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E7C1C2359A
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 13:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24361A4E89;
	Thu, 12 Sep 2024 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2H7PA8l"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC31819FA91;
	Thu, 12 Sep 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149301; cv=none; b=NlT5xSlkWx4/pl+BHm4SIUHq/RhzPi5F3ijHBAeQIKiZlkhb8SlnLnLO581ebmyb4DDwFkyy7Q8Q63R2XA6QB2d/wEG8RlI53LlZwb9iKACxh2Nviku6o5xqV8bxVeM2HLsG1+76M8NkYZmfiUV01n8D57RqEdkp2VNlZaS3B6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149301; c=relaxed/simple;
	bh=v69ORr0ifvFA/qf9QeGOilpbCJyouut1G4+0nulVqb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAODaruIr7jFzHFYC9trEDDhfgNUzhF2oG+emBDzj8Kgob1yssEX6UoHfc4OqxGV8zuPkSM597wEhqMpgZeFORteNDoaZhNnCWb+TSUxYIqwee3Mv5t1nR+jRhnvyR/sioAVMvON6gvhLUCX0xTyWXW4It1smN1L2ARzC8ZJRnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2H7PA8l; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so155744366b.1;
        Thu, 12 Sep 2024 06:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726149298; x=1726754098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1G5qVhSpJn+iV45COy44bHVmW0jeUlHnhOjcc2IqBg=;
        b=m2H7PA8luxxmvaeQ2qDtJm6Iyje6P88A/aW9BLCRfEGkVP6fPm6sDSQgfGSavV/hDZ
         AsNi/AiyxJfzb/Q+DxOu4+U6pwQbsf1oALr5OrkDIxhocN/OIukxFkiiUefbKj7MJyJk
         IMQ2WnVhomVfrMsXlUrSoCkrGBKeglmsU1Cd2eBDCaI0m2YVhi5UbMedbQ4VXCmWycrG
         52TgkcsrFYghk/Z3fGe1pXXRXw6p/oyvCrewsFJUGaNj7+mL1cV2DtF26b0mqTX4cb9Q
         QuG2HRFH5zbq3miH2KSMrm5PxcA6ndC4kJmcIfydmO5KPxmnda8YDphepXlc1Hzy/7bX
         /TIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726149298; x=1726754098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1G5qVhSpJn+iV45COy44bHVmW0jeUlHnhOjcc2IqBg=;
        b=JELgvNhaG4A7CC7VqVkiXMWeX1EBfVUaf8r0PEosEHhYfGBDZ4FZ1p66nm/gOAyPwq
         rxN6GPDQA4KYwsJbV/14REAnNfucdP+hPnOwqb7VGzTrlUmocda+bT5MRMVk30bBGjCy
         +7KMxyqgU7w38LZz1i87ToFIXxKiukgVY6XRwIzy9UFyOYvChj0OMvLfNDkiW2asI1cH
         rnhAZbMRynz3IMivbDk1DDRba4dOq0CMmXeajDNKsq9dtPVtFevOVT1439E4KW5oJRMe
         s8xq7z7IhG+X5SFObdmhMaxF/9XabO6j14HDgGuum4vLHc8mWJikG/Y1n6PRSYq1VSfb
         Yjpg==
X-Forwarded-Encrypted: i=1; AJvYcCUljf8dLyV8LRl6l6Suqf9/0crIx3Usq6O2rTUROz2HuDh2x05tSyHsNcwnOyhiV/J8oHT/6jWm+d+n19M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7TfoLd58tUAkpaCf0LNHlbqZ0THvWIsEsuWbp7kUoZKQ9uV3F
	jJ2yKcJp8y+oHP8x8pJ01nEtcYfLlMti98CdHKGhgifZ/NqoKf0M
X-Google-Smtp-Source: AGHT+IGHyggpXdC19jbQjmV+z/3GczJJNtHI7cEPIGNXAzJMFOl3VDvtIn7uWtgy0U0A/cj483cK+Q==
X-Received: by 2002:a17:906:c151:b0:a8d:5d28:8e0d with SMTP id a640c23a62f3a-a90296175a4mr320642766b.45.1726149297648;
        Thu, 12 Sep 2024 06:54:57 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:5725])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d5dda8sm744523866b.211.2024.09.12.06.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 06:54:57 -0700 (PDT)
Message-ID: <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com>
Date: Thu, 12 Sep 2024 14:54:56 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org,
 ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
 tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, rmikey@meta.com, gourry@gourry.net
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
 <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/09/2024 14:10, Ard Biesheuvel wrote:
> Does the below help at all?
> 
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
>         }
> 
>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> -       memblock_reserve(efi.tpm_log, tbl_size);
> +       efi_mem_reserve(efi.tpm_log, tbl_size);
> 
>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
>                 pr_info("TPM Final Events table not present\n");

Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
which is e820_table_firmware.

arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
its end, just with e820_table_firmware instead of e820_table.
i.e. efi_mem_reserve does:
	e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
	e820__update_table(e820_table);

while arch_update_firmware_area does:
	e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
	e820__update_table(e820_table_firmware);

Thanks,
Usama

