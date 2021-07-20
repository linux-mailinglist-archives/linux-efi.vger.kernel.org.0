Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287AC3CFCEF
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 17:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbhGTOXd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 10:23:33 -0400
Received: from mail-dm3nam07on2135.outbound.protection.outlook.com ([40.107.95.135]:52672
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231993AbhGTOSm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 10:18:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbgJiCE7HU//XoLTdsPR2cNCetlAIr5CKF2s/LH2beAPKGa8dU0oIAKAIMkehAwFWiokI1QM7JhLWTv6q3LeJO8DoGzp5jQJj9JRVUR6G8qYa2gTWpkiLM7lkRdYW4W2U2vngBMIMsIrkd7WzF/pJGqa4D3bsT382nAu55jd3UEZt8TOQda8m5zD2P1yEaIJYyM/zvKyd2PCAGXp5aHL7GRkEIQeCZDMSMKbRH7WKM176YizTgMe7tPR/UMDDSi4R0lu5aG/qix+4fwERJYWt09+lBNQpwVUh3op7oWyB/YHqwUlHW4VOKPbDjulX4VtB1Jz7OF4aRkSR7n4Lg/l5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSKE7KsZhel89WAklbG+zH0DgO9IbVC7ODkZQ2KYEmI=;
 b=GDXO9P1UKDF22Hu+oIUL4TFxLAvRfSsPEZAPiFMMp+pUE0aqMTRzunNDd8UvnJSBg7MRNIClnR95k6hPiaVyaGslKU8nBP80wp4h0T1w14ygOq9c1qXhv5mJS5iqX0k1DW1g/jp5rQMhw5Qw9lkAHZUV0SXFRgjxGyDmj7pfxKcUwRM63azudjZaRTDMKi/3GORJWIWyh88YURTqK1gpX6fXMG5Iih9wDhYCJDpQQB/DysHMqSWXFJ1O3YMS0vKFHxQwqbyyd/fnwETYOTc1yP4UAZhomtl46VptCzhTShcmd84C++hCIgu1pRLG/27lRd/P+0ggubsuQcPPiBVrKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSKE7KsZhel89WAklbG+zH0DgO9IbVC7ODkZQ2KYEmI=;
 b=Vig4/rQdUXx53t34qmoOt8Mb9pX/d/0jYrBGgbJhJvfcqocp0qIG9IOqY8PXsM2JOZExLcg99U7C9A4q42Bf++tuy7WUsRvfZ6Al7nCTJJV71lg6+R5Y4JRpa8r00edIV8UU58zjhJX/jorj3HSSr4wH/6Be6GQ6R3mGEyJhmLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.4; Tue, 20 Jul
 2021 14:57:26 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::3505:fa47:39d0:6dc5]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::3505:fa47:39d0:6dc5%9]) with mapi id 15.20.4373.005; Tue, 20 Jul 2021
 14:57:26 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v11 4/5] arm64: efi: Export screen_info
Date:   Tue, 20 Jul 2021 07:57:02 -0700
Message-Id: <1626793023-13830-5-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
References: <1626793023-13830-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:300:116::33) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (167.220.2.16) by MWHPR07CA0023.namprd07.prod.outlook.com (2603:10b6:300:116::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 14:57:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b101a304-ee10-450d-0461-08d94b8eb022
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB098123B02F4846F98E4F1ABBD7E29@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o++JZ8PyuVEZo0u2gABep08UbPY1OOqGJ0BslIsBop7VhXRm0YBUrwG/cqCv0aMw6kjAMxEORjp8RWMd/rlZKsiQu3PwDHJIYX8LD1lhx2fTPQdLJF08jeGl7Z9dtvQBzN0PhS2XaE0cSU5WjGYYHhzBFm1K3qeDQgA3/uszweE1n1mieysjuVpwLUTFkwnEWAVO46lLKUSCxaNm+X4wGPxnbGMhRf+r1igQSXdfOwmWtkJWEg0XQYhbod2yumFyyiMNufwrtW/NWP0WWfoWLBLKb5Sx+cUF+ve4MD4hBNpXS1wbE2MQnlfEWVDQcoepmUDOmSecURrxl5ML/3OPsHwyudL0RZw+gAnPaF+79eMIBOtOS9hiTkW2ai5KXs+MyFvh8IqRzr/h0KV5OQmWGRa5sEStmAhCvzfs2tZ+dB5I51U4Rgny0ZDI2o1gMo+70RdhSEjClLK1QjiJNMNwTw8+8JeGhDSHHYeGZ/ptsgv9EPdm1jpCcrltN7kXIGc9I7gV/4MquAjsVWWqqW9fBwoXcq5qgSr6mDC3KbAH5mYs37kvvzYqLG8R1NUukOZy3HTqssK/cwer2qglPR0DTtkIGmXGomPg93j3fThU9JE54jFFta6SRReoe9Vw0+yTzJEOM50+r3essfKeBQEmkm35gidTr7SPEkiLDPF51Z+odNapVIH4x41NWDXBU+A83Y24bPZcV+vr8jtkHTArxT3r7PKqIKn8j399Ot+t8T0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(26005)(6666004)(36756003)(508600001)(956004)(10290500003)(66476007)(5660300002)(38350700002)(4326008)(8676002)(38100700002)(66946007)(2616005)(82950400001)(186003)(52116002)(7696005)(107886003)(6486002)(8936002)(82960400001)(4744005)(316002)(921005)(66556008)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/kFzve2X3W3orUMoFqKTYzQz1TCuc2HIT1RVyT+MZZ/WkN1S3Emu7EniEk5c?=
 =?us-ascii?Q?mOp1hWmxr6YSohZGSmQdLM/2KYPdV5EVYEdtGXSNnX9vrSeGGnghbVm8K7Id?=
 =?us-ascii?Q?f6nvrG+30UnWNPNc7x9EwLbdD0//LRREIWeulli0bY/dYMSo+u9+y41oboyS?=
 =?us-ascii?Q?6xt8kMhwWirHEmLUnMLsJyt0GzeuH5Qz02xaEdsQZ4fYG1DgWzFhjuVIOHcb?=
 =?us-ascii?Q?tNobNECUGayEjtwr0ODKsOC3H15j1V1DwD8p/tTezJPmNn5/jcEgz+A5ddMW?=
 =?us-ascii?Q?t4HGuEfOhCV5ZJHxMDQRXbDqR8KwmRr0N4KeuFsW3bJvE+w1xD5eldCqo4aG?=
 =?us-ascii?Q?rc2+eB5aiOf25nGHSMlaPgLgTC5hVVKjdgupNJdTxIEjPM40nf6zqvaJj099?=
 =?us-ascii?Q?Kpze/0v8im/ZSpCMIDLVCxuEF6CaG8HmFNrTGSd12EA3hIACP7QLSaygEeWZ?=
 =?us-ascii?Q?2p/9/KmcYziwFz8/dMb3IriTIR9Jm0e5Fc4FSgiAJu6YrVBhJ7icQJcUVJrZ?=
 =?us-ascii?Q?BzDkJN/wsF09dqhEZa2PEbqGA9lwCvf1MzRLUew7NcxXuKD/7fr6/Rk1pN2v?=
 =?us-ascii?Q?dzcjI6u1wjtpM2pF0HnOOlqQPem4NOExm3R4NwxNPrU0e7d21sJt2E8PVngT?=
 =?us-ascii?Q?f+28TPj7Nbi9iryYKy/Bw8dwhzX3C05crnBrBcNK+2sGsciQTr3VogKuWaZi?=
 =?us-ascii?Q?RPCqmqcDHDCxJ2eV99Ml0dxHpn4xdKe5M05CcpwYlX+S/InSzO+aKLsAg1DU?=
 =?us-ascii?Q?zrZtvIWcLpwwTJS7h3Ml7NqSMs3jDQmfvG7RqJLPMKbzNulNxhDKV4ehNJ2L?=
 =?us-ascii?Q?afvbuzrObU7t+rFh6Iq+82K64snc3zKDpRP0cI5aD5wLA90u7HRphobTLLKz?=
 =?us-ascii?Q?MhBVEYvluAOWyUrM38ncdDIe4LbSbKzdnnMymu/taNnqhiIpSh2OFl6hX9et?=
 =?us-ascii?Q?o68mN/C9ovB5mtr2llzz7r62W5YWBEaHR25w0AwCNLpY1yJSQf2+WnQvq03Q?=
 =?us-ascii?Q?AHzLx0Hw0W0vxhBAz6l2VJiP3pHUmliePznss6+K2wDzFUhxI4+v6IWuHejG?=
 =?us-ascii?Q?XAKOEFC2jUImMofGXDkd5W3cK/n+NNRdWRQ44jnoDlpgjInehujfc5+UIXUS?=
 =?us-ascii?Q?9HK4puxBM13irctQMO+tSDVtRY9OsNOL4OqGiXdfeOqMIIj7ei2FBwehHQE9?=
 =?us-ascii?Q?MuzcKAuniTUURhEekv7k/cpEFq7W8zB9VndhB1+/KgVFaqUUH1F9X75aVg4M?=
 =?us-ascii?Q?IrMNyBPeVE0j47mMPw3usZDUoXzzKstcBJhJslAntpckyKzxwR+5LXW2QOB8?=
 =?us-ascii?Q?ZrPFalbbkgxmyvmMw/jwqfZN?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b101a304-ee10-450d-0461-08d94b8eb022
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 14:57:26.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9WUHnXrSSIzIWHCmzUgSr7BhRwQejQMsQXHNmYua/NkMqLxMDxlubzaOv0b7POZ+roK1/vQC342+9ERHGZNSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The Hyper-V frame buffer driver may be built as a module, and
it needs access to screen_info. So export screen_info.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
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

