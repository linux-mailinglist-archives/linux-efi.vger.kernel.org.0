Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE094CCDED
	for <lists+linux-efi@lfdr.de>; Fri,  4 Mar 2022 07:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiCDGhb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Mar 2022 01:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238479AbiCDGh3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Mar 2022 01:37:29 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1353D18CC0C;
        Thu,  3 Mar 2022 22:36:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsfpVJ5zMAPPJCp91Ge4/ja4DPffqpIpD2ih+Lx5SYo9X6wbdG3ZT/bTa8HhiH7iwi1yxQpiWVhbfpcJA06vfQzE0xGl3MU+QbUcQpCraXqeSe56Rngzem5u3XMpJKyL/1V5lkFV2d6zQsgRFvJ/BfMvV2vit20SDdXmrp3u/NX7zemuBKBj6EvDEPlw7SyByfCIFeD6+KhSp3DqawWzQ5j2sLu2tUOuXw5EVFtMzQJhgh0iyTjNBaP24c/LkBHTClKPsm9BdfmLz26XY/8ZyTP2n4UHt/tGk8dSQWtBZX3Xn8RIvXJEn943aoDEKcOUxaKkQ8j3Zp5KdpPgSsM+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ucv9KOqezzVtY7dl0ACi2OUlllz3kxbIzfeKXHwz+Q8=;
 b=LfoQTbZ9JaFja/lYy1fHP6neAwULkNhIim916Hc58Xisj0+O4/ZdWupXe/7RtqVlNhDxLBeavD5/0gS6q2kBBZt7g0NxG7zdJo0+hg02hQKAux2Q1sDXJh1SXQp3m4gRdkB+PuHA9cN8qkuPZdOmlEpN6CQbM1KkEtXOIb2/M+ZMAwvgmJEJu2GpeQV6y/ZeyQCZcqzTCJN1YNuu5CsJmMwRxR2a/SHExbEHICokGE0zXC9RYRWaqJnzMHso6Qskkh6M0yHKs5xiVs7DYseoQNMIs1AZ9IJDYlHRQqnG60gucJYYSvBCJjyl0onEEGPNxpDWqTpLK4QkgeGaDy77+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ucv9KOqezzVtY7dl0ACi2OUlllz3kxbIzfeKXHwz+Q8=;
 b=t7bQR5pizRmd1dYRK6s1k4PntfRU4xA5/XahbHevY5+pIKT8+4UL2SSPYqKMzpAvEHxKHLV70mV40yPOP4fNmQiOzWYdS/qAuhIolU4nsALiFuOt/QnvEFb1pZ5rVIAoo6hFOYrsKFm5ApH0NGQu35IR+QY68VknLpDegpQvKu9KxMM3Fumvdgb2KpMa8BGR9obxCbqmXCXsBADrq1xIIj21f0cpPt6vGwvLJv3yfGuBzKKZUisVjJulgeUwkpiNGHs3bnP1XhAwhFTFEIu1DjRfy1kzlSF8yJz3aB1LP0uzslNkk+mwFJ/iw0DCmuoakcw0u+rsgOe1rhpxxXmzug==
Received: from OL1P279CA0028.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:13::15)
 by AM9PR10MB4580.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:271::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 06:36:40 +0000
Received: from HE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:13:cafe::74) by OL1P279CA0028.outlook.office365.com
 (2603:10a6:e10:13::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15 via Frontend
 Transport; Fri, 4 Mar 2022 06:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT043.mail.protection.outlook.com (10.152.0.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Fri, 4 Mar 2022 06:36:39 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Mar 2022 07:36:39 +0100
Received: from [167.87.0.77] (167.87.0.77) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 07:36:38 +0100
Message-ID: <c28d3f86-dd72-27d1-e2c2-40971b8da6bd@siemens.com>
Date:   Fri, 4 Mar 2022 07:36:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] efi: Add missing prototype for efi_capsule_setup_info
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.77]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79410c4a-daf9-413d-4323-08d9fda956d0
X-MS-TrafficTypeDiagnostic: AM9PR10MB4580:EE_
X-Microsoft-Antispam-PRVS: <AM9PR10MB4580A8E1EAB9F67137E2D8BA95059@AM9PR10MB4580.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hAb4s4ML5eNS6eJbEyatIMxAOpBPxG1dMUITZz9BvPQn9uRljsIaidWiScc67zVhCZvZ8DbsK0xUT29Q5oyHEoYa55DvfVXuDjy6yAZeeo478H7T2IadyPH2389NqfG1xKf35c0C9TbbRLeANF8rU4U+OFTkiJRGOc7AVaSRJVRATAzJfMUXDVbSJe3Q733jTjteUjVvtxQh+Tl6t1Wjm+Hpi3uMUMxuhgpJ6GCowXJequ7iUNzuCi8HD5A6YBUEqGZ7RpFcuf0Pqd8XdrOm/hGSzfeZzdESLjUxT3MXz9Vc6FXDrvNHgG0IXnrh3h7sEXQns+YMU+hDGM8FGIcbQark6/ZF3+pyQXl9CEUBtQ5EZSEqdzqAtdhLFWf0PvmttQS7+7GKH2Q6EXvi3hMU0LiJAaEPVtkR0uuG8Wx3i1Dmj3RWIM5o28TdbPPYAz4/JQtfcJImOQTAVxou3rqK0nn+VLftnbHI0yiRKTeWhu6u3BiVjtXuNbl7/ZXqT9olVfZk6DYUr4ed+EA1knEt4j3s/O0HE5Je8BF/TyQ0ZVRvtyM/47UjiFnSnXlVAs+zF1YSWJ4rPibRQvrEzkxU8rgVgxQMHaIb+Mp9D9BhBSRY7Oo0WelCSv9Pu6J7KQS9sjtB4nKf/7y8jyhXYPX8SG8ghwU0aPVcrHHGAFnwNPquL4nlBNq3Hk1I8diPCMFlBVRBsIDZT8GjaocnsOAhToiPjKJnORnZZn/TJa9TGhBtSLF/qY1zgLqSRPe/sYym
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(956004)(336012)(186003)(2616005)(16526019)(31686004)(83380400001)(47076005)(40460700003)(7636003)(356005)(7596003)(26005)(82960400001)(8936002)(508600001)(2906002)(82310400004)(44832011)(5660300002)(70206006)(70586007)(316002)(4326008)(110136005)(36756003)(6706004)(16576012)(8676002)(31696002)(86362001)(4744005)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 06:36:39.6644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79410c4a-daf9-413d-4323-08d9fda956d0
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4580
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Fixes "no previous declaration for 'efi_capsule_setup_info'" warnings 
under W=1.

Fixes: 2959c95d510c ("efi/capsule: Add support for Quark security header")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/linux/efi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index ccd4d3f91c98..cc6d2be2ffd5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -213,6 +213,8 @@ struct capsule_info {
 	size_t			page_bytes_remain;
 };
 
+int efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
+                           size_t hdr_bytes);
 int __efi_capsule_setup_info(struct capsule_info *cap_info);
 
 /*
-- 
2.34.1
