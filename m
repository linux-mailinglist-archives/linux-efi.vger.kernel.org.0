Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE1F251B24
	for <lists+linux-efi@lfdr.de>; Tue, 25 Aug 2020 16:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHYOrj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Aug 2020 10:47:39 -0400
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com ([40.107.237.48]:42881
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbgHYOrg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 25 Aug 2020 10:47:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvZM5BEz3rJLod78Ms/HgDmgfNMUVDcVWMu9LfQO7y5Kh+V+R/ybACNoAZQT+EgPaxIW1z1kRIHdmFF01MJYeO+AOq3xHtMjaOA9jJHDAF7azh/cDMrlTMFEWFPeqZCZVDrByoK0dTwoacRDjAsc09qymoXuH58bKCaZq9bubDvsJkfGkuJ+EntOXTMYUz3+S0Im5Dd0JqnakUWwBQi0bHS9HuOPUimR9M8xWH6yrJg4lQWXA9YfUW6+6VkcEPkbj0ha9c+Ga6EwXK4YFn96sKZLgh/yv+xUKkEXCzRqTOKN63YohKPN4VhQx13etAwfdB+jd0jO3wgKh+MUv/11GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjVYfu4fzEC2Ra6AUbUWtzHLChPWFu1quA9YBDh9SvE=;
 b=bUDOzU2lGXF15uex6FWPyP/IRXriOnmgIFdtiGZ2XvXSbkErmtjlyl3WcLHObPlM4yHYM6qFEopw+aSmYfiB6M7g/vwStycvlhekFvoNuCi4AT3z2FnQ1seWlDzEN9iVg7/Sl6XnoE11Jw1avQDPsq30SmwP1SbObWbJ3rtrkfumuhqRcAg0hDwO+QsdJmU67x7gnMj4rSvwblE6vNXcTlMNbkhAZVJf+boOfSzJoam/9XbcDLAWcHoogsoZL+gYXeKlalMoxBMCGCvidHUcFYhTUB8sP/JJWCCNFe5XZ2WvuCkbfytxh3rdpzFTeLwRtTVPlN/Q1wlYHAm8KjS7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjVYfu4fzEC2Ra6AUbUWtzHLChPWFu1quA9YBDh9SvE=;
 b=ekq2o5ZIPZhIfNE/ywFE8dETbPpjdxIh3ibWsiv5v+IO2KDKnk/IjoWNDH7IEIbVyBwJPJQbytFC/S2f2z3lGknsDxxzoUPwk7ZLtDSTfu5YClamr5IrwHhRviujWhiJ/eUXyIsNds5ZA0sAYK4xsnd3gWwy+6rR9mzxOSYEiQM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 14:47:30 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::48e9:c9c:7cd7:de86]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::48e9:c9c:7cd7:de86%5]) with mapi id 15.20.3305.025; Tue, 25 Aug 2020
 14:47:30 +0000
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
Subject: [PATCH 0/2] Decode raw MSR values of MCA registers in BERT
Date:   Tue, 25 Aug 2020 09:47:08 -0500
Message-Id: <20200825144710.23584-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:806:d2::15) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SA0PR11CA0070.namprd11.prod.outlook.com (2603:10b6:806:d2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Tue, 25 Aug 2020 14:47:29 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d1b1bc1-6fb3-47db-7e2d-08d84905cb02
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB276718111D5A4F9DAAA170A790570@SN6PR12MB2767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Slz/1ZeJ2TzakOTQaBlGRe0wfEq4BYrInBDZSTTJmchPvygPjZkcfg5E2g6cQ3vlOTZ1pbd8cmQ7V8DQqIwvPBYXV4mrU/7ct/GTK4yiJQwv56I1lqf90Oh3a604vlV3ov0GQy7jka0QHbruwpYlGLeabIKjeHcWIoYVoEzfLudGl9OJ5acok41HjiOYUpIeK8iL5djHAjJS51MhRoKaJ+4yR8fwOIb4JwnG2KdEpwQaaHTtcsQUYJk+J+kvLSa9LBnBMWpOAXySY3QSkvBuZ6tZ2/a3oK2b6RjOMicnhH2V2s69V0RZiFMYCPG0TrEItgx3FE/Q+sZPr6FTLL1z4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(5660300002)(956004)(186003)(6486002)(2906002)(52116002)(8936002)(26005)(4326008)(8676002)(2616005)(1076003)(66946007)(7416002)(83380400001)(6666004)(16576012)(316002)(86362001)(4744005)(66476007)(36756003)(478600001)(66556008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Mdyk7Sc13BhWpM2Bc77qu58uViwsUV5PWjDmd+B+IwmltI07Szw9NPPWuiFf4hnZjRxLb2sZCVNHGW71x+XcnFcqPOivY5JtTr1r/+3CFMBmT8IuOFH66MEfoKspZefelvHyoJU4RIzquqPDW0qIwgLJ1I0BS0D3SNmE8Gigq28SB3c5BXw9zjvigttyEKPHIXS2gwcxlK9EH4eCc56taTBtYJNRs5Nw0Gc/wsOIX6zxRBt3nN2j88lR7mN/Wn3T2y02D0Nw85tmPgxC36pOduUJWTF9xRM1Wqowjffyi6hbtHm9bZR15/eG1IwPpE++vlRvl/InSh4EGL/4Q1+mtEBnHIR5dxx01Ox864u59ugMihu62NtacwP7CePckDdk4WMEakXX+5JRtEPBEVGH5EdMRrTNMgxPC9Fvpyatq2uSAgdRaWXaSoDaEfQ6TK46GfFj+5+0qan7Ko5a95ntMg+eTLcMiCigAjXmZHBk/LUaFuY4vnIVsWSVGF57H/D8awCW0owBkIV/PGaDnbMjhdSIv1yaHbVhEmHgJyLOH39H1p3RYFLljJYo/L8Kb77uLTWry2n4KHtGP6dozlwnlpXkDKhTodPWTJi7LXabbDdpda+dr1bRcrlr31zxxpFkX79UqBd1znTzSU78FGsZNg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1b1bc1-6fb3-47db-7e2d-08d84905cb02
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 14:47:30.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXDl8vkOvgkDEkaDFsMKK7+H3BWWByQKwEpHenwaQYdkJBCzQFUodLN1FwosShCw0A6NLyNFlINx4RWk4mJpow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2767
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series provides better decoding for SMCA specific raw MSR values in
BERT reported using x86 Processor Error Common Platform Error Record
(CPER) format.

Patch 1 extracts the raw MSR values of MCA registers in BERT and passes
it through the MCA handling chain.

Patch 2 provides a fix of missing error logs as observed in Patch 1.

Smita Koralahalli (2):
  cper, apei, mce: Pass x86 CPER through the MCA handling chain
  x86/mce/dev-mcelog: Fix updating kflags in AMD systems

 arch/x86/include/asm/mce.h           |  5 ++++
 arch/x86/kernel/acpi/apei.c          | 10 ++++++++
 arch/x86/kernel/cpu/mce/apei.c       | 38 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/dev-mcelog.c |  4 ++-
 drivers/firmware/efi/cper-x86.c      | 10 +++++---
 include/acpi/apei.h                  |  2 ++
 6 files changed, 64 insertions(+), 5 deletions(-)

-- 
2.17.1

