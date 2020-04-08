Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0BE1A1D4A
	for <lists+linux-efi@lfdr.de>; Wed,  8 Apr 2020 10:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDHISx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Apr 2020 04:18:53 -0400
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:46547 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbgDHISx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Apr 2020 04:18:53 -0400
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY m9a0014g.houston.softwaregrp.com WITH ESMTP;
 Wed,  8 Apr 2020 08:17:11 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 8 Apr 2020 08:16:40 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 8 Apr 2020 08:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZT+Ss9ZEHlvopIviqSmXKF95jgyivgN0Nny6OY6r5N25XXT6Bsh+eL6XZH1HO41TnOseRR7iS1fGrcHUCbcHkdjjlxZ+0nPzEel1tiLrXxRtRazCgRt8qVn5xbi13JQGlW1c1w2rNYpMql1jMlbjMS8yJD92xllNlxc5tohjJWwRZ5mlVs6B5QgJoco0gnxbkH4G3WByA/zixapxv2JG6dJ4NdMrrrJiYlCprK2tAdb0ufVk/0NIVqVybHT8fnux2g7uRh365PZbm0kIkFF5pIjRo0kWVA34AatpPfGU9gxuwmjMqvlRKAtJ9iiDIwx+3BnacUgyCk1IThA1sSfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9RVjQMwAweUsGPIrxFQ5uoQd+S+xcQhJwImUVdbgks=;
 b=gmypXGGbYOFZI/xo6jAC/J6b7G5XQE80YtAT+NkXiVoJ5PAYvVNB41/3iqMmnFpRUuPL6ASzNv0RvLY+V0ktXk4DQHXKrT6MlJMXAbxKCTD3Y4gXaKBECVVPEc2aybel8wUiUnsNu9ypj0BSKCmX5BcafF8oq3Sk/mV/PO4toHXlnw2mZ3r7hbX1EV0m2NPGY3xFHVABlL6qvybJY3wBQi837F85uSir4rAP41BlLuxXPuAy2PBlAolrlsGNx5CJv60Me/YpTUpztiNsuJillDku2SZ0hlYQwFCnMVueg9cqKjqKqXiVl2W+nzn25D9UJg72Z52ZxpGESqOVUn2wuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=GLin@suse.com; 
Received: from DM6PR18MB3258.namprd18.prod.outlook.com (2603:10b6:5:1cd::31)
 by DM6PR18MB2857.namprd18.prod.outlook.com (2603:10b6:5:16f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Wed, 8 Apr
 2020 08:16:38 +0000
Received: from DM6PR18MB3258.namprd18.prod.outlook.com
 ([fe80::5cdb:be43:a2bf:ca25]) by DM6PR18MB3258.namprd18.prod.outlook.com
 ([fe80::5cdb:be43:a2bf:ca25%6]) with mapi id 15.20.2878.021; Wed, 8 Apr 2020
 08:16:38 +0000
From:   Gary Lin <glin@suse.com>
To:     <linux-efi@vger.kernel.org>
CC:     Gary Lin <glin@suse.com>, Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] efi/x86: Fix the deletion of variables in mixed mode
Date:   Wed, 8 Apr 2020 16:16:06 +0800
Message-ID: <20200408081606.1504-1-glin@suse.com>
X-Mailer: git-send-email 2.16.4
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::36) To DM6PR18MB3258.namprd18.prod.outlook.com
 (2603:10b6:5:1cd::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from GaryLaptop.suse.cz (111.240.153.177) by LO2P265CA0048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:61::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Wed, 8 Apr 2020 08:16:35 +0000
X-Mailer: git-send-email 2.16.4
X-Originating-IP: [111.240.153.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18311f08-49e5-41d1-b962-08d7db9528a8
X-MS-TrafficTypeDiagnostic: DM6PR18MB2857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR18MB28578310D060FE55E2B7684EA9C00@DM6PR18MB2857.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB3258.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(8936002)(86362001)(6512007)(6486002)(2906002)(1076003)(81156014)(478600001)(66946007)(36756003)(66556008)(5660300002)(6666004)(66476007)(8676002)(54906003)(4326008)(316002)(26005)(81166007)(52116002)(6916009)(956004)(16526019)(2616005)(186003)(6506007);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkbnHYSnBx8wBD1ZLncKHVqyjGJ7tazKQpp53uxItkrF3lSZO3jwIG0FsG/yfoQjaOXWJrtP58yHo7+NviZ0kQ1zIhNzQq1uzMCf5b5ap/lyw2JclGnNSToQ0HCvzA2z7Avn5Of2pOQ+e/RxQae5ZUcIWrpiri/Vpw5J4JIRgHh9sbRTpDhUyhPzTBTPINf0j13S/TG//Nufq96RMecX9iqlu9s4GhMv7ykS7Z5GitM8we1b34JV6CFWs5YHSv2rl1b1HErXXvDeirfQRIbW3WPpn3CF+K9Reuy9L6J6FaTFMhRRLL2C7m88Zd985Q3M/R+InhrigTkKNA03bBx1pyhcokJFacQqj0bq+GpcfR0g2yAtT5wNC2nyQ7KeOZkPIo+Tdf4pLDoJEwVPVxLzl97+vqPwoVYgi5UF1R1csZNus3i83oZlAMY9NiLEw4NN
X-MS-Exchange-AntiSpam-MessageData: Ohdw7jXZdN/qREdo4zrj5wvFR3bB/75/7oEezM9uZztDAVhN5ywolBFELW0whgth2oupO1wfn4l1Ej5rN9OwwjIWjpza/URmH+/OI9EITEUk43swvJAqLSWmEVtsLLuuwFLOTDS3pYmyFVmC6ZSNkw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18311f08-49e5-41d1-b962-08d7db9528a8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 08:16:37.9058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1T2AfLUWPTD4oTqMT11P79J6+V3b/rypYqkB7xw3UcbymOpMxJ5EpgtaPjH7pTR1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2857
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efi_thunk_set_variable() treated the NULL "data" pointer as an invalid
parameter, and this broke the deletion of variables in mixed mode.
This commit fixes the check of data so that the userspace program can
delete a variable in mixed mode.

Fixes: 8319e9d5ad98ffcc ("efi/x86: Handle by-ref arguments covering multiple pages in mixed mode")
Cc: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Gary Lin <glin@suse.com>
---
 arch/x86/platform/efi/efi_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 211bb9358b73..e0e2e8136cf5 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -638,7 +638,7 @@ efi_thunk_set_variable(efi_char16_t *name, efi_guid_t *vendor,
 	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
-	if (!phys_name || !phys_data)
+	if (!phys_name || (data && !phys_data))
 		status = EFI_INVALID_PARAMETER;
 	else
 		status = efi_thunk(set_variable, phys_name, phys_vendor,
@@ -669,7 +669,7 @@ efi_thunk_set_variable_nonblocking(efi_char16_t *name, efi_guid_t *vendor,
 	phys_vendor = virt_to_phys_or_null(vnd);
 	phys_data = virt_to_phys_or_null_size(data, data_size);
 
-	if (!phys_name || !phys_data)
+	if (!phys_name || (data && !phys_data))
 		status = EFI_INVALID_PARAMETER;
 	else
 		status = efi_thunk(set_variable, phys_name, phys_vendor,
-- 
2.25.1

