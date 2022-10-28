Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D0C611B65
	for <lists+linux-efi@lfdr.de>; Fri, 28 Oct 2022 22:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJ1UKh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Oct 2022 16:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJ1UKe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Oct 2022 16:10:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A590E2CE2A;
        Fri, 28 Oct 2022 13:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6CI7kV+JcA9Sly+ZKI5xdl2xlAYaCobSBZIINtlt6nDxwA4fT+X0D4omJQPTvVrMl/ooaVMJA162HT3wu+Wi3hDZC5oIQ8udCoKXZ4m3TjQLLqPkzqCRdvF45XJILD+BJZNkaw097PSjMjFh6GjnETfLtv3CUAOqcyMKW1QY6TvPutErqsTB/6+yt0BFFtVy66bGHh3YB9Ctek9bN5MxAiMnYc+a0yTX0UPaZGgrIe/4yFiGaP8C+jmR9FMO7Ref/HoeFkPCVmpTAnFPIyzr5QgYRak5gNA5UUbA6DKU4XvHow47r6hC07X3jOMgehlw+VtMiWhg4fQrm67vjz8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MygrOwVMvfC6rz/QahgIOS76j6h797FQHiN0qT9IhZU=;
 b=hV3GP88LIWjT08PhDi++cbTcHFn8U2d0WKpCi9jXYbb5qmrbCwW4Uw4g0YcR3FRsqLgkV9vmS5BBX+kh3kT8GTecrQ4lGKoYuSknol25BKSDgk98C5mRzZ6G7bhUxGECJfbACharxCtz9DJdNw2oP/adFKsrdL826QNXGfz01jxGWhNJtGvKwDDhgsU1+jAscL4oSnI7Yois6kyFo3dU0sBWVBz597Ot1wDvwozHH6CxEuEJHDI8ijFoZfvjJS1PI6+OUY2BGu0JttiKWHLddA22NtLbBjssrgi7GL3zmZqpkUA2dhxR6LRyi8Cu+7aWewTv6bsaYz6xJautSxPYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MygrOwVMvfC6rz/QahgIOS76j6h797FQHiN0qT9IhZU=;
 b=qQOKTw4jNlpfHKBcV1xq8I5gNve3F16lYdDUUBRbobp4MKR9/TgU4KIjKdVIgjIb8fvVkheqrvwonSbh+ld4iv5RvKK/q/sXElC9CHQ8kpJBi7+jpjhQVc0JE+dssFKh5XGvS0NWUO2cs0HqdlUk8Ks0tAH7MXl9rL4Zm84vfLk=
Received: from BN1PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:e0::13)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 28 Oct
 2022 20:10:08 +0000
Received: from BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::2e) by BN1PR10CA0008.outlook.office365.com
 (2603:10b6:408:e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 20:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT084.mail.protection.outlook.com (10.13.176.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 20:10:08 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 15:10:07 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-efi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 0/2] efi/cper, cxl: Decode CXL Protocol Errors CPER
Date:   Fri, 28 Oct 2022 20:09:48 +0000
Message-ID: <20221028200950.67505-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT084:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbd2b37-36f0-4b01-abe1-08dab9206970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bkpg3zxGVmkoUbY+GLZkPrZwYf9zBSWeKHx++yYhYV+H0hLJdBrH/sM0J1vhujxVEkBUKIcrxRTdD2rcEZJzsvMnPiy3PEyWSCj5qiBYVGHl9W2ub9XRwicqObcNY6WhQ9ygpUcLIFT/RS5Wjb0BoQ/ktf3k/C2Xdfip//L+PPMILwJTlYgRiy4RuZeDdoKe/Xi9smM83sGE01lcJbaB9dufZxodAPg/u/T+zlWL2cw8/TfEYelqwxeyKyn0BKmiXV2WJnf+LiQG+8LEPpJKitNhLsCryLI1FmG+GwZ2BR9+8noC6KeHoTrLyxtTFrXvZXkx4rm9rw/Ppz7h9vCV3TyZpCi8q/6r9OzXU5DoO68IP0kYXfa0O9bt66ZPLL9prDsKHJ8Vb25WJ1YVjy4mrfra2uwqOVVOICQEPPVKXW/ls2I+xVX+k7qsESEuDO+/KUXAbKJ2PdE5mtQsnoAVJULnjUc0Q88LDmgQ9z0k4CuoP0EHQ3xZ1Mo6jH+zbnsyh/pGaY+9TWhtOxU+RwfHsJQPJhQjU9CCiu5pMkOYWn6XLVZ9zRgPypH7UfgIjL0R21KfHze1aWhcLL/mVWpi2t2SSaW8W24XMXDiHpVbzwKwpp63+ic7e8DhlXRJo7qlCyEZAR+RYqsA9/Y6Amji25zq9mRKsy2v2rJDZC7YCMLZdRsUpy3bBlI08/3qg+kgHNuPlmNJ2V1tTqatVi13UZG4pAcZHyOBHj112YvOiGcgGnYWPDmFWT8UvLQbOSeDTP3tpE2GdXpU11b5BZdy9jEAaczy8QO8g8a7aoDf8fvGOYHPCogSTMAdqk6B60cJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(40470700004)(46966006)(36840700001)(70206006)(4326008)(8676002)(40460700003)(7696005)(110136005)(54906003)(36756003)(70586007)(316002)(6666004)(83380400001)(82740400003)(81166007)(356005)(36860700001)(8936002)(5660300002)(40480700001)(26005)(41300700001)(86362001)(2616005)(2906002)(426003)(336012)(82310400005)(7416002)(4744005)(47076005)(16526019)(186003)(1076003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 20:10:08.4961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbd2b37-36f0-4b01-abe1-08dab9206970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series adds decoding for the CXL Protocol Errors Common Platform
Error Record.

Smita Koralahalli (2):
  efi/cper, cxl: Decode CXL Protocol Error Section
  efi/cper, cxl: Decode CXL Error Log

 drivers/firmware/efi/Makefile   |   2 +-
 drivers/firmware/efi/cper.c     |   9 ++
 drivers/firmware/efi/cper_cxl.c | 179 ++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h |  66 ++++++++++++
 include/linux/cxl_err.h         |  22 ++++
 5 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/cper_cxl.c
 create mode 100644 drivers/firmware/efi/cper_cxl.h
 create mode 100644 include/linux/cxl_err.h

-- 
2.17.1

