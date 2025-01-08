Return-Path: <linux-efi+bounces-2542-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955E7A067B1
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 23:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672637A23FF
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2025 22:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5346B2046BB;
	Wed,  8 Jan 2025 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8k0eeHq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B1B204691;
	Wed,  8 Jan 2025 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736373626; cv=none; b=hi73YGRPF1IbwJ6Wp4UQpg6wZuzJSUi65t0pHngED48Y2jaNDqLx1mVotsYquVz2XvvBynbIidMAaDVpMpMrg+uwkmJxvDSg+7XqKZnRLljE0OmB1CcbKpuBbJbz88BgPLXhPDP2FolGsey4ZZwHskys4u6UzBDHqckQ7BjuTHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736373626; c=relaxed/simple;
	bh=Y+WgUfynyOBUqrX4LzYlmSPUviTCw17bcczlXFW5F4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+FOsEfac7SV99mE86+h8c7GFVRO8QnPX+gzGbAZPFfGVonKlgwmDn7bIvgIQmRnX57kGkDB2HanCtM/fKpuvfRPaABgBmWmbzjr5LDM9tLeNbeFDaB9AQ76Q5TdPsniLZeEJJYhWtmSE7yV5JbYjtifGyPmacu4eyzvIXwA6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8k0eeHq; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d8e8445219so2870646d6.0;
        Wed, 08 Jan 2025 14:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736373623; x=1736978423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lxzi816vsV82LbZekUeaxCWiwSFstfTOO/juIDysp+o=;
        b=b8k0eeHqA+KUsN7W1UW/XP1xdbqH2H6/z0f7T7HOrMgGWBhC/6HHl09Uzjgmh2+6GO
         dRNLqF0mWcvUeFAC+62PBsN5TblPQ8RP+RGyOGL8h8ACBJqIm67HprWBSHpo8N2QGv4u
         4BU5vWJxRzeF4oApqkmXKFhNjEb6+iCzaMpOpQAnXv4KBw88r80l4MNZ9VuYolTts7K2
         6r7r/pA3qfDf2r0gLVf/RZHSkxvBivp9/KCJhyopM6vLy49/0i65WFoHoe53uYs+HxCh
         dyBCl4CUrQrz9RvTycYr84gvY6ASm5ZMNo/vFlIZ6ASy7eBVhS4IDg5duabKOiXwi4Tx
         k79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736373623; x=1736978423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lxzi816vsV82LbZekUeaxCWiwSFstfTOO/juIDysp+o=;
        b=X95eHl+6YkesqRm4ny0IIUvemhpmaQjlEMQwE2OwIa+Zc76W8I2U0mdTh3EvC70PJm
         8qe2j6cC3QW+xIQyOuraklfILIvOozIbqlmWBf00mjkReKkQT4LIKsQwe0du2rav6vLz
         Ud0t56qEK4JyuOVbd5snwwT7S/rjZkNDBWBdYk7mwPaHeLWtbV0VjnWX+WNcV7A5S7v0
         YEmhmRPrkMl/USET4jwagKNlo6iXbqh9DCmlm9oodbQb57MDmw0F/VKax0tsBghti1Ej
         AfxYi0HwIwMuJC27cIF+DeArFQK1O/T4/uc0Qw26YA7BOjEzTiVCdOt3tV4YD4Nbz8u6
         v4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUHYKy/LdrSWop8JrDQwO1Ppl+iWS4qTe1rIvUgL7NQD5DIP8Nd0RJ9H1r9nX5AAYPzqzizlW683zUhzQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuW8dtTGK7u6ucNMDHeW2LaAObvNsUrD9+L2KKB+fLu8e0Zkal
	yrRi3xmwpAe5YhiuKohmIZzAXyOhJhvF2qXyHp3+Rl8wRH168qD76GStIF3l
X-Gm-Gg: ASbGncvj8rU2Ne5E5wJn14E1a3TDvWCkA5MANaRAhj8tAvUX1gF7nw5ltIYCwWCttYv
	c1b1weNoRdu04+pa4NM2KpBBRYTOv6L5sZLuIv8e/3xdMTs2Vwcg2q5yjzMZR0CJh5VEReqajuJ
	5iCqbrNjzPRAdKWXgCs7sxqEoU9xsnwW3yM0Yjf2O/1LJQ7RWEZn8K9YlMPw+adIEQpdbuo8DSF
	k9cfNjhObwTJhAq3JnclL/sRIcgV355aQtvxtznB/pqBgMkDU3H4w==
X-Google-Smtp-Source: AGHT+IERhB4z90VYqb4Dv2R+PhhDYDodptRvo0eGmXLkrsvBtS5WFJP/mvaGuTVc1PGcKc2NU8POeg==
X-Received: by 2002:a05:6214:3008:b0:6d4:2646:109c with SMTP id 6a1803df08f44-6df9b1cf3c5mr54781556d6.3.1736373623069;
        Wed, 08 Jan 2025 14:00:23 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:6::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181372easm195398346d6.63.2025.01.08.14.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 14:00:21 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: linux-efi@vger.kernel.org,
	devel@edk2.groups.io,
	kexec@lists.infradead.org
Cc: ardb@kernel.org,
	hannes@cmpxchg.org,
	dyoung@redhat.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	leitao@debian.org,
	gourry@gourry.net,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved region in 820_table_firmware
Date: Wed,  8 Jan 2025 21:53:37 +0000
Message-ID: <20250108215957.3437660-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250108215957.3437660-1-usamaarif642@gmail.com>
References: <20250108215957.3437660-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When this area is not reserved, it comes up as usable in
/sys/firmware/memmap. This means that kexec, which uses that memmap
to find usable memory regions, can select the region where
efi_mem_attr_table is and overwrite it and relocate_kernel.

Since the patch in [1] was merged, all boots after kexec
are producing the warning that it introduced.

Having a fix in firmware can be difficult to get through.
The next ideal place would be in libstub. However, it looks like
InstallMemoryAttributesTable [2] is not available as a boot service
call option [3], [4], and install_configuration_table does not
seem to work as a valid substitute.

As a last option for a fix, this patch marks that region as reserved in
e820_table_firmware if it is currently E820_TYPE_RAM so that kexec doesn't
use it for kernel segments.

[1] https://lore.kernel.org/all/20241031175822.2952471-2-ardb+git@google.com/
[2] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Core/Dxe/Misc/MemoryAttributesTable.c#L100
[3] https://github.com/tianocore/edk2/blob/42a141800c0c26a09d2344e84a89ce4097a263ae/MdeModulePkg/Core/Dxe/DxeMain/DxeMain.c#L41
[4] https://elixir.bootlin.com/linux/v6.12.6/source/drivers/firmware/efi/libstub/efistub.h#L327

Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 arch/x86/include/asm/e820/api.h | 2 ++
 arch/x86/kernel/e820.c          | 6 ++++++
 arch/x86/platform/efi/efi.c     | 9 +++++++++
 drivers/firmware/efi/memattr.c  | 1 +
 include/linux/efi.h             | 7 +++++++
 5 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index 2e74a7f0e935..4e9aa24f03bd 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -16,6 +16,8 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
 
 extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
+extern u64  e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
+					enum e820_type new_type);
 extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
 extern u64  e820__range_update_table(struct e820_table *t, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
 
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 82b96ed9890a..01d7d3c0d299 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -538,6 +538,12 @@ u64 __init e820__range_update_table(struct e820_table *t, u64 start, u64 size,
 	return __e820__range_update(t, start, size, old_type, new_type);
 }
 
+u64 __init e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type,
+				       enum e820_type new_type)
+{
+	return __e820__range_update(e820_table_firmware, start, size, old_type, new_type);
+}
+
 /* Remove a range of memory from the E820 table: */
 u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
 {
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index a7ff189421c3..13684c5d7c05 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -168,6 +168,15 @@ static void __init do_add_efi_memmap(void)
 	e820__update_table(e820_table);
 }
 
+/* Reserve firmware area if it was marked as RAM */
+void arch_update_firmware_area(u64 addr, u64 size)
+{
+	if (e820__get_entry_type(addr, addr + size) == E820_TYPE_RAM) {
+		e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		e820__update_table(e820_table_firmware);
+	}
+}
+
 /*
  * Given add_efi_memmap defaults to 0 and there is no alternative
  * e820 mechanism for soft-reserved memory, import the full EFI memory
diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index d3bc161361fb..d131781e2d7b 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -53,6 +53,7 @@ int __init efi_memattr_init(void)
 	size = tbl->num_entries * tbl->desc_size;
 	tbl_size = sizeof(*tbl) + size;
 	memblock_reserve(efi_mem_attr_table, tbl_size);
+	arch_update_firmware_area(efi_mem_attr_table, tbl_size);
 	set_bit(EFI_MEM_ATTR, &efi.flags);
 
 unmap:
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e5815867aba9..8eb9698bd6a4 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1358,4 +1358,11 @@ extern struct blocking_notifier_head efivar_ops_nh;
 void efivars_generic_ops_register(void);
 void efivars_generic_ops_unregister(void);
 
+#ifdef CONFIG_X86_64
+void __init arch_update_firmware_area(u64 addr, u64 size);
+#else
+static inline void __init arch_update_firmware_area(u64 addr, u64 size)
+{
+}
+#endif
 #endif /* _LINUX_EFI_H */
-- 
2.43.5


