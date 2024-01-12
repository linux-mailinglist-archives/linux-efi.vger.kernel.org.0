Return-Path: <linux-efi+bounces-402-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554B182C5A4
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jan 2024 19:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23231F22E6F
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jan 2024 18:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FB5156DF;
	Fri, 12 Jan 2024 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Eop9q6v+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F9154BA
	for <linux-efi@vger.kernel.org>; Fri, 12 Jan 2024 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so4433156b6e.2
        for <linux-efi@vger.kernel.org>; Fri, 12 Jan 2024 10:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705085809; x=1705690609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEDXOfS1OMRNJt5xI31mTmXvOtMcxWRYjl1hJhJ0V4k=;
        b=Eop9q6v+WA9BKkBcof4vDIjvAPUOMUnvNM37X9NTMw+7dFR/oqZo1PI2JiAJjbd0qO
         g4BpBjMnf3s4ckjqmPjzDVwLGckdQs5L71sddoI7GUfuu7mUA6Tu9NoLCeh4qJEFNxC/
         ehtasAv6noY8XMVrbC4ylvIdzkngrAJnin6CmPpfQ/ytneuSLTF+w9SiNpTRtDjzoDXt
         D4BygPavHT2xXctZk+siU37BYfixw4MAXn8CwvmM1v2vGRTbdtlP7zFgB6HrwdpYxmAr
         emOSdclUMdtrSJ6wCaPfzw024tqHkc/cxatgGnJwQ46pNVrzv+hCZL1npC0EKOJ/Lctq
         fcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705085809; x=1705690609;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEDXOfS1OMRNJt5xI31mTmXvOtMcxWRYjl1hJhJ0V4k=;
        b=dVydL+ZvLCBQTgRaNy11UywuOobB/7IGlzkss7JXoPLTgX4+YvoHCkMqvo0PQzZr3e
         hr3pg3bXzJGGndeiDC0JUy22Yzp/gos/uPAsfRoaTbRERW6ZmTb2hDjlFfMaa2dOqwQA
         PTv3MSjv7yopgf6gtrB3M280UZNK1snVYdOJC9a3H05fmhlSnYTIcHyGN0WeZVG3UXzd
         vDMsElrG6XBqPQRVJz+6Eg8miICKmAO3Br9sr+4dF/2N9QWIBgN90qPmhkLigrLP5EuS
         VRHvDa73ZREGgkV9EpPjHgOE+i6IE/mEG6vkobuBVlr/JxJUAGsaQVaSRVo90eroy1+A
         MTTg==
X-Gm-Message-State: AOJu0Yzdat2c2OD8g/ghulBuD0Y1V1UKVARTz8eCjT/51fYsCC1NiNnj
	Le5UzUHp+BtQCIxrvq1BdVMURlm5FMQTUA==
X-Google-Smtp-Source: AGHT+IGVC8u3Z7XhUx88aePFDNg1yWAOfkOK5jeF8gH2sPSCuwtXvRlutmna/rxPgxxzAyvOnrMJ1Q==
X-Received: by 2002:a05:6870:bb1a:b0:206:7a58:fe85 with SMTP id nw26-20020a056870bb1a00b002067a58fe85mr1803263oab.61.1705085809448;
        Fri, 12 Jan 2024 10:56:49 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id mw2-20020a056871d08200b0020652f4567csm943125oac.33.2024.01.12.10.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:56:48 -0800 (PST)
Date: Fri, 12 Jan 2024 10:56:48 -0800 (PST)
X-Google-Original-Date: Fri, 12 Jan 2024 10:56:45 PST (-0800)
Subject:     Re: [PATCH] riscv/efistub: Ensure GP-relative addressing is not used
In-Reply-To: <CAMj1kXHUAQVrzdqFXDX1Fid38Gov3R-DNwJSSXXNqVgJPr6cBw@mail.gmail.com>
CC: jan.kiszka@siemens.com, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Ard Biesheuvel <ardb@kernel.org>
Message-ID: <mhng-8a4a5f85-faf9-405c-95a0-78cd04ec6509@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 12 Jan 2024 10:51:16 PST (-0800), Ard Biesheuvel wrote:
> Hi Jan,
>
> On Fri, 12 Jan 2024 at 19:37, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The cflags for the RISC-V efistub were missing -mno-relax, thus were
>> under the risk that the compiler could use GP-relative addressing. That
>> happened for _edata with binutils-2.41 and kernel 6.1, causing the
>> relocation to fail due to an invalid kernel_size in handle_kernel_image.
>> It was not yet observed with newer versions, but that may just be luck.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Something like this should go to stable as well, but we will need
>> rebased patches.
>>
>>  drivers/firmware/efi/libstub/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
>> index 06964a3c130f..d561d7de46a9 100644
>> --- a/drivers/firmware/efi/libstub/Makefile
>> +++ b/drivers/firmware/efi/libstub/Makefile
>> @@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)          += -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
>>                                    -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
>>                                    -DEFI_HAVE_STRCMP -fno-builtin -fpic \
>>                                    $(call cc-option,-mno-single-pic-base)
>> -cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE
>> +cflags-$(CONFIG_RISCV)         += -fpic -DNO_ALTERNATIVE -mno-relax
>
> Can we detect the presence of these references (via the relocation
> type)? We already do something similar for ordinary absolute
> references too.

If there's no `__global_pointer$` symbol then the linker won't make 
GP-relative relaxations (because it doesn't know where GP is).  We 
usually define that symbol in the linker script, but I'm not entierly 
sure how libstub gets its linker script...

>
>>  cflags-$(CONFIG_LOONGARCH)     += -fpie
>>
>>  cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)   += -I$(srctree)/scripts/dtc/libfdt
>> --
>> 2.35.3

