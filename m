Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0A3BEDD3
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhGGSSX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:18:23 -0400
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:62945
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231376AbhGGSSQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:18:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=govqA+X9+lzVM/cD+0ruYXc1YZ177VDjcRa2ZwrdvCHR7twPw0eYBdTlPRRUgkob+/xeSNvclcVpcUHGrxfQVc9z+DAGBwIZ/5jnGxJ47UaJQ4MoPqXtA9VjKFndouyfFD2z4tZczhR1a+VM5MbR5SkGuJQLyneeY5qmXzDbppGOT1Z4nD0Gd7+A0KDlRd8cR7Of2742HVrA7N0+ihs9fVX1KnptovzvcgxQ4n3iqGK4I0ZWXgRTxREl34i1WUCLGe8cWHsgyD/4XLkjgwjO4qhgZgPeoo7VSO/pImPf5JB+TJmm53KP1dIvqI97HLFM6c1UELEDU6kK3EI9jTrUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0N9ZErqug4pgk71YQajHqeQ3GpWF4d9XuQBEPLDLKU=;
 b=SnHu+UARWILRiFARMWOjz9pZGg5/ECx4n3IZ+D4oSe06tL6v9m/IjRRg+5gkOT/iCki834HbaC4a6YMzGejHqfP22j/xHdm1QwGgOS9SrF1dgeLC5iApBzbSvHX6ZcOp0QHjq1KRao7yX3YIkQAUzzkHO9l6kjiJAByLzJn12sY11FDTnGfpBydPfHx7hmfIKrCyHTJcEYTbDxX37AC0TSBucxGoYjE1Y9F+tZCnDMf1sfBRPOubGT/GhDISOW9gjf3k0X8RhUl1HDVkKkM+Tv9KDku9gZJ0yAA8zDCDDRdAVAS9146iAQg+EWl/vuNlnb6gsQhOmFX9lO2VFKckmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0N9ZErqug4pgk71YQajHqeQ3GpWF4d9XuQBEPLDLKU=;
 b=bax/LEPFLjmqiSaju20PY2z5JRDotTDhJYqd4aFH2omQGvaB6GzMP4w1HCB97kj0UhB+o6VSbI6RymiIKPvmXQOft38Pa1nbcvkroMSOzFT4XrKNXuNDfiP8D3qFK7EIQPBeBvgy1LJhZkKG2S0x0QlOUtyPjpkwh6Idfh6CjF8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB3939.namprd12.prod.outlook.com (2603:10b6:a03:1a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 18:15:31 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:15:31 +0000
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
Subject: [PATCH Part1 RFC v4 02/36] x86/sev: Save the negotiated GHCB version
Date:   Wed,  7 Jul 2021 13:14:32 -0500
Message-Id: <20210707181506.30489-3-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707181506.30489-1-brijesh.singh@amd.com>
References: <20210707181506.30489-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA0PR11CA0104.namprd11.prod.outlook.com (2603:10b6:806:d1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 18:15:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cc1bbae-1f48-4f5c-1a4d-08d941733487
X-MS-TrafficTypeDiagnostic: BY5PR12MB3939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB393907CC5202D477D84A9422E51A9@BY5PR12MB3939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJjmhGIR5F1phAfCKaA2jlwFYPRtpCKep5bzcpfxxQGPAk71Rhl43VI0HJn7ZBiR2n94cKmwnoXi9T8vRAj18zoqiXRUmqF+lU9tsG8hP1p/Kl/XUT3oFTbuLQyZ/SzEl9RMGEuf5ztj//qkSIMNw0XwNRbak/1ACRvWgIxH6ND4CF76+gibm/jG6/WD63yubnhOZ0DA3WoIQWkeLfPV77aRbpD3vHz9HkB1j+NnuIFu87PdKjSSaIcrmhhBALNGPwrGhNqi1D9nGVK2ZuiNyDDVNPM9fuLhshe5LZSvv+wVKQnEwi13aXKiVl/GFo73PfB1TTBrkPKK39hLTrrikv057/bZJPZVBcrqy+StK3uUoA5TzyKii1JmYCVnUbkGg7iI0aW6436SdHU6eUVR2GZ10nlBXw58/59FTuzHEgVXWgrSI1OpqL4FuQklcoJsNl+iLy7H28fuj+jDYM+VrQo83WOnJmxNngVVt5O5hoX9PwrRAUrrLAw5HEizoaprhjmIwAN4LkNJqGfpGLLXUYlr/RRXca+aYWTHV0LhWLa0ZdayUgWqWsubzSXsotUo4H+sIOPnN/q25STzZe7TjKgHrBSHzuxrvM/QKl3It9AwE45+i2arVl1u3JfY0C1SQVWu7wsBdHAWG1Q6+h35hOu6zjQDw7hMS9/LWPa4+4oM2LRKdiEn1PiLioZ4DjoWgbk04DDFZ2vfaxMq0jfwHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(44832011)(66556008)(38100700002)(38350700002)(66946007)(186003)(66476007)(2906002)(1076003)(26005)(52116002)(8936002)(2616005)(6486002)(7696005)(6666004)(5660300002)(8676002)(956004)(7406005)(7416002)(478600001)(83380400001)(316002)(54906003)(86362001)(36756003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UPYNYcVq1LQbk402D5wl0W0nZSq1ZkVofeuUEr4cKjk7Zfgu08GsfbrmzeRa?=
 =?us-ascii?Q?sfFBi8Cji0799mqKALBMTtMoR520i2ZIv22oV9w+/cOiFkfNExTYDnDngC8E?=
 =?us-ascii?Q?R4n5mY5zxngDJ1hV8OWX8pnWJLiY4ASgo8KLmd2KR/DOiKxuEFFWQCUydi3Q?=
 =?us-ascii?Q?FTSmtkJUJDOrESYmnwbyouHpyjbmuZCyH/DvkeNugbGbHSmEDDaP07uiC094?=
 =?us-ascii?Q?CeWOPTa1e+UrTljSGa7UpWW2Xp/Ic6O5rwXKVvOtlEvdEYnpWD76pZYYZ/EE?=
 =?us-ascii?Q?+9g+ozwNtUrxgOP0b/cXll0mWRiPSc+0IbYNqyU8Y3uzzEduTzHcWKvcNbIm?=
 =?us-ascii?Q?Qtc9546cNECCmSAhPjLuBWPhDMU6+Z93+6TotmH5aNjOEA022GBYaBv6a4Hp?=
 =?us-ascii?Q?U3KMTYxw46i0j8AnyDlUeiLi4JiHiXk2HCYKwIXeSKC33qOVRw6AXPQKjwyl?=
 =?us-ascii?Q?ShOnrbL1NtrPzrAQb0lPkUi/o4mHVyVeyXIwopKWLIKMxqzYRVvdpomfAKbv?=
 =?us-ascii?Q?xjW7o9WCu2m9mruvTw/B1yizhlDNg31hMaZGxqStrRzX6e1+qPjkRmZu5uYq?=
 =?us-ascii?Q?rzWGwcfoEN/ZTSJOHHeqRsXN80v4qZ7o9spPVtv3Dqh/uOzU2YQ2LxB5LpkD?=
 =?us-ascii?Q?6v8qCEHa6Gih1lhffX3dnHFPeNB9JjNmTv/Z/HmNP2RvzKzEiVLeT+YVhTRx?=
 =?us-ascii?Q?VyAYQb9/HW78q0qieI3nyD/Tbl1/e3A5Y6VBCf8M5HdY9pnxuGy6KSY3JoOp?=
 =?us-ascii?Q?aVU+5905YXE2xdSRRQYySbVqULNN8l3XUYhrZRBKMUGB0tSHkorlpUihAvaN?=
 =?us-ascii?Q?xYuAetG+l3VNw7Xwn4Pv95xfzM7UrDIzhDX5Kfo+EDkjEQMk1zZJa1bdMdfV?=
 =?us-ascii?Q?wRjdbJEqfRV5svThnhqLYaGlC14A82aZE/JBqBpMUVacBLviT59P330FciIh?=
 =?us-ascii?Q?chAoIhXTxlptauHQmMRY4U6WJvhYJgB9tGEeZrzYqfuSGh12hu7EvpEqCpvN?=
 =?us-ascii?Q?d+pfyjAsWOiG2fp1JKCQbjj8BB5WzD8ldaBRRdCEu001Q4kPO7sxMlj5UCFG?=
 =?us-ascii?Q?NFRMajDAGnXKAmsjiYHoO1SWQZkjpHcSmuDNl5ibQ01TQYwfM4Xd4dv37IG4?=
 =?us-ascii?Q?+F2lZy81vrl/jvMBut75b3ZJJBv5UDl7qcQ9SL5US4OyWVMXmWJDqX9+4cno?=
 =?us-ascii?Q?wIPLNTAo8nDfN3gh+jWcyE2754BpAiP9KVk85RJja119mw9m6355oKdLOsap?=
 =?us-ascii?Q?sA3tjkS+nBjzw6eofIpk8IVz5/b4Hw+pI72Pp7oRY+zd36/BKMRGh855rIBS?=
 =?us-ascii?Q?D298Wk2VbjhPndrU9Pz6Mq4E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc1bbae-1f48-4f5c-1a4d-08d941733487
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:15:31.0498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktux2SXOBM7PBwWyERbc6E7/DPh0NOFYRQAJiiUyi6eh902/upxbiGyljVW7zsRIAldY1tUuvAZszz4YR2asfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3939
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-ES guest calls the sev_es_negotiate_protocol() to negotiate the
GHCB protocol version before establishing the GHCB. Cache the negotiated
GHCB version so that it can be used later.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/include/asm/sev.h   |  2 +-
 arch/x86/kernel/sev-shared.c | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index fa5cd05d3b5b..7ec91b1359df 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -12,7 +12,7 @@
 #include <asm/insn.h>
 #include <asm/sev-common.h>
 
-#define GHCB_PROTO_OUR		0x0001UL
+#define GHCB_PROTOCOL_MIN	1ULL
 #define GHCB_PROTOCOL_MAX	1ULL
 #define GHCB_DEFAULT_USAGE	0ULL
 
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 114f62fe2529..19c2306ac02d 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -14,6 +14,15 @@
 #define has_cpuflag(f)	boot_cpu_has(f)
 #endif
 
+/*
+ * Since feature negotiation related variables are set early in the boot
+ * process they must reside in the .data section so as not to be zeroed
+ * out when the .bss section is later cleared.
+ *
+ * GHCB protocol version negotiated with the hypervisor.
+ */
+static u16 ghcb_version __section(".data..ro_after_init");
+
 static bool __init sev_es_check_cpu_features(void)
 {
 	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
@@ -54,10 +63,12 @@ static bool sev_es_negotiate_protocol(void)
 	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
 		return false;
 
-	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTO_OUR ||
-	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTO_OUR)
+	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
+	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
 		return false;
 
+	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
+
 	return true;
 }
 
@@ -102,7 +113,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 	enum es_result ret;
 
 	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
+	ghcb->protocol_version = ghcb_version;
 	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
 
 	ghcb_set_sw_exit_code(ghcb, exit_code);
-- 
2.17.1

