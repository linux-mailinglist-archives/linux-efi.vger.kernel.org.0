Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4675839FEA9
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 20:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhFHSIy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 14:08:54 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:49988
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234246AbhFHSIw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 8 Jun 2021 14:08:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ji8pFvEk4pozRY3nCirAHytZuXNFZtClJNEOYD/Orr3/mj8eKhDhdXo0x71o/nxVBF7xKcjhZ1F/VDyL+5pyG8a5F4OpbhuzRz/f9GbRMBvoFsuMxkUh/ejz6wUeelTJ1tLTj0YkglGxmXzfUDRUP6TpZdHn9RVY6Wm/AfdR4O7/n89kK4MNxdjWHLzWMxR0ZYbz8cdNSZmqQYE9Z0eYAnQPViA+XTG9T/FpMLizJ+GGdtFq/oku3+WFlpkTSUAn3pRcbN43cilP9xRCvjlGKzy/AbSNjd0yzjhJPPtjz9EMtEyLicwcDkEEM1pisRM/iHTy5pAelePS/gTp6weCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEviQ1iNZ66KLAyhHDcKxcCB08Jy+gxynqCE6dn+Kas=;
 b=jX2asGcYvHzKLLxTrB8G1YBdmruIj03KS06ILM5nVO44PA0G8hv1vgiFKXN7XWd4m7MDU3mQjWatdnTcx+vBV+/1KaGM05SNCH710bvSyavEp0xgp+XHIcmdKfFzmYVcWYPrzBoKNlQD+qPEBzw1rIU498nxmRHVrR3JxT5aylKEwqKYL5xIJ1NKGVb5o8f5cDWWmxS8riy/sU8u1b4z38qh9WWnV2DAQVAhr2XupjUEoNqe3iFjBQTykxNWWUo5ZXJC37UhgAq5Biv5ruPMrlimq2xYDg5xY2K6VBn9IBvaoLpXhdeUtz4GYb69i4X0TgmTfb+yy5EokdFNAuV6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEviQ1iNZ66KLAyhHDcKxcCB08Jy+gxynqCE6dn+Kas=;
 b=ZjgNuIWiAqiLG4/4fsWa+sQnfzPWtVq5vsW0n+w2LR6URhdre8MF2Y4IyT65umStXU1O02AmuLytk2x+5hJdUdR/azzHwZdGXPa9+Eb/bCFeKKpvKW2E+kr79KMbxdqmgiGazOGFtrvfuM3vpeqpQx4G+crh/KUkJ5h2lESOpFk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2759.namprd12.prod.outlook.com (2603:10b6:a03:61::32)
 by BYAPR12MB2775.namprd12.prod.outlook.com (2603:10b6:a03:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Tue, 8 Jun
 2021 18:06:57 +0000
Received: from BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::ed9c:d6cf:531c:731a]) by BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::ed9c:d6cf:531c:731a%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 18:06:57 +0000
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     pbonzini@redhat.com
Cc:     seanjc@google.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com, linux-efi@vger.kernel.org
Subject: [PATCH v3 4/5] EFI: Introduce the new AMD Memory Encryption GUID.
Date:   Tue,  8 Jun 2021 18:06:46 +0000
Message-Id: <13d4bdd5fc0cf9aa0ad81d43da975deb37f0d39c.1623174621.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1623174621.git.ashish.kalra@amd.com>
References: <cover.1623174621.git.ashish.kalra@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0128.namprd05.prod.outlook.com
 (2603:10b6:803:42::45) To BYAPR12MB2759.namprd12.prod.outlook.com
 (2603:10b6:a03:61::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by SN4PR0501CA0128.namprd05.prod.outlook.com (2603:10b6:803:42::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend Transport; Tue, 8 Jun 2021 18:06:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ee3f55e-feb4-495c-9b0d-08d92aa83465
X-MS-TrafficTypeDiagnostic: BYAPR12MB2775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB27752204F32918D1557C8B4C8E379@BYAPR12MB2775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfuY/onWdiBmWSKV3PO5rKj8gTazjmY77WCHKrz4xAbl9W3BgqKVX1Bz2EGg0BGtMB/dTzuGtfeNudORTrNFskkdhDpxNzFqwLnw+bDTXmOKhIY/iCi6q87+oC7Dq+kJKvDzCy5inxCxLkRRLkhbHi55Xc08XH4uLgaXdMJ0g1/r5WrXwDdE+DGL61LRJRtdHVFqx8IoIaDoD3A/3QV3Yvm3LHXuWbIjBKj3FSb2RSDrcgHv7Nt5utT7YL2kz29fpwy4iCgmoGaKSwkBxhQkqT6xTRh+K0fRS0mlEJBid+76dmpRS0ctmuVZDKZtQzaioQfyutZ0K8lQwKQPcReWK/DQRhKkwcgi7SISGXe0NcCPVtAohuCokxBMhb+Pc0J2dqbGDNaKarXKn7m7xCsJ5vfaErztq5+sQS1I83bV/t2ou6Q922WHCZXgbl0ChcnNjD4iouhsKg6+nxGAa1s755kdtvQifPNKhEMB0hZrumpexQ7S2kIfg+M7YWsHt3Ux6CAa30mS68+YD4Q5O+t7EGjB9Ig7+Y2yRn+cKNvXHgfNzYK5TMyxi4VvGw2hivci1ZqXhCMRxf0H3uHttsalaISJWve/j1923u4iHE8Of4GRwzr/TJM4lQYP5BADncNf+mxZOKSPFV7oO3BxgryLJalIvJTFWvXr3Tsaamt6Ev8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2759.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(478600001)(2616005)(36756003)(956004)(6666004)(6916009)(66476007)(26005)(4326008)(38350700002)(7416002)(7696005)(5660300002)(52116002)(86362001)(6486002)(316002)(66946007)(66556008)(16526019)(83380400001)(8936002)(8676002)(186003)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t5TNHJlN+eQ8z2Sbxs7hUeaJ2yg23WvEHyewaS/ypdvu6C9ZEBIhyRNppP9j?=
 =?us-ascii?Q?J5KvpQ6TIxPqfw9kJ5XbZMm4k/pqUfdH7WXj2LGHYgGf6/er/PokzS4dRJk8?=
 =?us-ascii?Q?oSyerpJox9NWsW6UFnIe5NErGme9oQz71CaOXMamyAsfQRlWLidNiq4h/wd3?=
 =?us-ascii?Q?WDs0hdsbFButImntbsKrPoX9T4LpaFncivQoj+J0g7DY2zHJCl1HNNe8/RlL?=
 =?us-ascii?Q?bHa201ae1iStv36m60OHKc2+7QZgnkGiOdc/jLO2XjlsC/NVXdQnJMzE5NRb?=
 =?us-ascii?Q?VbRzVkQ4axPo2wV9u5RCFQo5xt8qXcoDl64WzECQAvZJjkNWFrrXf/EdBhf1?=
 =?us-ascii?Q?qqB7ytcD25QwAkuQUdFb8hSjR8FBiWP11d0IUOUuA4NoKVqDngcCLXqH/tj0?=
 =?us-ascii?Q?5P7t7mFJNLkwF0CfLWr4MsmK/BtL++GCvSBt1CqiD0LSc+rtOeXyQMXEN4h/?=
 =?us-ascii?Q?OTWh0nthXyHxsVZaYa03ThftPBB+5Pioe3tAiMrUppMCoH/WzuA0bAslqU2y?=
 =?us-ascii?Q?hqzft0fHHB2kx9xChTpYm3rAmNiMRQ1HbtEPkkyxYyXqOwupe/n17OdKTJ0r?=
 =?us-ascii?Q?GwNnInXDoEaxWjqDatlKf1udiKSd0S1GqH31O9Kp9YIohoGHp8TABCO/kWJr?=
 =?us-ascii?Q?3Ox2Nt7BcudU5wbG3nf65MqlEIwRokag+QGmma5fb0F+NQ3guhryPwR9XY37?=
 =?us-ascii?Q?//XVHEVuw1x6EJnDHw9m8KvOWf9CRcvvVpnj6RRkmYSUfS6NHEyR9YkNCEHq?=
 =?us-ascii?Q?vIht9FPQpbvUcITsNr8bDA+NCiLRWqPMKIcrZP1Xyqdo52oYYvXRmNaoF9e+?=
 =?us-ascii?Q?1Z5SCUyk6NIEtKARzB3Ir8k/gPzzBavLhH0MfM+rNapoou1VXgt4F6NUoCAV?=
 =?us-ascii?Q?BwERgnWnHAGa4MnQep6bfgg7R84Ix4lFYPpseeN8tgTw/mV2E/Sr6lEqaXQA?=
 =?us-ascii?Q?6V+0PEzGwgUewSYld6X1Li/Xn4VBXq/Yhxks0aWmUzE3lUNc9Ze9jo6g6b7a?=
 =?us-ascii?Q?2hgR+jrNBdO8aQvUeS650RfApv7VUmkMPWYROlDlKjN9hn3OVraDUH9POkx6?=
 =?us-ascii?Q?AzMKW1I++ZiAJ3mkj7BpxrypmMqEcbPQG5Jb2JGFH/9hrtSotTExCyLuRsUX?=
 =?us-ascii?Q?nv8M62OkFq1nfoFmcWh6wYPZ6mmS8/XolE2hxztwNkHXbwekJjNdm0ySlT1T?=
 =?us-ascii?Q?W/UVIXDwLjsv4zR6k4Yo9vDhXAGSaL7mXqmOilhNheDY2QRfKMSPqb1drXLc?=
 =?us-ascii?Q?LYjMuYDBt9igo5G2kj76Dr71NxqKU3MidCDrjURZHa+XoFZajknD1q93S618?=
 =?us-ascii?Q?TdlcRFkS2ZS5oWuc1UfbtJGP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee3f55e-feb4-495c-9b0d-08d92aa83465
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 18:06:57.3800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3DwMxdFYJclJPrJx0oe8pVG3TmRW+RlyjTDNAquIAtff7LcpaGiMl+S/frWrqew4XuIQIumwHswlzbhxQi13w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2775
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ashish Kalra <ashish.kalra@amd.com>

Introduce a new AMD Memory Encryption GUID which is currently
used for defining a new UEFI environment variable which indicates
UEFI/OVMF support for the SEV live migration feature. This variable
is setup when UEFI/OVMF detects host/hypervisor support for SEV
live migration and later this variable is read by the kernel using
EFI runtime services to verify if OVMF supports the live migration
feature.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 include/linux/efi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 6b5d36babfcc..dbd39b20e034 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -362,6 +362,7 @@ void efi_native_runtime_setup(void);
 
 /* OEM GUIDs */
 #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
+#define AMD_SEV_MEM_ENCRYPT_GUID		EFI_GUID(0x0cf29b71, 0x9e51, 0x433a,  0xa3, 0xb7, 0x81, 0xf3, 0xab, 0x16, 0xb8, 0x75)
 
 typedef struct {
 	efi_guid_t guid;
-- 
2.17.1

