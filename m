Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF56256218
	for <lists+linux-efi@lfdr.de>; Fri, 28 Aug 2020 22:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgH1UeU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Aug 2020 16:34:20 -0400
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com ([40.107.93.55]:27873
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726797AbgH1UeL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 28 Aug 2020 16:34:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZJQ9iJHZiYuW7m5e8gbhdpTQS2zUZS5P/ZaODH6VuPe8TlbEhURayYSmdx1pY9dHKpHIwHtH/Q/oqANXTX55U+kmFaiJtZo/lGIbXpw3Xfo5gD9AJgmjLzjJfoFNkqMoB6Y6dArrnNGYojP7Hzcd+EYfjK2KaT2fyPXo4qG8Z3mT0Qr3++NQYxMdRec4wAKME2PDDarOP7dqzqFk0KFqyUCnllXKFbP5qf4nmYQoYuCebrBt5iIFxY+gHeMMhPswB5u7vC2bfemcd0nrH15yZif4bZzCHG6KuPdylmrLn4qydUjLgcBsJodi6mlt1BVh1P9vPz2rZ17hsihtQjwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p19DD4AlfjlaKQ/B6lMTKHLNGQAO319keFtPMDiG+SQ=;
 b=iwStTC5Pe++xvWvoU84DsknsH+bac6V/zWKwejMz5RFLLO7o7RJzLm/slhh3Br3CbIUxJgFzbULN/HjnHq1MfadoHSYvvtlIX/pzSH05bCMSmvnE5tViqlp/6aUB9u0mDE8r4rfciK733BODXCx9lispc2sqUoxwCWed7ImAme9dheUJEu4Juuh+JMBoanYqlU+ZGPfVcpRo6ozLQNzq77YpEpuKqt5xrI7FmcN3HyI0vSoiVlkf2HW5xKvSNK+B7I7yCv1TyeapC65lg11totBUrUrNISKc1rGm194r9O9Wgytmw5HVHK5glH+v/b8MlsxzB25pMfYmEI4EB8hGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p19DD4AlfjlaKQ/B6lMTKHLNGQAO319keFtPMDiG+SQ=;
 b=CqTeAfA6UDNf9ik3VzkVEjdowTmsfDVZt8VQJC9JGcgKfrDAPWju1aBe0YTyv/iQtT6QrK6vj2vrvKar6Zx4mKD4wHvlBlUlvdy1gtFsOcfR24G1wykYKB9Utnv+VcyFjfNAmZoGei+4ul4xVsFz4xkCfKkobyM4CnwH572E0CI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 20:33:59 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::48e9:c9c:7cd7:de86]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::48e9:c9c:7cd7:de86%5]) with mapi id 15.20.3326.019; Fri, 28 Aug 2020
 20:33:59 +0000
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
Subject: [PATCH v2 2/2] x86/mce/dev-mcelog: Fix updating kflags in AMD systems
Date:   Fri, 28 Aug 2020 15:33:32 -0500
Message-Id: <20200828203332.11129-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828203332.11129-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20200828203332.11129-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0143.namprd05.prod.outlook.com
 (2603:10b6:803:2c::21) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0501CA0143.namprd05.prod.outlook.com (2603:10b6:803:2c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend Transport; Fri, 28 Aug 2020 20:33:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 287fd341-5c60-46b9-b8b8-08d84b91b185
X-MS-TrafficTypeDiagnostic: SA0PR12MB4511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB451160E6AF1CED559F70E5F290520@SA0PR12MB4511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SxlCE4EY+cGEA9MyDo7mpAv4rV2TIrbHTplPncE3hY3tsaeKc2sVhCG0wec1q2YR78PxtbZmVu55QCcbGAt3M1WRTTclXpjM3aRdLyfEOCzlB0IfBcE+KeoBI53jsaDAu9l3fkdS/RjPTmdYjmVPWT5b3BqVzOe6zaNifmGok6H1v4nRAj5ZxHQAmeHbCiBKVnvLavS+zpHOCCVGuwMeIazmqR2sQRd+ej1IIL5uNvy85V0sA/JjhAtVjPi5DYqnq/1i12opF8YiXFfewFIwlkHdYu9t1ls4kpYUpR/v5yysYfhZ6zApEhMx/MxFBjzIm/k6vEP5RUzuK7gmyF3dVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(5660300002)(8936002)(8676002)(6486002)(956004)(6666004)(2616005)(66556008)(1076003)(4326008)(7416002)(66946007)(66476007)(86362001)(83380400001)(26005)(36756003)(2906002)(186003)(52116002)(54906003)(478600001)(316002)(16576012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XTTWkPNXZXfe9bQVlzQU5pj7OEa75q+XQuTI+i6SFrr5+YeEZk06qi8TSIzZVfsU5a2700E2QWKdmWwaYdBE0vK64FuHtZlRJuwbmPFoIDYVIdu4bmT4K/ZARMaCfFZMikAP7vp72+Sg3qfur1V7uTZ4bZuZahBWV3VA8sE1+QBPcb2zroqfbdAgfFWPDo3vm8W1FM/ju87eg6xf0Wgam2yfHHq7ox49cov2DpzawuiOoxLKCigAYwIpMABUKBcZhCk2nMBThgrWjkL8+/BcYf4s9ygLvOUeC62wWN9UmV7oCH6q9jSFAdhHPg3P8Ay9DUm+NlPzO/TTTUu8OjWnNhP8yZuLLt8PBIv5XGFEsepWH8R8FlJMbJzEBEtyMkj/1h6HKOAQvIsoe6wHxJ3urBLbk0S4DkUcjgQIf0zD9LlPEYux4LB+mxUHx+d/0KQZRA3x4C4Qb81BWYdd2DGw0Jfx/5/G4TGPCGWMTUVYU+AsvwvN1M8P+19cYVfC+xGZBP55O+MK3+OxtmhKwlpNqbn7BsHlh2cuFhEKVG/PDdjdpCRbi8hcdeFGxY0YAU2zbwC+OSqxu+zpho0/opAahF61FO5iMpCxYytPdbXQcAlI/Z1ZfAveuLdnHzb3+OdtDDqWbaCMnbRholQ5qhSWAg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287fd341-5c60-46b9-b8b8-08d84b91b185
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 20:33:59.6035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JM/d5Vwlfes0nSAmeGntqCybX8VWC17agw2O2axsJWE7yWtxQOW0zFn0+PMTLq6ILTVUWmbPduN319Gh8J9BtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
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
v2:
	No change

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

