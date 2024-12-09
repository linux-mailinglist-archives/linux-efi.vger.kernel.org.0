Return-Path: <linux-efi+bounces-2336-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748089E9DF5
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 19:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F4B1886EB2
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2024 18:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D546155325;
	Mon,  9 Dec 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jzb9gdAf"
X-Original-To: linux-efi@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCE7143C5D;
	Mon,  9 Dec 2024 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768455; cv=none; b=bbmxN+NAJE196VMuQkJAddDN3rE5UJFKlXZGHAa8cikP2Yomrkmt7sVe/oY83UEo9uooVsa7jAiOT/z2stvnAaS6vqQBeIR//fPH6KhmnGY14xK4XphwHet2L1uWNqU4b34LYkxyNk2qYKw7VVbyPXPMIroKRCWFuQ4FWG6Xf9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768455; c=relaxed/simple;
	bh=NK3UFV7EKNpDsXjKqgORVDaoYl9lZUCsUJf7g9bSxcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hv5jyM4SvUtcLs3pNZsRc7MQyi7K8upkLATgasiNYzAXbf7DlsVobA686WbGhIuXPY+SVdDsyIcFTsqYfio+LYQlOsWtC9ECyYmz4JIGC0SgsBu2KeE4jir0j9FMyGwXFRYV/gjZ664c1GNobl7rM3TgTlkUL/7EgB2bUuN7AY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jzb9gdAf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2.corp.microsoft.com (bras-base-toroon4332w-grc-63-70-49-166-4.dsl.bell.ca [70.49.166.4])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7A24620ACD6A;
	Mon,  9 Dec 2024 10:20:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A24620ACD6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733768454;
	bh=5zd+oLHB1Vo8goyu8DBTM7DCBRJbVW6fr4oIy2s1vvo=;
	h=From:To:Cc:Subject:Date:From;
	b=jzb9gdAfF9LsvV/GJcBovdYgsXdo+9EgUixG7/cIc2kWyzGy5yanELcKLB8d6/nTa
	 QQG6EEg9Nlh/JvcJz6cfA/AoSU3+vXl5F2E/2boLIrHbv/gdLXu0heE0rJq4NRp/h+
	 4akNkzRQYVPpgTr1Dw3Q3dby3cO62aCNpCx0TdeY=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-efi@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	stable@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Allen Pais <apais@linux.microsoft.com>,
	Tyler Hicks <code@tyhicks.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Marek <jonathan@marek.ca>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] efi: bump up EFI_MMAP_NR_SLACK_SLOTS to 32
Date: Mon,  9 Dec 2024 13:20:39 -0500
Message-ID: <20241209182041.60286-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent platforms require more slack slots than the current value of
EFI_MMAP_NR_SLACK_SLOTS, otherwise they fail to boot. The current
workaround is to append `efi=disable_early_pci_dma` to the kernel's
cmdline. So, bump up EFI_MMAP_NR_SLACK_SLOTS to 32 to allow those
platforms to boot with the aforementioned workaround.

Cc: stable@kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Allen Pais <apais@linux.microsoft.com>
Cc: Tyler Hicks <code@tyhicks.com>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 drivers/firmware/efi/libstub/efistub.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 76e44c185f29..e95ce6ae5c26 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -171,7 +171,7 @@ void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
  * the EFI memory map. Other related structures, e.g. x86 e820ext, need
  * to factor in this headroom requirement as well.
  */
-#define EFI_MMAP_NR_SLACK_SLOTS	8
+#define EFI_MMAP_NR_SLACK_SLOTS	32
 
 typedef struct efi_generic_dev_path efi_device_path_protocol_t;
 
-- 
2.47.1


