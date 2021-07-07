Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366FC3BEF05
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhGGSkc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:40:32 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:40288
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232406AbhGGSkZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2UzQOmnh1WJ8GyL0B4zRLQB14dt+FQQ8FYfQjnpAcV6Z61UXXs58Ov5IxJZ8JO3SYvGmqvEb402YoCKqtsMEuIdADtbFEae2uDkLPG7hsmRVTBAMJPNECc6gg1rDqlDiv+14zWG3xdXUB9FnhJ8IxUAxcjuJyyhHnqYx+Uyb+0nx0PNuAxEa5aa78ol1f7RvV47sxJ11pGhjJYR4XqMd6ahKYdHKNwy0eSUdjj9byTzIvY6TbHdPz5dQmr1p8bnvS1CkmaQJ1OX4wataeD0AVtcBjmAL2W1YsGLC0BVgpctov25oVUnG35csxEVaXL17tuUDfNxZncBqTi3K3YIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpXh/d1oW0O8X011nZrkk6bGWy2Oj+PMhUMITu+RQE4=;
 b=XhOwwLUacl91Dnn7TMBWFTgOpw1Ej5lt1K4iEQ6aTjgKtCDLb77DRCvJuUjrscsUbsfglIBT+e0pqDalSqDyfLV2CBK6eFreb1K4VjQ4au30qwuG8OYVJW7t7T+9vAnI8WLuKYODJqyHZv1R+UDwMvkQWQCh7byZF+mTyTkqAjSkGtdzKpoJCpksBckc0iKJIlqxD2zGs43eA2P1QDb4nsG3PMaAhqoejAxVGuSUz3Y/3YCC3niA3LMcTNOh0K5h2v6Uv6tj4HhjK/OfONOgmsUrYMonuZIyeTVBKsWVueYtCDTIGsaApdeRlJ0BqsIo8KHio5vVZ0UWCrc+xa7vag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpXh/d1oW0O8X011nZrkk6bGWy2Oj+PMhUMITu+RQE4=;
 b=zRKFnKFdrYzuE0gLWAjjsaDW9fxPQuXieQ+zCbBpHI6WDrVehIHwOSgLeL1gxJ76m3ZS82StfqvDHpBsIjMgtHD4kfmNRd/nVYWxOrsGExSQ4W0WjuoZpYMNxR/0qe6ev+sLOdA7yh3qi5+WfFLpWgJFpWg4ptY8x98yzzvZ3mQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BYAPR12MB2808.namprd12.prod.outlook.com (2603:10b6:a03:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 18:37:25 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:25 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part2 RFC v4 12/40] crypto: ccp: Add support to initialize the AMD-SP for SEV-SNP
Date:   Wed,  7 Jul 2021 13:35:48 -0500
Message-Id: <20210707183616.5620-13-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1350d050-3991-4a88-d679-08d94176441a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2808:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2808E9CF0E5518C6D80F9793E51A9@BYAPR12MB2808.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQIravkr50ECnbVwwyAJHpSUcs8XxZ+SLd/gwl/j6eyxefECO0Q+l2OeFxgaPgW6r+E/c56HUNgVASM6bOvRoGzqhBvtQ4OLVY2bVMDJygLbZ/SP3HNgKXBCcmEGL8oR4RvQEppqcjJHLY/jzyPch1O4Aw0VrIR3LCzo48HBwTYWoEXeaZln63XKPWuIiTTmzDtFot8wl2Os/YLVAQEQoJ6pkxKN7u9XtP4H021oRzOeV3id8IDLBAV6iBbr+ZZJ2IBdJwKLGuHxJpEOgsmtKILYwSKPCeIVkCCX73ealE5pljkOLNGzhuFm12VAjHOUa+3DSZMEpkEk+IbuldjWTSp1MkXRa5b8z9D/dcom0mB/CTVLvx9lDc7KWU5sSFvLQ+Zh6W1yr0CQb2fZCP+IUuV38WOCQ9Ms3KpiGbt9VpQXOCwgCNMnEOzKyi4QFpoJkNtkIlpPhYx/Y2zOYT7Cb9yTfB+l1qumtNYk5Bk36yIp6m6gdwMHpQ+IHuwJR2aYjKdMO9zI8XEsF8UHvM2JGzEPFVywJvDfQQrNeUc4gsKKHk0CKdx3wjjg+w1TcDA4tv+aVsStxYAIAU2G/FbTeQS5YzsxV/AE56j2/uhWzCfvkA9jEP7w5Cd8Qk6706cKa9AQdZDlTed8nMmDfnG6T37f8ZQHpS3bOoR68Fs29oxy3qL+Z5BvPRnFpZ7VPzA9dOuUwWVEtavmC3N/FyjW7hqYprAtLYK3eY9eSORparI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(36756003)(83380400001)(66556008)(38100700002)(52116002)(2616005)(5660300002)(956004)(2906002)(86362001)(7406005)(4326008)(1076003)(44832011)(7696005)(66946007)(54906003)(316002)(8936002)(6486002)(8676002)(478600001)(6666004)(26005)(66476007)(186003)(38350700002)(134885004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QWkL/QXMDx5cUByHrvxDlOI72YzixGoY7TypwdnzWjVv5KLOBvH/qX3k7PiB?=
 =?us-ascii?Q?sInNpc7ZCXQ4eqG5s85+Alp3mB68cWXuN2jp0BTaQ29dBOJd1aOJj2+W4ioW?=
 =?us-ascii?Q?zwF/90JzLSVWkYWO+aD8ndEU9VPMfU2XJyjV9fEm7NCtFP/lFQn2P7kluB6V?=
 =?us-ascii?Q?bNhrnwthtZUDECJYskKpKi8fsQbOpJOMrXkEiPPAdaZTJ0HjN3YYRrgi+Ffj?=
 =?us-ascii?Q?YOkpq5M22lW73D/OCwAfhUQrPgYMQ4yJQHxGn8216/Uii/BYvu9RXTNuo5UI?=
 =?us-ascii?Q?KlVHF3v8/xckR/BrX5KSTf7a6vCtLvZEF52mTCx94rnRffsHsb96ysYk//Js?=
 =?us-ascii?Q?9OXb4iPsz7U2SZg5d/a2VBjcXYxxf3be7hrt+jxPILNmyEbztsOWs/x48mAr?=
 =?us-ascii?Q?5Sdzlk2ZSntoTGNnXqlTe9Q38wA1P+5K3iL006KrlTJ/OByKfqngziipu/yh?=
 =?us-ascii?Q?2om11uxOxZ/gukMfIfMjnYq3y3ih25v126wuE1sIvEexNfQTrPCapXKw+Ua5?=
 =?us-ascii?Q?velcIto5M48oodyGuOF0nXoFT0aR6OhCy8XFvGXaKv+IurC0ZL/YCczAh+Vb?=
 =?us-ascii?Q?WB5mAUZrynwUE03P2VA7tE3dhytb/YqRjAQ/tK35JfQY5oDbeCsEyFhCavJP?=
 =?us-ascii?Q?BeETL/HyDfn+RdHeDAbUdOV/Mm/ws+kESZon8VkeAYo9fEBQ6dd1X62/xlzB?=
 =?us-ascii?Q?+vW3hVeL0PuHkC0VvTzIjgZBaWYtIFXHvlNTxMh+x06UFGnMWBpzUdFHqqaa?=
 =?us-ascii?Q?GkLi5AsAqpO6zjt4PI2/dHALhnMDzCX6fLyx+YrSeL1dq5w7Wt34hWb0vdWL?=
 =?us-ascii?Q?WJjYVUOp9cRfxhm0eik2n5UPrlVPX45potxrUYLstHzikuLR9MrUhtYxImJ1?=
 =?us-ascii?Q?Noh3B4GPpiu40UDsb2naJ5MQjSO2Sxv9yOiAa13G3F+l9RQdGVY9L2hBvgbW?=
 =?us-ascii?Q?7+sDDf2xYkrYiUr3IziIwtmBm+OM2giwte2DTC4WNXmEq8s8LnbZvqJf7FgP?=
 =?us-ascii?Q?6IjxSDZR/R+N4xHMc0G/Hy1tRSNcXipDPSqzd+kvvzSVH+oiMEvKfAnxZN/Y?=
 =?us-ascii?Q?Q8ZJ+5UBFCCXRCzMKI/l9D/9VqjYLy0MOuPp8F3AvTB7GvDwLCe4U64kNDxE?=
 =?us-ascii?Q?mGWlnqLPiP+bF091604rWkfDvpx/EoXOnQHDbAAoF4qujhIEp1AkqEkTWGYl?=
 =?us-ascii?Q?EVg2kr5/4yZ8tn9UYtul9SzX4Gaj6yA4TweYjriG8e7C3bj5Vj+8o5l2s+dY?=
 =?us-ascii?Q?zhj6OclX9xzyhlxvz3rnl8Habl7BEhb6hOXhYmZdaP8Vu0NsibqyXXna09GO?=
 =?us-ascii?Q?HtfCvZuqQ00dYRO+TOeP9L4d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1350d050-3991-4a88-d679-08d94176441a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:25.6580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEFFDdfEePNilokTIQP6pA7+vKH+J5ngTH+OGkzSpmCsfZ9uDSV9Bmmz7InNYUZksuKe5l/hX3jEJ9gZ5NFE0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2808
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Before SNP VMs can be launched, the platform must be appropriately
configured and initialized. Platform initialization is accomplished via
the SNP_INIT command.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 114 +++++++++++++++++++++++++++++++++--
 drivers/crypto/ccp/sev-dev.h |   2 +
 include/linux/psp-sev.h      |  16 +++++
 3 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 32884d2bf4e5..d3c717bb5b50 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -591,6 +591,95 @@ static int sev_update_firmware(struct device *dev)
 	return ret;
 }
 
+static void snp_set_hsave_pa(void *arg)
+{
+	wrmsrl(MSR_VM_HSAVE_PA, 0);
+}
+
+static int __sev_snp_init_locked(int *error)
+{
+	struct psp_device *psp = psp_master;
+	struct sev_device *sev;
+	int rc = 0;
+
+	if (!psp || !psp->sev_data)
+		return -ENODEV;
+
+	sev = psp->sev_data;
+
+	if (sev->snp_inited)
+		return 0;
+
+	/*
+	 * The SNP_INIT requires the MSR_VM_HSAVE_PA must be set to 0h
+	 * across all cores.
+	 */
+	on_each_cpu(snp_set_hsave_pa, NULL, 1);
+
+	/* Prepare for first SEV guest launch after INIT */
+	wbinvd_on_all_cpus();
+
+	/* Issue the SNP_INIT firmware command. */
+	rc = __sev_do_cmd_locked(SEV_CMD_SNP_INIT, NULL, error);
+	if (rc)
+		return rc;
+
+	sev->snp_inited = true;
+	dev_dbg(sev->dev, "SEV-SNP firmware initialized\n");
+
+	return rc;
+}
+
+int sev_snp_init(int *error)
+{
+	int rc;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		return -ENODEV;
+
+	mutex_lock(&sev_cmd_mutex);
+	rc = __sev_snp_init_locked(error);
+	mutex_unlock(&sev_cmd_mutex);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(sev_snp_init);
+
+static int __sev_snp_shutdown_locked(int *error)
+{
+	struct sev_device *sev = psp_master->sev_data;
+	int ret;
+
+	if (!sev->snp_inited)
+		return 0;
+
+	/* SHUTDOWN requires the DF_FLUSH */
+	wbinvd_on_all_cpus();
+	__sev_do_cmd_locked(SEV_CMD_SNP_DF_FLUSH, NULL, NULL);
+
+	ret = __sev_do_cmd_locked(SEV_CMD_SNP_SHUTDOWN, NULL, error);
+	if (ret) {
+		dev_err(sev->dev, "SEV-SNP firmware shutdown failed\n");
+		return ret;
+	}
+
+	sev->snp_inited = false;
+	dev_dbg(sev->dev, "SEV-SNP firmware shutdown\n");
+
+	return ret;
+}
+
+static int sev_snp_shutdown(int *error)
+{
+	int rc;
+
+	mutex_lock(&sev_cmd_mutex);
+	rc = __sev_snp_shutdown_locked(NULL);
+	mutex_unlock(&sev_cmd_mutex);
+
+	return rc;
+}
+
 static int sev_ioctl_do_pek_import(struct sev_issue_cmd *argp, bool writable)
 {
 	struct sev_device *sev = psp_master->sev_data;
@@ -1095,6 +1184,21 @@ void sev_pci_init(void)
 			 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
 	}
 
+	/*
+	 * If boot CPU supports the SNP, then first attempt to initialize
+	 * the SNP firmware.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP)) {
+		rc = sev_snp_init(&error);
+		if (rc) {
+			/*
+			 * If we failed to INIT SNP then don't abort the probe.
+			 * Continue to initialize the legacy SEV firmware.
+			 */
+			dev_err(sev->dev, "SEV-SNP: failed to INIT error %#x\n", error);
+		}
+	}
+
 	/* Initialize the platform */
 	rc = sev_platform_init(&error);
 	if (rc && (error == SEV_RET_SECURE_DATA_INVALID)) {
@@ -1109,13 +1213,11 @@ void sev_pci_init(void)
 		rc = sev_platform_init(&error);
 	}
 
-	if (rc) {
+	if (rc)
 		dev_err(sev->dev, "SEV: failed to INIT error %#x\n", error);
-		return;
-	}
 
-	dev_info(sev->dev, "SEV API:%d.%d build:%d\n", sev->api_major,
-		 sev->api_minor, sev->build);
+	dev_info(sev->dev, "SEV%s API:%d.%d build:%d\n", sev->snp_inited ?
+		"-SNP" : "", sev->api_major, sev->api_minor, sev->build);
 
 	return;
 
@@ -1138,4 +1240,6 @@ void sev_pci_exit(void)
 			   get_order(SEV_ES_TMR_SIZE));
 		sev_es_tmr = NULL;
 	}
+
+	sev_snp_shutdown(NULL);
 }
diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index 666c21eb81ab..186ad20cbd24 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -52,6 +52,8 @@ struct sev_device {
 	u8 build;
 
 	void *cmd_buf;
+
+	bool snp_inited;
 };
 
 int sev_dev_init(struct psp_device *psp);
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index c3755099ab55..1b53e8782250 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -748,6 +748,20 @@ struct sev_data_snp_init_ex {
  */
 int sev_platform_init(int *error);
 
+/**
+ * sev_snp_init - perform SEV SNP_INIT command
+ *
+ * @error: SEV command return code
+ *
+ * Returns:
+ * 0 if the SEV successfully processed the command
+ * -%ENODEV    if the SEV device is not available
+ * -%ENOTSUPP  if the SEV does not support SEV
+ * -%ETIMEDOUT if the SEV command timed out
+ * -%EIO       if the SEV returned a non-zero return code
+ */
+int sev_snp_init(int *error);
+
 /**
  * sev_platform_status - perform SEV PLATFORM_STATUS command
  *
@@ -855,6 +869,8 @@ sev_platform_status(struct sev_user_data_status *status, int *error) { return -E
 
 static inline int sev_platform_init(int *error) { return -ENODEV; }
 
+static inline int sev_snp_init(int *error) { return -ENODEV; }
+
 static inline int
 sev_guest_deactivate(struct sev_data_deactivate *data, int *error) { return -ENODEV; }
 
-- 
2.17.1

