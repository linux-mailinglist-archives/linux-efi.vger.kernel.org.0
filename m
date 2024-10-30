Return-Path: <linux-efi+bounces-2066-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A44D9B6ABE
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 18:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191561F26088
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2024 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FDB21B448;
	Wed, 30 Oct 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IadPIREw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C723A21BB19;
	Wed, 30 Oct 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308400; cv=none; b=q1Gwn2/TUHDtmcTIgykHyx1tY6nHyejeEjnJ4/GmqTtumNnvBtZF8IM/VhFWMNspeXefCTORNI3txAEp/r6LaovaLFj//TOEsmKw0E1WLdJWu1jmPUi1io0oBumi10bKujcVonR7fjd8GNcGS3ZQc8hz/fgvL+zBFAjOiXP5gYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308400; c=relaxed/simple;
	bh=ZwNkJqrjElwJsJnOeGf5gKH6noFlQ4hpl2p7zZjxJP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMCt4c9nrm79ZGAY1izsqit58pBoHxp47EwLQt9O7soRahcfcMi2JzjVR+6aY+eTQQsPQ3/7hk5MoxPX0y/BzGHXqZt56bts7m4S+eMLQekLrB/tlcWc0oeE2a/dwaGgiB245v1eu1CrlCWS1Huyg8dvCB9a+6ERph7iYChcZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IadPIREw; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d49a7207cso95838f8f.0;
        Wed, 30 Oct 2024 10:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730308396; x=1730913196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dcQ95Wox9GMvuABk5iVMp2oaaubr/R4lUr2slFSkGY=;
        b=IadPIREwmL/dAqbE8B6Eqs7/sE7XZGebvTedbQL/DdfTFrSoO3k6gT2L0zvfn2a53d
         W68qleP4eF62B14BME+yXegmIH4XViVKYLzFJlq++sFyORamQHCD3NqERo7d5Z8yCegk
         qf06Z9/47lrlXHim8E5ExUnsf0taXcoWmhlAfKOzCfHFGuVGDEVt+buOcI9RmQyMAMbZ
         Yh4zcpCDnBILWwRDvyh9emqEe5QyrLfcW6FhqX2o9+WBvm+FTe7FcjXML9oT/elY86kH
         v8RcROSamamgAayh6GhGy9cf4dQwmNY1oGOPRe2sccS5c8P6VdjsawizzFc5N4ONiQ56
         qeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308396; x=1730913196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dcQ95Wox9GMvuABk5iVMp2oaaubr/R4lUr2slFSkGY=;
        b=viIbRYt1yoXfRYlLHSrj2LCvky3u9Qq4bpcWxGJciYWeR27e3gdP8x2Guxau87uczW
         uGEVzIVqoHskZHaB1f+n9gv0kca0Dpgd53KOCRCmlhA+hPT2wl5QKuzthRK9b44P95c6
         k9OLEGEW4/ShRFJkYrjcizbgylRbGDGqJHYWzwwwLHVThqmU1yfulqUvWMMfxon6iffo
         osQMA1LOC6fKIUmuhVXJV+vnvH0tquEgIFX2tDrt6KEPTJ1rLnXWdlE18faz9lt0xFwe
         +g6IK9F13OFR9Hu2GD/tQ3YtbMeNRarxAuMYiCxMwy26Y/L5KPHuBdwWXKBSVskFP+rZ
         /2FQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5ntKCdfVVffj6kWd+n9iU+cjUa3IWmVdwZu7u2WQUJerriX281dRay4yYQcFGd1bh81g+9mLm@vger.kernel.org, AJvYcCVVlyULBbBeMRVUl91VbqrdAlIOvOJENwZehhi7/eQjIwKzYKADk6o7h/NbbDbfmBZReshljHMYpCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpQZWEB+qaS6Nel0MtGxWU7AZ3OuuOAUrMjhUZMNn8CWReLn+G
	k8xGwkhVVpTsZilXXXFB/4z7jUYhWvADPgAsgF/N0U+CpILJVVg6
X-Google-Smtp-Source: AGHT+IFYkRHC8BZyfB4LNJcYEGCp/7PObPTRO/IArem6YDOoHDlSFrUqf4OvebPCmOftbaDmWE0qDw==
X-Received: by 2002:adf:ab10:0:b0:37d:4eeb:7375 with SMTP id ffacd0b85a97d-380611283b8mr11430992f8f.16.1730308395747;
        Wed, 30 Oct 2024 10:13:15 -0700 (PDT)
Received: from ?IPV6:2a02:6b67:d751:7400:c2b:f323:d172:e42a? ([2a02:6b67:d751:7400:c2b:f323:d172:e42a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70d50sm15905598f8f.76.2024.10.30.10.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 10:13:15 -0700 (PDT)
Message-ID: <e42149a6-7c1f-48d1-be94-1c1082b450e0@gmail.com>
Date: Wed, 30 Oct 2024 17:13:14 +0000
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
To: Jiri Slaby <jirislaby@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
 linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
 Breno Leitao <leitao@debian.org>, Gregory Price <gourry@gourry.net>
References: <20240912155159.1951792-2-ardb+git@google.com>
 <ec7db629-61b0-49aa-a67d-df663f004cd0@kernel.org>
 <29b39388-5848-4de0-9fcf-71427d10c3e8@kernel.org>
 <58da4824-523c-4368-9da1-05984693c811@kernel.org>
 <899f209b-d4ec-4903-a3e6-88b570805499@gmail.com>
 <b7501b2c-d85f-40aa-9be5-f9e5c9608ae4@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <b7501b2c-d85f-40aa-9be5-f9e5c9608ae4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/10/2024 05:25, Jiri Slaby wrote:
> On 25. 10. 24, 15:27, Usama Arif wrote:
>> Could you share the e820 map, reserve setup_data and TPMEventLog address with and without the patch?
>> All of these should be just be in the dmesg.
> 
> It's shared in the aforementioned bug [1] already.
> 
> 6.11.2 dmesg (bad run):
> https://bugzilla.suse.com/attachment.cgi?id=877874
> 
> 6.12-rc2 dmesg (good run):
> https://bugzilla.suse.com/attachment.cgi?id=877887
> 
> FWIW from https://bugzilla.suse.com/attachment.cgi?id=878051:
> good TPMEventLog=0x682aa018
> bad  TPMEventLog=0x65a6b018
> 
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1231465
> 
> wdiff of e820:
> wdiff -n bad good |colordiff
> BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
> BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
> BIOS-e820: [mem 0x0000000000059000-0x000000000009efff] usable
> BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
> BIOS-e820: [mem [-0x0000000000100000-0x0000000065a6efff]-] {+0x0000000000100000-0x00000000682abfff]+} usable
> BIOS-e820: [mem [-0x0000000065a6f000-0x0000000065a7dfff]-] {+0x00000000682ac000-0x00000000682bafff]+} ACPI data
> BIOS-e820: [mem [-0x0000000065a7e000-0x000000006a5acfff]-] {+0x00000000682bb000-0x000000006a5acfff]+} usable
> BIOS-e820: [mem 0x000000006a5ad000-0x000000006a5adfff] ACPI NVS
> BIOS-e820: [mem 0x000000006a5ae000-0x000000006a5aefff] reserved
> BIOS-e820: [mem 0x000000006a5af000-0x0000000079e83fff] usable
> BIOS-e820: [mem 0x0000000079e84000-0x000000007a246fff] reserved
> BIOS-e820: [mem 0x000000007a247000-0x000000007a28efff] ACPI data
> BIOS-e820: [mem 0x000000007a28f000-0x000000007abf0fff] ACPI NVS
> BIOS-e820: [mem 0x000000007abf1000-0x000000007b5fefff] reserved
> BIOS-e820: [mem 0x000000007b5ff000-0x000000007b5fffff] usable
> BIOS-e820: [mem 0x000000007b600000-0x000000007f7fffff] reserved
> BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
> BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> BIOS-e820: [mem 0x0000000100000000-0x000000087e7fffff] usable
> NX (Execute Disable) protection: active
> APIC: Static calls initialized
> e820: update [mem [-0x65a5e018-0x65a6e457]-] {+0x6829b018-0x682ab457]+} usable ==> usable
> extended physical RAM map:
> reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
> reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
> reserve setup_data: [mem 0x0000000000059000-0x000000000009efff] usable
> reserve setup_data: [mem 0x000000000009f000-0x00000000000fffff] reserved
> reserve setup_data: [mem [-0x0000000000100000-0x0000000065a5e017]-] {+0x0000000000100000-0x000000006829b017]+} usable
> reserve setup_data: [mem [-0x0000000065a5e018-0x0000000065a6e457]-] {+0x000000006829b018-0x00000000682ab457]+} usable
> reserve setup_data: [mem [-0x0000000065a6e458-0x0000000065a6efff]-] {+0x00000000682ab458-0x00000000682abfff]+} usable
> reserve setup_data: [mem [-0x0000000065a6f000-0x0000000065a7dfff]-] {+0x00000000682ac000-0x00000000682bafff]+} ACPI data
> reserve setup_data: [mem [-0x0000000065a7e000-0x000000006a5acfff]-] {+0x00000000682bb000-0x000000006a5acfff]+} usable
> reserve setup_data: [mem 0x000000006a5ad000-0x000000006a5adfff] ACPI NVS
> reserve setup_data: [mem 0x000000006a5ae000-0x000000006a5aefff] reserved
> reserve setup_data: [mem 0x000000006a5af000-0x0000000079e83fff] usable
> reserve setup_data: [mem 0x0000000079e84000-0x000000007a246fff] reserved
> reserve setup_data: [mem 0x000000007a247000-0x000000007a28efff] ACPI data
> reserve setup_data: [mem 0x000000007a28f000-0x000000007abf0fff] ACPI NVS
> reserve setup_data: [mem 0x000000007abf1000-0x000000007b5fefff] reserved
> reserve setup_data: [mem 0x000000007b5ff000-0x000000007b5fffff] usable
> reserve setup_data: [mem 0x000000007b600000-0x000000007f7fffff] reserved
> reserve setup_data: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
> reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> reserve setup_data: [mem 0x0000000100000000-0x000000087e7fffff] usable
> efi: EFI v2.6 by American Megatrends
> efi: ACPI=0x7a255000 ACPI 2.0=0x7a255000 SMBIOS=0x7b140000 SMBIOS 3.0=0x7b13f000 TPMFinalLog=0x7a892000 ESRT=0x7b0deb18 [-MEMATTR=0x77535018-] {+MEMATTR=0x77526018+} MOKvar=0x7b13e000 RNG=0x7a254018 [-TPMEventLog=0x65a6f018-] {+TPMEventLog=0x682ac018+}
> 
> 
> thanks,

Thanks for sharing this.

This looks a bit weird for me.

The issue this patch was trying to fix was TPMEventLog being overwritten during kexec.
We are using efi libstub.
Without this patch we would see
BIOS-e820: [mem 0x0000000000100000-0x0000000064763fff] usable 
TPMEventLog=0x5ed47018
i.e. TPMEventLog was usable memory and therefore was prone to corruption during kexec.

With this patch 
BIOS-e820: [mem 0x00000000a8c01000-0x00000000a8cebfff] ACPI data
TPMEventLog=0xa8ca8018 
i.e.  TPMEventLog is reserved as ACPI data, hence cant be corrupted during kexec.


In your case, from the logs you shared, good run without the patch:
[    0.000000] [      T0] BIOS-e820: [mem 0x0000000065a6f000-0x0000000065a7dfff] ACPI data
[    0.000000] [      T0] BIOS-e820: [mem 0x0000000065a7e000-0x000000006a5acfff] usable
[    0.000000] [      T0] BIOS-e820: [mem 0x000000006a5ad000-0x000000006a5adfff] ACPI NVS
TPMEventLog=0x65a6f018 
bad run with the patch:
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000682ac000-0x00000000682bafff] ACPI data
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000682bb000-0x000000006a5acfff] usable
[    0.000000] [      T0] BIOS-e820: [mem 0x000000006a5ad000-0x000000006a5adfff] ACPI NVS
TPMEventLog=0x682ac018
Both with and without the fix, the TPMEventLog is part of ACPI data.

It means your firmware has already marked that area as ACPI data. Are you using efi/libstub?

Thanks,
Usama





