Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA21B16F01F
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 21:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgBYUeX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 15:34:23 -0500
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com ([40.107.243.54]:36545
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730566AbgBYUeW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Feb 2020 15:34:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1I6FqHRDFY/U4fiPuPfHd55nr4mU9lracwVK8v5ZRpv2x0eyXnPUCqX7MYuquzFMNrweptTpteTZK4bLiRw0QI0jVEel2qE2vzN9b23d5XQZeuTMIwa/szCTYcg5xQ4OahemvOkoiV2AfW+Bd6P0R+MMVC5+i8YAsiGJOZc4mjWsFhBqD8YSmq3KOMo/JmUKsPe9He8ndp3wNU9aYLl5L7xBN092i4c5MKROSBgHTTxmNAnIbVvxrDe5I4ZcWCtKTVkRsiJ7s3TCv7FsMWSfHF5RTyV5NYLg867fu8mUvXHCt5+rS6r63eTuSSzh6we4plMQk3IjIB0hV2Fh76T1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMu1safw3ql9Pth50Jj1XaUPIByC5j4iVT2i/oQTALs=;
 b=ezBOIuH8vsg+SjEj2dfF5CzNYapaD2JXdhLHEVJEtDC3Rq+5MRkk4+GzmD4VHeiWlqP6aJxZvUywcui6PZxWn/f+sEvDe5cJSpFfPbFLApOVhGc3xREGKMnS3bVWu4KAIAZVoYZYRJRN5ynCcYm/4JW0RzRfldZf8+ztZ7iK8YOIIIHss+E5J1Us9v3HAXmF5Mf+sMdZ2O/3af8thrAoWssK37nNPS6KF5bSv+VXQ6+QrD4daa3sSmTR2dOybNKSWFHnvDCora9iEz1/MtMEI8VIt/LO5Ryq6YIVSBg7SsJ2PSQbZsmCIKSyWDzdcs14Y0P0zZojte5VstQtlY9eig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMu1safw3ql9Pth50Jj1XaUPIByC5j4iVT2i/oQTALs=;
 b=WkPlT7KahK4vqlmbHnxaOk58o/St+pO1pIRSb//eQnxX6GQMepiNNCPJJQXq87EN0emHGz0SFFb+YpsrdzUEjNCHCkKz6j/wZK679bqejPnheyEYQWgLvojpIvfHbDwlHbPtXBP7i9MqcXqd1VSICctBDzqSrsLnbIpXATvVmzE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 20:34:20 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 20:34:20 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 0/2] SME EFI table updates/fixes
Date:   Tue, 25 Feb 2020 14:34:00 -0600
Message-Id: <cover.1582662842.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0012.namprd07.prod.outlook.com
 (2603:10b6:803:28::22) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by SN4PR0701CA0012.namprd07.prod.outlook.com (2603:10b6:803:28::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Tue, 25 Feb 2020 20:34:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41a0f8b4-e5ee-4a80-2dbf-08d7ba3216f2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4434:|DM6PR12MB4434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44344A3E71921208069C2897ECED0@DM6PR12MB4434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(189003)(199004)(956004)(6486002)(7416002)(52116002)(7696005)(66556008)(4744005)(316002)(5660300002)(2616005)(6666004)(66946007)(36756003)(86362001)(186003)(81156014)(2906002)(81166006)(4326008)(54906003)(16526019)(66476007)(8936002)(26005)(8676002)(15650500001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4434;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F02os+koM1CoOIlgT9oe3bJ+e11kUWOvoIWy2obCw7l5F+99LmvWgNhn4pY16gWx7W95anPR6jaZcF/1W+oDs8oNM9ephPt0iHNaxED0ZCi1CaOzZJPsN+729VjwFVU55igT45z7vqryJBSeXWNOz8s7TnjbeJMwh+1yrhlLthUGhKn6GlL5PTKlSyr+n4LOIMvRURBlqKnsho/YMdmMinABHGm5JC1ZkjNz6Ic/f4AHfFfkiM8GiqeuGrMCl9EqyEMkpUf8195O0EZ4R3nhWaKPTB/nIf+xPQ6WUpymZxPnlVOnQt/99mruElFZ2gDaFz0cm0dzACyAmnWSa17+OtVL0KWdO27e7Dua/l8KNgoK3O+S6NKDLKmhVmaLLgPy/qWKXi7y+ZdAFtyJKJhBilLPyVMe/4GWrDfldwcN0idO/MtFC6WePouA97Y9hVcW
X-MS-Exchange-AntiSpam-MessageData: 7PP9OGvKfeOHeMmjLYavCF9qkHhNqAzkbddPw5VahA+PjJIdSKjRkdgHhusUzU4YqVqKw/Zn1EyjlhvHlpVuY7Jr0Eh+b2XVPNIESb8gwxZFmTccTlHkXO5hauEP9v78CbSlsVrZoqTM3NIm1h63+w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a0f8b4-e5ee-4a80-2dbf-08d7ba3216f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 20:34:20.3619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZGqHI0a/Y7jdjvqU//nqXs3nvGpwDoaaZtmah5lU2wJuF7rqryRz8EEyJZKQOqTI7fcGdg4Fskt3G3H1K9dxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch series adds new EFI tables to the list of tables that are
to be mapped unencrypted when SME is active

- EFI TPM log and TPM final log tables
- EFI RNG seed table

---

Patches based on
  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next

and commit:
  dc235d62fc60 ("efi: Bump the Linux EFI stub major version number to #1")

Changes since v2:
- Split the patch into TPM related and RNG related patches
- Account for the moving of the RNG seed EFI table from struct efi
  to a static variable

Tom Lendacky (2):
  x86/efi: Add TPM related EFI tables to unencrypted mapping checks
  x86/efi: Add RNG seed EFI table to unencrypted mapping check

 arch/x86/platform/efi/efi.c |  3 +++
 drivers/firmware/efi/efi.c  | 18 ++++++++++--------
 include/linux/efi.h         |  2 ++
 3 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.17.1

