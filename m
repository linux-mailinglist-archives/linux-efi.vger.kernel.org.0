Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F6C7E04AC
	for <lists+linux-efi@lfdr.de>; Fri,  3 Nov 2023 15:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377781AbjKCO3J (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Nov 2023 10:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377761AbjKCO3J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Nov 2023 10:29:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6266DD43;
        Fri,  3 Nov 2023 07:29:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXJLM02PFZqLp8gb4zlK3Ok5aihroKz1euPB+PEymAjMQktRELojtqYXYhbl5Jt4pv5xMq/9zKFjm2lAQ0n26ImAy66G/lq5pzTlqH3wyDuVR9MlY6rR24uUb1cXg3t8YzAWP+7HtciJAJWa2PnDZEU6UCyC8Z4Gm7Rzy9yQwtbp6N0JCUKnG51shWM5ayEJIF8geH1wv25MNb8+P0BqspoHrbiSGObmBtHgorQjiZOX4F5Pn854uYx+YPhE2QNzkRv5ePBknq8GAhRj4d3hALV5R0sw3eb1oPT4hy51GNND/SaEwckeqVjrlM05Y6wDtebbLhg5q1J64y+03DgCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZaZ+wpf7eO/sfOl3udrQpzg2LYAtrdB8e2N4pjMP70=;
 b=RN7mVxOimFFOTNJ4Nq4GCD5VU/+zojBkG28VlpEgrM5ZQKm6RVKXwSjS+7JV/taP0RvIi6WxFN1NfXKn68erMWvYRZKflVZLH8ZVkKq7/o2b9lPafeCOgFG7v7XQGTpzHpAPrFNAkgAToMYGBtyZFl45oA85EU8P9+IIaiHX9gCEzZmBxpIpL1W9onTCNs4wUaZSHr/HbtWpvZbx7mhQ08DhsvXj8pUTqFJeCmczQlluYjcD9S/KG4JR+aVW0Bzde2nyzU0co09iLC+jzEFkBmXbbM7dPP/66RpL/AoNHQl3JS+80MRbvAq9WVI+tKzQEXU7xQDhzTrRCwuUKJyyJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZaZ+wpf7eO/sfOl3udrQpzg2LYAtrdB8e2N4pjMP70=;
 b=s2UDS4omXBBE5AOMwKQ9kc8UWb289T+N8I1pgh0/U/tr8qUi3DNww4tNWzTkasuLRKeYXEGEVCCWYXBwVfXtLg0isFdFzfinx+wKsrkEI+Td2TPkk22i5mVBGEV+5QdROrtdgQ58MymJGZRRnpLYNbjQBEbFFYISFMwas4qDvr8=
Received: from CY5P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::32) by
 PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 14:28:59 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::a7) by CY5P221CA0019.outlook.office365.com
 (2603:10b6:930:b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 14:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 14:28:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 09:28:58 -0500
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
Subject: [PATCH] efi/unaccepted: Fix off-by-one when checking for overlapping ranges
Date:   Fri, 3 Nov 2023 09:26:50 -0500
Message-ID: <20231103142650.108394-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|PH8PR12MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7eac60-6075-4b30-4a2b-08dbdc7937fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cg/+pnqPrz0UArUqlV/Nceny0HdiGC4eAyHCf6RAApgagy/Sm4e63J0+kBRA9n0Y7sADbS1y6L6RUvIbfg1kIvni2h6CFKf3BehlWZv+rjv68ZaiA3HuiaNcRwtEMxXnmrfcn3MmH8QFGh3Jk7kHghLeerUBQ/RovbbrTfxtDwtwRdjANs2nJKM74XTY0YBVFhDuAnkqNRlm1Sh+vxHZmgBH8m4IQXg4BFgta9gVaAgnJJsbYxEUeE1wnWN5X5spw2yiw0fk/dRLpbqbRx2+YtXE8g18MalFTjoQukdk468IWWZOeSPud5A4o4PxjAMoBZggoc6dciXA/Au2vdjhUnGeRKiwfu05vtHhEApWHK93RITf4EBFnc+6NZ4TJbFAlUexf+lby3w1Ll6DlXJ2u0DKPAh8eAuoJCADQAPPNQpkvwp9ClqwO6ucixLx4B8fjpp/UyIWjctjCJo5Pied5T1+L0EaCzglrCoDAPF0WN+MurPeX8crlm87A3M5Uj9cbWw47swfqh539t//Ybde/+7OA0KN4q9MsxaIhC8LqRl/qVSdTd4Rlf59t+30PAAG9A+kkVP4Qg722miYsWlOynUkjnMJM9xxwfDfmkf9rWhC733H32f2KU3luKecJp1VInUg+kv7ejsKDxV1iwO9seXXgTGtONn6ZcdqtEM0i3P95AoINV9VKK5lYGQGzQxTZZWRp23XPO19EYdNKhJURgPbAX8oGdBKo2EKkcvn7WuOuBN8Gxyu8iZfpPVMS0tH
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(336012)(16526019)(6916009)(316002)(70586007)(1076003)(70206006)(40460700003)(54906003)(2616005)(40480700001)(2906002)(426003)(26005)(36756003)(6666004)(478600001)(966005)(36860700001)(86362001)(4326008)(8936002)(8676002)(44832011)(41300700001)(356005)(81166007)(82740400003)(83380400001)(47076005)(5660300002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 14:28:58.9057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7eac60-6075-4b30-4a2b-08dbdc7937fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When a thread needs to accept memory it will scan the accepting_list
to see if any ranges already being processed by other threads overlap
with its range. Due to an off-by-one in the range comparisons, a thread
might falsely determine that an overlapping range is being accepted,
leading to an unnecessary delay before it begins processing the range.

Fix the off-by-one in the range comparison to prevent this and slightly
improve performance.

Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
Link: https://lore.kernel.org/linux-mm/20231101004523.vseyi5bezgfaht5i@amd.com/T/#me2eceb9906fcae5fe958b3fe88e41f920f8335b6
Signed-off-by: Michael Roth <michael.roth@amd.com>
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

