Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9523317EB
	for <lists+linux-efi@lfdr.de>; Mon,  8 Mar 2021 20:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhCHT6P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Mar 2021 14:58:15 -0500
Received: from mail-eopbgr770104.outbound.protection.outlook.com ([40.107.77.104]:16005
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231426AbhCHT6I (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:58:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCRG2uirGe7S/gNTEQ0OOd2WFNBPkBgbR1ASPsA28Iq7uFI/1vrI9R5VoNk+8tZGfmbeIhtLLORA2v/zPoKBtQ+oc6s70Mn0OSSykyLp6pVEWabh5Y1r+j80xV/e0K9bwGxJIvb5poIlCXul4AqQ5obfqCqTpCqaeDEmFan1VjnQ5XGN9aXOF6lKU+DopKAzybM7IO0uEfn3giyQnyaQon0Y+w84vbQUpq43OVz+p99pry/E4onFyA12QBp/0Ueb6T7XQy7NNlHhHQ6X8lJnxviqpQs3wEcJPI9z4iFk9vYK+8IvKh+2s8sLvGfkvB9/2efV0MLNbVVurhX5whMQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCG5xM+5O5U6ElTpsDEpitVcsMEGRiRbkxdc/A2ZuUk=;
 b=m14ulpM5k/vKgegSbIbE7sH7ItCHwkd7sEg3GRmo1vWlJjUNKm+tb/cY36Nf1s4OAzzXlzH/jOGTHIJCvt8seuFvUWPqdpagqOGjwPyUvHVr8rK01G2Rvt0Hfpqk1sJfifkqW2OLcV71eQccZ1Ztjxp3DGJy6J4gH0CohZi4CiYpvvaxdAIx47uQuC0F47vJyb+3m5fnFuryMM3dRa0+v9OlChon9oIL2mbekPLgcwKNrPEL0ViF4bilXUkpS7LmcNmevHjKQKB3VB+a4nSWYKT+rS7XI497vtIubFzZS0/Cf/qWlkmdYPM9hEcWeT9PYIXJpRvAQmrAWAai974GVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCG5xM+5O5U6ElTpsDEpitVcsMEGRiRbkxdc/A2ZuUk=;
 b=ZFjHdZqT684+Fi1YAAo+eYaYcJ2U+SX14vL/DoW5B9cTjqR5fqP5Z9SCJXq1KU6rILTpJ+ZK6rqC3FQ9Yuu0H84Wd/YdKsJwPdqfkI+1DiliF4UnquayuhtBVDCVnkDEHIUMOJtzplKb8pITLTq9jY0L/tiS8ZR3BjCwUltYbUU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB1797.namprd21.prod.outlook.com (2603:10b6:4:aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.4; Mon, 8 Mar
 2021 19:58:07 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3933.025; Mon, 8 Mar 2021
 19:58:07 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v9 3/7] arm64: hyperv: Add Hyper-V clocksource/clockevent support
Date:   Mon,  8 Mar 2021 11:57:15 -0800
Message-Id: <1615233439-23346-4-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
References: <1615233439-23346-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.174.144]
X-ClientProxiedBy: MW4PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:303:8d::16) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0161.namprd03.prod.outlook.com (2603:10b6:303:8d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 19:58:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05a609fc-31ed-44c6-9e7a-08d8e26c7dfb
X-MS-TrafficTypeDiagnostic: DM5PR21MB1797:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR21MB17973EC7D1103E228FF8D952D7939@DM5PR21MB1797.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lGttC8fd2g683PJqwJLO986AuQ7hDHgjRnu5l9cOY7RSV3iPZWBUM9hc2NjFmcroGtAE3WzNmu2ZkLen+BgELSzUNi/AxujUG2MzDxv1fR70oTck05RMFrIdr+fbApzmxOljji6Eo3ABApH2iEuOEgWdP2uquDL79qt5ODhvAXF9lYRIbrRLz6xVTnoSMbko92C86rj11md67Y62OwO3get+oCzNwDsLHaoxaPgDdJo8feWEHNJj/aAFRyrDSJ1F7DtKwyDUB/cuPxbnYF9buwwmGz8qv9A4/Gna3+6RivgfzQdureu9lOwQyNzpAYOVLlLHO3sOR5ulmFYCkPg0ovnretrLmRjrEWhjsJ+phSmupfcDEvQWGdoI4tsxkLMmkf5MuJYJiuqEHUzZjAmNu32YKIwzuL6pf1PZCLdbw6gJcAPg++Ru3CrnmI43LCu8wEjt6+6aQ6ImmHcAZuV4TCb1vNnB/f8z3YeDMoxw/6ZT82rvbhfV3+JgSJo9S5HlQcXGGdSEGYFW2lSSlRc9zQ3tKNhvDZX/Ff5CL4LmVRCTGNjnlK9xaRBs4yAlpSF1+WHK5G6j8hy7/GgGDiwMPhus3qvyKmJBA/vQC+awsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(66556008)(186003)(52116002)(66476007)(66946007)(10290500003)(478600001)(26005)(16526019)(5660300002)(2906002)(36756003)(8936002)(6666004)(316002)(7696005)(8676002)(6486002)(2616005)(82960400001)(4326008)(6636002)(107886003)(82950400001)(7416002)(921005)(956004)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gFxi+rMkDE6Ra5XqfdIVlsPl+OyA6hYWeDCaXBsyh30HyTo/z8wxNX4XxGUo?=
 =?us-ascii?Q?5tql64OBtdUlKaZarrm3HzUlaVNdsDJiNweqDax+O/09FFGJVW0npBQyAIjX?=
 =?us-ascii?Q?B3UczMAOPKkAyLA/KIsJFfauF1XDG5Mc2cPz+5TqqEt75xM1PY7c8FBj4ZnN?=
 =?us-ascii?Q?YScWhdzC5Il8NNXd9UjHK+XU230QlRgqDRdXHWpV0ckcRJRaOW5LtMJqot3D?=
 =?us-ascii?Q?qmMokTghHFKoIcUxiOoojXmFbtnTot62zFia1Aymtk5BswvzdjJ3bGmdXtGB?=
 =?us-ascii?Q?P+2RWokoFV28Mnh/we/gVFJf51yzbiVda7MLyXEKg/u55dnczxtgqZ570Rg2?=
 =?us-ascii?Q?Ym160ZJWByadpzKvkVq07DULyusyBD3CR9A/drD9hhJepDV2Pigl3s9NhXqp?=
 =?us-ascii?Q?26i5g745DwSUAN3D+e+R79KG7lll/+zG8FNT48aFEQ7RNHDrQ0cFvYku6XdS?=
 =?us-ascii?Q?eZeSVyaZsYW2HJG4qWR83BdVw+nGIbVtZZ1j2fCqGiIep9+ODb8IFfbqEJQ1?=
 =?us-ascii?Q?Zo20Axdb2ckf2nW3rLevAt3ApXmdC8WsFXYpwg8W+0IicZqFZngKMtKuLGQ8?=
 =?us-ascii?Q?d51/pb/FDsu5yrLkhU7NTdF/RCEXRuU0B4slYZ1Nky3ItzQT/1gzsA88eG3S?=
 =?us-ascii?Q?oz6IzuaPyNSrLsxIXaORZk7viDcjKhv4VItOxhLLBseHI1VlAK7qbOn58s/4?=
 =?us-ascii?Q?q13sTte+Z84CpI6ZSDWzyXkwo7nW7M6eOFtyYiMDZI00qyg7x9QIWu+2ERGH?=
 =?us-ascii?Q?VbNbE4WAWqMc1NEqnQpOtdjfSMQDSsY/hPwOAmbvHoFIqx23Na/+qLAx5Qdw?=
 =?us-ascii?Q?mh7YhHhce8T7uRn3IAU0pLVa5HSyvQOKRHYHKWe+5jX8dUwQlX3rzg90oRfJ?=
 =?us-ascii?Q?bCf+bkps9xkxrj9Iv3NB/Lhvm3XWcwkK3IArE4TJ9Le7kcdglkV0Bs8tPyj9?=
 =?us-ascii?Q?ahbJqEBrLbj7T1MIvkpnIHAB/GrDMVLeizoe9nIsB1uwted7UiNsdXZTinqT?=
 =?us-ascii?Q?SzYfBkarMXrQZUYkc4ghpWZ2LRvrtuXoCBhH9nj2J3/NEoJG8FHqXBeO94fK?=
 =?us-ascii?Q?pfqgX75dahjK938zxsM8trPpjOxw9VqGUwXCBjKMpmGXVgaz+7p+IB58d/Bs?=
 =?us-ascii?Q?39lVO7juFTFR6X2kx7wsYCJzxym9cfc8BCatlEd5xc6O6/JX3NElq7RmnxdY?=
 =?us-ascii?Q?Os+UMqBrpZx2wLXWDrOCwfBmvCCZM4NvQ5knSnu4trObAsK2QhRo4XD2477s?=
 =?us-ascii?Q?8pfIRzz2vfBYNUZEX6YabQiwmiP2S1NyRPW0jHrc489+lbWZaZXow6D6QIWM?=
 =?us-ascii?Q?EjvM6ibPLLb/CrqSqiyKQQsd?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a609fc-31ed-44c6-9e7a-08d8e26c7dfb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 19:58:07.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOdVW/kFrWbjQjFde2HICkE+KbUrQdkqG5kEKVRfb1XRbUdFWuwNfytAuZRda8AtCC+0rgn2MVX/F9Pvz6pUcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1797
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add architecture specific definitions and functions needed
by the architecture independent Hyper-V clocksource driver.
Update the Hyper-V clocksource driver to be initialized
on ARM64.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 arch/arm64/include/asm/mshyperv.h  | 12 ++++++++++++
 drivers/clocksource/hyperv_timer.c | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index c448704..b17299c 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/arm-smccc.h>
 #include <asm/hyperv-tlfs.h>
+#include <clocksource/arm_arch_timer.h>
 
 /*
  * Declare calls to get and set Hyper-V VP register values on ARM64, which
@@ -41,6 +42,17 @@ static inline u64 hv_get_register(unsigned int reg)
 	return hv_get_vpreg(reg);
 }
 
+/* Define the interrupt ID used by STIMER0 Direct Mode interrupts. This
+ * value can't come from ACPI tables because it is needed before the
+ * Linux ACPI subsystem is initialized.
+ */
+#define HYPERV_STIMER0_VECTOR	31
+
+static inline u64 hv_get_raw_timer(void)
+{
+	return arch_timer_read_counter();
+}
+
 /* SMCCC hypercall parameters */
 #define HV_SMCCC_FUNC_NUMBER	1
 #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index ba04cb3..044efb1 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -473,3 +473,17 @@ void __init hv_init_clocksource(void)
 	hv_setup_sched_clock(read_hv_sched_clock_msr);
 }
 EXPORT_SYMBOL_GPL(hv_init_clocksource);
+
+/* Initialize everything on ARM64 */
+static int __init hyperv_timer_init(struct acpi_table_header *table)
+{
+	if (!hv_is_hyperv_initialized())
+		return -EINVAL;
+
+	hv_init_clocksource();
+	if (hv_stimer_alloc(true))
+		return -EINVAL;
+
+	return 0;
+}
+TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_timer_init);
-- 
1.8.3.1

