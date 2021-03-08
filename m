Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BF03317DF
	for <lists+linux-efi@lfdr.de>; Mon,  8 Mar 2021 20:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhCHT6O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Mar 2021 14:58:14 -0500
Received: from mail-dm6nam12on2099.outbound.protection.outlook.com ([40.107.243.99]:39904
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231408AbhCHT6G (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:58:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAZrS1ZNjS4oxPspd0k5k9Fff/nIsqbAaYIhW+n47AfJarAJfSVV8JI/rvRntq3f4aoGQXgKF4mfwSpwvSrMv/gnPHgzaSzW0yzIHgtThAnMK2fLj93jaSHn9B8cZwGohosuUJ22zHhmyjfQ+2OcoVRXvUR9R9g0yTgV0yfPkGnEFMsjOJJEq6YDsOhA92UTNz63maYWrRpp+/KMr9ZivEl6oLuHXv7877Ap7JzrUAnd6qZxyACzwRO72VnN+SqSNhsblXwU11LLnus43Mab76tTJ9xxXi+8IbRGHjnmLln7IzXAjS5njJnnakJfJnjKHZH30Ik/yrPdtSA1wJ7XkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjnVlCjdirzLfOmUZU1miEK/c6Tg7S9zHT0pUjJUFto=;
 b=asmb36HWDtfsXFm0Dy0mLiy4PpRGv7GeZ7i+HM5dLpU2w82OfQpfXiAv8AGoZCHpp44RhD3cqt2L++GJb6G/9kUFUMfzn6Hb3E5UUIxjDalmBDg7O/mQu5JKuNN738rd2Eb9rucQqXKVGS9Bkx2ZVsDjtx6BjPQHsF0PwR14rmi5hDEJGcwdgiD+7E/SfcBZEfJvs9kWkP3LOG4odK18k4+WDnXtqRB4M3GF8OM4XBDE1lACTDKzjMmeiGyCaGuDNSpCrXYSzlj+cbYuRupzBS5sDh4dRj59nERtQuYLwZdRE5oPxT5912lrvoUVMtKha+PwmV4rrRnC91W7QNSmHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjnVlCjdirzLfOmUZU1miEK/c6Tg7S9zHT0pUjJUFto=;
 b=SscZyWqH7HxfPn090PcO4IWKPEQIzGlNb79sWhFtGvpdorigFB50G1OkGB5INePzU584YU1vYSc/l8EiBnkaVDb8bv+fM62W+7kiMHgXYl+qBdbEetZusBA/EQtSpSlFewVC6PMFseWJGzogmDdIxDKJZbUwlRiO4o2XAYYk8GQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB1797.namprd21.prod.outlook.com (2603:10b6:4:aa::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.4; Mon, 8 Mar
 2021 19:58:05 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3933.025; Mon, 8 Mar 2021
 19:58:05 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v9 1/7] smccc: Add HVC call variant with result registers other than 0 thru 3
Date:   Mon,  8 Mar 2021 11:57:13 -0800
Message-Id: <1615233439-23346-2-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0161.namprd03.prod.outlook.com (2603:10b6:303:8d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 19:58:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1e17fc7-c5ed-4021-7ebf-08d8e26c7cb1
X-MS-TrafficTypeDiagnostic: DM5PR21MB1797:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR21MB1797BE791BA615FD07450CB0D7939@DM5PR21MB1797.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1wHuCgkhNrVTdgMOV3+uRfRH5IKuU0O9j0wr6rFJ008WZjVO+9JI9Z+8MgPw5i5RpWDsNSEXRAHsqR44h1SFFO6bHfHFIGJcUw4W64Wk02Y+bl3HvTia6MOG9Z+FL2DtJjHCcAmEPgnNMJSWIBH02MLIv6kwX8hhkY8+opuH41Zlob5iqWTT/WAfL8vm/crEcajTQyyl9+inHwWqIkQvjXMI64KOqJDwhyOi9kJp9KAKQBH/b4ThxYKjDZzEmAs2sIPJDKO/fnj07mp9E54X+83T6PjYPLt66kD8lE12TmTLtcKoy+xxmSE/bjOQdIA+qfl+4rSG7Ms8Aa9A+StNahojdnb4FPjF9QK8CGuUmM2QlZc4Yg9O6rcsS3Gnhxqng9YZo2mfwhijgOpqZDz99WEHy0wAhfZp0Q85G/aGVUJSLknmMVh8djA4eVMyArjhXZjuQUr5xO/j0PRMPUnMzKECiRcX1uZ46RYHOCKjcSUmtMUiO1dtnw4OCG2nPetxQtiKcyUqLHSTbJkZH44cjPqdTHIsXvQhjyqiNhKBJoS9ErZdFVkCr9/TapAP5tHqpqHZjV/pFn1hf2J123VLzWShlVTCr04C0vfhS1r91A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(66556008)(186003)(52116002)(66476007)(66946007)(10290500003)(478600001)(26005)(16526019)(5660300002)(2906002)(36756003)(8936002)(6666004)(316002)(7696005)(8676002)(6486002)(2616005)(82960400001)(4326008)(6636002)(107886003)(82950400001)(7416002)(921005)(956004)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/C+px/mHLxAZ5FYB/7sfOOFhnoHGSjl/onbftkIopi6FnhnmeEzaRa/typeu?=
 =?us-ascii?Q?olbSRSio7Lp6hhguvvaf/2OGW0Xarf6xeC/6ERdKaEVKdzZPpwGzP7ZbLPmr?=
 =?us-ascii?Q?2vd5yHoc+LNA3TKqpnl52dmdIQhpbYpuBSyDvAM+ws2/NYtVELG8u4XetRui?=
 =?us-ascii?Q?2GRqu3a9HRyBBDMg8Di4NP6uTZxafe68E2ms+HhtkXwlPWCXHs3vfj5AWyFH?=
 =?us-ascii?Q?85qx/8MIpjzWFZU3xAIfpB+XIs2o9SW5I2hNmow+DDj6Ix9+YbGeTFQjr1+U?=
 =?us-ascii?Q?bLM2vvUi01JgxUefHwJcNS6oZM2iA6GouYGz1Z+2Nv2wPHGQI2k+NvxPU2U2?=
 =?us-ascii?Q?8RJfp4SxHImVUqL3CJ27Dlzs2FNSmJQK15XpNIR6aYCFLD4kFI4f3Usmzn6C?=
 =?us-ascii?Q?TL9KakKWIjiyAUXzKCllrBGVnpZUk4w8Wm5t/ZAyN38w2kVh58AwSeFTw8o+?=
 =?us-ascii?Q?4DTVOJA4MshYCPs8LC8/FR+2igpmjCqWRijHvNAbjkHNw2+7/ytxCYQcgG+S?=
 =?us-ascii?Q?fQ09t0RtGzVm+r3rdUJ3qFY+88Y8m2HJouDIvsFZY9tWBuDPcusUbdj1PBX4?=
 =?us-ascii?Q?LlzllSRonU0+Qbd6FxlJCeQc0TJjjEymXr1c0iTsnxqwp5ZuV2ZDbj1VOEpB?=
 =?us-ascii?Q?ytze5ZrjwmAiJIJJ3TV+1/0K1BISd8IIMOq7osGAl5sX6QP1zbODEnfB9XTW?=
 =?us-ascii?Q?K7Y9uajj4GgF/ro1/Gpr+xqQwxfy22Mm2pYcS5kcb81Km+1scA8IRrs61O7k?=
 =?us-ascii?Q?8yfO5Wrah8BljvaD36kslvivdm0fwgAi/4l0XwQDkeDcSf2WNy8cfBsNfDkr?=
 =?us-ascii?Q?chmhubjJqsmAs/ocwRWe7w4SsJ/dOXVIk9c++pNywJb3Q6tIc5mcZ7gpbM5Y?=
 =?us-ascii?Q?r1MpCL9zbVdMaF2WouCETQWlmMrbFAUJWWVSqrUvDgBAfnywi413Ne+VA0Ul?=
 =?us-ascii?Q?xcPUx7SpUV8dVwLBfs69bYoRQ/vledhlaolkZ6/AuOr4RrRMT+VMqiPALIkX?=
 =?us-ascii?Q?hKvY/Cx1jfN0VHOEhH9S9RXFA2NJJFXcjcDr7VaqwizZH8fEIM69GlcaADA5?=
 =?us-ascii?Q?Vq+LpwUDwGCpOR8fDkwRtGCjyLUJCtHVwVd/sw7KMPp5RLF/dnANSgjQPF+s?=
 =?us-ascii?Q?03+hENSXUEtPvJVVrZ7K6h4bPnvNycUOIiki6tBseQDQyT8A7cchl7bJW5qL?=
 =?us-ascii?Q?5QuXy61qNnccUqdDY4tkyNoXMlbknCIpDNASRrJmEjxb+oxdhG2C+oo/V51d?=
 =?us-ascii?Q?5vCGFQOa1wfeyetglIa6kV0/Hi/95U27TIzqpagVFcjqkLr47RKv8cRBLslu?=
 =?us-ascii?Q?2zNn+Ue/1qSQnFh/C6bG12Gt?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e17fc7-c5ed-4021-7ebf-08d8e26c7cb1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 19:58:05.0830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtNYgB6AWEQvxXiXBKnOgHKq/OXlzj9+80fPrdWr4970yczchR64WItTJfGRDD9MIkwfImgAWbSTNCRBDWJ+dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1797
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hypercalls to Hyper-V on ARM64 may return results in registers other
than X0 thru X3, as permitted by the SMCCC spec version 1.2 and later.
Accommodate this by adding a variant of arm_smccc_1_1_hvc that allows
the caller to specify which 3 registers are returned in addition to X0.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
There are several ways to support returning results from registers
other than X0 thru X3, and Hyper-V usage should be compatible with
whatever the maintainers prefer.  What's implemented in this patch
may be the most flexible, but it has the downside of not being a
true function interface in that args 0 thru 2 must be fixed strings,
and not general "C" expressions.

Other alternatives include:
* Create a variant that hard codes to return X5 thru X7, though
  in the future there may be Hyper-V hypercalls that need a
  different hard-coded variant.
* Return all of X0 thru X7 in a larger result structure. That
  approach may execute more memory stores, but performance is unlikely
  to be an issue for the Hyper-V hypercalls that would use it.
  However, it's possible in the future that Hyper-V results might
  be beyond X7, as allowed by the SMCCC v1.3 spec.
* The macro __arm_smccc_1_1() could be cloned in Hyper-V specific
  code and modified to meet Hyper-V specific needs, but this seems
  undesirable since Hyper-V is operating within the v1.2 spec.

In any of these cases, the call might be renamed from "_1_1_" to
"_1_2_" to reflect conformance to the later spec version.


 include/linux/arm-smccc.h | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index f860645..acda958 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -300,12 +300,12 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
  * entitled to optimise the whole sequence away. "volatile" is what
  * makes it stick.
  */
-#define __arm_smccc_1_1(inst, ...)					\
+#define __arm_smccc_1_1(inst, reg1, reg2, reg3, ...)			\
 	do {								\
 		register unsigned long r0 asm("r0");			\
-		register unsigned long r1 asm("r1");			\
-		register unsigned long r2 asm("r2");			\
-		register unsigned long r3 asm("r3"); 			\
+		register unsigned long r1 asm(reg1);			\
+		register unsigned long r2 asm(reg2);			\
+		register unsigned long r3 asm(reg3);			\
 		__declare_args(__count_args(__VA_ARGS__), __VA_ARGS__);	\
 		asm volatile(inst "\n" :				\
 			     "=r" (r0), "=r" (r1), "=r" (r2), "=r" (r3)	\
@@ -328,7 +328,8 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
  * to the SMC instruction. The return values are updated with the content
  * from register 0 to 3 on return from the SMC instruction if not NULL.
  */
-#define arm_smccc_1_1_smc(...)	__arm_smccc_1_1(SMCCC_SMC_INST, __VA_ARGS__)
+#define arm_smccc_1_1_smc(...)\
+	__arm_smccc_1_1(SMCCC_SMC_INST, "r1", "r2", "r3", __VA_ARGS__)
 
 /*
  * arm_smccc_1_1_hvc() - make an SMCCC v1.1 compliant HVC call
@@ -344,7 +345,23 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
  * to the HVC instruction. The return values are updated with the content
  * from register 0 to 3 on return from the HVC instruction if not NULL.
  */
-#define arm_smccc_1_1_hvc(...)	__arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
+#define arm_smccc_1_1_hvc(...) \
+	__arm_smccc_1_1(SMCCC_HVC_INST, "r1", "r2", "r3", __VA_ARGS__)
+
+/*
+ * arm_smccc_1_1_hvc_reg() - make an SMCCC v1.1 compliant HVC call
+ * specifying output registers
+ *
+ * This is a variant of arm_smccc_1_1_hvc() that allows specifying
+ * three registers from which result values will be returned in
+ * addition to r0.
+ *
+ * @a0-a2: register specifications for 3 return registers (e.g., "r5")
+ * @a3-a10: arguments passed in registers 0 to 7
+ * @res: result values from register 0 and the three registers specified
+ * in a0-a2.
+ */
+#define arm_smccc_1_1_hvc_reg(...) __arm_smccc_1_1(SMCCC_HVC_INST, __VA_ARGS__)
 
 /*
  * Like arm_smccc_1_1* but always returns SMCCC_RET_NOT_SUPPORTED.
-- 
1.8.3.1

