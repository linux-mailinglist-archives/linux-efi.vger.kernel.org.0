Return-Path: <linux-efi+bounces-1701-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B001A975052
	for <lists+linux-efi@lfdr.de>; Wed, 11 Sep 2024 12:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32001C222F7
	for <lists+linux-efi@lfdr.de>; Wed, 11 Sep 2024 10:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23497DA83;
	Wed, 11 Sep 2024 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez8cvMHz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065D33BBEB
	for <linux-efi@vger.kernel.org>; Wed, 11 Sep 2024 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052298; cv=none; b=OWs8z7C0Qkin8uE2T94VlXBFnDri4urEU5nNEq6UXqXDVODdZlZu6F9YcGsiYANfPRAMIRaXpK7VEI/9vwSNZFzlQzVifo6fqfEA68jLTn7r9Q9I8dBJqMQaY9n5PhRkAAvnxEE3MFy4CiSEMIpZHLiYNnDKRwRTDlm/OZDLp8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052298; c=relaxed/simple;
	bh=f3++NS2aJ2ciggrBGynEaInXG7RqQwWJ5yiYpt846HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DI1i1MFiNVdX9OzsujpzCs5ToVX5AFLT0f5SbRdiOqPttWjJOXcHtxNPszlIzt59yRbQHxSHM4/yzGOoCDZDDQMmrNNFsKdIA66sizySQIONp7QD5k33N/VxGcsQJcP0vDw8pHxJMexMRdCw70fUUmyOwe+gVDHmr9YORnZLMTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez8cvMHz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a83562f9be9so179501966b.0
        for <linux-efi@vger.kernel.org>; Wed, 11 Sep 2024 03:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726052295; x=1726657095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xfRXO8aG7CV7xVz5FI9ItiLuIzkInF12v0gTlp+dl+o=;
        b=ez8cvMHznEOSsPwfPI0HvCDdQDBCV5gxIMmDueynOXTdF/fJniuYg+f3E/1ryFHYSm
         jHs4FKl0YugPrZHf337fdKukS+z8mz9jvpNpk/zfttxQiFmq/CeM/AteOn5kpgtnQxFZ
         yPlqzoahpOsszVg+DXuoMpSTjwpmvBqNFVDQrFRpLbqzEf2v9xjiG2U63ko0hnXKZHSb
         xt5hHWuLwePzriq+vHRxthCnAotR/I/oTB07tU1SrqT1zKC39nsaqPaxWgaTZCAf/QkK
         yZD4OTc6ZFbVLXbskERXaxFT4DCKRJFWtdgVOWS3UYx8pJKj3Wm+pNKREH0M+/LEhwSm
         9rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726052295; x=1726657095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfRXO8aG7CV7xVz5FI9ItiLuIzkInF12v0gTlp+dl+o=;
        b=HA3t2QORyvXNcjEWFcpAEtlRzgtxI03Qp/4UdOQj4/z0oF9Imx0ZYBjqlTFR75x5KK
         t+RQFKHGaTMxwiocRRMfOtmhlfiaVCZglIO/M6YZNF8pmHncSsHSw8yYSq3eGnm2AMLV
         YZcFatYBvqfco2fx2EDPZM17C8LJf0dC7jOSJQR+825H5mwanNVkzLatx/MBzrU90CHB
         ip+gDaTrRAh4WbMLv4AlkWULwaEhf8KZokcX8L1Zxc6BdT4wO8LTatE+GlvnCpgsYGyl
         /qC133zF+cKetgJEvRJBMRPafh6xd+4UL3rdkTV9xYPiectDUaRWQSfDS5o/1g/A5ym8
         9Vew==
X-Forwarded-Encrypted: i=1; AJvYcCVPSIyY57gKC7V1N3kfgTSWgC7+p24+iqXk2F/5Eb3Df3G++lS2W/8+dsIz5KqOO1CQDUpKkzp4ByE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvbHDNnp9CPgUkf4m+M3JDUNe50ENJ5pY5zbxB692jprT1Dyt
	E6kuZQYSS/bswxPUUvuGX9dTSu/DGRx9U+iGT62gZiZ6jS0265VN
X-Google-Smtp-Source: AGHT+IGLMNPOA93gjLZo+ChcKvIbXVcmDwqywv3Wgapd4ujtL40XzixDcfbg0lCaaCCVF5rVri6aHQ==
X-Received: by 2002:a17:907:3d87:b0:a8d:60e2:396b with SMTP id a640c23a62f3a-a9004a98eebmr227622866b.65.1726052294334;
        Wed, 11 Sep 2024 03:58:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::5:aa41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d5491asm596445066b.198.2024.09.11.03.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 03:58:14 -0700 (PDT)
Message-ID: <8d3ec802-4f7e-42be-b757-bc103d039f0b@gmail.com>
Date: Wed, 11 Sep 2024 11:58:13 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EFI table being corrupted during Kexec
To: ardb@kernel.org, linux-efi@vger.kernel.org
Cc: kexec@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com,
 devel@edk2.groups.io, rppt@kernel.org, gourry@gourry.net, rmikey@meta.com,
 afish@apple.com, kraxel@redhat.com, "Eric W. Biederman"
 <ebiederm@xmission.com>, Breno Leitao <leitao@debian.org>
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
 <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/09/2024 15:26, Eric W. Biederman wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
>> We've seen a problem in upstream kernel kexec, where a EFI TPM log event table
>> is being overwritten.  This problem happen on real machine, as well as in a
>> recent EDK2 qemu VM.
>>
>> Digging deep, the table is being overwritten during kexec, more precisely when
>> relocating kernel (relocate_kernel() function).
>>
>> I've also found that the table is being properly reserved using
>> memblock_reserve() early in the boot, and that range gets overwritten later in
>> by relocate_kernel(). In other words, kexec is overwriting a memory that was
>> previously reserved (as memblock_reserve()).
>>
>> Usama found that kexec only honours memory reservations from /sys/firmware/memmap
>> which comes from e820_table_firmware table.
>>
>> Looking at the TPM spec, I found the following part:
>>
>> 	If the ACPI TPM2 table contains the address and size of the Platform Firmware TCG log,
>> 	firmware “pins” the memory associated with the Platform Firmware TCG log, and reports
>> 	this memory as “Reserved” memory via the INT 15h/E820 interface.
>>
>>
>> From: https://trustedcomputinggroup.org/wp-content/uploads/PC-ClientPlatform_Profile_for_TPM_2p0_Systems_v49_161114_public-review.pdf
>>
>> I am wondering if that memory region/range should be part of e820 table that is
>> passed by EFI firmware to kernel, and if it is not passed (as it is not being
>> passed today), then the kernel doesn't need to respect it, and it is free to
>> overwrite (as it does today). In other words, this is a firmware bug and not a
>> kernel bug.
>>
>> Am I missing something?
> 
> I agree that this appears to be a firmware bug.  This memory is reserved
> in one location and not in another location.
> 
> That said that doesn't mean we can't deal with it in the kernel.
> acpi_table_upgrade seems to have hit a similar issue issue and calls
> arch_reserve_mem_area to reserve the area in the e820tables.
> 
> 
> The last time I looked the e820 tables (in the kernel) are used to store
> the efi memory map when available and only use the true e820 data on
> older systems.
> 
> Which is a long way of say that the e820 table in the kernel last I
> looked was the master table, of how the firmware views the memory.
> 
> 
> As I recall the memblock allocator is the bootstrap memory allocator
> used when bringing up the kernel.  So I don't see reserving something
> in the memblock allocator as being authoritative as to how the firmware
> has setup memory.
> 
> 
> 
> I would suggest writing a patch to update whatever is calling
> memblock_reserve to also, or perhaps in preference to update the e820
> map.  If the code is not x86 specific I would suggest using ACPI's
> arch_reserve_mem_area call.
> 

Thanks, I have sent a potential fix for this at 
https://lore.kernel.org/all/20240911104109.1831501-1-usamaarif642@gmail.com/

We can see this issue in kernels going all the way back to 5.12. Up until now it only corrupted
the tpm_log version, so it wasn't really an issue. After upgrading production to 6.9, the tpm_log
size has started to get corrupted as well. When size was corrupted to a negative value, the
memblock_reserve in efi_tpm_eventlog_init is reserving the entire memory available, and the system
OOMs at boot time, which is causing a serious issue. It would be good to know if the above patch is
an acceptable fix.

Thanks!
Usama


