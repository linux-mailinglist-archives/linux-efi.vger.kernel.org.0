Return-Path: <linux-efi+bounces-2570-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C64A09665
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 16:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B837A01D0
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9332116EF;
	Fri, 10 Jan 2025 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C96mk95V"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DE42066E5;
	Fri, 10 Jan 2025 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524207; cv=none; b=izPB+hmQqcDbczGKRLQKBCo17N2s/fAK893lyS7k90ibWmooy90lTiJoJmVZU+H6ilRzcHF/YtisZ4jFHsemqbXch5rCZq6AQ06j3rbX/A2bB9FJrOq9R6XLDHU2CVDBNqgKHNjeP/DCOk6Q49mtzFscrWHfEXmslfjiO8S27mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524207; c=relaxed/simple;
	bh=oTHYO7HEQm1XrszJqfRQqaxI8WoE7SDwzxT+yVuAeTk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X+1MUW7OSQq7EbLxFTuhbYaZ9CJVkM+LiNyKL3atdGGSFVp4LBRLoZoMSNXDlHIl972no3FOg+fbPfevVls5HWt9N1ZJiibClxnq5gwIe9m4LuB6GSNBTpazSyke+r+iLEDDOHmA6dA4XNDWNe2XnT/yFwq5EXPuQy0v97Bp/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C96mk95V; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385df53e559so1758491f8f.3;
        Fri, 10 Jan 2025 07:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736524204; x=1737129004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7/c1zoXGuzll6xGx17OnRXhTktRZuXOkRRbzbli15PE=;
        b=C96mk95VBgLeAmpTlRsZgnUhua4NhDq6ItfsVMvdG66NQrRXVMZEvyMzg9a4iumd2p
         972AoKK3OttVqb+ZB3AhY8zlml3qq6KTyLD/9xpU6q4mScrUvRpVLif/xROb8rAkURtg
         GaJUh/UMQzga4uBq6qcNSd8L/dG7MQku3K+3USq8uyOV3b9Mhcr0PWZ+t6gR0tv2GUmz
         HASD/ZXDVcLgaAw11Iv6V+hbtkigIPnVwRsh/3mfOV3yfHZ5KIGSN8vGqGk6n14dbGli
         +bwFAsYe5wyCKwQYM+aCQrXz5YzNT9K6YM2yjgN/wyaIChqR009YMG8pzwNHtAbuqFhT
         SmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736524204; x=1737129004;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/c1zoXGuzll6xGx17OnRXhTktRZuXOkRRbzbli15PE=;
        b=HKNOj4/G9WEF2OXIdbY5MBdcZtVnJIbmpyHcqG/TBLiSeCBg2MWzkvBPeJlhjStXE8
         yFPQkTZpuGODw8XCBK8OxCqL3QkxQdfaYLUG/nDcWzhvyKrO4aaZ07fV0XwGB0qWxQp3
         UEsgkIVR7a5Q//Lg31C1wb1Ew1GICntk7Xv6FTni8+/6KDlIH86/QGo8wrVdRhqFiO5O
         RF+hio+U5mRJjdK0yLxLvPY5tUukuOMWmkDCl/xWS4CEf9RgBKpKCEWbEUkQ1VmCpcLy
         doIcXJ9rj5XXm0kVUSYG7Ta33BndYxdaxMvxV8rQ8+Upcvs0ZoR+c4RSzfHG46wpuBLQ
         TlbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXCYWEsts82qykbgRsJjOLSf868WxfbYt2pMazo32pQnvkatFbFzoE3+W+4z22u39Wks6iwZv5x5es2PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqWpIwhoCFfRSM45qr7GukTEYNJo+zdO/eAv7XSMVP+YZlZd/+
	kQhhZXsITuIeqRjfLbcl3XJR1n7JhCZkVLP4ppaYWC1zzh6R9ojs
X-Gm-Gg: ASbGncvsqKWoRNoi8RwdrLBD94RpOKpH/9hJKG+ZDpJzc7hJP9NgR9jS9rnBMQ9dqdZ
	VuHS8bSNISFQw//GT7ResHbqoYHtEJ4lb+bNLmVtTWRGfPYCdNkZmC+2r31U/vu7tcP/AVkLO//
	DzhKD4WxaxNNq/t3dOXH2S3EwF/Dof3eg4gdJ+0gYgnlpNhHENU+OZ1xl7LiVreN7nfTSCSJcKR
	u03P8wqXjQKDEQF86NRAEYi7nP2dBTgiWDR3Qiw7+KlfVPydZMk7GgiwXvFdBaDQunsyLheWG3C
	jvHhYoYJufTcJxkJZtvhWZ16ib3RL4/bG8bEK1Y2D4eaeWA7xg==
X-Google-Smtp-Source: AGHT+IG99ba+3EjbnJDKEadpRExVV0uXfnt4rvpxoh7E9vujPX4RITwsVLvUeQ3NSOG9KobH9SAa/A==
X-Received: by 2002:a5d:598e:0:b0:38a:8b56:f6c with SMTP id ffacd0b85a97d-38a8b56119emr6950772f8f.14.1736524203663;
        Fri, 10 Jan 2025 07:50:03 -0800 (PST)
Received: from ?IPV6:2a02:6b67:d752:5f00:c46:86ac:45ea:7590? ([2a02:6b67:d752:5f00:c46:86ac:45ea:7590])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1dc6sm4864460f8f.96.2025.01.10.07.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 07:50:03 -0800 (PST)
Message-ID: <fd63613c-fd26-42de-b5ed-cc734f72eb36@gmail.com>
Date: Fri, 10 Jan 2025 15:50:02 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
From: Usama Arif <usamaarif642@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io,
 kexec@lists.infradead.org, hannes@cmpxchg.org, dyoung@redhat.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 gourry@gourry.net, kernel-team@meta.com
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
 <20250108215957.3437660-3-usamaarif642@gmail.com>
 <CAMj1kXFWZNRwx1H2HT8V9hNvUKDi0O3kcLku+g94UOvNBzz5eQ@mail.gmail.com>
 <cade51c5-5fcc-4208-b46c-f2e2038f03e7@gmail.com>
 <CAMj1kXFwgnQT4jQF8zsX05PdrF_QDXK0+Z-6DD6LiSgjqY738A@mail.gmail.com>
 <d3ee6521-fae3-41b2-a759-e454681dde6f@gmail.com>
Content-Language: en-US
In-Reply-To: <d3ee6521-fae3-41b2-a759-e454681dde6f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/01/2025 14:31, Usama Arif wrote:
> 
> 
> On 10/01/2025 07:32, Ard Biesheuvel wrote:
>> On Thu, 9 Jan 2025 at 17:32, Usama Arif <usamaarif642@gmail.com> wrote:
>>>
>>>
>>>
>>> On 09/01/2025 16:15, Ard Biesheuvel wrote:
> 
>>> I think in the end whoevers' responsibility it is, the easiest path forward
>>> seems to be in kernel? (and not firmware or libstub)
>>>
>>
>> Agreed. But as I pointed out in the other thread, the memory
>> attributes table only augments the memory map with permission
>> information, and can be disregarded, and given how badly we mangle the
>> memory map on x86, maybe this is the right choice here.
>>
>>>>
>>>>> The next ideal place would be in libstub. However, it looks like
>>>>> InstallMemoryAttributesTable [2] is not available as a boot service
>>>>> call option [3], [4], and install_configuration_table does not
>>>>> seem to work as a valid substitute.
>>>>>
>>>>
>>>> To do what, exactly?
>>>>
>>>
>>> To change the memory type from System RAM to either reserved or
>>> something more appropriate, i.e. any type that is not touched by
>>> kexec or any other userspace.
>>>
>>> Basically the example code I attached at the end of the cover letter in
>>> https://lore.kernel.org/all/20250108215957.3437660-1-usamaarif642@gmail.com/
>>> It could be EFI_ACPI_RECLAIM_MEMORY or EFI_RESERVED_TYPE, both of which aren't
>>> touched by kexec.
>>>
>>
>> This is a kexec problem (on x86 only) so let's fix it there.
> 
> 
> I don't believe we can accurately tell if we are booting from a cold boot or kexec.
> There is bootloader_type available for x86, but not sure if we should rely on
> that. I think a way forward would be to move it behind a Kconfig option, something like
> below, which defaults to n for x86. Anyone who needs it can enable it. What do you think?
> 

Or we can do something like below?

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index d131781e2d7b..4add694b18d0 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -24,6 +24,15 @@ int __init efi_memattr_init(void)
        efi_memory_attributes_table_t *tbl;
        unsigned long size;
 
+#ifdef CONFIG_X86_64
+       /*
+        * On x86_64, do not initialize memory attributes table
+        * if booting from kexec
+        */
+       if (bootloader_type >> 4 == 0xd)
+               return 0;
+#endif
+
        if (efi_mem_attr_table == EFI_INVALID_TABLE_ADDR)
                return 0;

