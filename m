Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D093F2EDA
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 17:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbhHTPV6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 11:21:58 -0400
Received: from mail-bn8nam08on2087.outbound.protection.outlook.com ([40.107.100.87]:15585
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241147AbhHTPVn (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 11:21:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqG4Uw+c5KrO6pOe2YukON9GgnAwYjZx9l/IIXRQcV19CU+GoXLMVHsM42yahxWXKJ8QosTfjWireZubM6O+mVDbU9q88LIpZ8Bor7EmWT9SOtI/GNaPAqQAV1BNdswDpsk8RfLVRQeBIXVNudi499tEeJC8HL4MJC69oDfZ4H2VpCaCYZKgJlC408ZSNGnN/McMJJP12nnPMSy+E7fMBst2vzw63qn195Gn9XemSD036bTHAsDxmPM9Ng9DZTudE4LDSl2ok1UlhIOrEyLVCqJzQ+qMbUZe8zQUOmBb3cUo4SMaIpkyAl5j48Veyb0g8kfN7PeG5muzu9FoxxcekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPq/Bm8D4+T6YUsvjWVRoSIexYZEsWXMUsMbx0WMS4Y=;
 b=SgYNms7aZLH/9FNHG4T8jduVcr/jhZBaRtczJno098T3Y9+Aw86lWAQpAhtrDKOiESXXjlMsSCSafvLqI9DIu6xRrfiPTWxJAzPTUslmOeNMaEzL/tU700313WKVTwnLxLQ15EJYacVLtlwmDwYvX9GxwRltSIzUOE3xcJANTWC3NKr9n1mklVbQy8RsFNTMhbya9ulj8hhzchYZLLyF8DhZACEna4TGzz2pUUAXL+HBmRNgCeAfBDevG9XYD4rEXG++naFhwdDH+2l/9ArgWLZeUHZhkGcdi+EE2FIU7vp7hoZqhhAOp1sEn/lJdcv+GbIQyNtjFnDY6p+V4u4LIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPq/Bm8D4+T6YUsvjWVRoSIexYZEsWXMUsMbx0WMS4Y=;
 b=5Ljzs2R9p7tP7DieIuCEzZZBML48nrFbgiezf5I9nyUmsEFrqvr2lQDHJ87s26VdBopcRC+WGmF8vgkSU1V2e6jjvAPlwPTuZk/luaN7I60PG5yOd9+038+4lRxEKQOolCxqz0Yiim1LU2om8G4C9hq6uFYhTdIOkY4LS83d3T8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 15:21:03 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 15:21:03 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH Part1 v5 12/38] x86/compressed: Register GHCB memory when SEV-SNP is active
Date:   Fri, 20 Aug 2021 10:19:07 -0500
Message-Id: <20210820151933.22401-13-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820151933.22401-1-brijesh.singh@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::7) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:21:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66e6febe-de9b-4b90-3995-08d963ee1f47
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4557906DC2B8AB6EF7DFABF6E5C19@SA0PR12MB4557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNfbIiZEpTiCnr92fETCX+EwZKoVq6HHWeaK6AkaOCwPCnjwWPD6mjOYQlzyiXrPWECroLWqd0/N2WmfRpn+BRZWF2RXRXI6kxAz04Kz21c/1mH/TylxEHtWjEwkA0hhdKxIuhMeg7mRAjWoWwM38y3NAMUJBEf7ECMdGFeJH3EAUHZU77JxaJgJ4fVUpnKV+S93hEnNmQK9JNWP9d17O5puYF0iGYxeudddha5bpZuu2xaUxQeW9wJ/rdJbR0KZNGBJFhPjO8ik0I+H84p3G9TLo+rA7pHePd4JccUjZCNanbQ/BVuYIyVh7/DY3RvcL6nOwHr8P96m4pT0bPdwPbGamslmWjgSIVUd7ilGMWj4Ueuiz0POEfnpcfb6U7i8yBQkS0fMmggOxK96xsAuOZwOeUCcDbAHxXt6H8QnQ3EiAuJrLWMEOX3G1wxgWbLL3FE3kAEoMRCd+OyAUTuFh3O12IHb8dGsTpc36OIMse30+5Ad3RYzEe1vbXxAkZIoj8bkbgxLkHUD3y5SjjfYK03VvS/8HgztknfW3XYDk8Swnprint8Vb95fPriZfA8sA0czR65n8QAFkxmS2knigFcwcfxFk88nnHL5kR4a4DXCtHTJCLCD4KNCHAl+cx8sB1JGsQdtC8IIXnKk+zKNG5eRyQ7ElfcZ2hX9nkL87FdtaltClB5LBr/UvswMYBHYpkUihgjnhDltrD5C9wb9vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(66476007)(66946007)(4326008)(478600001)(44832011)(956004)(2616005)(7696005)(7406005)(38350700002)(52116002)(66556008)(7416002)(38100700002)(36756003)(186003)(316002)(8936002)(2906002)(86362001)(26005)(54906003)(1076003)(6486002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XJAjJ0l8dkrkD0RyBh1TkH0r51Kf11d9gBlZG9UpOQwVA2JZSHAeCgOA6O3Y?=
 =?us-ascii?Q?YdOfTnICoTOYvSkPdGSeTkl22gZsupOE1TCirX1lZGQ7s93KejxKYg58nobf?=
 =?us-ascii?Q?5hL2UEXcRj2CwTDyKeUQ90/hDa84c/tUO1ujhx0iQQzuaAguJ+k+ItyCiEVJ?=
 =?us-ascii?Q?GcL3UVlDCn8QyEicTk1mpxZFHJP0J1DPnN/+4Gzt9IdUqqWV8MLYvSms5aAN?=
 =?us-ascii?Q?ROlkwGkvuj8XnhvSLZXFb6ODecZSphqh1y75stUsRZdMIk7SlMlesV3GVb1Q?=
 =?us-ascii?Q?VYRQHUqTUbaYhHMswkOMBhdJeXf3g1xzZrlny6uoMHGVzmfxIennwWV/IoTi?=
 =?us-ascii?Q?S/faXA6y2x6W0zJT4/sq24SgCwsQ6iFAXf05f2C9ATKfusvTWYQ6cmDH/g74?=
 =?us-ascii?Q?ZN6aMwHAJHaGpvAjl1HqlvLwuWTe2UaT99BwXHL32rO6pRI/Gyckl8Ri/wQ4?=
 =?us-ascii?Q?nUjzWAocCrzQ6au4vjOoT+dS5tvI4ESj5/7UHJCC2kMaNEC7Rx26IoRW/PYo?=
 =?us-ascii?Q?vIrsSImrHp7AlrcOvB45/5RTLTN/euKEIFYUkyJvS2mSKefrW3RaRFP0jS6b?=
 =?us-ascii?Q?/X9n18xOhwHXnY/1XIVtJUTAWEjJBUUGjLYwPruMRt7ZubVdbXwHiCf/N+E6?=
 =?us-ascii?Q?tdiHdAmaEmgWg1xs2Cz1mekfCYaFOZgjd0oD/18o20DEzGELGRRW6h+dl5Kq?=
 =?us-ascii?Q?4OGlpMjPXjEfiYJwjsMakWxwxWmqGj0t8Fhs3bRhpNMyOd/zjymYPOGGGnr6?=
 =?us-ascii?Q?PTZtEOOZ64r6F38rrp5opjMOH2pSev9RTSS4EiblEbBaRTr0Nv+Syl5WgHCF?=
 =?us-ascii?Q?vRCbdjNiTEINF5hVeCwB5SgeNV+boNlVmQHAsHPNw+V04vAH+g6pSPAI/oeC?=
 =?us-ascii?Q?O4y/Ek/f6DvgTzE4MWb8gfUrZSsRTvWjwmy8uez4OQ5l3GX6H27/fKtUtyr5?=
 =?us-ascii?Q?cIykkRtn9e5dBD6rv4OhpnKDLbprn/QKI+fBrIwqbClL8uZ/ChxV5gIRXmfU?=
 =?us-ascii?Q?GBXlkG2oopMWdFjQ0nW4udMwoCaBizYd10ecZCzxscELXYdnjSUYCIRCPb/d?=
 =?us-ascii?Q?M+0/QbrygAB4ILThNvJyWeT+Rln5kN09hw2hEx07GjcuY7c7w7zHo8tA6jUb?=
 =?us-ascii?Q?mooK2VmIZ3FCJPWh1pRfigx5Nd1JgXW1B9VO8HF3QbLKmUMNZGeqpXjIFBwK?=
 =?us-ascii?Q?ujlFlkJ3uC0aqFISfIvdeRkp0U5Fv81uLph8SHilWN8G7fxzEb/8w9W+jV0j?=
 =?us-ascii?Q?Rq8sTeAPmJeaV+vbvtLQHs1CrBXwbd4V9wO4Knooyol+GviqMfcsNflWDO0A?=
 =?us-ascii?Q?MRFpXlkcaXiqGCWlssVydMcB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e6febe-de9b-4b90-3995-08d963ee1f47
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:21:02.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRADk/6Iyd5HA2CiU9jlrcz/hdltqA6MhBal5KRJwnSNqYArzvXfsyEmr0Fm1dKk4jwnB+las5M+sg9Bp6P+Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4557
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The SEV-SNP guest is required to perform GHCB GPA registration. This is
because the hypervisor may prefer that a guest use a consistent and/or
specific GPA for the GHCB associated with a vCPU. For more information,
see the GHCB specification.

If hypervisor can not work with the guest provided GPA then terminate the
guest boot.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/boot/compressed/sev.c    |  4 ++++
 arch/x86/include/asm/sev-common.h | 13 +++++++++++++
 arch/x86/kernel/sev-shared.c      | 16 ++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 5c4ba211bcef..6e8d97c280aa 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -233,6 +233,10 @@ static bool do_early_sev_setup(void)
 	/* Initialize lookup tables for the instruction decoder */
 	inat_init_tables();
 
+	/* SEV-SNP guest requires the GHCB GPA must be registered */
+	if (sev_snp_enabled())
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
+
 	return true;
 }
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 1cd8ce838af8..37aa77565726 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -57,6 +57,19 @@
 #define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
 #define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
 
+/* GHCB GPA Register */
+#define GHCB_MSR_REG_GPA_REQ		0x012
+#define GHCB_MSR_REG_GPA_REQ_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)((v) & GENMASK_ULL(51, 0)) << 12) |	\
+	/* GHCBData[11:0] */				\
+	GHCB_MSR_REG_GPA_REQ)
+
+#define GHCB_MSR_REG_GPA_RESP		0x013
+#define GHCB_MSR_REG_GPA_RESP_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
+
 /* SNP Page State Change */
 enum psc_op {
 	SNP_PAGE_STATE_PRIVATE = 1,
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 8bd67087d79e..1adc74ab97c0 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -67,6 +67,22 @@ static bool get_hv_features(void)
 	return true;
 }
 
+static void snp_register_ghcb_early(unsigned long paddr)
+{
+	unsigned long pfn = paddr >> PAGE_SHIFT;
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_REG_GPA_REQ_VAL(pfn));
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+
+	/* If the response GPA is not ours then abort the guest */
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_REG_GPA_RESP) ||
+	    (GHCB_MSR_REG_GPA_RESP_VAL(val) != pfn))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
+}
+
 static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
-- 
2.17.1

