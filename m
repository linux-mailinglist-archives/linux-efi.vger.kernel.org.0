Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A2F59C328
	for <lists+linux-efi@lfdr.de>; Mon, 22 Aug 2022 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbiHVPmy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 Aug 2022 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbiHVPmE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 Aug 2022 11:42:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DD771EAF8;
        Mon, 22 Aug 2022 08:42:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 385D4ED1;
        Mon, 22 Aug 2022 08:42:06 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 76FAF3F70D;
        Mon, 22 Aug 2022 08:41:54 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-doc@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: [RESEND PATCH v3 6/9] ghes: Introduce a flag ghes_present
Date:   Mon, 22 Aug 2022 15:40:45 +0000
Message-Id: <20220822154048.188253-7-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822154048.188253-1-justin.he@arm.com>
References: <20220822154048.188253-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Introduce a flag ghes_present to differentiate between the system ROM
really not offering GHES vs. the ghes module not running. The true of
ghes_present means ghes_probe() has been called.

If ghes_edac is not enabled (but ghes is enabled) on a system with GHES
present & preferred, no edac driver gets registered.

Suggested-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/acpi/apei/ghes.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 327386f3cf33..31c674639e86 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -114,6 +114,8 @@ static int __init setup_ghes_edac_load(char *str)
 }
 __setup("ghes_edac_force=", setup_ghes_edac_load);
 
+static bool ghes_present;
+
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
@@ -1407,6 +1409,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	list_add_tail(&ghes->elist, &ghes_devs);
 	mutex_unlock(&ghes_devs_mutex);
 
+	ghes_present = true;
+
 	/* Handle any pending errors right away */
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
 	ghes_proc(ghes);
@@ -1541,6 +1545,9 @@ bool ghes_edac_preferred(void)
 {
 	int idx = -1;
 
+	if (!ghes_present)
+		return false;
+
 	if (IS_ENABLED(CONFIG_X86)) {
 		idx = acpi_match_platform_list(plat_list);
 		if (idx < 0 && !ghes_edac_force)
-- 
2.25.1

