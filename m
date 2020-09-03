Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857E22669A3
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 22:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgIKUm3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 16:42:29 -0400
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:55307
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725803AbgIKUm0 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Sep 2020 16:42:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSr4/TylPJFgzOEQaVXZ90VUROc9x1oTx26vfb7PPgfujcVKLQTyL1cIO8rPMt2rDpy8sg1AvOY8rLssEwDXq1Lm6ESjBNVJjeYfl6cwaSNAf65DbhVqTKjv6x30A3doo4+QjlaJKmBJJ1//58ClivjAwxcSqRCms6rWzydHdXYhpDQqVtiuykTQ4ALMYQ8lal8GPMMD2K57fr2R0D4mkUfG8QrecbOUA+E6OdLXzLP3Cjcy6ShngQFonecjZIIPi7Ac2NgvmKyXyHo4CCgERVEmKKLDaoEvNicoqJcFxB4FlYs8iIbBynw14trh4VumRvDz9hbptDNb6XCvhnAR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H00Rpey9QIPRYn9fH6Pb6RC1DoDovFW8HVqA7jqXc9g=;
 b=HRJxVf+AF89zTpRrBsv+I1uMXVWExcpckT5bE7baQTIVGo4xW06KcX9sjVQBIGNY/gqdDegMTg/pYdDpX3c5b2qHkYdsM3BrerXbDGTtd1XQbAG6ddIXqqa8j7fHs+2WT/SI8S/d8V+k1vgG0woni6UJ3wWUZEZtnktGyR2Lzh7K6hoFSaxPsESB+EbapZIulLUsDkKMyQJiwn//WM2wAofgkc3THwxM+uW4/w+t/xP6U/UvUYz4etljYCbwSz/tOay0DUzi2YSIZZfpzLNZtGLLFa0hYIEs0W1iJHx7dVbQvkF4Z1MMk7TOvyG0BZM2Bu64mCr7bkhenPGhyYmPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H00Rpey9QIPRYn9fH6Pb6RC1DoDovFW8HVqA7jqXc9g=;
 b=fVeP8tBh32nIPocC1BtZQNSYz1OyHVhvNtuiFSj8wAi3YlJd3wkTymm/IlG13r2sXrgwsjLZmCaLoRDaq7H+CxE+iXK3k89oTRIw6hw+2+e367xzPMK7K2H4301+dUGuoMinMat9EMDkxrNlThjjqBzzA/YDP/fn0lNuAuvmV7s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 20:42:24 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409%5]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 20:42:24 +0000
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
Subject: [PATCH v3 0/2] Decode raw MSR values of MCA registers in BERT
Date:   Thu,  3 Sep 2020 18:45:29 -0500
Message-Id: <20200903234531.162484-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) To
 SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx024ehost.amd.com (165.204.78.2) by DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 20:42:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2dbe8b40-a576-4aca-902f-08d856932fea
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4431185ED8B64D1036C6495990240@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0t1lxQ072Aq65tslWYgeaeaaoLIktUu1IttfH5LfogJLbqUYQAqndOcdYsUZY3DtmkPEamHd9ctjuchckIhGE49EgEJvFCdi/8iOlAR5Og15ZEUjpDPW9EO8e7lNyHz4LYlCcCbk6q+wri7j3Sv5Yp90ZqFCM6/AhCbOHN3X2tTc9z4nK1TStM1ACGV9KBRPnmhu7tELGuPu/u6ghrLdn/b+69ACRvToxlrZ/qhnRx93bPZjt+jU3qWq9wXZL9pL7rKFz+AVmSaFPats2az/0a9wfTWsZ13nBmRY44EEenQFPAJe/CWrbSnfO1KK1YgUdy1yCbtjF6MDWERaNt2BgmrXgjGV/b7AX2W09cArAeKZtKiiWqlfhHo++cBC/v+I3qUBJrEIkW6/jxDT/sV0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(8936002)(316002)(2616005)(8676002)(5660300002)(956004)(54906003)(83380400001)(66946007)(1076003)(66476007)(52116002)(66556008)(36756003)(7696005)(7416002)(6486002)(966005)(16526019)(4326008)(2906002)(26005)(86362001)(478600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: N/5uXQHotiVEf/g7hCu42pwRYAiIK3ozGSMAzAVSqKUWA51egrLdTT6kLLad5bKbYQzm2UBREfetjEaQHvqYmts+YLT4RVAXTwTbD3+f468Gd2JTsuBbYCJKuM8rEdo0vznwUzSCyVCDv+v9GY/lms2v4viVjoddeO0Tq0f5XQOnod1la+4wbEp2FG0ZNcnEkTyiahnQNJ6fg5MM1MdTtxM7rPE2X6PD3c8TTUOSgbQPkG4QwwEIHpZE5mVWlAjdB75pOq1SmKkzkFXr5JjOuj/xEf9Ez/7o3DnwT4fU1oj8bnV9Xnr2/RTaRlEip+Sgo50PXdzGLpeRkyf+JNrbDdXzwJ1mzVhNDU6DV2G15B1LG8ddutS2lD4pj/oyp7avIL6jP8k2n6TJM0M5ELIImw/POg7NsYi8FgFXdySgREotihq5bFYuKo74TqhOefBqS2DrnpNgt6cLAtTHSonNjBATcX2cUngmSu0i56APaLUJWs7c0MVvk1woTW63ro+k41O82dRmuVX3zRexgk5oLrOYbjSnDOfLT6bbCNtKT+16L/zvnBJdpI3a2Q0jxfhaGToWnyUyXgWc5qn4nbjyjrQ4Cut+P/gCQU8MN97T4HU1JbTXJCoGDmUvmi8XnyQJaFDsoE+bA4pdAMaDgeIbDw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbe8b40-a576-4aca-902f-08d856932fea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 20:42:23.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNcAJVH0yu9lFixFurS1GcrXmeI8TVhLTYPXBWCb5A6o4TPdI+KVgF5quRBtkaAPHavEDAQDd8C5iJayqDWHaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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

Patch v3 separates arch specific declarations and moves them into their
respective arch specific header files. Also, adds additional checks for
context type and register layout.

Link:
https://lkml.kernel.org/r/20200828203332.11129-1-Smita.KoralahalliChannabasappa@amd.com

Smita Koralahalli (2):
  cper, apei, mce: Pass x86 CPER through the MCA handling chain
  x86/mce/dev-mcelog: Fix updating kflags in AMD systems

 arch/x86/include/asm/acpi.h          | 11 ++++++++
 arch/x86/include/asm/mce.h           |  3 ++
 arch/x86/kernel/acpi/apei.c          |  9 ++++++
 arch/x86/kernel/cpu/mce/apei.c       | 42 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/dev-mcelog.c |  4 ++-
 drivers/firmware/efi/cper-x86.c      | 10 +++++--
 6 files changed, 75 insertions(+), 4 deletions(-)

-- 
2.17.1

