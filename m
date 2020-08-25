Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5232251B26
	for <lists+linux-efi@lfdr.de>; Tue, 25 Aug 2020 16:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgHYOrw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Aug 2020 10:47:52 -0400
Received: from mail-mw2nam10on2068.outbound.protection.outlook.com ([40.107.94.68]:41440
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726633AbgHYOrs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Aug 2020 10:47:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErA8CfaGhsDXmbSxmZ2R4+wImXl185Xy0muxrhbZ2eq8ENPp8yJ9HI59eeXmcU0pbfVtAN53HfvyF1KIaw5TO7azNXLeZD1bfgjsxK3v7AYAGvhBeNbNWS9DWVngPwjozM6IaQZUzercX++wJG+B9eb3652Wz3MCx6rSmZ4D7B01EAxV2Ye6egesjEpD0HSZVze8gWtWyz6hiLe7nGKB3pYZpUpLajXRrWBxUXDnA6ZJokgneHj9kSq/WiMFUbCZ985YS8tylJ+edbuQnkfWm2fyxv3Dp6FVKttiYBxlV9ycMmH6rBWOAJkQ9CFjqotHnVN26nVlHgkENe6/O7s/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvKJMY36SVfX1e+Zj1DiTkT3fLYrUBMN119zIddnrsY=;
 b=SX82AGLLNdlsaZhjiZWZGkCqk1MZoARWW0xxrN/UpuygNM2H4ObPEBzUOGQKO3Jvd5H7YyHkZeoln2gimtAsYUtbqO+Tr9hzAdRAzXaKQ86d+3eeM8but/D8xDh9kDEhlSZ9KgmTlfagEgniVL7TZTwDLP4xFOLi0eaS9ZPnhKtKxj7zFaFFVaJ7r70CJcF6b98DAhCdUhBYzValixUtRJmkX6cS98BFMUKMRuPZ/nzaEjBB5I9JhurEQ2LRcMivjLvKJTQXb7AoZ6+1rec1xrlmM2f445uYZBsaGDEr0bEhI1X5dpB2ISqhMbnQUw3U/mG9A/qCrL/TvBJpD74o/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvKJMY36SVfX1e+Zj1DiTkT3fLYrUBMN119zIddnrsY=;
 b=iJxeFHAQ4XkhD2aMyd+YTIB3sQWX9YrCwnPG6sv/l0neRAp7wkiBa35hB+zmUcQghD3BdN9oxe6jOygrvJqe5Wf1O2r1NQBDzpCyL1UsY/tA2vB6p53Yeg/1DOq2H0UHGALofTD8fESLPTQUrAMT2NTxc+KrS6HpNWDuDd7h1mM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 14:47:44 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::48e9:c9c:7cd7:de86]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::48e9:c9c:7cd7:de86%5]) with mapi id 15.20.3305.025; Tue, 25 Aug 2020
 14:47:44 +0000
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
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH 2/2] x86/mce/dev-mcelog: Fix updating kflags in AMD systems
Date:   Tue, 25 Aug 2020 09:47:10 -0500
Message-Id: <20200825144710.23584-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825144710.23584-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20200825144710.23584-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:806:d2::15) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SA0PR11CA0070.namprd11.prod.outlook.com (2603:10b6:806:d2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Tue, 25 Aug 2020 14:47:44 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea2afc48-2ab6-4a41-f91f-08d84905d379
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB276729DB82F13B63A8038F6E90570@SN6PR12MB2767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tebwr3FM2GBHEbTNDxf7qw2fWEHHdKshitV0HGScGkPKw0Qx6pSI72gf1b7i7nxSsGIDieV2uHV/U2zp6lIbeQEdP8BiPIWzF2K8Id8bT87nYU36BBor0fk+sC7HkBrSt/xoBYINdZ0Vlq9P5Lj6xgYmrUIpyRn1OtyMsCVRpQwHPejT+ZTgnna5ZvSPla0nhU0p9/ORFfa+S9ZDHtEK2wA43kecHnWwPIOdRXqhJJCAA9boh4w6n9Juy0HNk+3EQbDIBIJxlusIIYhU4JzoZzCdfm/puf1rsvBSuVJ9K/LmaJawhYz0FVBzo4pkJkgJg+iJJkLWIzIsfrenzNehoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(5660300002)(956004)(186003)(6486002)(2906002)(52116002)(8936002)(26005)(4326008)(8676002)(2616005)(1076003)(66946007)(7416002)(83380400001)(6666004)(16576012)(316002)(86362001)(66476007)(36756003)(478600001)(66556008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /Hjg5Y3W8Fhl4ISosLOq7qmq7CQO7VJgW+6kjBQ4FAibtrzobsTc/m0+U051OW/1mg/d5wZofgvrvbSMTwX5ngfZLWIACtzIQugCqBH336mS/b1asH4z0R3bB9vpX3RAlpqKUnrXLf0z46T1o2nwN6OSSi+Ve68EYgeRosq/KbZm8Ld1DjCS3GWn9JicA19EN/k6m6IhxhegABOdFmdPRNa2AG8Q3EMaVFv2O7rI3oNpvQN/xPkilrenNJirQOXjkON1q4/ayiKxH7BxjvNiVvGOfntZRzyMmmkZsft70PT17AtHZIYlv8AHGRgCHkne+1YwYCiGyzLCmi0G8Zku8HWcVLwfTH1ojIaw0FZfEAM5ndalcpTeFVnbB4J72opjO2SpaqEwOviOtbt0T+wTprmGMGJfaeIbtdE+mKXrifASgzAjUid3suzu1Po3bNYbteiPRUsoy8E4QUEcpMTfGNY5sR+6slQiGwin4ZUUNnfdutEYhEK5AcmcQCZvbngd2gw3Ry9aQZw+qVOtrfT3P1iXaucORKYcSuHbertAO/pb8GKWaEGwMvItelPcrcvUFgSsfaiO1slS1YC+QNb64kpni/J2Hnf23AWTavDSS654n3dMqiwG7NekEgpK5bzW8q8yfAJbBvYS34ZXQ3UmtA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2afc48-2ab6-4a41-f91f-08d84905d379
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 14:47:44.6484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vF9WN8+USNjSFwOYmFa0diIVyRCresQs2s+eb0qqkiiudk86CgizeqwVuyDOQeK644TJgPB7by6YfNeUsTtMIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2767
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The mcelog utility is not commonly used on AMD systems. Therefore, errors
logged only by the dev_mce_log() notifier will be missed. This may occur
if the EDAC modules are not loaded in which case it's preferable to print
the error record by the default notifier.

However, the mce->kflags set by dev_mce_log() notifier makes the default
notifier to skip over the errors assuming they are processed by
dev_mce_log().

Do not update kflags in the dev_mce_log() notifier on AMD systems.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 03e51053592a..100fbeebdc72 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -67,7 +67,9 @@ static int dev_mce_log(struct notifier_block *nb, unsigned long val,
 unlock:
 	mutex_unlock(&mce_chrdev_read_mutex);
 
-	mce->kflags |= MCE_HANDLED_MCELOG;
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		mce->kflags |= MCE_HANDLED_MCELOG;
+
 	return NOTIFY_OK;
 }
 
-- 
2.17.1

