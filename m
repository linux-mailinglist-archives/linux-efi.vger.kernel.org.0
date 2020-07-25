Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5D322D89D
	for <lists+linux-efi@lfdr.de>; Sat, 25 Jul 2020 17:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgGYP7T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Jul 2020 11:59:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41450 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGYP7T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 25 Jul 2020 11:59:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id l64so4746968qkb.8;
        Sat, 25 Jul 2020 08:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mMGEOs38oJF3yC1EryMyVjgRpVr9wn9qQ6Mpuxbj1sw=;
        b=YaMeFhFS/fbIvmX34LDJOnFowVYY8S92dfOjgQV3bMxOIKiDHbGdnnnjZkdQIBQAe1
         PCIi35Hh4b69L//UNwO5LX05HEcOi1yeay9RM8AyrTlIm23lxCw301vBLz5K92XnWnmP
         P468bcXh5xqZZxCkQCbGLUaAvlu9+PZFf5I+5NQ86pFORLzrW/94VxQVgf3gMaAIRzP1
         dISvBMxGFkbdLZSmQh9aaIbvfM4yjj8pf1SI0B+NgQV/QqQazM/xpRBj82HqcHLVupOV
         ETamVOlbX8kKWJPTe1vMCw2JY1B3mzgGyaBIJu1zcASdq4TGZb7Lj70cZCa23ivkgm7v
         Qh/g==
X-Gm-Message-State: AOAM533KMAbEHVpTsfCkdmS6FnzQ2942G9RgULevA3SG6xEP5IFbFp3Z
        7WxySTbFbypxViUwxj7ma7RHFikG
X-Google-Smtp-Source: ABdhPJxH3dFFWEp6cISIOWcwXAJHwpbjX0DvVEawFuC81dbhHVPxdxlf+zQ8GCdr5vFoRaqn2JVqAQ==
X-Received: by 2002:a37:a5c1:: with SMTP id o184mr10290360qke.323.1595692757808;
        Sat, 25 Jul 2020 08:59:17 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h15sm6126671qtr.2.2020.07.25.08.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 08:59:17 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] efi/libstub: Stop parsing arguments at "--"
Date:   Sat, 25 Jul 2020 11:59:16 -0400
Message-Id: <20200725155916.1376773-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Arguments after "--" are arguments for init, not for the kernel.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 6bca70bbb43d..37ff34e7b85e 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -201,6 +201,8 @@ efi_status_t efi_parse_options(char const *cmdline)
 		char *param, *val;
 
 		str = next_arg(str, &param, &val);
+		if (!val && !strcmp(param, "--"))
+			break;
 
 		if (!strcmp(param, "nokaslr")) {
 			efi_nokaslr = true;
-- 
2.26.2

