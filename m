Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720D36DE370
	for <lists+linux-efi@lfdr.de>; Tue, 11 Apr 2023 20:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjDKSE4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Apr 2023 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDKSEj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Apr 2023 14:04:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442B072B5;
        Tue, 11 Apr 2023 11:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xcz1WYnwGD9AeMxuDRrhfkMxIO4Rh4TStJ3t52kY50+eeGXylxartGaDGzYAfdxYLu89yf1XhWOTR78/aXZdMCrVZSDYFUZIFcTsjBFr1m5D5GJR0RybomxPvPIQtoUOxOnmUMTei2V1K8xq7Af4JukOmVCu590dLGB5JCxfiKT5SDV3GtEttBsxazW8o7905bM1uu+K95uu9qtKLxPtGjQK5GNRb40GDysUQitv12HPxtDXWHiaqd8PKnfX9gsILJri9ixSeYhInAnOHV+yMQgcEKKMHYWFa4+Vl6M2pZUJre1nVnmYe1xtACaTbb1ssKxWQqd+xYVZXDVskrORuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suNq20ozk6lHdvyNJXs15e+AcBTMOET/Yr6d+SImQSI=;
 b=FvEAgQjwJgnFr11+bEbDMp5J326PlIfEDk+IiZ18OZWW7QbjnEY7lEWE6k8LOr1eiGw3e2QwqRdJ1+Ro9hZ8c0GuBOxLZRrx5juxMmjGsPF4xgHZ72s0KjZDOPcuVrZv8fzACyFYYMHu1DAgkdIVnZGzePU41/CYIhBGmczERkqTtLLd2t+kHCR6zqCwkIuniC1qHWnTiZeH7vFst2cqkUhsuldh4TTldqPFgybNvmAw7tEgo2z0KoukAO+pQ8wyTWxFjbBrRJSHeJcs9OHzSfCNFBFMcMlLYn3CM/3rEvbkJ0y9+LfpRGz5zQbk1lXT/5TlNmi9/TaO1pGl7moTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suNq20ozk6lHdvyNJXs15e+AcBTMOET/Yr6d+SImQSI=;
 b=avSXcZiZ2KIniYbTChZA0HehMiIc9BPFrAq+ClnVk7DG8+FBh0FVQGGQUOBf6YAuPyEd+U8sefwDzMItFb3amOsYw+mlRsyybtLqVFlQT2j4qS87kGkRdcznpBVlw9IVSx5cz2E1rCdIuy58d2rJ6vZ26VqVW5Uzk3H2y1jI+mw=
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 18:03:40 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::f4) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38 via Frontend
 Transport; Tue, 11 Apr 2023 18:03:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.29 via Frontend Transport; Tue, 11 Apr 2023 18:03:39 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 13:03:37 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>
Subject: [PATCH v3 2/6] efi/cper: Export cper_mem_err_unpack() for use by modules
Date:   Tue, 11 Apr 2023 13:02:58 -0500
Message-ID: <20230411180302.2678736-3-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411180302.2678736-1-terry.bowman@amd.com>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT061:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7447cf-7eaa-4a5c-1e86-08db3ab7147f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcOhJD+8G8sQipuvVxbAecE2ctR+zR8aaiMVVf+4gkW2A74mRgc9IW5c5Z1rF+F7f3NZAlzg8MQoYumz3qK8X0VjnZEG/H7rOsOPpVgLW22MJytrZ6FaqD8/ECgn5qz7KRXV/7DDW398h8BxJX9aStKjlgOIfMtZd37QsXkNM+DxubA74wmrIIZ2bUjxEQb+f1ba4EkFxDWgV3qEBJTvoMdDBn3t/LPUkCeXZ0TrGqaMwUwe2N1NxGXhbWeiS3rB6pGOpNbaAG21ygTZ0P+UwpXLlhnG/uz1Bo16TgdAkFkaj+g44IWXg0A+bp728uKHdDJTEKNb4SmpEauC1sGB1y4CxmGL7/z1rrPh4qLSXh6cXPwCJf3oPyUzwBlN2V/MPS2S22U+fWso4Rp+5PPOAna3ug/Tor93GtKMWTnfmO40DE5h1tdPxoUzg/WABJp+EG2kNSpEb+tgjKcb+tgb5sNMZL3r2OMrS5K8VvLT/oy5ec+zVHYufpUFw0Z1umBd4kEmOwCbH5ps22uSzA5sJ1OnkdX0JzojzQnenavJcJULXYEDUCf/tkGAfOhBcY1O1xXr/k8n7x3XXcpFzwPitkaAD1njvR8y7ik0bfhDfaSt23YekJ9G6UtF6WwF+bGJLr3MuOgFo0sMs7tyDz8C7A+V9QrB+dh+qckD5MSvGle4+Oz4DdvEPHjWSWfoBPbhqDCWazMwzGgGYi+U75pVzzfd41lGEhw8RgRU82oeUQ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(86362001)(41300700001)(110136005)(70586007)(316002)(4326008)(478600001)(7696005)(70206006)(8676002)(54906003)(40480700001)(36860700001)(5660300002)(82310400005)(7416002)(44832011)(2906002)(8936002)(4744005)(81166007)(47076005)(82740400003)(356005)(16526019)(186003)(6666004)(26005)(1076003)(336012)(2616005)(426003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 18:03:39.9889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7447cf-7eaa-4a5c-1e86-08db3ab7147f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The CXL driver plans to use cper_print_aer() for restricted CXL host (RCH)
logging. This is not currently possible if CXL is built as a loadable
module because cper_print_aer() depends on cper_mem_err_unpack() which
is not exported.

Export cper_mem_err_unpack() to enable cper_print_aer() usage in
CXL and other loadable modules.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/cper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 35c37f667781..ff15e12160ae 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -350,6 +350,7 @@ const char *cper_mem_err_unpack(struct trace_seq *p,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cper_mem_err_unpack);
 
 static void cper_print_mem(const char *pfx, const struct cper_sec_mem_err *mem,
 	int len)
-- 
2.34.1

