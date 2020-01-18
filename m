Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF5C141630
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2020 07:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgARGav (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 18 Jan 2020 01:30:51 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38738 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgARGav (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 18 Jan 2020 01:30:51 -0500
Received: by mail-qv1-f67.google.com with SMTP id t6so11751840qvs.5
        for <linux-efi@vger.kernel.org>; Fri, 17 Jan 2020 22:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rS4UKrLn3wFLir64JOAKmcnkWFvXo9oMWz1xNRyZqa0=;
        b=eUVvGMBgNG2WezfPIJ1ccDmNM3UaJoZwBsbIm/Ki9yMpPQy6NV7WJJhLbvBPQNjSQ3
         ggeNc6ZaiM2MJ/Vke9Qy7r5/J56CeKxXiTkRD1P1on2O4HNJV2DR1MsnzCQArVW67b4X
         GRHi4sw5un0fhmqzIWs9JLrvHF9HR6Q1zbDFY16N2A1JbijP9GgRJtchhukzUGrvRV+n
         9u/vLtHHBH7S21eTB5Eq02DOpz7NxtbJPOQQNm/uh5ZnR6j1cmF6Jv14ar31cjx8lJrp
         c78WDrseoY1eLEqNkp3CJdOrioyoIr2Le51RJG9obtDFK1nnZ12YLkpwUywf3pwuTOYA
         kIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rS4UKrLn3wFLir64JOAKmcnkWFvXo9oMWz1xNRyZqa0=;
        b=YDak6CcetAcDAwlBXouy6JcZ5Kw6ljs8FTQZc5rYzWeeB6Ls3qkrgb62i51WeFfR4f
         dTN3izLwfT8TnS8GbC5hrcbmQtedO3pQixqt+m3XYKnKDv4nexFB6k6pkvG5vUogIJkP
         qy5keFEWWCaAlf/ETKEsj7dssY1bXkMeOk7E8hquJBL2QdiEwlEkIL2rW2ak+0YvSf3C
         i9DZrMOUT0ckXe5VgQ0u+AFrscyPKyta9+JFgVJyzPF0AvZSgwYfR/8zzDYSe+Mh67QY
         f9tjnBSaxM1ammJpVSKssWnCargYqOF0HYr8WGxodB4EIHULHCUtH20vt/jEYuAwwxzB
         +Cmg==
X-Gm-Message-State: APjAAAUfYpsVWu5z284RKrGcB/WylBjNQHs8D4kHHYIOtGID47wRcAZU
        VxJYMGsdDL/gJ2nsrCHsLzOqIw==
X-Google-Smtp-Source: APXvYqwFtyLPY35Rjn8MlhEuM8fKyPTWbIggJ/o3RgaUDrwdDQPhT7VsTctTG0u+82iwEy222pk2DA==
X-Received: by 2002:a05:6214:287:: with SMTP id l7mr11513554qvv.142.1579329050165;
        Fri, 17 Jan 2020 22:30:50 -0800 (PST)
Received: from ovpn-120-112.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u55sm14693498qtc.28.2020.01.17.22.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2020 22:30:49 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     ardb@kernel.org
Cc:     mingo@redhat.com, kasan-dev@googlegroups.com,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] x86/efi_64: fix a user-memory-access in runtime
Date:   Sat, 18 Jan 2020 01:30:22 -0500
Message-Id: <20200118063022.21743-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The commit 698294704573 ("efi/x86: Split SetVirtualAddresMap() wrappers
into 32 and 64 bit versions") introduced a KASAN error during boot,

 BUG: KASAN: user-memory-access in efi_set_virtual_address_map+0x4d3/0x574
 Read of size 8 at addr 00000000788fee50 by task swapper/0/0

 Hardware name: HP ProLiant XL450 Gen9 Server/ProLiant XL450 Gen9
 Server, BIOS U21 05/05/2016
 Call Trace:
  dump_stack+0xa0/0xea
  __kasan_report.cold.8+0xb0/0xc0
  kasan_report+0x12/0x20
  __asan_load8+0x71/0xa0
  efi_set_virtual_address_map+0x4d3/0x574
  efi_enter_virtual_mode+0x5f3/0x64e
  start_kernel+0x53a/0x5dc
  x86_64_start_reservations+0x24/0x26
  x86_64_start_kernel+0xf4/0xfb
  secondary_startup_64+0xb6/0xc0

It points to this line,

status = efi_call(efi.systab->runtime->set_virtual_address_map,

efi.systab->runtime's address is 00000000788fee18 which is an address in
EFI runtime service and does not have a KASAN shadow page. Fix it by
doing a copy_from_user() first instead.

Fixes: 698294704573 ("efi/x86: Split SetVirtualAddresMap() wrappers into 32 and 64 bit versions")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/platform/efi/efi_64.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 515eab388b56..d6712c9cb9d8 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -1023,6 +1023,7 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
 						u32 descriptor_version,
 						efi_memory_desc_t *virtual_map)
 {
+	efi_runtime_services_t runtime;
 	efi_status_t status;
 	unsigned long flags;
 	pgd_t *save_pgd = NULL;
@@ -1041,13 +1042,15 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
 		efi_switch_mm(&efi_mm);
 	}
 
+	if (copy_from_user(&runtime, efi.systab->runtime, sizeof(runtime)))
+		return EFI_ABORTED;
+
 	kernel_fpu_begin();
 
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
-	status = efi_call(efi.systab->runtime->set_virtual_address_map,
-			  memory_map_size, descriptor_size,
-			  descriptor_version, virtual_map);
+	status = efi_call(runtime.set_virtual_address_map, memory_map_size,
+			  descriptor_size, descriptor_version, virtual_map);
 	local_irq_restore(flags);
 
 	kernel_fpu_end();
-- 
2.21.0 (Apple Git-122.2)

