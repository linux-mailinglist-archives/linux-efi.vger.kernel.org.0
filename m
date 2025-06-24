Return-Path: <linux-efi+bounces-3945-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0E2AE5EDB
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 10:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D395C4A05D1
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 08:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D309A2522B1;
	Tue, 24 Jun 2025 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7zemyC+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FFC1C5D7A;
	Tue, 24 Jun 2025 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752916; cv=none; b=IS6Knjui+56oIGYdI8GRySPeoTUKzx3ukjYVzn+CosQmQGDnGMviV3vIYlcNQC1q3nTsyJQH4d3U74Y4EEQ2lxjjK1m6OtztSmrSO+G3suxY5jDfcSV/pgmTUHq56Y7Vj6aZP/l5FSGNZJHr9oeQ7RUvUFPRRjYM/p/ch3qOLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752916; c=relaxed/simple;
	bh=rgVyY4/YTQrAfm/pNuYNRBSarkZNCyC8P0/M3qGNqqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojWY3k+X6ihZ3dc4nQE1Q+1JbAGNNDuh4wJ8n+mGzfgTfXX0P8OIve/vl6MYsiDi6YfZ05n38YekDjFpchjNZcEwbu6+fYNdiLinguSomXnRBCcTtfbWZr/nwM+x3oDkZQ81Vk0kqHAp255DYohj/pgytjaC0LGpUmztGnys0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7zemyC+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453426170b6so35829785e9.1;
        Tue, 24 Jun 2025 01:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750752913; x=1751357713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IpxvpdxasY3jjseo9IC3sZp16HwyYtH5hX5eKgsCpQ=;
        b=W7zemyC+8wcljneTFKc7IXOPM3fixe06z7wMSiikfJI5ZiSps0pl1sPrnBX/KvHo2E
         kvaE8F17dcAFPZnSgvuVlTUG/IIhyxD9/bgo56bb0n2zGfm8E7OaSlxgMObXKt9tBnss
         24T6ky2zoQrHWSf05To2umIyqTX+t+97tkhmgRkH5ENolsFK2RMelLa3Tim8Qh83D74f
         7IBr+dPAQgsqAjoQQtYKuN0SEyLJ05WkyX6raZpQG5uCndr4Caqlw+ErSu9tcVZG2yKH
         tb/B/+MX32oKiEfSmefGu+zE0zAt1MlEYo6oG+BvlWYOPlg7tdHQg6ntNhQRtTGQ2QWz
         K4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750752913; x=1751357713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IpxvpdxasY3jjseo9IC3sZp16HwyYtH5hX5eKgsCpQ=;
        b=hgF26JrzssfTvLbDX+5bFRNOpyQemlIrLipwJ6Srzy4mdYwM+i3b2TJgHFEBbJhdWK
         6Cn2Atl7Sj9ieCiBPpItER9z+iCeAne06oZlkMg4HO4QFjbxaSrALrxCl8cCHJ/Sd5NT
         rAHYHU740WBf0w0SvjGU5ApJWVyWbaSILeiGvY3Lx0qd8g+RYL3cu42weLjyDgPMSWQi
         DZe45cnnBxP+R7pDzzAQWjVTMXOnjiq1BWasYmojLYRlBR7jrzkA5sQjyKGHDQ2Wf8Ci
         uBipc5NbmJqGJUhFKbsarZ+NpPC330MVvRFTvhqQg5Yb9v5Q2DeOkFh2JsWaD/q5yH3L
         vaKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+ltBlP5Pzr+ItLJylvI/6ZBdrzHdPccfAU3uIfPDPsl3W/ykYAV6+5dQslJhQvsBRfEpsvpc59RhZ@vger.kernel.org, AJvYcCW/luR5cmp9NmDo78KOHOepbSgklLMlMU8nxhWhp5IJ74E73Ea5/KZXWCDdSM5eBjCPYGAAtY9me5NU09zY@vger.kernel.org, AJvYcCWj/Qrjmob2xvBFD+O7q3Zv3TJyYYhz0tXqndRezEoNpg4UkKpQLvHenvsDZPdZXT8GR0xCZ+aw65Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCWaA7teFd43LWBlCQhsQj8H0s+uiqDCqKy2awDeWW6t/4FT/R
	Ykb3gYH1Y3Io6NHCpTzQdlG4r4zHAYWSbycxeTlhfkJdvRR7P21YIZyh
X-Gm-Gg: ASbGncvKJFx/XVXm6LsQrVS6Vr2Qp9y8rvzBKHYlq8yl8kb9GcOs740AVZAjAehtup/
	ZiEnT0sNSwBCd3CvoziZL9xRD5I3COw2umugc2aDKcHRKms+oBS41hfnArSHZu6597BBLprBwIj
	M6sGgfRWw056qhPTPuNbQTuy6KbUDbW1wQUV57nr8cnGxfAlqcG/3AKUj1sym7QjVJPGx6s6GoG
	myc0fbPjOeMXOB0Q0j90syBh6fdsNlQPLVa+Vf2Sp73487nkE3i04w6vp5DynkpiAUd1THc/ke6
	q3No7IGpda1/yompd5gKaV4y+o1RmcLkLhkp0l/Gb3S/7pf8FFx5T0omcOZ5k6G3pdH4ateFPzj
	NtgwQJk6EhI8=
X-Google-Smtp-Source: AGHT+IGvxrxlLh/IwQsIqKE+iOFfbQrBMsh0pdGERhzrpVOADG+J1YSMUlf9uAMDMIBmyIUIZuLkng==
X-Received: by 2002:a05:6000:2382:b0:3a5:1241:afde with SMTP id ffacd0b85a97d-3a6e71cba31mr2270832f8f.9.1750752912995;
        Tue, 24 Jun 2025 01:15:12 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e810977esm1261465f8f.83.2025.06.24.01.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 01:15:12 -0700 (PDT)
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
Date: Tue, 24 Jun 2025 08:11:15 +0000
Message-ID: <20250624081400.2284-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
References: 
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
>v2:
> - Fix 32-bit build by wrapping p4d_set_huge() and p4d_clear_huge() in
>   #if CONFIG_PGTABLE_LEVELS > 4;
> - Rebased onto current tip/master;
>
>Kirill A. Shutemov (3):
>  x86/64/mm: Always use dynamic memory layout
>  x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory model
>  x86/64/mm: Make 5-level paging support unconditional
>
> Documentation/arch/x86/cpuinfo.rst            |  8 ++---
> .../arch/x86/x86_64/5level-paging.rst         |  9 ------
> arch/x86/Kconfig                              | 32 ++-----------------
> arch/x86/Kconfig.cpufeatures                  |  4 ---
> arch/x86/boot/compressed/pgtable_64.c         | 11 ++-----
> arch/x86/boot/header.S                        |  4 ---
> arch/x86/boot/startup/map_kernel.c            |  5 +--
> arch/x86/include/asm/page_64.h                |  2 --
> arch/x86/include/asm/page_64_types.h          | 11 -------
> arch/x86/include/asm/pgtable_64_types.h       | 24 --------------
> arch/x86/kernel/alternative.c                 |  2 +-
> arch/x86/kernel/head64.c                      |  4 ---
> arch/x86/kernel/head_64.S                     |  2 --
> arch/x86/mm/init.c                            |  4 ---
> arch/x86/mm/init_64.c                         |  9 +-----
> arch/x86/mm/pgtable.c                         |  2 +-
> drivers/firmware/efi/libstub/x86-5lvl.c       |  2 +-
> scripts/gdb/linux/pgtable.py                  |  4 +--
> 18 files changed, 13 insertions(+), 126 deletions(-)

I think i am too late, however this is completely wrong. There are still processors that doesn't support
5-level paging which is mordern. We may call those processors old, however they are still common and used.

So this patch seem too early for that. Some intel core-i5 and core-i7 doesn't support 5-level paging at all.

This will break x86_64 cpus that doesn't support 5-level paging.

