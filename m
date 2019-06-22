Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FFD4F47E
	for <lists+linux-efi@lfdr.de>; Sat, 22 Jun 2019 10:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfFVIvS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 22 Jun 2019 04:51:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40443 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfFVIvR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 22 Jun 2019 04:51:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so8718057wre.7
        for <linux-efi@vger.kernel.org>; Sat, 22 Jun 2019 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9crTsB/UrpUqqHUWXJKG+JkHwY6C6DtrEmHZcdZhy8=;
        b=Aw5AY8LxmwqzQm5h+un10GlowGYa2zi9DKB9ANx/rA9mkgDgc08z6KR4kCiOEtTISn
         M65JF8S/jPwJY8MDUGqlujppgDB46RZlKKvQEUxw4lXogAnaup8P13uMbys8QN8cIpUD
         bFR/ggkFZZWluEem+8XG1X5wamCkMtO5mnzi6pgorB3QSjrGQ6hmhU5BWrtCU1phnJk/
         p+ZFw5RFgn8yjr9YLuptDXmZzT+N7rDcnG0wuDwq+TOq7dXZ8hEXvEr6xVExV9lbTqll
         VAQdhSWWRA0h3ZVVVpNMzMTEc/MPGkiUHl3xYLkFoY9sSSE+ZVHHXCFHoUS2IMNG1hc/
         pKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9crTsB/UrpUqqHUWXJKG+JkHwY6C6DtrEmHZcdZhy8=;
        b=Z70M1ix5sfv87kht44LwGexDWL19WYyH9D9pyaCLb/Mt9XkTMrXE8AdAwW8DwNJH7A
         1c01oKw5DKF4ZxJlLK3+J64oJ7L6D9J2ryBzG814L5F84PDuqCbMnGRh1Q0QIEbiHEBM
         MhAvSkk4kDifcGSq0JgvN8RiLJjTUKVJy90IwUti+d3fyMrA6P2WMpALsVmLr3uN0Q//
         ubyYgf0XQgDUSgafjpqNWAYeULFcFbdvfgJ6oLhxGa6Dx/8v3h19oT2BAutRwCGoWGKE
         uz/eA2vRCMizl8vNtIEnWNyoEDvrgZHzysUBira5j2W4hneiLJAc9NZyCucskS6FiGLD
         GydA==
X-Gm-Message-State: APjAAAVmlTpyzin9dVCgM13nyYLUqsGiCUfXLw8PTlyqwIGCq4sHckGj
        VQmg3sgLHbsCAMFigMrOqLN5w/sFGBuwXf2H
X-Google-Smtp-Source: APXvYqwH/CLs+EGMzrd6HS4ZNLOsS6c0V+PJiCiWd+89bWRoTykVxApPgfA0S1jzs9RyCHafQBkGng==
X-Received: by 2002:adf:c506:: with SMTP id q6mr85043928wrf.219.1561193475344;
        Sat, 22 Jun 2019 01:51:15 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:4bd:3f91:4ef8:ae7e])
        by smtp.gmail.com with ESMTPSA id v15sm4863589wrt.25.2019.06.22.01.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 01:51:14 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jonathan Richardson <jonathan.richardson@broadcom.com>,
        Luo XinanX <xinanx.luo@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Qian Cai <cai@lca.pw>, Tian Baofeng <baofeng.tian@intel.com>
Subject: [PATCH 3/4] x86/efi: fix a -Wtype-limits compilation warning
Date:   Sat, 22 Jun 2019 10:51:05 +0200
Message-Id: <20190622085106.24859-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190622085106.24859-1-ard.biesheuvel@linaro.org>
References: <20190622085106.24859-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Qian Cai <cai@lca.pw>

Compiling a kernel with W=1 generates this warning,

arch/x86/platform/efi/quirks.c:731:16: warning: comparison of unsigned
expression >= 0 is always true [-Wtype-limits]

Fixes: 3425d934fc03 ("efi/x86: Handle page faults occurring while running ...")
Signed-off-by: Qian Cai <cai@lca.pw>
Acked-by: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 632b83885867..3b9fd679cea9 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -728,7 +728,7 @@ void efi_recover_from_page_fault(unsigned long phys_addr)
 	 * Address range 0x0000 - 0x0fff is always mapped in the efi_pgd, so
 	 * page faulting on these addresses isn't expected.
 	 */
-	if (phys_addr >= 0x0000 && phys_addr <= 0x0fff)
+	if (phys_addr <= 0x0fff)
 		return;
 
 	/*
-- 
2.20.1

