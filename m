Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBB9256210
	for <lists+linux-efi@lfdr.de>; Fri, 28 Aug 2020 22:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgH1Ud6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Aug 2020 16:33:58 -0400
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:31617
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbgH1Ud4 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Aug 2020 16:33:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTJ7EGU3MBrdduN8Txiv3OXTv4VFXh0YbK0suXyhCvrD0yOKS+AWD/8dWqzZcMbDeAWlNUnt5GJOy8E5Q4VnhqFzvyq9Hz7W4kelwr3VXgEjGHzUMd6anyFPlDri/pEwHE/7Eu14rIbzfPQP1R9QdNlp8BYBitySbVi4dfl7BhR0AmpLWxAC0ZXqj+a6FXIP/+FX/1KUhvv48/GKfBNqlfeAOgguz/Bp58XDoG/vutJTbWVoaaQB5iA3x308e7QT9a3GelC/Z7cJGdA77+jcncvyl577ULPi+Bv39S2tuag5gRVe1Il4EEHVO19VJHAJDnQJQbBJjDbqbdz/o4VHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZwIlSKC9QKpsXkRg8yzuPvbllQOcG3DlSI7iOUMXQ4=;
 b=MZqnnfgmJdJ+/SCax1YCXZXABbtF9ENZN7xCG8UGTaYgpT2pzqhl6bEXuy6iUOo5tiztlSF/DsNcyjMyKXAp58M2sn6fSvfJ6TBba4J233FKkBS34ofWU5f/aY2I8CaxENRB0f0u4OSgaRA/JS0TVNfei8GNgn9WXyTUp7o6Fub24uBIWxS/6ju/rAPdDlwJ99ARzgMHwf5xsQG4WRGA7GgCJYRPSZ76aJsgPvlu88IcNJ04K1Ecs8QRl2iYWiMvoJFK6rGZLZVSvqoLnzvVIdUocPWKsEoeSGqWf3O9SSRnVK/8DKXHn/S1Q3xFlSJJOTqYecAK2VvKDZFASMhNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZwIlSKC9QKpsXkRg8yzuPvbllQOcG3DlSI7iOUMXQ4=;
 b=ixtDeZ2oWGlp0/Hup4BcX7E/58O0JEvanhb6SHZawNeCG033lRPupjNlPjRrXdxJeGzfqfNE6CSeSI/w/IRK/8qY8boyKqel3itjcuqM/pbGEp6OL7GqaPTYydSVE+7QSGCjkfk7X8BftdvuKqapM0LIOrUGs0CBQW04MEXyr8k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 20:33:54 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::48e9:c9c:7cd7:de86]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::48e9:c9c:7cd7:de86%5]) with mapi id 15.20.3326.019; Fri, 28 Aug 2020
 20:33:54 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 0/2] Decode raw MSR values of MCA registers in BERT
Date:   Fri, 28 Aug 2020 15:33:30 -0500
Message-Id: <20200828203332.11129-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0143.namprd05.prod.outlook.com
 (2603:10b6:803:2c::21) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0501CA0143.namprd05.prod.outlook.com (2603:10b6:803:2c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend Transport; Fri, 28 Aug 2020 20:33:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67f18010-e37b-4dd6-e787-08d84b91ae36
X-MS-TrafficTypeDiagnostic: SA0PR12MB4511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4511FE44C5AEBCE95DF68D9890520@SA0PR12MB4511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KMzaLsHqIEaNqOvv8mOBZjDGmRzM3M9JE0XOvV6lVDEYRUrVYKz/qAq0iRapxoVTIAnLA1/uc3614nMtp1A+RUtYqPYcCACKHR1lwakcKBQRU78SKBcd4ClIxixZMJCtSoWl00NsWC/zQfIjlFGH5xFhtvAeweOwQ1G63CLO+fmL8UutF59sZFVSzrFQLMT15/S0fiuL0ShY1TEwz5bvecbPMXoscvUOINjUrMTcToSORZg3Lc5AoYaFM+/S4LCM7+SLUg0LPqs36UavPGCcqZcZGJO9vHdEGGeiTu8cJSN+D751ia77OpRlEPBJgfCyfqhMrT/X1I6PByMzesGozX4qD27Nu0v9uFvJE2c25TTKooGyNrjNqDtfQ9yg8Ds3GiUNAxkshBzLqlmwUugqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(5660300002)(8936002)(8676002)(6486002)(966005)(956004)(6666004)(2616005)(66556008)(1076003)(4326008)(7416002)(66946007)(66476007)(86362001)(83380400001)(26005)(36756003)(2906002)(186003)(52116002)(54906003)(478600001)(316002)(16576012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dw19xaV0lTZ+DaDa5Yx1HfKPXeASmIpSddBYvoDs8S13qoYBEJt9lx4q4R1LF1BRdKrDTpljNrdpGbVTp0xEuURXD+6Pr3ee81wDKM2cdZZnIoGE6WvJPtoZNDgWZQdl4+DTaWZtJgbFX9vVYwpFLK/z08xG481Svq6fetNGmhdttV9pwVmJixRnq2jvUqrdxQxN9Vm7Hezu03rrvScVi6eTWD6fZFFnjO55FCGxoGO20R5e3+y473Y0sa7KfU4kARrPxSwcnGt8C9IuJlZcnFudEVoclhbPrj/llhc/TxzQZSEQYhzYFY7Nx0iwHuKYgNN5oNhJwYagZyms7omeni7hKVhM5UHKMHOzpEoXUAAcACqGNsXInnDiX5ND6T7I5gtivue+O+Qs4kT/j3NCFiMpIMkUizynHXFofD/90Wf2uTCvSXzHFZsxrAwVyvLEA9aJjlBi7bn5TgJTuJdP2eXzmUA0cv6DoURYFLvARdXQhLt3JyA1GxGR6rdy1yitlcJzazrb5nU6otX/fG5QqqR/PB+rim6rBOMTm23TSUlxmibiBWySILhStGm5CsyDR4PwtljEaYuccAmRvJ5u797rjMjAba4g/f8VBb6gSJBJWzzeBOW7DE5j9PUJ341vFRjLk946hsgGglgz6otggw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f18010-e37b-4dd6-e787-08d84b91ae36
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 20:33:53.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LDTR7ke65y8i9RPGqof2VJ3mRDSuhTIRoNGGNWC7QNy0lTZGboZ4M9bKJPX1xhRHvAEPaYohTx0Jr7w+S6BQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series provides better decoding for SMCA specific raw MSR values in
BERT reported using x86 Processor Error Common Platform Error Record
(CPER) format.

Patch 1 extracts the raw MSR values of MCA registers in BERT and passes
it through the MCA handling chain.

Patch 2 provides a fix of missing error logs as observed in Patch 1.

Patch v2 provides a fix for the build error observed in Patch v1.
As reported by kernel test robot, Patch 1 failed stating undefined
reference to arch_apei_report_x86_error() in function cper_print_proc_ia.
The failure is noticed when CONFIG_ACPI_APEI is not compiled into the
kernel. Fix the error by returning error code if CONFIG_ACPI_APEI is not
installed into the kernel.

Links:
https://lkml.kernel.org/r/20200825144710.23584-1-Smita.KoralahalliChannabasappa@amd.com
https://lkml.kernel.org/r/20200825144710.23584-2-Smita.KoralahalliChannabasappa@amd.com
https://lkml.kernel.org/r/20200825144710.23584-3-Smita.KoralahalliChannabasappa@amd.com

Smita Koralahalli (2):
  cper, apei, mce: Pass x86 CPER through the MCA handling chain
  x86/mce/dev-mcelog: Fix updating kflags in AMD systems

 arch/x86/include/asm/mce.h           |  3 +++
 arch/x86/kernel/acpi/apei.c          |  9 +++++++
 arch/x86/kernel/cpu/mce/apei.c       | 37 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/dev-mcelog.c |  4 ++-
 drivers/firmware/efi/cper-x86.c      | 10 +++++---
 include/acpi/apei.h                  |  9 +++++++
 6 files changed, 67 insertions(+), 5 deletions(-)

-- 
2.17.1

