Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9707E4AF9C6
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 19:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbiBISQ3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 13:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239264AbiBISOz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 13:14:55 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5ADC05CBAB;
        Wed,  9 Feb 2022 10:12:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9EgbW5SSmLEF1/C8aiUOm1LPj5MuA2Cax2iZZJk4+hWCwqQxhhY9NlMVRbCAYhouyIeLNCKhNZnmG2V//qO1xuyETixr0UcuSxCgmiaTTseEABdANFd8OOk2X+7zrvqB2X879qHIqHlEyPlgAARjuZLMtpl0Z3MqGjTv5L+IATidt0VOv+isK+bwl2Gtq+CR1/JoHTfhZN8F8SRnZ0qaTBENwMxk6enoFj1aXpUag00c8eW9E5Fstr9gJImwh/6o8x/zWkJ1EZCS9FUr0voNtQ1I2Nropk6/ZzdH2P7PDjbdiImiy+mfHWrNf/UMWFQv+sfMDjJiH9pM8tHSnlz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbvaTYmaqxdr+kYYkpTp/E6MXTk5T4w/SS2QoHRoiF4=;
 b=NkmamtdUJnScedIPU2s7TgD1mMwOUoebjxpb+fG7sqz76EHRxDlc6UyV6jt69wvoKqDzN+Syn6sA/FZAFLO21aGP++fu0WFx6uLoQN2fwCz0msF1Mv4pwGuAkmCmaCrTUOIidoUHX9OymBdmlE186Fb1W3BPyjXWtvTP7mkXuEB49avbcA17zGVWFDwe2TqcACT43N4aetUc1BF4vt2q0UuO3BLbGxrUb6DIlYjkaJzEYbIbnoKfpgBl+nyd50Yvt+D5DfrGZ3dcCIpny0KMseZArcIy5hH+4O/PdyPf6Pi9oi4huY5nnv0Smv7yjRVUM+SodzxE6PQD5qGuO7V73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbvaTYmaqxdr+kYYkpTp/E6MXTk5T4w/SS2QoHRoiF4=;
 b=cv+jMAo147jxjm5YDc9TE89MWa+i7v7uBMON0/rLn/Ph+MQnWCBgKhL8joeGzXGdB7xPTlGQ03bfcPMOtXgoPzZqjb137BryuxxmwyIZzExxt62Pl3MZLPdZjxN3u4ZsPz0zPjVWOe+bByOVODInFEFIBrfoAzm3JBlkhyZzUjI=
Received: from MW4PR04CA0172.namprd04.prod.outlook.com (2603:10b6:303:85::27)
 by DM6PR12MB4700.namprd12.prod.outlook.com (2603:10b6:5:35::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 18:12:47 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::24) by MW4PR04CA0172.outlook.office365.com
 (2603:10b6:303:85::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Wed, 9 Feb 2022 18:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 18:12:46 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 12:12:43 -0600
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v10 45/45] virt: sevguest: Add documentation for SEV-SNP CPUID Enforcement
Date:   Wed, 9 Feb 2022 12:10:39 -0600
Message-ID: <20220209181039.1262882-46-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209181039.1262882-1-brijesh.singh@amd.com>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20b6ceb7-0422-48c1-778c-08d9ebf7c656
X-MS-TrafficTypeDiagnostic: DM6PR12MB4700:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4700378CA0D45606976B38D1E52E9@DM6PR12MB4700.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U19iRl3KFxlM/xElZDquP3rkbT+wiqeYBYPG/4Fmv8OPFkmQRK0606PtFo/hXzFLrIU8wGkOUR1kOsdKyWlvFMy4228N0TwWiSUi/tzeqbj735kPnXBX6J3t46OjBb45HWw49h92hAMhzmz3kuePAD5QfJiZ3PYNlrCHoVDBlgHquRSULAzVjeB41T86o9mzhlgbGFcBFUonHnxUAd1LlYwQ4pB1hQVGXdHy/b7cfR54shm+BFNlzUPa76e9LkPfTRee9m9Zo/+5eI/L4px0Q0kwguuPuqKwLDunZV5tNhb8HUtUxEvn9/tGpvnBkleqOphVE9aUX2tLvvao85RkYTPnFJCYb0f12durCnCX8kn7U00f/ObVGDlPZVoULdXrDaEUeK+Ts/lBZ1eJI8oVaRGq9kWDtBVJNQN9UPA1cxVvjWGrjvdhBAJulDNU9768igaqEip1YinacdGdhnNgow9qtBmPVZxYB4xHCV52qS1iZoRH5/gfROXOCjYE3WPZiKUwawxsTWu0rlhxXjXmzsciGQVO/3g7AfqGb42nxvjumnWH0bd/HcpX8E0qoyG+5J7AIzpq44M9feNCktPQmpc1qsFek+/MnlpzE4FbeZzK9oSunorvqgAKB6ulSPlrpieD7HuL9NK3LJTckHHLK90s022tVQtHN8oRcSERynIoPfdpM5saMw0UAzocAhBJtts1XnQAzk6tgG3OyaWjVNQDrpKpM2TWxNa+Lle1MH8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(47076005)(44832011)(36860700001)(2616005)(336012)(83380400001)(7696005)(26005)(36756003)(186003)(1076003)(54906003)(70206006)(70586007)(8676002)(7416002)(82310400004)(316002)(110136005)(6666004)(7406005)(86362001)(40460700003)(8936002)(426003)(508600001)(16526019)(356005)(4326008)(81166007)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 18:12:46.3672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b6ceb7-0422-48c1-778c-08d9ebf7c656
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4700
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Update the documentation with information regarding SEV-SNP CPUID
Enforcement details and what sort of assurances it provides to guests.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 Documentation/virt/coco/sevguest.rst | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
index 0f352056572d..48d66e10305b 100644
--- a/Documentation/virt/coco/sevguest.rst
+++ b/Documentation/virt/coco/sevguest.rst
@@ -118,6 +118,35 @@ be updated with the expected value.
 
 See GHCB specification for further detail on how to parse the certificate blob.
 
+3. SEV-SNP CPUID Enforcement
+============================
+
+SEV-SNP guests can access a special page that contains a table of CPUID values
+that have been validated by the PSP as part of the SNP_LAUNCH_UPDATE firmware
+command. It provides the following assurances regarding the validity of CPUID
+values:
+
+ - Its address is obtained via bootloader/firmware (via CC blob), and those
+   binaries will be measured as part of the SEV-SNP attestation report.
+ - Its initial state will be encrypted/pvalidated, so attempts to modify
+   it during run-time will result in garbage being written, or #VC exceptions
+   being generated due to changes in validation state if the hypervisor tries
+   to swap the backing page.
+ - Attempts to bypass PSP checks by the hypervisor by using a normal page, or
+   a non-CPUID encrypted page will change the measurement provided by the
+   SEV-SNP attestation report.
+ - The CPUID page contents are *not* measured, but attempts to modify the
+   expected contents of a CPUID page as part of guest initialization will be
+   gated by the PSP CPUID enforcement policy checks performed on the page
+   during SNP_LAUNCH_UPDATE, and noticeable later if the guest owner
+   implements their own checks of the CPUID values.
+
+It is important to note that this last assurance is only useful if the kernel
+has taken care to make use of the SEV-SNP CPUID throughout all stages of boot.
+Otherwise, guest owner attestation provides no assurance that the kernel wasn't
+fed incorrect values at some point during boot.
+
+
 Reference
 ---------
 
-- 
2.25.1

