Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC844AC35C
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 16:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiBGP3n (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 10:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444032AbiBGPQd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 10:16:33 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80119.outbound.protection.outlook.com [40.107.8.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F44DC0401C1;
        Mon,  7 Feb 2022 07:16:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bayUOjcoHtK85S8v59ZX66HCrXsLU49XAH6AY9qYuBeVXFXmiLXRWpe921XxuTpHBPNGP0p2DqL6jHBQVYovhvO0P99OwpN4Yy4kTkC88097NlyS5Xuj+ba8bvH8gPacX5bjwEZ2h+8i59cD8fxe5cmwZww6cqNpUmzNAspn1zsMZOfS5WSN9JeaBYpNh7PbmMBV1WD9zHeq8DFbbOM8TiImr+DtmFVjSnXeLvUBpe2wt6MX3+BsHUZ3kBv5xs4ZrtbphTeBW4nouhAU4ETZViXeC1fOkuLJ6RpVQ9ixxNd04Mf1WuDjVa7dfoKNWUTbK3ec3AJONzFbSB/ZEguLuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxxUza5IJqoiR3BTA15it9jQlxEd3ohaGe2dqt4Zn/A=;
 b=FN1kCkge4a5dlHdGRuWbEfuCa2GZQahBmy/fp+nNUOeq/YsGshAx6K3/fe2NaLKEsDEJ91IumfAnEbk086y7JTNrGFcTJUgCRxSP8tN36LmJYwrSIvB3h7x6O/DPMKbON9a7HE9/1VnVCFizSQnt4XlIBg/lfyjcKAUIwO+GVgi4qWMfRFy/gFveIh3s+X413z1Y6ovhJvjKzhxTfsbcKTD4R/4HlKGu4TdHGmucK9oriTgul/Daqi49igErpZIOwan39ho35k+ha7vvDMP7bclELx7mYRFxcV/YthkqewvYlFoM7lM28OxGaQBSjwpIuAfs1ao6ZRvdEg4fOLbz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxxUza5IJqoiR3BTA15it9jQlxEd3ohaGe2dqt4Zn/A=;
 b=C+txKzoKLGAaS1XHXhp89tpDOt8OE8XAUmiIawweiBtbDu3sDn9egRQjcjWassdNjILoMJ9wPN1fwYrvZrVUr3nP8qr0GH7pICMcp9XtUFFKDCWmX8kqw3Hiu92RN/Gj4WNHdsE8duxCwXEJWF5LtGKuEdKxcQCOWfjUrS2LDbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS8PR07MB8104.eurprd07.prod.outlook.com (2603:10a6:20b:373::6)
 by DB7PR07MB5227.eurprd07.prod.outlook.com (2603:10a6:10:6e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.10; Mon, 7 Feb
 2022 15:16:29 +0000
Received: from AS8PR07MB8104.eurprd07.prod.outlook.com
 ([fe80::add0:5657:466d:4803]) by AS8PR07MB8104.eurprd07.prod.outlook.com
 ([fe80::add0:5657:466d:4803%8]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 15:16:23 +0000
Date:   Mon, 7 Feb 2022 16:16:18 +0100
From:   Krzysztof Adamski <krzysztof.adamski@nokia.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: [PATCH v3] arm64: move efi_reboot to restart handler
Message-ID: <YgE3wo3W8y1qcd3t@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: HE1PR09CA0080.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::24) To AS8PR07MB8104.eurprd07.prod.outlook.com
 (2603:10a6:20b:373::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97f76af9-a26a-4a42-ca24-08d9ea4ccd43
X-MS-TrafficTypeDiagnostic: DB7PR07MB5227:EE_
X-Microsoft-Antispam-PRVS: <DB7PR07MB522777057DD320E2A9070868EF2C9@DB7PR07MB5227.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hIvGRlwTU4cj39cA5endG8tI2MZ7s95FcoV/QJcvXhBvmnvRIBMNxgQAHGBRKtotqx1uRSgC3DH2VArl0VaN0C01Q9U0LKiMzkiVx6YJd0pLurb9t4Kz34YGHBAd+iQ/4ZbHXVe9J/+uFqzRGWhMiR+Wr7L1W+nmmfPHB5az694EXNvbdsg6XimioEA935k/FuTManF58MuG1zSrgqtSCZzAzQjzzp0woRyv3vGpuRiZsZ0zion8Bd99wlrNB/EKxrVjNtH5sgwCUCMTS7FpnpdDHwJwE1Zj6iFomIRba4GlIjFeXUgYdFQtnlUf1c/Pdw6jLWIIDRQ2S48KSZRpjl2e78ZVYZhavqSklUoR+ynl7/YbAhdZz0yrHsLzU+1NkUTjC8AHULqli5rbN7VFwq+5X+OMz5+6SY94GQW42PlbtvURBk2u0Gf069A4R3/1Je7DPlwBTeN/NYifkQ5R0kVFkH8cr2vHnPX5Y0HwWv0licb3BjkWcwWzZEx8YTsQ90JtEoHxDX1r5HZOm0xj30c89f63xSiyg5QstASPlv+grLty45F97hxQ5FSTECf7vXI+OMHby274cYvHGPfjUeHG3LF5daSATwZNzS78IKZq8mZWBHvgCT1aU7Uve9E0mAeJXF83ioeuKguiGN3rqd78it5o5QTWYS7KE4IYp4L4h2YY30JyaYl7w3VS5BKRDrdh74UxpLKaPoGcAXTjAwbgzjd919BxdrhpmDuV9HY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB8104.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(83380400001)(7416002)(9686003)(186003)(26005)(38100700002)(38350700002)(5660300002)(44832011)(6486002)(8936002)(6666004)(4326008)(82960400001)(8676002)(66556008)(6506007)(66476007)(86362001)(66946007)(52116002)(2906002)(110136005)(508600001)(316002)(69594002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?izEmHuRBb32Sgf9pcvGVztFFkcgY8y9NOgZ+Iq9B3/6N9Wt/3OZlLoO6QL4y?=
 =?us-ascii?Q?JZtnJuYt8V21RdltEI0wMdbpiKM8e3Gx1ok5VvatNhi/YbDuduz8+A33c1NX?=
 =?us-ascii?Q?l8QtG+F42JayCDFK3y2WCF2FXCeCm113kB8KJnqJEvnIo+jkVupBM4rwTuYy?=
 =?us-ascii?Q?+/a7UH54SuQt8N3fHOlQLRX3oBUClU3H3SQSiLXXyVyTWB2U5bLI1rxgUrqr?=
 =?us-ascii?Q?sqjKlVutVAhe8oNhtQtV0os+/Fux355ZYmSgOCS46rmcv5puJPg5fTz3ppN/?=
 =?us-ascii?Q?gsY02A1458vD0tlLR7BLCO/FNj5OkVl4yvdb6mD2sxZTVKlzC/fYFEodyk49?=
 =?us-ascii?Q?MfLEckISCpBFS2BN1b2AAiJjQPPOqOB8nKWYh823c+nvur5OzH+f7ik554UO?=
 =?us-ascii?Q?xH/AfupzK7VqWCiG0hVnfQLewGQSnvKNf8R4ies8nwMlEyi3DHLlyK/HYKgM?=
 =?us-ascii?Q?T7R4iHMGdRPyrhktRGb8NnZcy/CwewtBLykMHBjmuQAWb0KMfF21C29yZSON?=
 =?us-ascii?Q?0Hq254NKVGXKsGT22no2gXw6SingLZv5RT2tHstNq0yiRK6i2J529lBalPpu?=
 =?us-ascii?Q?BjZoYzCV83zi/QtrfRnFhs8K0WoFYDO9ipsG3vcHFuMcx165JrG3Ui4oV9sW?=
 =?us-ascii?Q?3UqXAmZa7fn/92/WjMnjbhpvupz4elUmSQy9GR3XW1MkahhatNZ8kRH8htiS?=
 =?us-ascii?Q?ew+ZCtZKIggnT3cl/2e2hwFMHCFcJ2zP2cCMmc1xSN5u3jpjBni5TKX428/x?=
 =?us-ascii?Q?SO32KUhUnsab3gjI0OkeIX66W+g0muPb0oNwNVSY56qr7tHe7+06bXBEHGaE?=
 =?us-ascii?Q?0zXAyBWQlS+WAXja9jOdpP8G6Vonjo14+p6y/6R1l237+6+VMn4StDIGqF3X?=
 =?us-ascii?Q?dyZanvtzpS5ulxeC2CuCWBz4LQdCONj/ap0mbvJsveWEfLCeFygaBTDtK45h?=
 =?us-ascii?Q?N1HVuqe8z6l9T6c0Z8KcgmX2pL5noYATtDdv+q7s5CA9ycAr+GIxAy+WGqRT?=
 =?us-ascii?Q?8BkLivJFGHn0oPlYQFRXvd8pFstxa02rTs763V1QeOh8vm93ImWQgTqW6pTT?=
 =?us-ascii?Q?tudyRoJ5KNtKAaKPSR/dU7zd/GX6jcZM3ppN+tyWuVQm+ENHRqyeIe8MxWi5?=
 =?us-ascii?Q?MAfmrMtk9oTy/uMgqWne5RTCkzoCa7/1yh/kvwx0EsW2NqJm8BUiXaToVCG+?=
 =?us-ascii?Q?tCSUzSDiOydmBKBzuHVcJp6eFvFNUrJcNm3JVHnzSP22Zq64YhHVc9pIF9FW?=
 =?us-ascii?Q?u8/2XtIiEUkJIERPd6mM8RBBxsJ+wFblPc7lxfcbwggz82KK3KKR0X0Rp8Kd?=
 =?us-ascii?Q?LaIu6xzNtM4SRUiFTXf6JTAMIh1ZpfB1IKivgXWfkUqqTiK0G64h1oBVmYCq?=
 =?us-ascii?Q?lycOwA3cqpvBvQVO8okOE00rRtJHvLRi7ltNUkFTRNOgl3E8ZWaJMHuemJn3?=
 =?us-ascii?Q?R8ToTxpKrrP5xMYqjFwMlk1PIPz5tx4rOCfWcL539sk4Hmqjnj48PnmrW0TP?=
 =?us-ascii?Q?d/JtKiZhkozVPz67BIa0wwm40zwDX7HCo+Vl6Ms4qM5Avg3NnIEvY3juFgMj?=
 =?us-ascii?Q?6nMWBKJWRzFmFvyk8MTZE37uftFYHOcHL0UzdABr6RBw4E6LK8sN3VBjXz4L?=
 =?us-ascii?Q?iWwbMoeHWzr7WUBualqxikG65cLffCHcPDScZBuCEsR32c2Nif8Q/1y9z9/O?=
 =?us-ascii?Q?YCAKLA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f76af9-a26a-4a42-ca24-08d9ea4ccd43
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB8104.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 15:16:23.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rQmAi3eRy5EuVx4tDrmHYYKvMFQOwcpJ81OxXMpjMbeMnAI+KZKEKQZMlUHqC8ki8OHv/OU/+vajxiVVVhL5v570hs5mQBoncupyICnWoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB5227
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On EFI enabled arm64 systems, efi_reboot was called before
do_kernel_restart, completely omitting the reset_handlers functionality.
By registering efi_reboot as part of the chain with elevated priority,
we make it run before the default handler but still allow plugging in
other handlers.

This is useful in two scenarios:
 - Abusing the restart handler as a notification mechanism similar to
   reboot notifiers, but working in wider spectrum of cases, (notably
   also at emergency_restart) and just before reset. This is useful for
   things like in-kernel pwrseq_emmc, or any other place where it is
   beneficial for an *external* component to know about the restart, but
   not performing the reset itself.
 - Providing higher priority reset handler, where resetting the SoC is
   not enough, and reset of the whole board should be orchestrated by
   some external component, that the firmware is not aware of (like an
   FPGA or some PMIC).

This change moves the conditional efi_reboot() call from arm64 specific
machine_restart() function to an arm efi initialization code where it is
registered as a restart handler with a very high (but not the highest)
priority, leaving a small window of opportunity for some code to be run
prior to the actual reset, like on other architectures.

The restart handlers mechanism is proven to work reliably as we depend
on it heavily on other platforms so there is almost no cost for this
change but it adds flexibility and unifies our infrastructure with other
ports (where one can depend on restart handlers working).

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---

While previous attempts got mixed feedback, my explanations did not seen
counterarguments so I am trying another round:

Changes in v3:
  - Bump the priority much higher, to almost maximal value
  - Add a comment discouraging from registering higher prio handlers
  - Update the commit message to contain some more justifications

Changes in v2:
  - Register the handler in EFI code, instead of arm64 setup.c
  - Remove the contdition from the handler - it should be run in all
    cases when it is registered
  - Bump the priority to 130 to make it completly obious this should be
    run before PSCI (which has priority of 129)

 arch/arm64/kernel/process.c        |  7 -------
 drivers/firmware/efi/arm-runtime.c | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 5369e649fa79..b86ef77bb0c8 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -130,13 +130,6 @@ void machine_restart(char *cmd)
 	local_irq_disable();
 	smp_send_stop();
 
-	/*
-	 * UpdateCapsule() depends on the system being reset via
-	 * ResetSystem().
-	 */
-	if (efi_enabled(EFI_RUNTIME_SERVICES))
-		efi_reboot(reboot_mode, NULL);
-
 	/* Now call the architecture specific reboot code. */
 	do_kernel_restart(cmd);
 
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 3359ae2adf24..b29f47783bbc 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -80,6 +80,28 @@ static bool __init efi_virtmap_init(void)
 	return true;
 }
 
+static int efi_restart(struct notifier_block *nb, unsigned long action,
+		       void *data)
+{
+	/*
+	 * UpdateCapsule() depends on the system being reset via
+	 * ResetSystem().
+	 */
+	efi_reboot(reboot_mode, NULL);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block efi_restart_nb = {
+	.notifier_call = efi_restart,
+	/**
+	 * If you are running UEFI based system, you most certainly should let
+	 * efi_reboot() do a reset for you. If you think you know better, we
+	 * leave you a window of opportunity here by not using maximal priority.
+	 */
+	.priority = 251,
+};
+
 /*
  * Enable the UEFI Runtime Services if all prerequisites are in place, i.e.,
  * non-early mapping of the UEFI system table and virtual mappings for all
@@ -148,6 +170,9 @@ static int __init arm_enable_runtime_services(void)
 	efi_native_runtime_setup();
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 
+	if (IS_ENABLED(CONFIG_ARM64))
+		register_restart_handler(&efi_restart_nb);
+
 	return 0;
 }
 early_initcall(arm_enable_runtime_services);
-- 
2.34.1

