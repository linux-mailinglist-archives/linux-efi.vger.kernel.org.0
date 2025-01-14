Return-Path: <linux-efi+bounces-2630-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E13A10CAA
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 17:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB0C1675FD
	for <lists+linux-efi@lfdr.de>; Tue, 14 Jan 2025 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813801CEE8C;
	Tue, 14 Jan 2025 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcPP1nUm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966EF1547FF
	for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873269; cv=none; b=lVrvOICc2I6Bmu3ePaVKKPAC9PbgFw8BN1V8bsqwMMgifiLpUxCEUG4ZOcdk9PxvaotHT/aE6fdI/VxAg20CgtqGH10p7T4iY5asTOHdLuusIR6dHA/IHzh0O5EOy+VEnpj7wk6Up7wnRNJXABWjtFN1Cztkn3Jm8/92gWz/0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873269; c=relaxed/simple;
	bh=VlLZbIWEPQWuHil+Qec54gsCOSrBaxuSV4RA3C8/Grc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HG6WrJ1EdhQxdhC1oF531/HSWIJt6EG7Us4PfJrnpt+HFnH0Ba0lTtjnGysa/YAsHmxOrb6I6YK+6Ph5jWnjSeZSQMfmftqmFCGgNl7n+9525mqPZlrKCCYvwU0yplH4En/g0b67glCnq8qxZASTwizf5q8FsR1J2CIgrOy3Sss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcPP1nUm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2167141dfa1so101282905ad.1
        for <linux-efi@vger.kernel.org>; Tue, 14 Jan 2025 08:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736873267; x=1737478067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/3H888iWJqrG1t6QjFjAFsstlvu40LfZvTm0hiY+/4c=;
        b=XcPP1nUm/8zlKYT2O4txtpR9V+nqrzLl41w35GZy6p/pQ/7hMdbTL03HUe94qGRe/X
         lrvFX+oLJnWYg05O0PTndWyPwwvvNWILjxEgNK8Yq0lqoPv7J+EHA8K0OfbkULrucXy8
         WenNhmgZf2tfg4pDib+fd2qZdg8A7KYzREtQa+KsINVP08b8O6zKPgBXF8AWKWuW/AGI
         cFo3RfxgNYldCKVUURipdRrz0OhgfTaRr29TcbbIzHa2f2iEqnMvWhRYBMRTTz64irZZ
         bu80/1K3HddMAM1AI2ttrt+XISB1kOqCxJhyCYXxnwJZjpLY1WLdhMOCp5e3NB19F+ov
         lyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736873267; x=1737478067;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3H888iWJqrG1t6QjFjAFsstlvu40LfZvTm0hiY+/4c=;
        b=iaOq+YNA4eEw5Xge97qzJ8Fy673RI9h0IKywLQx2/NwLDnGN9nZ7EEyW5h8jIb8+0a
         6Je+DOhGkLtX3OGV3ETCnoeeEN3ZKNHniJYD8q52kmHNaklFkGTW+fUGzo3efiNi3z93
         3tTlgujjVr+ddxwdb2tj5ewAeD5H3NcmVl2NXtop07qRev3O/d4p3XaLBr1cFsSD7bHa
         xyRYOur/Eb1R7w8JUnyyn7uTyDhgf/iSyfsg9ZFAoSGDUkXFIlOTy5x4bK+cqlrk3PC9
         /w7rUAEIAdVDW5F1mcdLX3QzvMhMTOW7IeJpMJ3zGYoMo+03KKSpmktfYFMAAMpp1Oc/
         +B9A==
X-Forwarded-Encrypted: i=1; AJvYcCXdQSc21RwR+MoP0U93xPNXdgaMu0XYsO/3q796ADV0O+SWqMxtyN4MMozKU7Ww6hklVfHpocJrrH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV4o6YavWozNmmLkzv64obg5U2EF8E4RvUlhPFjeM+mYWKdXjM
	+aVZiuILLZZOdU4wgfm4xks2BkHZCaC/LmZuLYRnl8ESHoJvwzRK
X-Gm-Gg: ASbGncuuZJqPYGy8KhWvUAsX094dwyrdMjXGMYH+SEFwuZlUiKgLBFy2/yx97pkwuMo
	8VQrJ9F8ZpmhVT1sYYe9SBICXLq8nNQUKAcAsjjvwO5jwNbZp7MIDUFTqk4i4NTHCifso0Pkj/Q
	xfpoqgJPIt1vDQw8p0HfM7nIZVQK04Jbka0MA8jR4zC0ks+uTn/T+W38qS7w2TgpCycEyofGMUr
	9OjLC6J4yNVVWGcKeGFgUsWKIWxLv7meZ9cq5NGl62Yr3ZlTPgqy1SHs14xK9Yhyck8FreAXZWG
	ybcip9+9yrqnG1cfY5CSuEs8Xiabiw==
X-Google-Smtp-Source: AGHT+IG5j3l6Z3Y34pOMDBQEWQeMG+g75xpVVQPRVaNM53mQk3szTV5IGrgtR2oFvJr5E2TEc0phYA==
X-Received: by 2002:a17:903:2407:b0:215:3998:189f with SMTP id d9443c01a7336-21acb9dc117mr172523115ad.6.1736873266670;
        Tue, 14 Jan 2025 08:47:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f839sm69120445ad.15.2025.01.14.08.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 08:47:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <86c8c2d0-a00f-4df1-903c-c0839ce9471c@roeck-us.net>
Date: Tue, 14 Jan 2025 08:47:43 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] efi/libstub: Avoid legacy decompressor zlib/zstd
 wrappers
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Pingfan Liu <piliu@redhat.com>, Dave Young <dyoung@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>
References: <20241218150316.1583806-6-ardb+git@google.com>
 <20241218150316.1583806-7-ardb+git@google.com>
 <3d6f2bb7-3c23-4df7-a787-034bb30bff19@roeck-us.net>
 <CAMj1kXGz=dazpagUsxoDGHd4-n6QkoZta90h-c0DCBZPWuc_vg@mail.gmail.com>
 <CAMj1kXEgdUS3qxGe9_uQF5jNxwnFAR2giA0dTvE-kQ=u7Bmh=Q@mail.gmail.com>
 <e5e1f492-1050-4c4c-9e61-6ff4a68c58d2@roeck-us.net>
 <CAMj1kXGtspGNfV2ESk4bR8Tysr_GTRAbU1AQ6ZHtbkEGKYNv-g@mail.gmail.com>
 <CAMj1kXGFWLKf3R3N-5uetBBARA0UqSoOsExSpMS6ZFXW+_yJuA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMj1kXGFWLKf3R3N-5uetBBARA0UqSoOsExSpMS6ZFXW+_yJuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/25 07:38, Ard Biesheuvel wrote:
...
>> Everything works fine with my distro QEMU:
>>
>> $ qemu-system-loongarch64 --version
>> QEMU emulator version 8.2.4 (Debian 1:8.2.4+ds-1+build1)
>> Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
>>
>> and it doesn't matter if I use your firmware or my own (grabbed
>> randomly from [0])
>>
>> When I build QEMU from source (stable-9.2), things still work happily
>> if I use that same firmware. With your firmware, my QEMU 9.2 is
>> completely dead.
>>
>> Where did you find that image? I tried rebuilding it myself from a
>> recent EDK2 base, but that doesn't work at all either.
>>

I built it myself sometime in 2023 (when working images were not available anywhere).
It has debugging disabled and is much faster than other versions because of that.

>> [0] https://github.com/AOSC-Dev/LoongArchQemuVirtFirmware
> 
> ... actually, turns out I built the wrong platform. If I build
> 
> OvmfPkg/LoongArchVirt/LoongArchVirtQemu.dsc
> 
> from the EDK2 repository, I can boot the kernel with my change
> applied, using your command line.
> 
> Perhaps I should try your .config as well?

Please see http://server.roeck-us.net/qemu/loongarch/

staging: My EFI version, the version from [0], and the version from qemu 9.2 work fine.

next: My version hangs. The version from [0] crashes:

EFI stub: EFI_RNG_PROTOCOL unavailable
EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
EFI stub: Exiting boot services
PROGRESS CODE: V03101019 I0

!!!! LoongArch64 Exception Type - 08(#ADE - Address error exception) !!!!
Zero  - 0x0000000000000000, RA  - 0x900000016D817264, TP - 0x900000016E3AC000, SP - 0x900000016E3AFE70
   A0  - 0x9000000170430000, A1  - 0x900000016C200000, A2 - 0x0000000003CD0000, A3 - 0x9000000170430000
   A4  - 0x0000000000000000, A5  - 0x0000000000000003, A6 - 0x0000026713E4D52C, A7 - 0x0000000000000001
   T0  - 0x000000000000004D, T1  - 0x900000016DE0B118, T2 - 0x5453502039333A33, T3 - 0x0000000000000007
   T4  - 0x0000000000000006, T5  - 0x900000016D8801CE, T6 - 0x0000000000000007, T7 - 0x0000000000000002
   T8  - 0x0000000000000001, R21 - 0x0000000000000000, FP - 0x0000000000000000, S0 - 0x9000000170430000
   S1  - 0x900000016C200000, S2  - 0x0000000004230000, S3 - 0x900000000E166018, S4 - 0x900000016E3EF000
   S5  - 0x900000016F214448, S6  - 0x000000000A45D000, S7 - 0x000000000F467D30, S8 - 0x0000000000000000

CRMD  - 0x00000000000000B0, PRMD  - 0x0000000000000000, EUEN - 0x0000000000000000, MISC - 0x0000000000000000
ECFG  - 0x0000000000000800, ESTAT - 0x0000000000480000, ERA  - 0x900000016D7FE2F0, BADV - 0x0000000000000000
BADI  - 0x000000002900008C
!!!! Can't find image information. !!!!

The efi image from qemu 9.2 crashes with:

EFI stub: Decompressing Linux Kernel...
ConvertPages: range 200000 - 3ECFFFF covers multiple entries
EFI stub: EFI_RNG_PROTOCOL unavailable
EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
EFI stub: Exiting boot services
PROGRESS CODE: V03101019 I0
SetUefiImageMemoryAttributes - 0x000000000E2E0000 - 0x0000000000040000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x000000000E240000 - 0x0000000000040000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x000000000E1A0000 - 0x0000000000040000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x000000000E0F0000 - 0x0000000000040000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x000000000E050000 - 0x0000000000040000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x000000000DEB0000 - 0x0000000000050000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x000000000DD10000 - 0x0000000000040000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x000000000DC70000 - 0x0000000000040000 (0x0000000000000008)
SetUefiImageMemoryAttributes - 0x000000000DBD0000 - 0x0000000000040000 (0x0000000000000008)

!!!! LoongArch64 Exception Type - 08(#ADE - Address error exception) !!!!
Zero  - 0x0000000000000000, RA  - 0x900000016D817264, TP - 0x900000016E3AC000, SP - 0x900000016E3AFE70
   A0  - 0x9000000170380000, A1  - 0x900000016C200000, A2 - 0x0000000003CD0000, A3 - 0x9000000170380000
   A4  - 0x0000000000000000, A5  - 0x0000000000000001, A6 - 0x0000000000000053, A7 - 0x600000000000007E
   T0  - 0x000000000000004D, T1  - 0x900000016DE0B118, T2 - 0x5453502039333A33, T3 - 0x0000000000000007
   T4  - 0x0000000000000006, T5  - 0x900000016D8801F6, T6 - 0x0000000000000007, T7 - 0x0000000000000000
   T8  - 0x0000000000000000, R21 - 0x0000000000000000, FP - 0x00000000000B2298, S0 - 0x9000000170380000
   S1  - 0x900000016C200000, S2  - 0x0000000004180000, S3 - 0x900000000E146018, S4 - 0x900000016E3EF000
   S5  - 0x900000016F214448, S6  - 0x000000000A42D000, S7 - 0x00000000000B2950, S8 - 0x0000000000000010

CRMD  - 0x00000000000000B0, PRMD  - 0x0000000000000000, EUEN - 0x0000000000000000, MISC - 0x0000000000000000
ECFG  - 0x0000000000000800, ESTAT - 0x0000000000480000, ERA  - 0x900000016D7FE2F0, BADV - 0x0000000000000000
BADI  - 0x000000002900008C
!!!! Find image based on IP(0x6D7FE2F0) (No PDB)  (ImageBase=900000016C200000, EntryPoint=900000016D86E5E8) !!!!

Guenter


