Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789F8311F4
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2019 18:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfEaQFz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 May 2019 12:05:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37747 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEaQFz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 May 2019 12:05:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id y57so1509059qtk.4
        for <linux-efi@vger.kernel.org>; Fri, 31 May 2019 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DjNhKHlzP4NpT4FppWGQqOUxDm61aLRXlbul/68FN0c=;
        b=J54mNqWnAsUqfoo6Snrd0nt6rHdZUZGVIA8h1HkrYROKwApJcsyUPHXuVo5D5vgDSN
         2xThXTxduhEmpX4qIuiTxWqObBI6NZKlwtr4+3SrJwUsyTpI4qmLajgnuV+gluk6CFgd
         4GE32in3vruyTdsOnFaG3X7w2AfbfBT4DTIpqN3YwXWOVlqG2bYCq7a9R5YDdmeEhXbf
         KR/pKt45RQg9OEQU3vGVzHDcc55L6nNpcwNPtrzeegxYSU5X46qevKISjhuUnWGW3DMW
         vt9GLPhehySPkevDVhDxPRMGAOqcr8E2ytELNUUcgEDw144kSwMN6BR7uu357Y1c0pBb
         cyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DjNhKHlzP4NpT4FppWGQqOUxDm61aLRXlbul/68FN0c=;
        b=FdZsGhzC0hD7kx7gw3aocAxockpsi5FGmt/e2gmPBab6qV86wPwq31/HyWjuFNOeQ7
         q00Ks39ISJk3ZUtbw3qJLQZPtINFzyTI5wY2AjfJ6m9OK4nC2AKpOPgPryFRDHMgOq5c
         J37WT0kqOsgMewoRbMairyoudH9BrTZHqXXaKbvNMBx7Vue6lOJuOM8OYBeZ5g+JqJ/o
         4IMuoCtduB4oEW2FBpkC84LurNHoVzMbJuJqMowta7UJ+RhMlt9zx0s4hXW3v/yZcN3T
         PeKdL+2qPrtlaLZSUDfy/CwuYQLiIs5yuh3K3jqlLNZeF//D4ARfwu1m1U/VTpyNEbDr
         YnFg==
X-Gm-Message-State: APjAAAXuguYdvnQFTD3yL4+nrl3AIc42urtIsC6axvWUUDSjFOAu/kIE
        XrxEqs9/L1h6YWYK4LwT8kUx3A==
X-Google-Smtp-Source: APXvYqxJNBD7sPuLzVYvt1sEsFPROMBtqLJuc+rTnHFxP1OxTaqffPfJkEIBKsX40tRmy60nV+Zomg==
X-Received: by 2002:ac8:183a:: with SMTP id q55mr10085427qtj.23.1559318754496;
        Fri, 31 May 2019 09:05:54 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o71sm5181164qke.18.2019.05.31.09.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:05:53 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     ard.biesheuvel@linaro.org
Cc:     dvhart@infradead.org, andy@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] x86/efi: fix a -Wtype-limits compilation warning
Date:   Fri, 31 May 2019 12:05:34 -0400
Message-Id: <1559318734-27591-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Compiling a kernel with W=1 generates this warning,

arch/x86/platform/efi/quirks.c:731:16: warning: comparison of unsigned
expression >= 0 is always true [-Wtype-limits]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/platform/efi/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index feb77777c8b8..ed88c95f9daf 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -725,7 +725,7 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 	 * Address range 0x0000 - 0x0fff is always mapped in the efi_pgd, so
 	 * page faulting on these addresses isn't expected.
 	 */
-	if (phys_addr >= 0x0000 && phys_addr <= 0x0fff)
+	if (phys_addr <= 0x0fff)
 		return;
 
 	/*
-- 
1.8.3.1

