Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97EE316ECD9
	for <lists+linux-efi@lfdr.de>; Tue, 25 Feb 2020 18:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgBYRlY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 12:41:24 -0500
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com ([40.107.237.55]:6057
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728499AbgBYRlY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Feb 2020 12:41:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLPPPmh861BW0P1eq7Mpoy20u6ZY5utk+R5I2Qg5q9PxEgh0W4tr0aRdYueGRN+OI96tYfsNwyy6t6atL68r1rffwjFd+FoRSP7+OzaRvUFKX/wye3uMhz09ShGAr5Wn6X+xQw52V4mE0FGmyjoUSe0NjV0pUvaDixZDxjYs6r0sopra9XIbV0S8HMrnNEIGGrIG25oqNn14wyEzoqOhCOZr16jPzXw6IwTgfq6wcwJ6mKcG1yaID/i5Q4WGzxKCPB11rSr3Jn+qqVnRuJHqrg3p9EIWLMA9ngp6N8lOh8dr50+Es9cyKa65Y76KZ9uNJeZxuBWpXf/eilaFIvb2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjneBDvsnLQdnepiwO96/O7C93f/e0k0WmzetU/zjI0=;
 b=ZP+rFBAdKgGntQx1WBlA0qKYTbNe8W1XwWTBMe47ZcMTffN8ZkOcPugOVZ5BhRv3sHW13CvK/dpyHKJv1cLDtwmq9hFumzFAE6mWXYygDpUsJkecQ4HlBHWvFzBOMVrFR/fLfg2mq5JV2z3jPdiAKHGuX6RuJS/oHxhid+zCm97zYJGv+k+rI+Ki/XxuFkGbGIwSba7/aRn4lfJsTDM9pTuir5XJ9UGMQ3H8NlwpLcBQBsXLHQHLagjrRVLmPfdMxUgpFnnh02sY6UVTeUerDQq14DA9gU0Hav6jx9hYrkM5tyRrAABLH4sZ7767kf4+486elBGB0nG7vVsJABzoAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjneBDvsnLQdnepiwO96/O7C93f/e0k0WmzetU/zjI0=;
 b=zNFribzmJIcNXrYS1nQJgUXykgn/oS1jVsG1In1M0xwQbHA3i7pWcTbKSVclWFQxPWHuEQhAHqkLu9tdmsbPx1LNvvugVQ3N2hyOlegt+TlxkfPMtqncik+t/cZzavCFCyb/Tf6NBdkesAlZB3qtQq5TrhUNDu6dSNpQPoJICUk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB3850.namprd12.prod.outlook.com (2603:10b6:5:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Tue, 25 Feb
 2020 17:41:21 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 17:41:21 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2] x86/efi: Add additional efi tables for unencrypted mapping checks
Date:   Tue, 25 Feb 2020 11:41:06 -0600
Message-Id: <261ea8108c6290e95962be2638bd204f90787c1c.1582652466.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: DM6PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:5:15b::29) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by DM6PR18CA0016.namprd18.prod.outlook.com (2603:10b6:5:15b::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 17:41:19 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84b99741-3dd3-4b43-afde-08d7ba19ece1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3850:|DM6PR12MB3850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3850CC62E9EC8C7D1CB338DEECED0@DM6PR12MB3850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(189003)(199004)(5660300002)(66946007)(16526019)(26005)(6666004)(478600001)(66476007)(186003)(7696005)(4326008)(86362001)(52116002)(66556008)(8936002)(6486002)(81156014)(2906002)(316002)(54906003)(4744005)(36756003)(7416002)(81166006)(956004)(2616005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3850;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIfylyXYPOjLVk9TKhCuB7MU4iMCYFTa2N8zUEfq+iWaqnPmzUDwmxO4CttiFahuO7uUF9bJfY+x/KwBenkyPVkJDIyB5HqenjelBVOel6Ia558XYCaIYUMaY3xoJlVjPHmJN32ALCcv1qpU16rBGYJOHm8U128iN3PTVUjVC060zjTotZp9DmCtLR+0QFBXUajpV6J8aL3zscKfmBI1do7gDyplFtBl4RwZShj8xDkKy+BwapRuXXXQm7SX0y+v5liao5sRhcvLN36sru6Ys7CKTPzQ+BIfkB/7LSDy95zWqCXV5hMRgnBlhZSE0jbUCYduzJrG2CZxQxKPOvBLQ1nbhK70HwAIXnqH8A3JfiV0vZJj+5EzEwHUKqaHQNllcQPX09+byZJWg+FGuyYSgEt69YKbw1NKYqrBQn9F/VPBa8zt3h87tGc3P1Lc19YW
X-MS-Exchange-AntiSpam-MessageData: rw6nUIPllrqBbo34HT3ysGeYbBAs2Sn3k7Jo6Zg4rjr9/j/PuSDxJuB7b4M3leuwkwqnEegQT1OZF5ZupPrJjUrFTAY7LotLdQQmk3xfjwltP9XnGm0M8sfR9gj5XWGZeFSHkaTWwTGiHLfMVWVp0Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b99741-3dd3-4b43-afde-08d7ba19ece1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 17:41:20.9905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvOBjVeFcyzO1z8gAjqFtEuq2kj3WBMeKbEgpyaKM15jrXg3TyVpOWUHSOJwYaR1a+rzSU48M4UGgKzuJY+UmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3850
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
Changes since v1:
- Re-spun against EFI tree
---
 arch/x86/platform/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 43b24e149312..c6ca959e2366 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -88,6 +88,9 @@ static const unsigned long * const efi_tables[] = {
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

