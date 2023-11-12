Return-Path: <linux-efi+bounces-44-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CFA7E8E83
	for <lists+linux-efi@lfdr.de>; Sun, 12 Nov 2023 07:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11F4280CF2
	for <lists+linux-efi@lfdr.de>; Sun, 12 Nov 2023 06:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A20433E3;
	Sun, 12 Nov 2023 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rsp148KX"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A082568
	for <linux-efi@vger.kernel.org>; Sun, 12 Nov 2023 06:13:49 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4742C2D46;
	Sat, 11 Nov 2023 22:13:48 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso30423885ad.3;
        Sat, 11 Nov 2023 22:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699769628; x=1700374428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7eOU/FVQME/8M+ZotWOiPunL1mimnTtMUIxdT/VvjGk=;
        b=Rsp148KXcLRZqBkxGX2iOnwmHm9YDl9BqreImCEFlKRSjrnCcgoe5qrTEsF/sq5hU8
         HUUqYXG9OvM+xlFFuT4d4AVZgv25tkiBMCb2OAuUoxofJfnBbBmtcr73t3pebn+BC97M
         oG93UJoIP2N4Lb645p/xUlPZ++/iCte1W6jA/9DaOheVH9kw3aSWtndGHj9cvXjK1VD4
         5qI/ybd8tP5GYht3Wf1b+XxQ4+IVQgXD7OZS/fIVSFOj/drMl9FPeQEdGV7pPCIHVe3k
         aUtECr97iwzY+h0CEOgcjchhw7LLc1ffQL1287OYuPjXnuRFnTpv5m9YXD3vZN5GXSH5
         hrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699769628; x=1700374428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eOU/FVQME/8M+ZotWOiPunL1mimnTtMUIxdT/VvjGk=;
        b=R+mVXU+P9mUC29+WccLuQN6n9UIwiXLHJaLkJ/BQqqlkiU5cfeJV6C9q10t5o/awN6
         zKt6ZOdhB4CWkhM7rSRUQLWzxU3kQ5vyjqUKNlu+kbGGKLDaOqYzi9fbhmZV3XWZllvi
         u+LnGNBrpq9/aawSwOhlNDDWytJvjT9AOcK7ic7ZhPzJ0a5dv1FsGq6wQi6DxCFfN1D6
         D9epfE3Q0UGzwerfceWhvpyNrGKf28qZeikQYiQ2Sa8xs8VZnIJL0s92rp80EMG4HNuz
         u2X5lAN7TwmHgaa2dCzNyTGardzyuyvPXnWRDIlkB6oMueOlyWfxKeeK1YETPmPQ/h1a
         Bg/Q==
X-Gm-Message-State: AOJu0YzWxJbQ4kwXJqeBN8G+ispAnb0cO0npEtJf7p1Kl46TwKnTME+Y
	GcP/lTkVxRmr6nugQYAPIEM=
X-Google-Smtp-Source: AGHT+IGy3DkHuF8vM7kFMYga9vnuoKWMVEH9Sqhe7qkgbshJvCdmkxHleF8+j++EdBQb4OanYYAqAQ==
X-Received: by 2002:a17:903:124b:b0:1cc:3f10:4175 with SMTP id u11-20020a170903124b00b001cc3f104175mr4644630plh.28.1699769627644;
        Sat, 11 Nov 2023 22:13:47 -0800 (PST)
Received: from localhost.localdomain ([112.96.230.35])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001c72f4334afsm2104384plg.20.2023.11.11.22.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 22:13:47 -0800 (PST)
From: "shiqiang.deng" <shiqiang.deng213@gmail.com>
To: ardb@kernel.org,
	bp@alien8.de,
	kirill.shutemov@linux.intel.com
Cc: linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"shiqiang.deng" <shiqiang.deng213@gmail.com>
Subject: [PATCH] x86/efistub: resolve compilation errors
Date: Sun, 12 Nov 2023 14:13:20 +0800
Message-Id: <20231112061320.85149-1-shiqiang.deng213@gmail.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

I found that under the conditions of
CONFIG_EFI_HANDOVER_PROTOCOL=y and CONFIG_EFI_MIXED=y,
there is a missing-prototypes error for the efi_handover_entry() function.
Let's now fix it.

Signed-off-by: shiqiang.deng <shiqiang.deng213@gmail.com>
---
 drivers/firmware/efi/libstub/x86-stub.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.h b/drivers/firmware/efi/libstub/x86-stub.h
index 37c5a36b9d8c..aa020f88ce68 100644
--- a/drivers/firmware/efi/libstub/x86-stub.h
+++ b/drivers/firmware/efi/libstub/x86-stub.h
@@ -8,6 +8,11 @@ extern const u16 trampoline_ljmp_imm_offset;
 void efi_adjust_memory_range_protection(unsigned long start,
 					unsigned long size);
 
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
+void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
+					struct boot_params *boot_params);
+#endif
+
 #ifdef CONFIG_X86_64
 efi_status_t efi_setup_5level_paging(void);
 void efi_5level_switch(void);
-- 
2.30.0


