Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9F47C7A29
	for <lists+linux-efi@lfdr.de>; Fri, 13 Oct 2023 01:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443197AbjJLXDx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Oct 2023 19:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443202AbjJLXDl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Oct 2023 19:03:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B73E107;
        Thu, 12 Oct 2023 16:03:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kftVyhn+hiTYcnTa4rXXIgRH2/o37lkWnSxOfp2vmTTvWO5lOzeDaiqAJAGyKWEmmNqW34poIb7Q2+U98ggxm7alz4meqZgoILC5RwYz3AgbH/7LETLADnVZlI6wctzyDaGPWy+GY6nashFPqy0ErRbFwyYjD4tOaJy1Xhh9UQwRtUqI/ChWrGOpno9RgucAX4X3724X9ypCfCJGdDuCS7a5OXcSqQ8MILfyj/Rb+eyn0jzBRECRehwC9U+9altkZKbuj5Azn2qwSjUrZaYCsA0gdwS+Kcu+r393WU+XaHNRT+h1gHe/Xf7Lti/bUJLMjD0mEuiVYEvgWK0pVQAXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9bg4gxPY8sTxr7lBipM/rfcpj27DWcIWYQvu7aL6t0=;
 b=KiFZaFgLc45/6PXUjDHIGfbGj2+U8pZ5MiNRPEc5fED8O1bUSXp0ssb35/eIfSOSnfed5N1al/SfMkknmTPlibOAoIDMSUcftSwwl3Tebqzhh7siRSArkzBtl53STuBQCLOddL35sSOa+hnZiu7o1RR9oNZLKJWnkwdRZ/iGSRY/X184Ot3eJ3am8nFggl8vbxU5vvtA9QvQJBEn6STpEz/bXoqJSK825JRBWSPWi+OpQMrEOKIw4ad8goVjr5+G+EhAqVrxSEaSs9LjFzwBloHFoczH8N03cqIgcjMIh1gtI8HAtlaA93f7eGUV3DPD/yVmbo1aYQNSM37+IV2pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9bg4gxPY8sTxr7lBipM/rfcpj27DWcIWYQvu7aL6t0=;
 b=jxCbiDDgBfftgAFySJ2PFVAB7OJtPD4MxeG+ysR+SqwNsz+M9IY4JLFTSyevh2UCz6Ks2zyDNg2F1TBTrXZ8Ny8mZXdYFhA7IXbk5fEbmS8ljowkjdRxechDw3oO3cYvvVCYsV954S6mt5NlkpfLaKfKgf0Gy8Vd86HT+nBXXWQ=
Received: from CY5PR15CA0090.namprd15.prod.outlook.com (2603:10b6:930:18::8)
 by CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 23:03:17 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::d4) by CY5PR15CA0090.outlook.office365.com
 (2603:10b6:930:18::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Thu, 12 Oct 2023 23:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 23:03:17 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 18:03:14 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-efi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH 0/3] efi/cper, cxl: Decode CXL Component Events CPER
Date:   Thu, 12 Oct 2023 23:02:58 +0000
Message-ID: <20231012230301.58500-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cd4d30-4834-40de-d44b-08dbcb776bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0pvY+HmM6tVN/2R31QzzaJ0XA0ZgFknzJ54N47RBwy0YqM42qW5yZvbfU85w8WOBzV9X+DYBTK/P/SkR2Hc2Vc3qp/9JNWpIcOvqpjSPBDS/hxWAxyKGV0c0yIddBrWb7g6zQ4RU+C3D1CwC4u7HutGovsuSZvG7rmsQt2fFReK5cx6NQgMhnpyRLqpwTohix63m3y8HY7KaP3oxeBntfRKVB/Etw8WhTXDAPOrUcyTWBP/BzNs3U4XA0Eqf2Uow1EBGS8uS4jHPYLeuzNWTY5AW0lK0myKMHiKYyLWg75YIXNNu/KLv/MEGs62Y8hO7a8XCpEVYXq9UwkeuFd+t498flBx2iK4YkYUxcY9QCEtpRV/dUyIpE3XvDVhaLv+XrYMpmYiB+Y1t2pBOwf1r6YpeKizsyWASF1C5S+TQ4vgYqkngwKgQIZo6TuiTyq6yl1ulNdNBUPyHc80IlJQCoNWJ9gt3W0uKhGt8qlzhwl/8/xm+UrhXF/5CoU9bO/NE8q8LdK2D3tHLxDVH5HJx/MCu55q62WxT9G16Gab/5f5aaQnc9Nx6KAIXZLC0p8MXVmM2aPj61ggW/Be8PQ5ld3fv4o11O+CIsfhkuvFaSQtcElvHn8V4HaVGLJAO/z7y8evktID7eOAuAoy225BpUx/ZlZFHtaNQm4YOCrgA8hxAvckrD0lwM2UwOLd1dIcM2uJjCZEITwTICZWzXLiujq5s1F30MoemYsOwzUXyKHotBp89swXLQBW8yU7kGvXuPMTqo4rHCVtax4RJdajMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(2616005)(26005)(16526019)(70586007)(82740400003)(54906003)(110136005)(70206006)(1076003)(36860700001)(40480700001)(356005)(8936002)(8676002)(4326008)(316002)(36756003)(426003)(336012)(2906002)(4744005)(7696005)(6666004)(86362001)(5660300002)(81166007)(478600001)(47076005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 23:03:17.4258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cd4d30-4834-40de-d44b-08dbcb776bed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series adds decoding for the CXL Component Events Common Platform
Error Record.

The first patch adds decoding support to General Media Event Record.
Second patch decodes DRAM Events.
Third patch decodes Memory Module Event Record.

Smita Koralahalli (3):
  efi/cper, cxl: Decode CXL Component Events General Media Event Record
  efi/cper, cxl: Decode CXL Component Events DRAM Event Record
  efi/cper, cxl: Decode CXL Component Events Memory Module Event Record

 drivers/firmware/efi/cper.c     |  24 +++
 drivers/firmware/efi/cper_cxl.c | 332 ++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper_cxl.h | 122 ++++++++++++
 3 files changed, 478 insertions(+)

-- 
2.17.1

