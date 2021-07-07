Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5F93BEF0D
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jul 2021 20:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhGGSkl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jul 2021 14:40:41 -0400
Received: from mail-dm6nam11on2042.outbound.protection.outlook.com ([40.107.223.42]:41569
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231814AbhGGSkO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Jul 2021 14:40:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+d7xfIN2m1HrqLFaDxjg3oJdCXFOdJKehTnjJqCor5YBGv3cSn8V54n5TT0751Qhr0Aj/yeDxvPbrmIxTyp0mWoXE92nttGfQj0xJCR6ma84urY1xQ+/gnWtkdhiJH2r721oIFWQLNK6+9Iiw1eFviSF9exxkcXJqzoEG3RjnoH3Pq1slGGhPNSF/wqwTxH/GSoStvcouaN3IzWhfzWxObYialipthKKmRBHTzWhoFvB0Oo1haPNSnUmZiF0Wi6uHkFQoViqHt1zcWc4KOkmC4revNkaueeIUiE3KJNhOOfiiB4QztJcUjfvTrJ+ZDzsOXe6iVaWPaEPeFiUwAV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdCG0u3ayVbn+HorpZdl77V5My68WVbHcotRfTz5MO0=;
 b=dk+ZE8WwZMPINeWJwZ+9ebnZgaW8C1pfx0ANpy6pwKPk2PW/TTE5w414ntmPXyQVBHPVUdLHcSMcgNIDr3/pdjWc2/uxtBQ3lZTEK+14jrbqoW3Zo3VxD8N4JAepJRY/2wqkIpWER40m7YDWbpHEoLoysZqtoW2QPrCJ/3lm08RWA6uiva8d2HvkBNR2FWEbPPW4bGwX7Kh9bpcqGGttC5Qk9xnPgkbl+XJ61Yo4knYab5D8zYb4IUG81jHeaHub7/auXTNvvP8nQ4csEmsSZdap/sfWZVGROHYZ0H1aa9oFru0/C9Vv/fiHND7w2OgzIRc4ILukD/NwohqogQPX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdCG0u3ayVbn+HorpZdl77V5My68WVbHcotRfTz5MO0=;
 b=jdBhdU97fqEVQLXg4UGJjnhpCs3P8StWcpYyI/VCF2hT+mQMYl+O2duCSZcM7deaH9/VaJf8x3WDujXFjvzR20FSRvFVUG4LeEiajrdB7Rs7meEPkJ0cKAUiIwnOUDAwXTWvI/fwZBTMciDXJ5eo4PNnu2TRMvVkZ+3HrlKL1/0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 18:37:30 +0000
Received: from BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed]) by BYAPR12MB2711.namprd12.prod.outlook.com
 ([fe80::40e3:aade:9549:4bed%7]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 18:37:30 +0000
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
Subject: [PATCH Part2 RFC v4 14/40] crypto:ccp: Provide APIs to issue SEV-SNP commands
Date:   Wed,  7 Jul 2021 13:35:50 -0500
Message-Id: <20210707183616.5620-15-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707183616.5620-1-brijesh.singh@amd.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:805:f2::19) To BYAPR12MB2711.namprd12.prod.outlook.com
 (2603:10b6:a03:63::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:37:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03ee22aa-96b5-45a7-eac2-08d941764722
X-MS-TrafficTypeDiagnostic: BY5PR12MB4082:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4082D56A8BF37B8D2D8A75A9E51A9@BY5PR12MB4082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZS2DyaYkP4a7oWyOu9phh3kzz4iDbFgK3CjUcHe55vMV3vwSKnz0flWtRiKtZktEcnt9Ne+T/oysM881m15/vuoRnMSqGIU3ayqmWojhu4aU6rxCXTzx4bDr83v/9xh2LvVNyD/XZTt2kYm29UMWTR74tG5WZnIiwuLFQEDUXwqC/z0DYkfTVhN9YxPugRKj1TuWqsyLLDv7/MeL3FT1cNJD+URoZk7DDgQX+ERERRdFrD+eGPp0AEr2HciHYsRXYyoKb/GI6rXajRTfkKojw9rVAVWsiIgqxBT4QGtujple0S+6p1s3wpnKol2rh7b2BM8aTJUUp22bH2VKjQid/kdNVvQF6aZv53LoGyH2uy2Fc0OYjBFb9FqHOAy/lwJ9IgqyGK95d0Q48Lx6jDKTzX28vytUVqeEniwwGqpcXIe/FLjlhOFOXPNMmCpXn/oatg58XiKpnm1UiBBxGRUo/3j1pJ5trRDk2dPetCaIphV5Q806u0N7+di8wCRSjZ2hl+LEs7Wi6OX5KXCWzVelbExKUBJs6UNWnz6nGDDDMtfYoNpgGHdSm5uYgeohtzzTv2zePn7brm0L8lsRRRcs8jpiitiVpSA6se5x2bQ/IAffNLABnPN1nw+y4I2TKwyivC1RI3gA0u7dePMHR1ydKQcxKDE83XX4HRH3YvF2cFxckQon9ZcSNoGtdWOL1hkQWTA7r5eVB/ycJjh7LJRk6H76Zr7lauLmdsKqOg+yLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(7696005)(52116002)(44832011)(8676002)(38350700002)(66946007)(38100700002)(54906003)(66476007)(8936002)(478600001)(6666004)(956004)(6486002)(7416002)(66556008)(7406005)(186003)(2616005)(2906002)(1076003)(4326008)(86362001)(5660300002)(36756003)(26005)(316002)(134885004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SI2bZmKyuBbou40fi5/IHyAavzLVFOUTFkytWKXvB7oz218byoy8/a4GnEX7?=
 =?us-ascii?Q?11dj8vtjWSD1dycKcBu96b2DolWYcQVGnCobOrQnUovbmGTMUUK4JPE23WQn?=
 =?us-ascii?Q?prjDDtKJPa/zsjUta5qTAUY6SmPeMwH9Xz6OLNZChimc864UoulRMFNpC4V/?=
 =?us-ascii?Q?O1buu6F7uiND0mVeQkTFlkm6Q+odDmlGMyc8Tn+EPbDZlxQJlPBfvQnI4Ons?=
 =?us-ascii?Q?yG3BD2ryFI7+hd4nGVoTPPeNZWZ7smuhEFYAaAfbDqOy5D01n4IV3tciYZNK?=
 =?us-ascii?Q?w1tDPLjSQ2Ud3TjQt6jWSWbxjo/zUIh9JYd/VL93UhylFkXjMwUIrUBKeva8?=
 =?us-ascii?Q?dN8YLG9sCaea86vCelkTPoSwVWyrH0Yqld6kBdW+VqcIU5bEGF7ntlSlQfSr?=
 =?us-ascii?Q?83kArrcKDySxySJZAs4+bGc/x+zGMsXw/WkPpEHLVGY28KAUitd4/3DqtJwD?=
 =?us-ascii?Q?L1Q1E71/ygA0AntPAfIj8xhJK5U9OBPElO24ru8zZNfdoJBwQdXBGM/vdAe8?=
 =?us-ascii?Q?UEhZbVQYQqhRRzD8Tdqd7QgqKiAS8I0L1MNevUVGqYFJTkfXXiUEJ/EvOSKe?=
 =?us-ascii?Q?3ATZTWx/1Fxw7zbm5yygseHTTPY35iV4XtHnkzjQy79vlr7GZtHkpWMSswP/?=
 =?us-ascii?Q?nXaqF42BQEUMkvsoJRhPNlVbW2AqbBb7I5qWWlQj5jAbKf51FhwK7CnF6T2m?=
 =?us-ascii?Q?PLFqN/4C2q4NbVH2qH8RGY2qODLYcI8CluUtEwz3pzrnreDRR9nC8BbhlikD?=
 =?us-ascii?Q?LR0qPu2B6LWZNcM9N1tNUm6c5iYWzDVthfU34KzUn2Esvjlr8egmmDWtSpKM?=
 =?us-ascii?Q?ABrKMY2XIRw+I1HgrquxrLzz5jcge0kvWaT0tX9iSJTr2zeXlriPtd4zwBbi?=
 =?us-ascii?Q?fxbWHTWb2DCQ1b95LMKZG9FmmR8TwaIIno25zEeRigQxoYxCBOwxBWUtWSQO?=
 =?us-ascii?Q?hqJvex8J1a2CbNMQHvsGUlzHu1kpo4u92oKH2ajZ+CEDfFDlKuxfNegb4Kxj?=
 =?us-ascii?Q?9wgHZIDG68RBTJmXZdi2omeXB9S1o/jHyYxqFH135drkh+vnf6tjHCoQvnfX?=
 =?us-ascii?Q?6IddBDo0cPicjDPmDarf6k96/9ngwgXAUYd/x06Blsu2X48WQ5rJuV5Fvina?=
 =?us-ascii?Q?3MTJ4Bl/LhwiQwZeFbnWkpKYmg1DJZ4H3H22Sl5IAqMFS2Dwn66JqvpyhEgx?=
 =?us-ascii?Q?Ay/1xBGYIXay4d5oDhVvNV9hYSnhlCx3X+9BP//6exwNwfWXX/pgcdGP0M6+?=
 =?us-ascii?Q?tYahBtKFrwD0k8qnHC8eXayBltJ8XhzuHI1zgiWX5Cbv0cW8pI2ZccHItNwE?=
 =?us-ascii?Q?p7FBBfqV0fGyCLj2k0cpdvfj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ee22aa-96b5-45a7-eac2-08d941764722
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:37:30.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xIJde2cyZ+allzPcCsu00+lZHceFg17uuk3cyTcwxHNr8DY3vRMqkKIT7Cpf9tYGFOqjjVVbV0Uj0eWzR4bbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Provide the APIs for the hypervisor to manage an SEV-SNP guest. The
commands for SEV-SNP is defined in the SEV-SNP firmware specification.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 24 ++++++++++++
 include/linux/psp-sev.h      | 74 ++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 84c91bab00bd..ad9a0c8111e0 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1017,6 +1017,30 @@ int sev_guest_df_flush(int *error)
 }
 EXPORT_SYMBOL_GPL(sev_guest_df_flush);
 
+int snp_guest_decommission(struct sev_data_snp_decommission *data, int *error)
+{
+	return sev_do_cmd(SEV_CMD_SNP_DECOMMISSION, data, error);
+}
+EXPORT_SYMBOL_GPL(snp_guest_decommission);
+
+int snp_guest_df_flush(int *error)
+{
+	return sev_do_cmd(SEV_CMD_SNP_DF_FLUSH, NULL, error);
+}
+EXPORT_SYMBOL_GPL(snp_guest_df_flush);
+
+int snp_guest_page_reclaim(struct sev_data_snp_page_reclaim *data, int *error)
+{
+	return sev_do_cmd(SEV_CMD_SNP_PAGE_RECLAIM, data, error);
+}
+EXPORT_SYMBOL_GPL(snp_guest_page_reclaim);
+
+int snp_guest_dbg_decrypt(struct sev_data_snp_dbg *data, int *error)
+{
+	return sev_do_cmd(SEV_CMD_SNP_DBG_DECRYPT, data, error);
+}
+EXPORT_SYMBOL_GPL(snp_guest_dbg_decrypt);
+
 static void sev_exit(struct kref *ref)
 {
 	misc_deregister(&misc_dev->misc);
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 1b53e8782250..63ef766cbd7a 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -860,6 +860,65 @@ int sev_guest_df_flush(int *error);
  */
 int sev_guest_decommission(struct sev_data_decommission *data, int *error);
 
+/**
+ * snp_guest_df_flush - perform SNP DF_FLUSH command
+ *
+ * @sev_ret: sev command return code
+ *
+ * Returns:
+ * 0 if the sev successfully processed the command
+ * -%ENODEV    if the sev device is not available
+ * -%ENOTSUPP  if the sev does not support SEV
+ * -%ETIMEDOUT if the sev command timed out
+ * -%EIO       if the sev returned a non-zero return code
+ */
+int snp_guest_df_flush(int *error);
+
+/**
+ * snp_guest_decommission - perform SNP_DECOMMISSION command
+ *
+ * @decommission: sev_data_decommission structure to be processed
+ * @sev_ret: sev command return code
+ *
+ * Returns:
+ * 0 if the sev successfully processed the command
+ * -%ENODEV    if the sev device is not available
+ * -%ENOTSUPP  if the sev does not support SEV
+ * -%ETIMEDOUT if the sev command timed out
+ * -%EIO       if the sev returned a non-zero return code
+ */
+int snp_guest_decommission(struct sev_data_snp_decommission *data, int *error);
+
+/**
+ * snp_guest_page_reclaim - perform SNP_PAGE_RECLAIM command
+ *
+ * @decommission: sev_snp_page_reclaim structure to be processed
+ * @sev_ret: sev command return code
+ *
+ * Returns:
+ * 0 if the sev successfully processed the command
+ * -%ENODEV    if the sev device is not available
+ * -%ENOTSUPP  if the sev does not support SEV
+ * -%ETIMEDOUT if the sev command timed out
+ * -%EIO       if the sev returned a non-zero return code
+ */
+int snp_guest_page_reclaim(struct sev_data_snp_page_reclaim *data, int *error);
+
+/**
+ * snp_guest_dbg_decrypt - perform SEV SNP_DBG_DECRYPT command
+ *
+ * @sev_ret: sev command return code
+ *
+ * Returns:
+ * 0 if the sev successfully processed the command
+ * -%ENODEV    if the sev device is not available
+ * -%ENOTSUPP  if the sev does not support SEV
+ * -%ETIMEDOUT if the sev command timed out
+ * -%EIO       if the sev returned a non-zero return code
+ */
+int snp_guest_dbg_decrypt(struct sev_data_snp_dbg *data, int *error);
+
+
 void *psp_copy_user_blob(u64 uaddr, u32 len);
 
 #else	/* !CONFIG_CRYPTO_DEV_SP_PSP */
@@ -887,6 +946,21 @@ sev_issue_cmd_external_user(struct file *filep, unsigned int id, void *data, int
 
 static inline void *psp_copy_user_blob(u64 __user uaddr, u32 len) { return ERR_PTR(-EINVAL); }
 
+static inline int
+snp_guest_decommission(struct sev_data_snp_decommission *data, int *error) { return -ENODEV; }
+
+static inline int snp_guest_df_flush(int *error) { return -ENODEV; }
+
+static inline int snp_guest_page_reclaim(struct sev_data_snp_page_reclaim *data, int *error)
+{
+	return -ENODEV;
+}
+
+static inline int snp_guest_dbg_decrypt(struct sev_data_snp_dbg *data, int *error)
+{
+	return -ENODEV;
+}
+
 #endif	/* CONFIG_CRYPTO_DEV_SP_PSP */
 
 #endif	/* __PSP_SEV_H__ */
-- 
2.17.1

