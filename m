Return-Path: <linux-efi+bounces-1706-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A44909767AD
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 13:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D461F27CC9
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 11:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8AE1BD01E;
	Thu, 12 Sep 2024 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/4StBwI"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7FA1BCA06;
	Thu, 12 Sep 2024 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726139831; cv=none; b=Uz5LsYIUZFLrLWbnU0TgJXYrcYlMCZrkrpwV+XKaewWDGWbcTc1B7IiUKupgawyr+5MHFs/89ad16pt4GhgEGlStjIMYsFg8gqhKHZPzRXLGTMZscCrLpz18RJ/iqMqEW+6++7szZT3cjSVeQ8XnVwpfvKS0DnoiSm8mjwveEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726139831; c=relaxed/simple;
	bh=j5fuxxpav+uZ74ZBA2z9B31IZX3q+Gdm+A/u+8VumTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpvqnSxxL10pI61/ITadSo+CyfuVIv3qmdBKESvZ/Sy9eSkVDgjhVv/5puoCM7lv6Bqt/jl+I1xkSbOeiSriyJOYlav8/g/xZ2HLynFo92lqNPFk2xWisWAcICKM2Qb6zwr2z59nnUc4aJIW76SCIM9n6YJBmeBPFip4k7J7LvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/4StBwI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d24f98215so127132966b.1;
        Thu, 12 Sep 2024 04:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726139828; x=1726744628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udqUp2dBMuH8FikDBmFuVSTqfSs+UwH1MG42wpMB/w0=;
        b=S/4StBwIzgbmWdUYU6Z/jn15Au0nK5iiey1J+lGyHpa1ShfhhZjs8u1CtZFiMBftEG
         LYsfLMzA7veV82iSj2NTRwuwi+/q2JTEWqNlZmgoDSxYKwuGS6UGWoQhRnu6OnU+JQw4
         6S+tsEH65dnJI3PJk7tfTKI1rw+vuv3IWD7TcseZzT86F5rW//rcnb4tQBbWlE5V2BHe
         qaqEaqnV1KFm5bY1ZiQbOr22lGgzVq20eY9V6qW0P2cFzFgICxUsMQZHxIbL5UZl7GOv
         XcW+KiVd5sW/huTEPX4xIhOhBNmFImDnTwOFPAO7kHxasMCZAZG0Z9zHNIr7u8skSkXT
         /kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726139828; x=1726744628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udqUp2dBMuH8FikDBmFuVSTqfSs+UwH1MG42wpMB/w0=;
        b=G3ygRubIymDNXuEficdIkCwal+Uy6uFUxvB0bsDQV++4ZrWgqNbtjnsxPcTaIrfpJ4
         0rDK7Qfyg/Zq4AELvjOvvSIKT0wsJFY+miDYkK4oC0tjOxmx1CDJ+NL+a2/wFb1R4moO
         sl1K6GI2L7Jo7MCVx7os95nM25hbfm1mnQ1kYB6p5AOZlYlT1p0xAbq2k5TkVbr6xZx9
         kXGdjmLQcDEDKETAJz7E0Sdtj0iJLmMF7gloHkkHoct4dsk2OAoUuhrUO0zKL9+r/P+o
         YhXUgcKiyTuRg8HeW2izwdYQgO80ZCvdh+7uOcoHTqRkY6iuo3xblyYj9jBNE8ZlIkyZ
         XcMw==
X-Forwarded-Encrypted: i=1; AJvYcCXghI+wJtDpAyymlU+8X/Jzphlwra5798QCInlHQSF6ufreyOqGo5UFv0+pmftRqY0yxIO3VPK0qcfa5O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4nvYC7LKxl+SUvzckTFT4NX+aXZl4YTPsESQ+9uwPbklv0aZF
	0jO5E8H6PGP28y0cksMBEmgj4t3fgRCqDHRQY9edCJdTqdtztnF1
X-Google-Smtp-Source: AGHT+IG8eEbLacNT0/CFp+OSUG23KZhYQVEMcQQAWrhz2GEG2iBTsKC89UtLDqZKQLHhu8M12nUMBA==
X-Received: by 2002:a17:907:724c:b0:a86:8863:2bf0 with SMTP id a640c23a62f3a-a90296c42fdmr233020366b.48.1726139827591;
        Thu, 12 Sep 2024 04:17:07 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:5725])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25953275sm733979466b.70.2024.09.12.04.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 04:17:07 -0700 (PDT)
Message-ID: <542e0a32-5dfd-4894-b08b-f4cdc49705bc@gmail.com>
Date: Thu, 12 Sep 2024 12:17:06 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org,
 ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
 tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, leitao@debian.org, rmikey@meta.com,
 gourry@gourry.net
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/09/2024 11:51, Ard Biesheuvel wrote:
> On Thu, 12 Sept 2024 at 12:23, Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>
>>
>> On 11/09/2024 12:51, Ard Biesheuvel wrote:
>>> On Wed, 11 Sept 2024 at 12:41, Usama Arif <usamaarif642@gmail.com> wrote:
>>>>
>>>> Looking at the TPM spec [1]
>>>>
>>>> If the ACPI TPM2 table contains the address and size of the Platform
>>>> Firmware TCG log, firmware “pins” the memory associated with the
>>>> Platform FirmwareTCG log, and reports this memory as “Reserved” memory
>>>> via the INT 15h/E820 interface.
>>>>
>>>> It looks like the firmware should pass this as reserved in e820 memory
>>>> map. However, it doesn't seem to. The firmware being tested on is:
>>>> dmidecode -s bios-version
>>>> edk2-20240214-2.el9
>>>>
>>>> When this area is not reserved, it comes up as usable in
>>>> /sys/firmware/memmap. This means that kexec, which uses that memmap
>>>> to find usable memory regions, can select the region where efi.tpm_log
>>>> is and overwrite it and relocate_kernel.
>>>>
>>>> Having a fix in firmware can be difficult to get through. As a secondary
>>>> fix, this patch marks that region as reserved in e820_table_firmware if it
>>>> is currently E820_TYPE_RAM so that kexec doesn't use it for kernel segments.
>>>>
>>>> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-ClientPlatform_Profile_for_TPM_2p0_Systems_v49_161114_public-review.pdf
>>>>
>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>
>>> I would expect the EFI memory map to E820 conversion implemented in
>>> the EFI stub to take care of this.
>>>
>>
>> So I have been making a prototype with EFI stub, and the unfinished version is looking like a
>> horrible hack.
>>
>> The only way to do this in libstub is to pass log_tbl all the way from efi_retrieve_tcg2_eventlog
>> to efi_stub_entry and from there to setup_e820.
>> While going through the efi memory map and converting it to e820 table in setup_e820, you have to check
>> if log_tbl falls in any of the ranges and if the range is E820_TYPE_RAM. If that condition is satisfied,
>> then you have to split that range into 3. i.e. the E820_TYPE_RAM range before tpm_log, the tpm_log
>> E820_TYPE_RESERVED range, and the E820_TYPE_RAM range after. There are no helper functions, so this
>> splitting involves playing with a lot of pointers, and it looks quite ugly. I believe doing this
>> way is more likely to introduce bugs.
>>
>> If we are having to compensate for an EFI bug, would it make sense to do it in the way done
>> in RFC and do it in kernel rather than libstub? It is simple and very likely to be bug free.
>>
> 
> I don't see how this could be an EFI bug, given that it does not deal
> with E820 tables at all.


EFI passes memory descriptors to libstub, libstub converts it to e820.

I believe the right behaviour should be that EFI creates an EFI_RESERVED_TYPE region for 
that TPM log memory. Then libstub would automatically convert that EFI_RESERVED_TYPE
to E820_TYPE_RESERVED in setup_e820 [1].

[1] https://elixir.bootlin.com/linux/v6.10.9/source/drivers/firmware/efi/libstub/x86-stub.c#L573






