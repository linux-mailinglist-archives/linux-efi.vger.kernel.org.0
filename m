Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717B53CFCF0
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 17:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238159AbhGTOXh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 10:23:37 -0400
Received: from mail-dm3nam07on2104.outbound.protection.outlook.com ([40.107.95.104]:14017
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238580AbhGTOSt (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 10:18:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH//PYv3dTGZF+X5zwME+EnYdT+n6iNNK20913hIIebTuOPRCpDVu49KKhLmybuFf//hrr9qWDAy194v6gAK/syjdmLFFIbAtdyR8NZgYrQm+5hNNLwBaHCyJ5KSUrWfoyneVMZ46cJqKqq2+gJeHxT4z/QZ5JS2xv0IuM+XJ1+pC20KSSZCsGnIAxr0q1MTDXvj1zdefFUod9KpcAwr9PTwV9t42jB9mh9GxPC8BilV4QtG7DKkvJo4RnjtpNfvxTik9YTKQJqve6x7BvpZMRVTnlrLxLZyfaJwZ/wZR4iwSOwQnPoXmgMbAPqMdhVlgtswQ/y1Zci1Sm0rvNCSkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xnCcy767WKevDP5UhHtnUI+xPQRl1REcs1nGDGtkcM=;
 b=VRP7phQvJOlDO8r+aU4/jOfao0fvJjP56nZak1H6hiQdGJGL2nI1A/vH9l/DXMdqPcl8XHleos67QPTHpl+9bYCaBlVFNbAptYB5MbMOdp7vOZWRGjaJqgQbecTU2R1NcQi4UUbsNMoPGiNn9ltdAw7bq0/bNaufn465RMe5WF8GxzI/OLdfozOjyYrkw1sgiltiAsujmL+QdGoxNyJ6fpSH4ANAW0W4DR99sDtYm557aw2pxZHYXjXLEXnzytIqPaNbaJxKX+4YAQXkzfcioDH7L5BCqJqDbdoXvH8QW31nhguT6sucZIY0SKE+1OvXcabI9Ht69jUwBSxMP6XT7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xnCcy767WKevDP5UhHtnUI+xPQRl1REcs1nGDGtkcM=;
 b=a5Bl+gQGxqTGc3OsPvwVxdgpF4L+RAhPmeI3C9yKDSlQpzKYesknhCv727W1A4nhHAyLDyIpchHVjANA+CmBd03NtU+Gdfqr4nLTy2H1jVooVmZkpr5MCTK5IhfGGFXWWEorEA8MdL9d7n6+qhlc+KInF3yX35H0WiRcmMSdkSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.4; Tue, 20 Jul
 2021 14:57:27 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::3505:fa47:39d0:6dc5]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::3505:fa47:39d0:6dc5%9]) with mapi id 15.20.4373.005; Tue, 20 Jul 2021
 14:57:27 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v11 5/5] Drivers: hv: Enable Hyper-V code to be built on ARM64
Date:   Tue, 20 Jul 2021 07:57:03 -0700
Message-Id: <1626793023-13830-6-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
References: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:300:116::33) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (167.220.2.16) by MWHPR07CA0023.namprd07.prod.outlook.com (2603:10b6:300:116::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 14:57:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65c35511-5203-4c63-e5ba-08d94b8eb0b6
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB09819FCF0802BE2901B2C318D7E29@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WYNnTay10XxhQFaZJtKJDA/saIZGPWRlXz+sZxz++bOpf5IBlSPN3/wK26CAlGPn16jH5Mi+/2fjk761I6uffH4hHnFKHzWOhBPD8PvQTC/+qzxsgK9Bjd9FU0rPjlf8413UQmk/wQRPg9EJFO56YnBZ4aCcp5yJqtNK4egESZZw9a6zg3XzDrKwlp5J60YmpJPdOdvZO+GDmrx8HiKfPsd/0hMfc+xOrzoEv8gjrYhWm9+15y+VcvfYdP0NlVNtV+c8DB5p6gDqL9yvn9ssuGSJaPhhtkubXztLI+K7Is/rygpHKHJ2LFB/mYgJeMGR/Mix3fqnxqFO3fb/in2sVbodK+tvn9jtBZWR6lwlp8r6y8UNeztq8Wn4xwW7hgsFpLhS84VqIMrCG0V+8QXEzP/oDXjL1l+Em0I+mTB0v0T1CFIpCB9yXaVjMMB6wIRYn6hu3fraecl4MTjpHzL4x+h/fhgf9uwD1eEYvG54Cg/sXCrMg1z6Su49SJhw1NS9NrU8pWote6khHpQ2w5PN3EJqL0uQfGxHicO72TFqWOOtU+7NYVNvmJDSIP/+zXW5czO0AACskV/JW3MSys9bEbdcbBoFf5hX7KWe1oFO/ydBuaeGZerv33WlWwW6DJguv1W5EVOM50ucP+GUhVK3hkcieiB4bp94VKxln36IyjJruiQflsm1L8f54ly7G/aUYjBdVyOJ0qd6lfsz/P2P30VrzR6rAKvwsPyakiJ2x8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(26005)(6666004)(36756003)(508600001)(956004)(10290500003)(66476007)(5660300002)(38350700002)(4326008)(8676002)(38100700002)(66946007)(2616005)(82950400001)(186003)(52116002)(7696005)(107886003)(6486002)(8936002)(82960400001)(4744005)(316002)(921005)(66556008)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EgWdLkqOs3gYep9WaAJK2KKde+oRAxsntMiDp0bDcK0KnI+e1liy88xDSnS1?=
 =?us-ascii?Q?l6iI6jdHiZfJiY7LZhDCPybNfnTMR3Q82goclyi435sACmOxVQqjSfrPx7ED?=
 =?us-ascii?Q?jA8XjedDBnNi9AL8DEnVvbmn9NLri+pWXe7XRztoRRQhsaXENKw0fXt96YB0?=
 =?us-ascii?Q?zRwkCVHqC7k+7/UKyNPQqN6kD+q5k9yitJlpLKEbeWvSd3t+E9o6HWAtFjwO?=
 =?us-ascii?Q?dw/jWaZL7tmDJUHqh44mFksVN8QN0UPTOH+ioeZDn2xo76ENQak5z+LfcQ6q?=
 =?us-ascii?Q?8rcOpJX6weo1CjvU43e+eXHM4AYhApYslif9SiGN3vRUnjEBbWj6bI2ExSCq?=
 =?us-ascii?Q?eIqMhEy71h8iufzDMVPIoGoiAkBnPjUs4qMl4mpZJREHyzpDzTNyPbP3nFc7?=
 =?us-ascii?Q?Ad9E0DHzRHSX8B0tR+yPImxUMS9wA/pan2oDX75W40D8Py/zKikXPyMf7Gtb?=
 =?us-ascii?Q?Eh4iEuZCnCqNcQ0bTCn5LhYVO4UWraACpW7lT23UAEpqhGWS6izkRfWNM7ty?=
 =?us-ascii?Q?IfQrNNtKRWio8KVy8iUV/pTzdQkplbhweaHZL9RDz7AuldCepfbrFo1ghr1t?=
 =?us-ascii?Q?DI69ePtM/ZQqm6E+3g+qSOUQvuEWTyU9K7hM+YfuXSqihr319KKVPDvTiLOq?=
 =?us-ascii?Q?SFKCdGJbSoZxSX3jyucg/bBh7AP1sMT2aPfuZ9Mg0BDu5K66JSSDaLMJB7XU?=
 =?us-ascii?Q?8Z/Y4cmE8FXEGMXtp9oPKR1rzW5HiNmFNj7NksNwK4+CQLtACUIWjlv0BYn0?=
 =?us-ascii?Q?Kl25MIiCUMNq1DIj6svH2kJ9ww6G4X4fo0IzijJ4KGpNbzz1RnjjjQoT2oG9?=
 =?us-ascii?Q?iAkEejr5Sf+StpmgpSCKTH7o2EkG42dNdLgH4OVGS+tp8cOc8M8b2Y8adfNj?=
 =?us-ascii?Q?yFsVKpvrQKtMgUVUVkyAvoXz2t6be+GMy9Fz5odGdN82fSKJd9bY7Zlsm+LA?=
 =?us-ascii?Q?akY0IlBG+Uz3cdjLA7n4Gc2RnYzEbyHjm36GSAzPJarXraWjkWgBU2B+vCgD?=
 =?us-ascii?Q?hZl5sFG6lLNX1+e6SR4rOK4gw/PtC+pKHgFy89+bc0l7dS550x9iWgzFZ7SJ?=
 =?us-ascii?Q?EJDeD8h/9qq39EfGGLCazvedOWN8TXE0g79mUDS1MLa4RYTfyKLGKEpCnIf5?=
 =?us-ascii?Q?jVEL+SBGTmC4Xe7Fchf1VEnBxXAhMsvpl6B1U0t79/e4miS6YUgvTGLuKv2w?=
 =?us-ascii?Q?8EqxTcs4RRP3cA2lPjZCbD3Q/ZaI55OesOrEv5sGRsLCJwJdX22huFvKI2GE?=
 =?us-ascii?Q?L9mbuj4JFF2wpGBF0/FKUWp3m1DfXYfMTMTkEWAFqpXdwg80MCRH5OnMdro9?=
 =?us-ascii?Q?cB6yPErabwJzMhb0PkQY68aQ?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c35511-5203-4c63-e5ba-08d94b8eb0b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 14:57:27.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibMGh1hKM6nsGlMLWGvV3ZC2XBPNPJ9Ko7jO5xocHUwiO7lekaSQAqoHDKH2YfCBCxTQRXsPYGmrBlfzt2XotA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on
ARM64, causing the Hyper-V specific code to be built. Exclude the
Hyper-V enlightened clocks/timers code from being built for ARM64.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 66c794d..e509d5d 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
 
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on X86 && ACPI && X86_LOCAL_APIC && HYPERVISOR_GUEST
+	depends on ACPI && ((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
+		|| (ARM64 && !CPU_BIG_ENDIAN))
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR
 	help
@@ -12,7 +13,7 @@ config HYPERV
 	  system.
 
 config HYPERV_TIMER
-	def_bool HYPERV
+	def_bool HYPERV && X86
 
 config HYPERV_UTILS
 	tristate "Microsoft Hyper-V Utilities driver"
-- 
1.8.3.1

