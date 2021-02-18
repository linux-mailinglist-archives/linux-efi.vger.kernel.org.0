Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6100531F2F1
	for <lists+linux-efi@lfdr.de>; Fri, 19 Feb 2021 00:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhBRXTj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Feb 2021 18:19:39 -0500
Received: from mail-bn8nam12on2100.outbound.protection.outlook.com ([40.107.237.100]:10081
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230145AbhBRXTI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 18 Feb 2021 18:19:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/bh4R3BSJ5Ix/YiBDRxdqn8mRWJR9azvMBl0biQjkZ9vfeRkk+EhIrxUFofFoDlJmLu3h/Q5lHv7A6GvJ4YLh8j9+whp3MZYPYkLieelfLMJVmA3RN2ODNDMy7iofxsf9KGGoD8NrbbYunWoDtpD0/UgkIcNwYH82alYes0b4GaxfqUD5GK0Cb9h4OUO3HRQUoOtDe22e4BhDxsBdavk2bOMuKyO6Q6trWcQRJrngcdS8i770avZzB1IzkCyQv3t4nTKaypx+wpxx++iiDi2IHst/jpAVEOPLK8pN9lC2rrW8QnRYUMwqPW+C/j/9wryE6PtWJBtTkSH2axVwiGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mlo2yDKTnZXGpH6Rnfo6Np0t3b6NB4ioh4U9dPBlFn0=;
 b=il842BbcbXBnelTJvcvn5tcJKmIbtORuv9L6QGa00ifai49DD7gJN5YJ39cuEhospZcyV8OMa7LHqWPt93B1+G0ucYQraJkxahU1pqr4vNV577A5blSwOO7YiWHo1k+N0mYTUkrV1y9ow17Qp61+UlxHzSQYvm2t9lm8vWMWLx6T0y9+G1XLndinnD25vFh644prPhko00f1Qm9ZGSQhQBWWgxpPGiDeeANFl5Vcn4sXH9pwIn1jl2ViPmjHSoyXUXK0a+S0+OuEa5VLnH567Rwu0mODDwquD4BI2EV7FUqO+rkhpEs1KGeMZb6IxHgMqlk5lkgFmCcWKnwSGM83bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mlo2yDKTnZXGpH6Rnfo6Np0t3b6NB4ioh4U9dPBlFn0=;
 b=SxrM/+xZqXm9wgdBViFwKUoWR5j4OyAv+MdsexRv5/U5AYoJo1LiXXX2yx/FEISK7T5vRolcOmr6Fo6NvPubCNpjd3nT9A4kOFixgV7DhAsPsJUy2Ud0N+iP6ybEHyLGPWdcgsLS23RvqGf+kprXcmvDPFwR7Q/dtiNhO6i/T8c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from (2603:10b6:5:22d::11) by
 DM5PR2101MB0983.namprd21.prod.outlook.com (2603:10b6:4:a8::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.1; Thu, 18 Feb 2021 23:17:33 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%5]) with mapi id 15.20.3890.002; Thu, 18 Feb 2021
 23:17:33 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v8 5/6] arm64: efi: Export screen_info
Date:   Thu, 18 Feb 2021 15:16:33 -0800
Message-Id: <1613690194-102905-6-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
References: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.147.144]
X-ClientProxiedBy: MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27)
 To DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.147.144) by MWHPR10CA0017.namprd10.prod.outlook.com (2603:10b6:301::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 23:17:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: afa23990-412d-4a5f-c6c5-08d8d4635f0e
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0983:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB0983C512E41AB5ACE18E650CD7859@DM5PR2101MB0983.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4WHz1LnvCQ+wSnEektaej/LacbzdX1FwG5EqhKlaZe8TV9BRMlWbvc7/XBg+shZ+m6iAkY5c54zFCObM7qfDFiX16avDIYi2dilNpTHhG0sSCEhR4nVE5bYtgQEcropW9JIQIJsodPQGGS4wqhOpux7SQ05zepUeQFJwCkcj/27ra6NVL+J7rx0+cjEiCNVUU6wyLOe+D/Wm7bpcP8lcYQMX8+9eT4lE/vjj+SNdacOx/xO0queX/D3WFx7E/NmvfeEDJ3bqVSK89VYnQ/0U69sQcDp3R0h0NWQRPJV7a3yBzNSqUuG7928IVU5bh1QzMUiU+89qL+pRDWP9Fa0O8YhNuXZ6U7ecM8hzhQ3JDeHMr+JbFvFWVNHyNnygMINLJSuu88mbw/Y2iA8ueyploJcFpFcfPqE+mbyEqyPsr2rxEP8WSUlZtI5oAtR7hEGvcf5lipV/8vBiWoUwAbhg5mJ9J0TpAEoktKYINcrDdiQyS/9HTlrXQiEE5NyyXHRwryy0A14DodGVp6Tm0onoEVQ/5dCsxkEz9rkJ1GngZxgu7Fp9TgiIOY35wCtar2wS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(5660300002)(6486002)(921005)(107886003)(8676002)(7416002)(82950400001)(2616005)(4326008)(66476007)(478600001)(2906002)(83380400001)(36756003)(186003)(66556008)(6636002)(66946007)(86362001)(10290500003)(956004)(16526019)(26005)(4744005)(82960400001)(8936002)(52116002)(7696005)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pGBbwV5yUYfWgnFMouXx/T3LE0f4rrAjutLNPuwGnqWzeaoyJPq8cJS0X3Rn?=
 =?us-ascii?Q?7pNbGj//7RqAcqQ3V/WuS73jtpV+5dA/Z2PvRBkUib79qbouCdVKfO0JXlGY?=
 =?us-ascii?Q?SAW8uA36XlVEA7gEh9T8Ek1Lg/xgyKbtSuTyRO0Nt0zhJXNG3+R1a8ytZpm7?=
 =?us-ascii?Q?zBeJLq/My912oBQeXXmsf79wbKYm2zi3NlE/BsNZHYjeT2X2giPbkpHASocV?=
 =?us-ascii?Q?WQMtj1UJQn3E0Qzw6L3SnczN27/d40ylvGg4Ol+l4Mt4JMYlc+H1FK8D3Vhw?=
 =?us-ascii?Q?tdfrD3MPKGreG3bvrfO+ZAw/RgK5EKjHvYVtDk0f7SnFhSrI4xq2Gsq1canr?=
 =?us-ascii?Q?1xIhg9VixvaIMKyQY/fFseZxmQlMvyQm/7CRGWBGZ04Q/oQg72e+/4eYJToM?=
 =?us-ascii?Q?yzSCPNCkN74resPRIjJ8FoXDpc3V8IdP4H4tfx8bfOPLaqsx/rA+IpF4pwfV?=
 =?us-ascii?Q?M+qBDP+w5+LYEhQcBogw+t3xVV4mN/Nq7JMir4OEFAUhXDoSoJ1dEIy2fn5D?=
 =?us-ascii?Q?itYCCZ0W5404C1KOTM1tyhkzQR3xd3n8jUlFVNZcXGgdGMZSYo+VOqrikGsk?=
 =?us-ascii?Q?rZNY/Xt13HrqdQNOm4xR7tsPlKL9t5wkGN3eQOX55N5BVqLlhrpigEiHD7mn?=
 =?us-ascii?Q?8pKxtFhFH9Ye1m0FA2hZ/b8yuVqlRsC+9NYOFIlzkFSykmHzre58kon14KQA?=
 =?us-ascii?Q?wFiZSFTNtis/Go7SNFFkuWHbhvv4bjpVqDwf+Y1XGCO7Bx39BL4Q8SRlhIan?=
 =?us-ascii?Q?rqQIBPDQ5mnHFbOLojKwJFLZ8fo7dy0ragGiAuCZ/CIufwp9/BCyeR/Nmmu5?=
 =?us-ascii?Q?RHFwKDt0XFjtKAY27/iLa/41dNA3jQp3mKuKq6hxXGR9G7skrJ7pSAS9MCtH?=
 =?us-ascii?Q?fGc4AWhSRa7k6Ak4b0lmSnbJYgqUWJ/5AQthIrfzYRQBKkQNxVQWJITy36RZ?=
 =?us-ascii?Q?SuQuNe6vXsISv8KuvMXS8Vk8Z8/o1hHjUtHJ/xRiqp7MIUNgLt2clVEMLmXS?=
 =?us-ascii?Q?GsUe2u22WpfMyJUVZFr/rtlgOHZY71VcRXf/iPTeI4KGPfwb75SObf7+ojuP?=
 =?us-ascii?Q?w0wW3YjS90x0FYbWulAp5oCwbCSZolKztM9F9SS11q5R+xcfjiKgBa1ZLefC?=
 =?us-ascii?Q?oCbNmExRLzShpghCbPuMv8liMgvYOhGeU19JM0Ql8mMxDdWPiDe36RVa56n0?=
 =?us-ascii?Q?19nu5pqwmOUBiqPjdTSK3pylShNmpFqH3sJw1WC/mgTdn4w8rtvn8YeoVyDZ?=
 =?us-ascii?Q?e5GFi+kdRFekJ+TR9TnARUA7DxY5ZhlRjk2QghdsqUcoPLB7mg8ugZ2cmosy?=
 =?us-ascii?Q?wpblWYZrqyTN5Z3TICTDntgA?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa23990-412d-4a5f-c6c5-08d8d4635f0e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 23:17:33.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lD139is5Z3zF0SAEYfq/Kp9a0pyXkz1bAZ9eZDxMV1Mt5/4/32lRoN4yzRaDqXfjoRfmYPx3bwCymBnVa9OImA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The Hyper-V frame buffer driver may be built as a module, and
it needs access to screen_info. So export screen_info.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/kernel/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index fa02efb..e1be6c4 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -55,6 +55,7 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
 
 /* we will fill this structure from the stub, so don't put it in .bss */
 struct screen_info screen_info __section(".data");
+EXPORT_SYMBOL(screen_info);
 
 int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 {
-- 
1.8.3.1

