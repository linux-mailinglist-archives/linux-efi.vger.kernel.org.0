Return-Path: <linux-efi+bounces-5088-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A88C0BFE5F8
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 00:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC20189DED0
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 22:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EFF2D0601;
	Wed, 22 Oct 2025 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfbhPeEy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7582737EB
	for <linux-efi@vger.kernel.org>; Wed, 22 Oct 2025 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170893; cv=none; b=E16T9GZ3N68qUBmgQTvVU1HQxX49JiMIb4y5P6hObW6kg7Dr+NczdQLbT4BRRh5Y+FkJc2dcQgA2lTnDKv9+F2yl7b95wkxzyj3TfBiUguMI8efshaSasAEadM4Ie7MVgvYpTUfnM6uRHHeblgxiYpZD1SDDZ3PvZnED6DE/gxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170893; c=relaxed/simple;
	bh=94Qlr/Rj9e3g/GYu+xAfDE8dPghucJMHFBk4t2pKjvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBMUohW4rUmcdCa2P3kTDIvQNsJp0XW5znQ0zfRL47sNedxy2jZkzDUuCc+aA4GnCO/S8dpf87WDNekYeDhiWhkpqv6ryKyR7IngV8NrZfHlRGJYmqyozeOvramLbxpXk0dsICrPBlyKoxY+ihvqggDMaoRZ1pC/WMC4oDQ4kcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfbhPeEy; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78487b0960bso986467b3.2
        for <linux-efi@vger.kernel.org>; Wed, 22 Oct 2025 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761170891; x=1761775691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XYPBLl8lEjNb2771iKm9ddg/BP0hYG7IxkPUeJF/g00=;
        b=WfbhPeEyqEVXoOBN4c0CjaaCwtQ8nfMQuAnF7JTU3ApxHkaUYt8s061CgycZl0Ml/9
         tHkqyVvELd58pKSafy5cVdCto15NI0+adzgyfo0p8W9pkk8OvairLkat3YMa5MuUexYc
         uNY5alv6xsk+fbhXwWlVKh+5z5r3fdveGKeDhlh6vgaLgm7wJno7lH8q2S3PgI30ROoT
         TNX9lJaI13T6gXemoYWRzWkjg83QQ0l0J9lWWTYydVjizm1xhEAY0OxCYkore3BbjLfv
         lIfGECwkM+B33nQrDcpatLe/4L4NOoqgMEXmx/GcWpdLk3I2omp4J2vcGfob9iFCFNic
         ke2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761170891; x=1761775691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYPBLl8lEjNb2771iKm9ddg/BP0hYG7IxkPUeJF/g00=;
        b=wgNw4WW9JosbrHwX1bGsAhAcys2aQM8WyWS0PNT6+KO/F1ASoEpNYYtmFQUECdp43f
         ivHmbjgLZzegLgqIyrZqnisLOdEni5BsX25OPZ9PMdcuvqEIBK85IMU2GN02POe2CUR2
         8Z46FxOMjHqMlxlrFp6w556E6OoeIiYHeZ5u3bQnxZilcFV1Aim3BfpBFwCHJAFIWhzj
         f9ilouUe6Ma1E+MGOn+ypGp+TkWvUxEzeic/kWRFNAQ9pkUhgMIE1MHb0JpxiIfWvUBK
         heYYGwLpajY5m4nrAaiWXC/kn6Nh3rzE0N53Py8wvPujoM+JRNBj+z0GfoAcSjQR+9Lk
         lHTw==
X-Forwarded-Encrypted: i=1; AJvYcCV6+EwvPbk9/KLwt03j7ncM3f3lpILyQyIq17OzuL6Cze9S5KF6VAS6E8vCXCVEUGy3q3avGBFaoOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE+N9JquwnnFt7/zwHm5h5e/Dm4tOFrwluwX1Qu0UtBCNYpsqf
	4X8pGRBUBrJ7vqL/ZiCe3iZFQChNKqZJ9n/gsS7UOASYwRvmW/MehHJn
X-Gm-Gg: ASbGnctphSH+1JBohGxi7PNon7ex0mOIRoaItSX2DaaUGLD8b1fQw2NajsEQayHYwDo
	XcC55Ps0cx/vMMDWJoz7G+pGVEbdPZCdtWfi8Y57OGRff5YCrETIngZW58I+y7eG24vfInQt1YW
	quMtvGUP/hoxGVnj/inwhGTH3oOnQHVeNu4trTu2OorRlN0SUohGW0bxYB8lusqt18rLDwFcFOk
	k7EGA4B5AjEe3ikEWwXrCySvKMz417pcegY+MYpKm26rgK3kFHJ4n2Q5vIsk+O45UOmOzdKzoD0
	pHce6EcmljglqdyNkLknw/uY97FRcGf1f0HrNNdEXE8rnMK5CBcaEbDuESHVEW1y0Bi8xxkHKq5
	DxyVBkaS7ax5iLccsbZVPzMlOniQKj/DsHT1xDzzz8LAsh6uJJGMwBDd7axLDL+qhrULS8/KS3C
	0onfrBY1heGF8cCtBgTB8=
X-Google-Smtp-Source: AGHT+IFu4hN4ipSSzPrzhwFT7gQ83AT90It480qBPOB8KCTNDJfSxNZBI5oOkdrpgpWQnaZvr+WVow==
X-Received: by 2002:a05:690c:9c0e:b0:77e:dc10:1b29 with SMTP id 00721157ae682-785cda64315mr4655617b3.24.1761170890635;
        Wed, 22 Oct 2025 15:08:10 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd4584casm1358607b3.0.2025.10.22.15.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:08:09 -0700 (PDT)
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
Subject: [PATCH 0/3] x86: Fix kexec 5-level to 4-level paging transition
Date: Wed, 22 Oct 2025 23:06:24 +0100
Message-ID: <20251022220755.1026144-1-usamaarif642@gmail.com>
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
transition. Specifically p4d value is masked with PAGE_MASK instead of
PTE_PFN_MASK, failing to account for high-order software bits like
_PAGE_BIT_NOPTISHADOW (bit 58).

When bit 58 (_PAGE_BIT_NOPTISHADOW) is set in the source kernel, the target
4-level kernel doesn't recognize it and fails to mask it properly, leading
to kexec failure.

This series fixes the issue in three parts:

Patch 1: Fixes the x86 boot compressed code path by replacing direct CR3
dereferencing with read_cr3_pa() and using PTE_PFN_MASK instead
of PAGE_MASK.

Patch 2: Applies the same fix to the EFI stub code path. (Done in a
separate patch as Fixes tag is different).

Patch 3: Moves _PAGE_BIT_NOPTISHADOW from bit 58 (_PAGE_BIT_SOFTW5) to
bit 9 (_PAGE_BIT_SOFTW1), which is already properly masked by
older kernels. This provides backward compatibility without
requiring patches 1 and 2 to be applied to all existing kernel versions,
which is not feasible for production systems or live patching.

Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>

The patches are based on aaa9c3550b60d6259d6ea8b1175ade8d1242444e (next-20251022)
 
Usama Arif (3):
  x86/boot: Fix page table access in 5-level to 4-level paging
    transition
  efi/libstub: Fix page table access in 5-level to 4-level paging
    transition
  x86/mm: Move _PAGE_BIT_NOPTISHADOW from bit 58 to bit 9

 arch/x86/boot/compressed/pgtable_64.c   | 8 +++++---
 arch/x86/include/asm/pgtable_types.h    | 4 ++--
 drivers/firmware/efi/libstub/x86-5lvl.c | 5 ++++-
 3 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.47.3


