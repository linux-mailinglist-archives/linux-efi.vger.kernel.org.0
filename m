Return-Path: <linux-efi+bounces-5343-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE4FC2DB46
	for <lists+linux-efi@lfdr.de>; Mon, 03 Nov 2025 19:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C1E3A255C
	for <lists+linux-efi@lfdr.de>; Mon,  3 Nov 2025 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D35F28D8DF;
	Mon,  3 Nov 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSxRJoJB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739981BD9D0
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195013; cv=none; b=In3Buvt0NPVCEY3mrk9DESRx7fSQmVQPjBysINAjBZCB1HMfnQqjmt26NGbbnkE3d8cSSSFxRwrN/U5xRcQNtsCqQd5ueAYP+/awuuuma5uryOZCQ6DVXnDmfTNqlKx4Wo0EL4NUveTMGGhFeBFoUvfhD9Hv3t03S4ty/kRXo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195013; c=relaxed/simple;
	bh=avadB8g9qjqqRwulQIzu5lecW++0n0UMpXPoAJxVaeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QEk/Qc/n0upoH8Z5aop/3GGx1+cJFt3oUvbGSH/+6ATIQCxeKLwIL75h/3xHitR5+WbvRGQnkQoR+KgW/gQQJZO5qEAWzKs86K4v8QFrPS/iScqiAV3MUgg5OJwCi870kQxWRyqpmmMW8a1cMnaAqP8BeEzIfo09xMXs4UZVpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSxRJoJB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4710022571cso44997855e9.3
        for <linux-efi@vger.kernel.org>; Mon, 03 Nov 2025 10:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762195008; x=1762799808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZanATNUPbFaToYEjjeEZY7zqm3TfGXKjQ4xQUPFBYw=;
        b=BSxRJoJB0Pw04WvS13QuqsO0ecXX4xoZ1KLV9C4Vu9HBYDfWc5bBvtB5Kkr9m8xn0K
         kDggvI4UORpCiCiwLaXZO9WOaoges7krCbelrM1dQkCPkxe2op96VxSbZT958tyfkcop
         +/uzOOmhCNqfZgzxUXFpMqgHBeSfTB2qLbrARIMwHjbpLEtqWUjco+MPnJSUTp7AYdG/
         IaIKJ3qIkRud14SSvkNiKl2cticrjuLThdh1metYi4v/VfUNnnT2l+HMWe58qto/VQmQ
         640A5ppAu00RYtb1mjF5adQ4yOK9bDVVWdCbj92ha5NL+SiwvbIreufUvfas+gpb64iy
         nBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762195008; x=1762799808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZanATNUPbFaToYEjjeEZY7zqm3TfGXKjQ4xQUPFBYw=;
        b=e7UPINC3dY0MhlwGN8MR/7uim0sSBfaUygJpPJDt3BP/heTwZmIH1mAecjEutjatws
         vIz62HLhdUM5jbAqQqQrQTfV0NHwKO08u8U/aPNnejTSfmgGmte/mbjj95UDhYDx5n8j
         jRRe7ilkBJIbHpkSW9Ds7+WXxqKxeepcl6hKMYpzeI9G4zocs9esb+iALSpGlIf/Jtqg
         Z6wIP5Upkhy8cpU/LKbwSH7ryGbvrFI6EHaVNcYiairy06FkS/oFJWTKgdz8mKA7OU6W
         OoE28mPyvvOcQpZm+IOxuI2Hie83AGcnc4hGGFDjyZ/P0fJ/C3ryv3/cWOzQ7JXw7sNX
         lJRw==
X-Forwarded-Encrypted: i=1; AJvYcCWZKYPvaC+OrjxyGAeu3DOhWCBbCxwYfs/QzDmjagBm8DIFo1rcw28vgwSUUrHtL6+/3UnC3OzCXQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycXyz6yg02nSus8yIU9MFxafUj+jK33GErAvtCjJ/OYD8/qfAx
	44/2Wt6L4oRKOWQffWURcsF9HLtq1o6WkTYui5IJrMq+4L1ZkwgyHmDv
X-Gm-Gg: ASbGncth/k2VTQ1mX6/nLzWMOEvfeuXMtK031qxpohiQHuu++6N8aj7M+3MqV3DOh9C
	gjVborPK5tnX7em0voOh5itlNzF82P6G7Dbu7LzTYl9E9p7tK189U7ouRcSwn/Mq2Tm+dTjiqv+
	1ma4RJ41bRAaqLexSSpZ7XHMTiu3DDFdZtY4xtTMxdGsZhyjjXcnDJuSWF7gbBR/KHzcIxv89IN
	q/EuufeLVJQ/MrWoWoop8UBdn5aoZOkxnQ7eGtcBwQlSxnO3ALSOD5FtAdusYXaGhmYcvbzVPQY
	q8DbvjXG1yldrEerpVkw2CkYtNNq9UpTM2IDKmy+JGgi7bSA8bhf87+ifI9RcG3igU5ThR1I8C+
	1B+8nuw6HMihcizDLrda4D+FrW0hs3EZcZw6Hw2A1g4S/p4XcWXZ8XxR4Tnk5B4Rc+DnyaKPIlV
	3aKEq1lzhys9LfkVTIkeY=
X-Google-Smtp-Source: AGHT+IHBT3goG6o5/i+wGgWn6B2Jy5qdG/7qj4PSYlOBOKWqyZ1rxQ3CXxOOnLL5mDuZ4WsPZ6qXHw==
X-Received: by 2002:a05:600c:811a:b0:475:dd89:abc with SMTP id 5b1f17b1804b1-477307c147bmr109383155e9.11.1762195007648;
        Mon, 03 Nov 2025 10:36:47 -0800 (PST)
Received: from [192.168.100.110] ([77.31.161.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm169323925e9.13.2025.11.03.10.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 10:36:46 -0800 (PST)
Message-ID: <e03f4b4e-dc94-4444-8fe0-6c0c18a424d5@gmail.com>
Date: Mon, 3 Nov 2025 21:36:41 +0300
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] x86: Fix kexec 5-level to 4-level paging
 transition
Content-Language: en-GB
To: Borislav Petkov <bp@alien8.de>
Cc: dwmw@amazon.co.uk, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, ardb@kernel.org, hpa@zytor.com, x86@kernel.org,
 apopple@nvidia.com, thuth@redhat.com, nik.borisov@suse.com, kas@kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
 kernel-team@meta.com, Michael van der Westhuizen <rmikey@meta.com>,
 Tobias Fleig <tfleig@meta.com>
References: <20251103141002.2280812-1-usamaarif642@gmail.com>
 <20251103144557.GHaQjAJZGz_2ZPVDXq@fat_crate.local>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20251103144557.GHaQjAJZGz_2ZPVDXq@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/11/2025 17:45, Borislav Petkov wrote:
> On Mon, Nov 03, 2025 at 02:09:21PM +0000, Usama Arif wrote:
>> v2 -> v3:
>> - Use native_pgd_val instead of pgd_val to fix broken build with allmodconfig.
>>   I wanted to keep the code between pgtable_64.c and x86-5lvl.c consistent
>>   so changed it in both patches
>>   (Borislav Petkov and Ard Biesheuvel)
>> - Commit message improvements (Dave Hansen)
> 
> Did you run the build tests I suggested?
> 

Yes, I did the below build tests:

make LLVM=1 allnoconfig; make LLVM=1 bzImage
make LLVM=1 defconfig; make LLVM=1 bzImage
make LLVM=1 allmodconfig; make LLVM=1 bzImage
make LLVM=1 allyesconfig; make LLVM=1 bzImage

make LLVM=1 ARCH=i386 allnoconfig; make LLVM=1 ARCH=i386 bzImage
make LLVM=1 ARCH=i386 defconfig; make LLVM=1 ARCH=i386 bzImage
make LLVM=1 ARCH=i386 allmodconfig; make LLVM=1 ARCH=i386 bzImage
make LLVM=1 ARCH=i386 allyesconfig; make LLVM=1 ARCH=i386 bzImage

The i386 ones had a failure in lib/math/test_mul_u64_u64_div_u64.c:156:9 for linux-next/master
so I rebased my patches on v6.17 and tested and they all built successfully.



