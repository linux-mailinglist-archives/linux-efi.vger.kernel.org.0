Return-Path: <linux-efi+bounces-3947-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B13AE5F07
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 10:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E8A4A02D2
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 08:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E8C2571DD;
	Tue, 24 Jun 2025 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1a64fpg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDEE86347;
	Tue, 24 Jun 2025 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753436; cv=none; b=kuv7NYz3LvwUX1HcXLEMt8QnJ9vRxuZyHiYVl1oMhP+WwBh2UMQ1dnqmWIOEAqNUFo15OHbUMi7tXcNGDhCy6wkLUyXgQ0m1auYJZb2H1CyoNM/lGXJXBeF754Cu8iAcWmx1CiDwg8WhpQS7yYZEh/ZW39nnJwHqAUuVoQZTLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753436; c=relaxed/simple;
	bh=0DRoBk7a+ONA+bOlmOa0vOv2EeXtSy0ZwgcOZn/WSpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtABd4X42IgFTnfJrQvMlPaxpyNn9bHMV2NEMZ5kP/Iv19oLD8CrhfUUjkCSiH4wQHisXSTeDYM1O0VDFMRyCu3Rpvv8h6xy75KX9JYhj/t8uOdVrZt14Yb9C29H7NQNi16hC9fzCIKRc5UpB8f82+Hs+xDRK3GMMnQORDVbIco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1a64fpg; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo9602970a12.3;
        Tue, 24 Jun 2025 01:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750753433; x=1751358233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2H7FVeT03BXWcr+Xp7XmzKQpCwCD96qmn55NwEfYCg4=;
        b=Q1a64fpgVglQwckG0B0D31EwaQG/F5hrRItQ6rKNSLUIKLtJZl2s4L+w/9vQI2c4qc
         cGVmv2aMfv3ktx4nddCGSH0O7JpZ9DOxr5epv75jIqiRsRD4KBLOeAAJNrzLlRfLU5S5
         ymz2vSGkuvCR0UEca32U1LC02BvmAeOszLoSjpc2RLVQ4HRB38b2oNZSkyiH9sy8XC8E
         KsTdZC/KxlLZ+tFL2/5rn4HCuP5eltw4Fg00qMciCStbc3TOhZci2UXwycXjz1ZWuK5r
         nMh7IfYl8mHpYbzY+qUPckQbbxfuuqvzwfJm8ybvZHdDG5GCHnk3JrpHy3w3fqGgTlnd
         NGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750753433; x=1751358233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2H7FVeT03BXWcr+Xp7XmzKQpCwCD96qmn55NwEfYCg4=;
        b=lbNKEiK5azPfZNkABwm+LMj9PBV5QgZcXnsblE6MVYmXGgNSZfYZ2bbLUp72ZuQ9s2
         S1W+slVf2zmCn7tqXf7bq8X1yZbmVgcpZRbSyCw1afAhPTKiQvKEcHM4UL/YEhXW5H4L
         l84Da5P9QO4Qwmjb1JbjG5kKGyTm+4e/+W6KbFUdTAbi4VOs3kwz4VS5WINZby9pdGE7
         FdN2T4In0hSj2YIcGIyP9JiK0fqZyzsdtCFfhWYV4j38/1lee4UJfJhIYWQRHxCp2iTx
         9fPiyh4lhZGolOL5IQrOMpoyEyQva6gcrfU0oDHQ38CloqeaTbq4rthlw80Pmw/CGqq3
         jjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6TS4SZOBFmTKDoPIn5FkhrDQKmi4jFzRbdkKhmz5P1K14cbRGcK8nzse07R2MlEm3jq1h3t7mUvs=@vger.kernel.org, AJvYcCVrM4NQK9XEH6ZGRubmCongv856PUSQY91BzF5v7st0al4p5JnCUpU/D+x3BZ3jMU86LaKpW9Az8ENS@vger.kernel.org, AJvYcCX8Fs/IcWD8IuYBG4iH5V4mXfxaKSspFD/iYgu/EdKikyA3AtHcAzYjWsNc+AtixHnw4AZGg8T7iRLrSGT+@vger.kernel.org
X-Gm-Message-State: AOJu0YwcJwebTMdMrbhl6+f0gqvGsNFahbLcejHG7z8fOENUm1jMz+S6
	fJ5IF8Cl9sLWeq0FuEFRxqiao1UJwuZalg7J2NMC/02mVvOlND3hK5q2
X-Gm-Gg: ASbGnctGUYoxtfXi3Lm9Tetm5ZqAfRlXtFhqZDU8cKqvYE89p2BThTcuHDEZTdwCmae
	Fk894vEzhOhAfhsLj3bUvqgzdE2VOodPZU5LtGDNGkC9LgAc/8vg8QJ8abMee2c3Ysf4yrEXqAL
	dR4iZhfJZIhPOYjBZ4KmrgQruaBQgOHIu8szBIybH+v3g9/d0XgO9pFFnyn4YSpS2Id9JtFkbBH
	sKsOvAroKyh7EmQ3oxlYKFvhLnqvvmpAy9t0o6aXJEZa4V0VOrOw2yJTLoRqcwCg/XjMghpx0Rj
	hA5yJnQHaKDXcTuq8fMgqJ9gd6W9kBRLdhPrUfZi3P9QcC/N+e92f9ERqDvYvpzYknF4dKDywLZ
	s
X-Google-Smtp-Source: AGHT+IE6uFBShvRtJlJrHnQfSTfKaDchryVCXm3Xlc5jSRa7ZBWQ78xrOHfYewZsoH8M4NZdRafhDg==
X-Received: by 2002:a17:907:9816:b0:ad8:9b24:9d16 with SMTP id a640c23a62f3a-ae0579cd970mr1424596366b.6.1750753432204;
        Tue, 24 Jun 2025 01:23:52 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e7c6fdsm829165466b.3.2025.06.24.01.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 01:23:52 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	corbet@lwn.net
Cc: luto@kernel.org,
	peterz@infradead.org,
	ardb@kernel.org,
	jan.kiszka@siemens.com,
	kbingham@kernel.org,
	kirill.shutemov@linux.intel.com,
	michael.roth@amd.com,
	rick.p.edgecombe@intel.com,
	brijesh.singh@amd.com,
	sandipan.das@amd.com,
	jgross@suse.com,
	thomas.lendacky@amd.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCHv2 0/3] x86: Make 5-level paging support unconditional for x86-64
Date: Tue, 24 Jun 2025 08:23:03 +0000
Message-ID: <20250624082305.2351-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
References: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>Both Intel and AMD CPUs support 5-level paging, which is expected to
>become more widely adopted in the future.
>
>Remove CONFIG_X86_5LEVEL.
>
>In preparation to that remove CONFIG_DYNAMIC_MEMORY_LAYOUT and make
>SPARSEMEM_VMEMMAP the only memory model.
>
>v3:
> - Drop few "#if CONFIG_PGTABLE_LEVELS >= 5";
> - Make PARAVIRT_XXL 64-bit explicitly and drop ifdefs
>   to support PGTABLE_LEVELS < 5;
> - Add Reviewed-by tags from Ard;
>v2:
> - Fix 32-bit build by wrapping p4d_set_huge() and p4d_clear_huge() in
>   #if CONFIG_PGTABLE_LEVELS > 4;
> - Rebased onto current tip/master;
>
>Kirill A. Shutemov (4):
>  x86/64/mm: Always use dynamic memory layout
>  x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory model
>  x86/64/mm: Make 5-level paging support unconditional
>  x86/paravirt: Restrict PARAVIRT_XXL to 64-bit only
>
> Documentation/arch/x86/cpuinfo.rst            |  8 ++---
> .../arch/x86/x86_64/5level-paging.rst         |  9 -----
> arch/x86/Kconfig                              | 33 ++-----------------
> arch/x86/Kconfig.cpufeatures                  |  4 ---
> arch/x86/boot/compressed/pgtable_64.c         | 11 ++-----
> arch/x86/boot/header.S                        |  4 ---
> arch/x86/boot/startup/map_kernel.c            |  5 +--
> arch/x86/entry/vsyscall/vsyscall_64.c         |  2 --
> arch/x86/include/asm/page_64.h                |  2 --
> arch/x86/include/asm/page_64_types.h          | 11 -------
> arch/x86/include/asm/paravirt.h               |  4 ---
> arch/x86/include/asm/paravirt_types.h         |  2 --
> arch/x86/include/asm/pgtable_64.h             |  2 --
> arch/x86/include/asm/pgtable_64_types.h       | 24 --------------
> arch/x86/kernel/alternative.c                 |  2 +-
> arch/x86/kernel/head64.c                      |  4 ---
> arch/x86/kernel/head_64.S                     |  2 --
> arch/x86/kernel/paravirt.c                    |  2 --
> arch/x86/mm/init.c                            |  4 ---
> arch/x86/mm/init_64.c                         |  9 +----
> arch/x86/mm/pgtable.c                         |  2 +-
> arch/x86/xen/mmu_pv.c                         |  4 ---
> drivers/firmware/efi/libstub/x86-5lvl.c       |  2 +-
> scripts/gdb/linux/pgtable.py                  |  4 +--
> 24 files changed, 14 insertions(+), 142 deletions(-)

I think i am too late, however this is completely wrong. There are still processors that doesn't support
5-level paging which is mordern. We may call those processors old, however they are still common and used.

So this patch seem too early for that. Some intel core-i5 and core-i7 doesn't support 5-level paging at all.

This will break x86_64 cpus that doesn't support 5-level paging.

