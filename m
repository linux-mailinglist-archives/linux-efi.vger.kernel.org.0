Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A4516EA36
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 16:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgBYPeo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 10:34:44 -0500
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:6174
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbgBYPeo (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Feb 2020 10:34:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qc6qpHnuG8h0kshdpAoGdD69tFSolBqvZzDXb1f6AGlEyB+iu+SuwTcmhJO1hE1+tXgMa3AKgXkz+Bm4o1J0aGaK6wjGTgK7I4gxjcsp8y5mfEHiKURBc9SyG9A6zrQODzIp885QHwtiJNaSGk+LGqf54d47v8vfwHtOGC+rfOPlrn7yUZdlNpFCvYrgTYBEMqsC1XmqTxZd/lr47rPheYe8+MNn9OPXGyIcW4NbUFFoWh/Sc09H2LaapqT0J8ls2QJ8QbPyD+8iReO4FDe0ylqEDneQ3JfQDV6/ypxfuT8AKAXkDR2rn5QcZbif9FYsHsz1xJAp5FPUITTP+fEHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYdIxPP0DvGcdDqF9+6+0QSGc0TSSLAWAFJy/JODWE0=;
 b=DRMmxxxe8OMzCnq052/YmaiWXAXVentMPSAi72/zbcqYaazc3oshuTKg3EPoZbfGyqAQoseeGE8I7PkzGtGOdbqvsoMTw8DwrMsEknwb+5vyiz9gBZhJPNDTfFzo9EvhS3FtysU5sa7fobFo40f1+MlCJpfRJSVz4cmDoomUzJtz4giuK6oajKtv2BbBVaIHZQGw6D62jR2hDykHxT6EoM1PFxUITQtrgCPZ+t51in92DwA/6tOqo6oJcKghWAf4KFOSI8Rmg5oxG1tJ+obfarOMQRdycvs6OROLE/zLv2VbfLCKzr7IQqMHvsEt3GzAVawKOyws9waPGfEMcEpP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYdIxPP0DvGcdDqF9+6+0QSGc0TSSLAWAFJy/JODWE0=;
 b=CVaSt1m/TWbOpqZDqFPOAOCNg0U/XQdTwHBcIYGhtSB6/Lmc3YjlFb1maFEC5sXqIM9FrJFI9inaRChfAud+GKmXKFFsuzy3GQ5kRcwAn3fAoviVqG2vz+ixe08RmYZpZchhZsdbVgAbQOUFRjWWWrFDlnXOOA2RjDSHomk9zh0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 15:34:39 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 15:34:39 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/efi: Add additional efi tables for unencrypted mapping checks
Date:   Tue, 25 Feb 2020 09:34:26 -0600
Message-Id: <9b52495a2d8adfc8f2d731a0236c945196143ef4.1582644865.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: DM5PR15CA0067.namprd15.prod.outlook.com
 (2603:10b6:3:ae::29) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by DM5PR15CA0067.namprd15.prod.outlook.com (2603:10b6:3:ae::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Tue, 25 Feb 2020 15:34:38 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fd4f116-39a6-484b-383c-08d7ba0839e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:|DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2985ACFA8AF05639BC838EB2ECED0@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(189003)(199004)(478600001)(52116002)(6666004)(7696005)(81156014)(4744005)(86362001)(956004)(5660300002)(2906002)(66946007)(36756003)(4326008)(66556008)(66476007)(8936002)(2616005)(81166006)(8676002)(54906003)(316002)(186003)(16526019)(26005)(6486002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2985;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvoo9rdy+5XGUXajHOFE79rLdSgayMiacxgcwyFIHiXOQEErztIv6p2m8Q3jKuN7N8plZtoDE8cWuGTq/WGBBSNhqEXYVjIeBK4bJNLbBkUe7mz48g4PLUyKQ+igydngBF5t/dXxXX3ML7u98y8fRtKXkHKRO2J90l/LKXMegpjzMs2blz3gP1YoioZb5UhjBBP9NEIvThGbUX2efxLCNLjbHoHJrFQKjBGENl/W+QYu0PjwFWOsR91eMOHqnZWiaVyIugJ3NlxnaE+Jn63arhx9MGm86p0SaeGuffDDMyupCQvjOoCWMThjC3OoiBLoMTpx9xku5unnJ2Xb4L9eDD5itLaN0rzwV4vfwN+b2cJCuDekeQG9TIQYF/Lwulgc3Bc7kBENRt98Oz3aveSBgrc87FyvZW5doHIEt5XnXBdSpy8l+RbDCtapnpAXBOzX
X-MS-Exchange-AntiSpam-MessageData: ZBaznb/uxiP/2nQXMG2v1HDb8/obbQcm88Abqpn7FFSRMexE3/H3IGnAZzKvoj+esSbA6x6EQ8zLm4ciHdwEWeg7aelSjjh+udLoTb4EUFWNPCNLxdj15M/KEZFj3FEIEn+TwLOg0PQ7IHvyPMgwBA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd4f116-39a6-484b-383c-08d7ba0839e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 15:34:39.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOpTR+GSle+SrgpRGIS4plRcz3jhm6B/skxa8HNX1z6HM6mcpF1RD4cMefZ0e3GeWCPkwRKCGmkHEvTN96W50Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When booting with SME active, EFI tables must be mapped unencrypted since
they were built by UEFI in unencrypted memory. Update the list of tables
to be checked during early_memremap() processing to account for new EFI
tables.

This fixes a bug where an EFI TPM log table has been created by UEFI, but
it lives in memory that has been marked as usable rather than reserved.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/platform/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index ae923ee8e2b4..eba5038c7a44 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -85,6 +85,9 @@ static const unsigned long * const efi_tables[] = {
 #ifdef CONFIG_EFI_RCI2_TABLE
 	&rci2_table_phys,
 #endif
+	&efi.rng_seed,
+	&efi.tpm_log,
+	&efi.tpm_final_log,
 };
 
 u64 efi_setup;		/* efi setup_data physical address */
-- 
2.17.1

