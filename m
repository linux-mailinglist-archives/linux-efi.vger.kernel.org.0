Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A59E7E055F
	for <lists+linux-efi@lfdr.de>; Fri,  3 Nov 2023 16:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjKCPQC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Nov 2023 11:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKCPQB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Nov 2023 11:16:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB14D48;
        Fri,  3 Nov 2023 08:15:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me0NeXvJTgOpzu+Rp6oPk5GLsSh3to1Yoj/r4ajJlxrMsR9GwjuPoiVlqerx1uCHxGKBisJSsA5SlwdRVqGURdDWPIXECCOj5x3y5xDnDk1jf4IN10hTp/EjYCtBpNBPEyNADHjpHewl2AXGiiTRasODC8gTdkyVe+FpJB0mX6aUYam4nVICPT2uLArrbcQ8gJ115K70Hgp6YtB8cC0vYyWzxmB6nxoZ9NNuCUUN3UPQHS3d5sQ2UFJouctHcaxc1/jB+lZSzL4ua0VCxvTg7OzA6jaiJLEnvD5+YsQGmdSPx5NzYY0e8PDNiFyOIniDixsEhloazbSoYMZ+0x339w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI6KHNAQhrYqC2gA5NOfCUoTg8lunEAMJBfDkENyfwo=;
 b=GyXVyKWFGadvLcR7kmjRbe+sxHw9vS5MgURCiuRJj0hsgkzC0MQ3diAjFmOseneKW7C/KHbXr+VkCJLlkiEmcvCEnsvwuy5PT4Czb38p6WZTg+kAGZrjT3ZcyqM5w0JAv4sUqemN4mv9jlRM/BRuX2mFXzlbaoNrQVldl3O7BVjhXSyLS9DvoIfQqJ2jvi1tLbGD1ZJv2/9UtxTlEULCWNB4ImS3It3toFs02BuKSN53kDErOShcj9z4z3YoHd8SvJwIeD7LusSP4Mc7Q1PKWOQN/+RyKX5vJuNvt4qQDHy14WJjk7yE6luZJin/SfsdivCnS5/N8xpiyAjlYaCDug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI6KHNAQhrYqC2gA5NOfCUoTg8lunEAMJBfDkENyfwo=;
 b=Az2TYXnkmU8Gv2RMRD68YZ46E/hti3INo8Z2U3XoSPFKCzqu++rIFGGVL6MrrmIDTIEDUOB/MExom1rM4ASDmmX/BY4xvdOZf6sIN9XsJGIWnZqQvUUjOE37vNhrC1J3SFlDpzU7IClQSn8xQuyyC/7/W6/s8TEep6YrKv0FlTM=
Received: from MW3PR05CA0021.namprd05.prod.outlook.com (2603:10b6:303:2b::26)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 15:15:53 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::32) by MW3PR05CA0021.outlook.office365.com
 (2603:10b6:303:2b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10 via Frontend
 Transport; Fri, 3 Nov 2023 15:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 15:15:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 10:15:51 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     <linux-efi@vger.kernel.org>
CC:     <x86@kernel.org>, <linux-coco@lists.linux.dev>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nikolay Borisov <nik.borisov@suse.com>, <stable@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2] efi/unaccepted: Fix off-by-one when checking for overlapping ranges
Date:   Fri, 3 Nov 2023 10:13:54 -0500
Message-ID: <20231103151354.110636-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: bac74ebb-2f42-430f-7705-08dbdc7fc527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MxYN3tr3BDCRYyTYxlTmV8HHcPeiw2BEZ+OWHINzsIVyTvClfELToyy/7Lwr5oDqLKBkpEPi93n4qzdrev7pDeICq4XoOrBVTF4y9I9x/c/fKYF4yORwpJ5FcP5aVqc10SvPE6aMRHy4TaQeONg6WebiNQgZt9uhtvBqY4j2/3PBmJqwEfpfs/Q6ZNcYXSIoqQgd4PcVJtv5f+kqbk8aPOh1+USECdOjbqgIty6UZpS1OidE4jQP9BClaREtqUseNXIdfT2DphrLmhG9EZRKYPAWUeft+CmdFGwRMNRFJhzQLs9ItFoif4IbcJBEtAkeGPOmJ5FNIe5I+Gt42fkF37xO5RxedYK7T+Q4g/M0wYwOVi28dNCM5PdadiII2NWEVgfFm5Wj1FOP+tDa1hTuZxuXmf9drOnCX3IKEfNcapI9ZCCj4gdcHe5SkmbBWO4QIsTCmeCMIOL1F9x4kjxLCFsE4wgCKDd67UyjRICWc3gsaQsWCJFapmRnya17gyikhZBmbZOrHOVuHN+PLIGITsGnBWfqyb8nfRgKhpG0jqpAwlnvsyxIqjwuLXymqg7dSgBIr+nGsm23jBF0pUk4LRZenqJP9OUcsNecRf/bxs/mL5DqnAV/vyRpjPHySYp7GilPh1UHDMbTn0qKLI5jysb9T/Fmnafe5+OiHI5R7W9zJD5Rk0vTTumJ6BvNFUWyy9dSHcCeHQDGdHNVww9+DkqXwx/tj4E692Kb1vD9qs22V79wru8ym+P5J/BXjT4VEMH9iIdyYefVWwStSkQCgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(1800799009)(82310400011)(64100799003)(186009)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(70206006)(54906003)(70586007)(6916009)(316002)(36756003)(86362001)(82740400003)(356005)(81166007)(36860700001)(83380400001)(426003)(478600001)(336012)(16526019)(26005)(1076003)(2616005)(966005)(2906002)(41300700001)(44832011)(47076005)(5660300002)(4326008)(7416002)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 15:15:52.6118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac74ebb-2f42-430f-7705-08dbdc7fc527
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When a task needs to accept memory it will scan the accepting_list
to see if any ranges already being processed by other tasks overlap
with its range. Due to an off-by-one in the range comparisons, a task
might falsely determine that an overlapping range is being accepted,
leading to an unnecessary delay before it begins processing the range.

Fix the off-by-one in the range comparison to prevent this and slightly
improve performance.

Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
Link: https://lore.kernel.org/linux-mm/20231101004523.vseyi5bezgfaht5i@amd.com/T/#me2eceb9906fcae5fe958b3fe88e41f920f8335b6
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
v2:
 * Improve commit message terminology (Kirill)
---
 drivers/firmware/efi/unaccepted_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index 135278ddaf62..79fb687bb90f 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -100,7 +100,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 	 * overlap on physical address level.
 	 */
 	list_for_each_entry(entry, &accepting_list, list) {
-		if (entry->end < range.start)
+		if (entry->end <= range.start)
 			continue;
 		if (entry->start >= range.end)
 			continue;
-- 
2.25.1

