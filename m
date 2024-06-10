Return-Path: <linux-efi+bounces-1187-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 463C19023E4
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 16:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB7CB291D4
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2B80639;
	Mon, 10 Jun 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4hHeUqQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10BC12F5BE
	for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028584; cv=none; b=mpWxtk9qDN1oRbYampbXkOC1Wgewa1wKpHKp56CuXsg92oT/ixjmEN46xHdCn2YVQUvQRxMoKr8kfyXi2CcxF7o1SjQA5/z0Btgw/ATLYWR39utfn/RZao9em3sVKjW/55KtsHxQukliBmMDHRkeJESI4i02KDQFgjTMKcuKJzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028584; c=relaxed/simple;
	bh=4aaAgEJ4no9Xmp4mAov9FrzUsh19wG6FNUPI7ez7R6M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lEdq7k1W7+IC0sxN+PITsDYCreuABu1Mo84eQymMudi1trLJ6TF/Kr34qLOjt35hOBbTI1RqZYHtpu4WAb6ZSkyVdIgJjB5XC+427ujbmFcxFnXNL9tILemFLeykxdfambdZp4CFei+6CM1d7Rdw1vDF5uEVv2MLvvc54g1ofo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4hHeUqQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df4d62ff39fso7591481276.2
        for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 07:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718028582; x=1718633382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dgenhHanHHj3lnmpj2N/ZQ5FyHhx2VF3uOYFtsXU2e4=;
        b=B4hHeUqQTdR9/6sc+/8ej7P3vjULmwRZVzp6Mmi2/PKlcTT2FMwIEglnJzb+y1+7Ig
         FggeewVtvTqSGj/eVHdNJdN3IRhId543Xj12DVjEfGjCxZLF/NwoaAtLewtHY6pQcPXJ
         JbSeQSr5xef5bwSL5gIxrHu4VayrJEIqgMJn5vaCx0KUec3mbamJk7hL0xpJ0l7zVDmL
         +aEa9mjt6YAoUn7GjB6Ls/SLg8rPH1/1XCQS/EbmGps901El864m2DvOm7Y5PcquneuH
         RNTfQfNKZWkvlExtBgH9tGT7/4fj2V41RgtnSxlN7iMdDSowmks9dAKpR/TH8P80x8LG
         j9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718028582; x=1718633382;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dgenhHanHHj3lnmpj2N/ZQ5FyHhx2VF3uOYFtsXU2e4=;
        b=sXF0xrbmgtqztI5M46N0EICcoSnyYEZCX0/rXuCMSv31PYx1jSEZWdvKS8zaqveNSD
         1BrI5UhiPl2/S5KYGicm1+2vUbTBKO64Lo/xIZiKEQqIfDZtPIwpOzKjsK6bcI43CN3J
         IfK0AjIlQez6aHrvNZCAdb0b/8AHn+JXkbeGB4DSc2yHCAmM6KpQZ2U4JTp/Epy/YRWt
         IOpJtJx12F8xTYggsJVCtqXdPAbGteF/1fe2Aydu/lg4yIMiupd3uj8NfqnrHqf+cQCt
         /aO0Bzw8XgjN/SvFiPpdQFkdPbD/lFak6XIaX29DY3qKsfTUNZYv9loNIa+4B4eds6Jk
         9Zvg==
X-Gm-Message-State: AOJu0YyXE1rekVyw/s+c1F/S7Qhf9wx2R6ob+7awOFYhYtynAz551FNA
	k/aYFfLOf4YkgPFta5Jn5CPJ0063LWFzVH0xYgSl0BzV++HAQYRypwHWaeIb60r8+Q6bW+E4ZlV
	X0ayIXqShk8CDbodfd+UWcwMI0M1/lKAxmHLFUo35JOGsZvAPBJj63L0l4vfGGcSaOrbOwlR5VS
	etYSpWytEbArTKNlZk3mNL8q6MTQ==
X-Google-Smtp-Source: AGHT+IHCyPKX79a5tm9JTqThqIgBdA0usaL7W5XvXzJtEvNSBvVv/Xx7RKZXpJ+F65zXBGGopWTjXMu4
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:70b:b0:dfb:210f:3ad5 with SMTP id
 3f1490d57ef6-dfb210f3d5cmr1232075276.11.1718028581873; Mon, 10 Jun 2024
 07:09:41 -0700 (PDT)
Date: Mon, 10 Jun 2024 16:09:33 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2783; i=ardb@kernel.org;
 h=from:subject; bh=7tiDVDTWIXbfAudS++fHHxGeLcuYd15jw6ZEmeO+/MU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS2dU9az1Pxb3uenUiVclcU1PN5qVm32v5zOOZyJKvD++
 ihkalZHKQuDGAeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmIjnP0aG26Ux2Xcmy3AcLN9+
 VjxE7nVQn75Ox6HN9hs9lM3ksv99ZPjv7HhEeN3/U5Zpp6wubl54XfX8c2M3mxpHI+YNmYsTrqz mBAA=
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240610140932.2489527-2-ardb+git@google.com>
Subject: [PATCH] x86/efi: Free EFI memory map only when installing a new one.
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Ashish Kalra <Ashish.Kalra@amd.com>, Dave Young <dyoung@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The logic in __efi_memmap_init() is shared between two different
execution flows:
- mapping the EFI memory map early or late into the kernel VA space, so
  that its entries can be accessed;
- cloning the EFI memory map in order to insert new entries that are
  created as a result of creating a memory reservation
  (efi_arch_mem_reserve())

In the former case, the underlying memory containing the kernel's view
of the EFI memory map (which may be heavily modified by the kernel
itself on x86) is not modified at all, and the only thing that changes
is the virtual mapping of this memory, which is different between early
and late boot.

In the latter case, an entirely new allocation is created that carries a
new, updated version of the kernel's view of the EFI memory map. When
installing this new version, the old version will no longer be
referenced, and if the memory was allocated by the kernel, it will leak
unless it gets freed.

The logic that implements this freeing currently lives on the code path
that is shared between these two use cases, but it should only apply to
the latter. So move it to the correct spot.

Cc: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lore.kernel.org/all/36ad5079-4326-45ed-85f6-928ff76483d3@amd.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/memmap.c | 5 +++++
 drivers/firmware/efi/memmap.c  | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
index 4ef20b49eb5e..4990244e5168 100644
--- a/arch/x86/platform/efi/memmap.c
+++ b/arch/x86/platform/efi/memmap.c
@@ -97,6 +97,11 @@ int __init efi_memmap_install(struct efi_memory_map_data *data)
 	if (efi_enabled(EFI_PARAVIRT))
 		return 0;
 
+	if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
+		__efi_memmap_free(efi.memmap.phys_map,
+				  efi.memmap.desc_size * efi.memmap.nr_map,
+				  efi.memmap.flags);
+
 	return __efi_memmap_init(data);
 }
 
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 3365944f7965..3759e95a7407 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -51,11 +51,6 @@ int __init __efi_memmap_init(struct efi_memory_map_data *data)
 		return -ENOMEM;
 	}
 
-	if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
-		__efi_memmap_free(efi.memmap.phys_map,
-				  efi.memmap.desc_size * efi.memmap.nr_map,
-				  efi.memmap.flags);
-
 	map.phys_map = data->phys_map;
 	map.nr_map = data->size / data->desc_size;
 	map.map_end = map.map + data->size;
-- 
2.45.2.505.gda0bf45e8d-goog


