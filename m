Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06B41F4EAC
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jun 2020 09:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgFJHO6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Jun 2020 03:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgFJHO6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 Jun 2020 03:14:58 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1431CC03E96B;
        Wed, 10 Jun 2020 00:14:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v24so614920plo.6;
        Wed, 10 Jun 2020 00:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQFi+lcF05CW4Ej031KV81/AVIbBtZMykD/fLL3QP5Y=;
        b=bdKFjNSWC2yCB1RKei6u4m0vXXlkskpgU+WnywsEAkV95t09Oj0xHI6WJUTqGriyb7
         Q+EKTxRFjo4dWUwcP1GlBX5ORj/+XYgaNalxQH0rr2fVfYe+PlZ+SpVfVu0w3wnPL0Dw
         +Wj9ixr9/nqzWyZ8ijFC4hiO11RnAC5j/mzAzXlJoZzG2pcMORtzVAkD6bMGNZprBrdX
         5bJFjQeLMb6QOIsGelnjJNrL3+fSgFni1jv+v3xG06p+V84P/dVpFoY/v2StxjGDYhAI
         s2Vmr8n18JrIjgoY3c55ICVA0Y4Nulz49uMnLMffBiiwEP6K+Txj3L4MOWD/zoXdf2hC
         XOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQFi+lcF05CW4Ej031KV81/AVIbBtZMykD/fLL3QP5Y=;
        b=MmEtbGF+x9gvt7dNLW4x/mA2Y+YVze6M53iQ/8/6tYPnHk0YGJHcJ9L8vW8d/H6GfJ
         KDjNUQnG8z6enfcMcmLOlt21q2QCsik4px56uQzgRddJku7uU5G6/O5dU6azLZW6Gb2S
         G1KxT+EuM1Kj8uzQf4h66iojhZbYmfl94vMvXC+0w6h4CJ6X2BODjt2DBWDCfImI4C1Q
         beWiZJkf2Tmr4TLDRz7K9EKOusUUAywKPms4Fp38Q5e0o/DzNLxmxJchjZwLFVrvydop
         C2pIFrShz2FRtCe/rJktv8Gxh9AnDj1a3URN4FLwGwegHOurszZP/RAr6Z4JHHV/zxqv
         Ysiw==
X-Gm-Message-State: AOAM530lHPIfxkGkCUCwvawkDzZON1VAYUiTf6WqQzje2pFvLXlOmvta
        f77nMc2VyZ0MsaPp6gILVRrGwrFF
X-Google-Smtp-Source: ABdhPJxSIMHQUf8whPid8rW0EXwUfsfiMwZB6P1NTcxs2GVG4+xTOFaA56N8Uqefh7HHE+EFLV6XnQ==
X-Received: by 2002:a17:902:a585:: with SMTP id az5mr1838022plb.207.1591773296946;
        Wed, 10 Jun 2020 00:14:56 -0700 (PDT)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id q92sm4455003pjh.12.2020.06.10.00.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:14:56 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Cc:     ardb@kernel.org, nivedita@alum.mit.edu, keescook@chromium.org,
        mingo@kernel.org, Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH] efi/libstub: Fix build error with libstub
Date:   Wed, 10 Jun 2020 15:14:46 +0800
Message-Id: <20200610071446.3737-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Got below error during build:

  In file included from drivers/firmware/efi/libstub/efi-stub-helper.c:16:0:
  drivers/firmware/efi/libstub/efi-stub-helper.c: In function ‘efi_char16_puts’:
  arch/x86/include/asm/efi.h:355:3: sorry, unimplemented: ms_abi attribute requires -maccumulate-outgoing-args or subtarget optimization implying it
     : __efi64_thunk_map(inst, func, inst, ##__VA_ARGS__))
     ^
  drivers/firmware/efi/libstub/efi-stub-helper.c:37:2: note: in expansion of macro ‘efi_call_proto’
    efi_call_proto(efi_table_attr(efi_system_table, con_out),
    ^
  drivers/firmware/efi/libstub/efi-stub-helper.c:37: confused by earlier errors, bailing out

Fix it by adding -maccumulate-outgoing-args for efi libstub build
as suggested by gcc.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index cce4a74..25e5d02 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -6,7 +6,7 @@
 # enabled, even if doing so doesn't break the build.
 #
 cflags-$(CONFIG_X86_32)		:= -march=i386
-cflags-$(CONFIG_X86_64)		:= -mcmodel=small
+cflags-$(CONFIG_X86_64)		:= -mcmodel=small -maccumulate-outgoing-args
 cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
-- 
1.8.3.1

