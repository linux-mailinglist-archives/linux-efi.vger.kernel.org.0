Return-Path: <linux-efi+bounces-5338-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E94C2C5B3
	for <lists+linux-efi@lfdr.de>; Mon, 03 Nov 2025 15:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE38D3A7818
	for <lists+linux-efi@lfdr.de>; Mon,  3 Nov 2025 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D02B2D12F3;
	Mon,  3 Nov 2025 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKkidALW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37DE13B5AE
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179008; cv=none; b=oZpmLhDyAU0qj4zvFzj+usK4cCgt9J0HBqAnf+5uBlEP3cJae78BOGtLuSdp2TlhtGfVYmWjG3L4R/1o3y3v3dxkCehx6L/5bOkhI265cC2RGZRA6YmohSQAyg/8fwC+wNonqWHLNe5Ehb/uqj5L8L6+pDTLMPGyt19KAg1c318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179008; c=relaxed/simple;
	bh=kvR+F866SCLceHUacVTlInqOmhhQYvk+JX3lcueuQxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bKQnU5VEuO2Xndo8rRV9As9JtkjU70F07R+nResDA3PfM7+4Dfin8okUYs1ykoj1JHev/vU5JAuVHfBohM0NOuMMRsTXbUz/IIb7Ag0HP8hhJwOc5ol2dxr2xZysomnPoURxpcXTANNZ+zvrHS5xSe5Ds32oJMdhXqZoFoZbA14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKkidALW; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7867497ad2fso14566417b3.0
        for <linux-efi@vger.kernel.org>; Mon, 03 Nov 2025 06:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762179006; x=1762783806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=69ZIdxIDNMyXZ/xRq3HrmYW4BOl2xzIyC5pgSkkI/HU=;
        b=hKkidALWt0Ysxm6eappFrc2IUZQmlAhBeXLwc7nIGt29/xwqEXTIha3lJoEdTndQZq
         Mh8TQ4IoGXvLxCSpb3+CniWyhHlyREK/trjnDptB+WMxZ5ZGOTTCi1Y1V/hjUvZLa7om
         L4voJnSt1gwuqoe63K2L+ynEvfeFVKXIuDL8ZyLNb3bZeIOP1bpkAY5OtM6zumUfn3EZ
         oUb23wT+c1CgVsdnjIiypTX4Tc9UDLlWa1bpcMiIitlrqCPfKQfdtKwMFs2+chaoXXhy
         Fr5EbmZHzGEfkL22bLp9TvgCO97jHrwgDYXaYJF3Zf4u4QJKUlmhyX9J7kRMZ1jFAOMn
         7ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179006; x=1762783806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69ZIdxIDNMyXZ/xRq3HrmYW4BOl2xzIyC5pgSkkI/HU=;
        b=xAxNKr0Ml4NBxws/ZeR3rJ4XN1PAXlwzn/K2UcAg063jhBWjFtQWR+NyjnYBPfD1do
         4AeeCeYpLlx0nPJjRMVm/1tKq7oj0pVTi3GU3yTvsjiRsLtrphTKfiukZFMToZa8AJLq
         4E2sCRrC73aDRN/r+6K9Dbi83eYkk6Ir7Qwe6nTeqnxYm8zSb2WPjh1XNutIjuTXGfr3
         Wd6sVBJWgq826yyS52yKbaA3ucDrc8fm42eyzuolUWSgRYEAoap0E9Zzivla43MJF0Os
         HtpLDvS30fpy7UEhfyQoz1kalbj6VlYGUCN2Q9OQzZ9CahY31lLnyhvxjOidZdkUWXqI
         KpMg==
X-Forwarded-Encrypted: i=1; AJvYcCWMDjvYczGvIbq75Jpz6l8IimW13tCPtQoG5fBVUoJjY7VG4ik6mEeHoB1t75OOlnwBIEvicPhWWJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfvfIbivDTjottQGRzu3vf0j/UYAVQceOafZqbxMmkiIoAAZ9o
	WVb2JsvfWD6BPyLvbnP+xdxC5KrjFPUpuiuHnuUrZ/M5hW3wYJJFopzs
X-Gm-Gg: ASbGncsmT+6CmEGkdQsQTYI2GrtMHFr+W4K4qR/Eobc2ciblieW5kqpXf2cUqXtxrQM
	T28dyoGP/XwkzlVhLmZJuCS8qv3EMr+/RLr4i4buawJzKXxBUypItL4ugHpe6R/3+Tuyk5TQFVh
	XrP/nQM+vbPQtEz5/ly+66ThZ/2zIokSFvqiFsvkUNNOhIyCwtVL1gQ8sA++nUBEe7RPsOyMZ86
	0dLuletjUN8VpM+B/6+ajmktcMt8LNbER0dqxKE5Fzpg9GA8Bofc/XHRxb4esOdhwIpF1teMMvw
	NTHIReVtwPnRjG9zIl7kdR9QxRRo8fArJnDMRzwc96bhvDf2qfWd8kL81YmO+Zsr5Dy2HTTctmL
	tATNGqLAD4WG4RrGvsXhgzOTSaROx5wo6i4wmS/KQIQkNguOehQm/EUuxloMX/6vlLmxNg0gtdH
	KXNlQysNk9bA==
X-Google-Smtp-Source: AGHT+IGD6jontoCLUBayhIbAtJav+5thxwXtcpelKDJ0KvQPHTZJga3plVryThbhDNEe0gpi2QFgWA==
X-Received: by 2002:a05:690c:4984:b0:786:706c:7e8d with SMTP id 00721157ae682-786706c8b65mr43383617b3.27.1762179005542;
        Mon, 03 Nov 2025 06:10:05 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-786920630a4sm837387b3.55.2025.11.03.06.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:10:04 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: dwmw@amazon.co.uk,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	hpa@zytor.com
Cc: x86@kernel.org,
	apopple@nvidia.com,
	thuth@redhat.com,
	nik.borisov@suse.com,
	kas@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	Michael van der Westhuizen <rmikey@meta.com>,
	Tobias Fleig <tfleig@meta.com>
Subject: [PATCH v3 0/2] x86: Fix kexec 5-level to 4-level paging transition
Date: Mon,  3 Nov 2025 14:09:21 +0000
Message-ID: <20251103141002.2280812-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses critical bugs in the kexec path when transitioning
from a kernel using 5-level page tables to one using 4-level page tables.

The root cause is improper handling of PGD entry value during the page level
transition. Specifically PGD entry value is masked with PAGE_MASK instead of
PTE_PFN_MASK, failing to account for high-order software bits like
_PAGE_BIT_NOPTISHADOW (bit 58).

When bit 58 (_PAGE_BIT_NOPTISHADOW) is set in the source kernel, the target
4-level kernel doesn't recognize it and fails to mask it properly, leading
to kexec failure.

Patch 1: Fixes the x86 boot compressed code path by replacing direct CR3
dereferencing with read_cr3_pa() and using PTE_PFN_MASK instead
of PAGE_MASK.

Patch 2: Applies the same fix to the EFI stub code path. (Done in a
separate patch as Fixes tag is different).


Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>

The patches are based on aaa9c3550b60d6259d6ea8b1175ade8d1242444e (next-20251022)

v2 -> v3:
- Use native_pgd_val instead of pgd_val to fix broken build with allmodconfig.
  I wanted to keep the code between pgtable_64.c and x86-5lvl.c consistent
  so changed it in both patches
  (Borislav Petkov and Ard Biesheuvel)
- Commit message improvements (Dave Hansen)

v1 -> v2:
- Remove patch 3 to fix kexec for source kernel in 5-level to 4-level
  transition where the 4 level kernel doesnt have patch 1 and 2 (Dave Hansen)
- Add include for asm/pgtable.h to fix build for x86_64-allnoconfig (kernel test bot)
- Use native_read_cr3_pa and for both paths (Ard Biesheuvel)
 
Usama Arif (2):
  x86/boot: Fix page table access in 5-level to 4-level paging
    transition
  efi/libstub: Fix page table access in 5-level to 4-level paging
    transition

 arch/x86/boot/compressed/pgtable_64.c   | 11 +++++++----
 drivers/firmware/efi/libstub/x86-5lvl.c |  4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.47.3


