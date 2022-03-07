Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30124D0A11
	for <lists+linux-efi@lfdr.de>; Mon,  7 Mar 2022 22:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245720AbiCGVjs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Mar 2022 16:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343770AbiCGViH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Mar 2022 16:38:07 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B8D6E8E2;
        Mon,  7 Mar 2022 13:36:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elgpLs8NLLTkxSsH9mRrAIABc2zur0zNMcp1XHu1dyG8De6KYYtxcCdTxEDFaSSLvdAz0Rh9SB9gxVcGqCXDZ7x/pSnvAn5wN3ndRPDPLiS5wcRqwqAzbQ+IylUucaJAvR8Y2pvwyDskYhJwTfVf4GsLkQV28w85abL5IsCCTkLrgN1wTeTTzixb/+EpdbLAXa1VET3wbE4teLKPt+vIItKuWSNjvIDNlVBse/re/KsvMOCDkRKag6dN5pUnY/io3wAQK7KuHWtXMSNDmyM1ju2cS41ppQ8NEs3JN1kzzgYJKWZNknY98JvqXfnatmoEUGZYvlrcPQiLHQWG79U/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbvaTYmaqxdr+kYYkpTp/E6MXTk5T4w/SS2QoHRoiF4=;
 b=UWjLPvs+BFqx70Fl406hZGqmaDPAemoB+5KrwBw2qANIGmQqLy+h6iqY/i3ZvsCps9k84Y0BDixPDYuZyMrQAu2AVre2eosn6Ufr1lb8WPkISeM3Vc2z6d6kz/dgbHswKqVAucUhpQpo7C01eauSuwUawlotXLpE3hSKKfcZKM6nbYb7RYbhliMWZ5YVgt3UR1uJXIth1SbahzCVqGFt1zfaHaiMXCr4qdMS5D72ZUPRqW/clEwqVtGkcF102+TZh0TXQBkchW1e+1Pdst53fZqeaeBbsfesEySJoZ3OF0cbdmwEAtSLU8yMGuC61+ufm8Qgu1ni3T2sSaLGyECjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbvaTYmaqxdr+kYYkpTp/E6MXTk5T4w/SS2QoHRoiF4=;
 b=x/GshBK7FI9c3LE5tPol/Mvwm5lhxZczX3uU54gigql2vfWZTSRzsl6czyNSTljs9mB6HqrX3fuvojbpqxj0vPI/cdtvBVxUYChLmfnEbNpX1PNzaZrpBY/BgFhSGROSWKn4xLQ5u/IBtih4Sy61z2gNY9fD60/VY8DD+ybeiUw=
Received: from BN6PR13CA0051.namprd13.prod.outlook.com (2603:10b6:404:11::13)
 by BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 21:35:41 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::9b) by BN6PR13CA0051.outlook.office365.com
 (2603:10b6:404:11::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.3 via Frontend
 Transport; Mon, 7 Mar 2022 21:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 21:35:40 +0000
Received: from sbrijesh-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 15:35:38 -0600
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH v12 46/46] virt: sevguest: Add documentation for SEV-SNP CPUID Enforcement
Date:   Mon, 7 Mar 2022 15:33:56 -0600
Message-ID: <20220307213356.2797205-47-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307213356.2797205-1-brijesh.singh@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bda279a-0d38-41a5-283e-08da00826d46
X-MS-TrafficTypeDiagnostic: BYAPR12MB3479:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3479BB26CA6B2174798DA726E5089@BYAPR12MB3479.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySIjH6rVRwjy2QKEaexQohzdfQOyjpG4L2wi/BPoOw+3NWJsvTmmOW0zTUDwjADKmE+PzP+74LFdhpdzizPdGlTrRMf8vJ+oPQqMctef574iKdBQG4jXFFTJ4tv+2iKOMTfu4ASz03302MA8vzXBNdDtqhLaiZW0q/AA+FOtOS1SBLCgRlgj0I5uyh6D56BbKjtVSv/xngAUFlwkQv7HXZqOAULoY2YSqNwx/j2iWWqSI0Ye6HzhzmZaCfXszS6XzzJSsYWAa8Qo8yK9duscpuUL1inBTY0M/IFLcLSubiELHQMdgaktg15AXGosOoReffxEDNX8alJOAHTkkW0SfRNwIk5/RRsE2G/d2DZJ7KpwkNlc/hP5OdBM90cnpURtDDP5zDArK3H/PB4gO3uVwvBCHXL0tpFgaTFqulBPWgCHgS4immyh8KkbDzLcZN3/OefhZTW079YUn3NKDzJaPGvpOharwac1X2pZVdcQETn6trhevXRjYIoSAV0meeVTLesGfiiKdB91CJs+u2kxxD9DCE6fhu6tMQAKUL9yLuIltl1x2Jk80KvDffftY2y7PNXH2mVvikgNJHn0+kbSilib7d/pBaTpNNV7yk8VRzImgyJnj/kvbLT5v0q4z9GpxSBJ8Y4Dx2g7Mh9m4+X7Dqnt59BrrfTYNO4I6XViCsDN8NIoF0tdSqlNMYiTuNHGbvNu/xxIYRTXxhuZJRS6yF580d0VgVNEyWcr7TS/6GY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(54906003)(110136005)(8676002)(186003)(16526019)(70206006)(70586007)(4326008)(6666004)(7696005)(2906002)(2616005)(36756003)(44832011)(8936002)(5660300002)(7416002)(7406005)(26005)(508600001)(336012)(426003)(356005)(83380400001)(1076003)(81166007)(36860700001)(40460700003)(82310400004)(47076005)(86362001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 21:35:40.4471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bda279a-0d38-41a5-283e-08da00826d46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3479
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

