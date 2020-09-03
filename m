Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99B02669AC
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 22:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgIKUmw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 16:42:52 -0400
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:55307
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725803AbgIKUml (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Sep 2020 16:42:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd4PQY+Kq6nRbSa40E8BXsRc0B9k0Ymg7kPQCMQEXSNkanNWndqUcvHeaPufstftL0Zu/q80j5wR70a7MwQklf3iXJJDQQbIcSjwgf0adw5AAzOTQ7V8DurGORaN6HoXtrvIoyM/o6BsL+GToPMHtnfbPLrbQuLrtqQgQWQDin7VpAHegVTPp24IzChgueUUS26sc+/aeSCD26+Ic7WdVgztnMFGVV1J9++tmySl46YHUG6ob9jiGA7KfHwEYzmB2IJSCkZi/RH5d5b2TnQaZVPKTBf5PeorBECQ5rR6CbEZ4j3EmEctR3quDW/x1Ps12TxBkJlSaat3v9oA+Tubvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l51y7K+2A9GIEbrN+8NUJTrjpWudnMNjCcTpaYwqAbU=;
 b=CWkDd0atJLqgsXy4n5OrwZ4Omt/vTMkgbAJcmP+N4CEq+TFVfcTfc6YrtOs9PFu3djcyZhrDUQCGYiXfoOpT6JsCojpD6tFzrUMHT5X/ZNG9xaazBX0/pOuJ+bzzo9ImdDou87cmD9ZJKDC+wZ8YtRZTNIFwYUAycHfcExpKPIkbtXNpaL6I4aFReJ56oiZ2kn54pRZfFwuPfAsJkjAyDsw5yhNlrerp7M/nKDI7N3YoGWugtfnjGyXU+axrPeKn0uRTDCt7uKXzixG1fZKB0AmGXPo0V9uy+vEXyt74c6eEJsyJv4JLYFn7prvaGotUw/MCjSkdXy1uAdXTW9u4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l51y7K+2A9GIEbrN+8NUJTrjpWudnMNjCcTpaYwqAbU=;
 b=mlYBQjh1Zv7oRanIHcKakbK+YZw1faV2pERS3LBKtAw7UGEAYHYC4zY+o9xBSFTGTAMG/P3ofsI1RTQr4Qz1AvqmllnAmfLrxi99JFshDGjQ9P3ggIbWMJqNKQatwiMglTS7av+nhRg+JQPSJkZhtaqtszxnzyfismyk6b5vv3A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 20:42:29 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::c0c8:60e:9d04:1409%5]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 20:42:29 +0000
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
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 2/2] x86/mce/dev-mcelog: Fix updating kflags in AMD systems
Date:   Thu,  3 Sep 2020 18:45:31 -0500
Message-Id: <20200903234531.162484-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903234531.162484-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20200903234531.162484-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) To
 SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx024ehost.amd.com (165.204.78.2) by DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 20:42:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f73ee275-1d3d-4da9-33e1-08d85693334f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4431807E12092DE403E0885B90240@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlZQmOFo9J2+yPi4OkzvIa51PLI1GVFdaSqjj95iuTg30y6cLm9fxj8mYCQfI6aaZtVk3Le365i7BFGZrQ+TKvlwmr9Eh0v3v2Cn0a0rtCL/bn63z+aZEOdd371dM18nynl9fipdAV75ShZUo1cDKasoBOhbOTauco6bzO/06rhI2t/kUYCA2AwizRajntKnKTpxYDPisxVw+ZObp+bvIkzb7jIpX+muliHsfiG8G8p4nE3qWQM5yYDTKKtWVMoSTp47Lfb7F+Cs3rmTkf0VN6DBVYtysKt0MuqROMmR0KzGPmu3XPa+4TXE3pQPAmuLaYJk9eXEIKIeBez6sVK0ObnDfC7443aL0nq/mRhPuEGDTUS2KSyQPi4+sjf0uAq65wN0u0ydx+lLNu110DMr2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(8936002)(316002)(2616005)(8676002)(5660300002)(6666004)(956004)(54906003)(83380400001)(66946007)(1076003)(66476007)(52116002)(66556008)(36756003)(7696005)(7416002)(6486002)(966005)(16526019)(4326008)(2906002)(26005)(86362001)(478600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: M65F3wj3fTTG3jduktukXaKAk2m+nHLRATzXoakm0cD0TzV4PdfM/wO2vU4wqSOhxKSwritsWyopLGpDsArWE+sfixyPUtyKuXwq/vUzgsc1YEUFCl/Emf35cjNa0gty+OnikqB3OpgYUHiawNpGXU0LMQ57x+xGskJZBLukzqNOIDLk/EoQmOpO9ZTAGpztWiZ80CGwcI9OTvL+qVxL9l7E7fZdGJ6HAzn/YiXpSiop1izCqhkeKAAO5ei/MZQJVMasanV9DL3aLW8rFTdnSrBk/IkGEC66Oo15QMnhggJ0W8lXo5g6w0bUT1XR6T9u1IkSPW3CQldk+ow4SMiIHrFCr/KE8nivOyjH1ALvOLMfwVDARYNpbsivhBFFmPpKRzqWMyGvBNnvHRGrJY1gLx+CLFdm5UD5200naCzZ3uKP6uunpI7BO+K5c87Iq7B4Bt8RxNKIjW/aMAy2j4G/bfvqBTSTwp3dCnVkVad1oHqojraeGYRD3eUVfAM6ZpDtOTCY1T7Ci5v6sWAocOSWcJweZRfBTN7W7tziJu5Pvsw8rKjvnV+lnjURZCLzYwYO6VEbDOkFWf6v6h+982e7HS9OgswL16301+LWli1Pg54N7ju7lgghV/emq0PCQXOlrpYVBtWnYncEKJ3dl3cieg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73ee275-1d3d-4da9-33e1-08d85693334f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 20:42:29.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9gsPfHGolTSgucpevB0T8Xnu9gMgVwJAzIBvwzoYR+b/Mk8h1zoy90WJ+OPmiCijCVjfyZqLuHPRpYLJf6lKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
---
Link:
https://lkml.kernel.org/r/20200828203332.11129-3-Smita.KoralahalliChannabasappa@amd.com

v3:
	No change
v2:
	No change
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

