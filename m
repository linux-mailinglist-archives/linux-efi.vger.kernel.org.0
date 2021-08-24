Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDCA3F5CCE
	for <lists+linux-efi@lfdr.de>; Tue, 24 Aug 2021 13:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbhHXLHj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Aug 2021 07:07:39 -0400
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:13466
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236443AbhHXLHi (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Aug 2021 07:07:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0afvSI5T55wiq45my1TKXbU4uUWghYID/qlOmW0NZJVQMZ6WIZKHek4yTGxpM57mLShAygHYtAOpvM+O+1VKA1ngSsp4ZumU+BSQnT/HIku8ad+FOlynY4FTLEQcj2TuTamAeHdBja+6TTom5PXtS3D0WPusstfzA/Et7gFkOET/gZNUnXCauk34RhtMjBWjFpxB0csvUuNf3Nv7r6KoH0qeigXVJPQan9L372vmFwTv+9fTrQHeZyeT9QU2VOxcNyJo2iUucFct/bBBSI9DuBCP6X9Yn7Jh+fku10fFTHIZuonOgPccK5xOjK+pOsFlvt5Vl/YDKqnNrR+qfifUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImYRURSA0MWns+++F1GteOzG2evYIUzjTgbdkzculhc=;
 b=VqKEqV2Rj9WNViTlG9F5PIC3ghxZVCD3lrZZzeBKE+18n5lWcQFKScJJ9NqcRLBMRRyNLUaGzVrItHmDt8biw/BsoFXP/oKk6vsl4ZoRgOPFDKleoL00bnijhADGhAcQjw95ROLOqE2l6BkLF9guBDKrCnN4trVepuWLAw8nQgG5RADd5aApAtRuYWWliTlVr2h3U3pRPrdW825gLqHNLyVL+nKTEwjgsm1EHMaB9YrSsAjRZ+qjlULA+OoVPBHTkfdTH435eWLPiyUA0uVEThpP3EPT0e2tK8lYV0JaHQL1lwVWFIN3KK2nKr4e/L7NErUgVf7U30Hq4Z2FOzBHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImYRURSA0MWns+++F1GteOzG2evYIUzjTgbdkzculhc=;
 b=mmujYlpBmKOtV88GIKOsXuA6K2vxM5OA5J3gsyBFtw5eoChWFEzTbWtc/ypWVisKHgVxeHOcC9L2U/G0ckiTq0upyCc6FoWBpxatMh1Xx0lsH1QB6D9ZUt62faFZf+XFRqITP6Dzzij8x+5QqUGUygJ/58duX/fwFg/aVU+zhLU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN6PR12MB2637.namprd12.prod.outlook.com (2603:10b6:805:6b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 11:06:51 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::491e:2642:bae2:8b73]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::491e:2642:bae2:8b73%7]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 11:06:51 +0000
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     pbonzini@redhat.com
Cc:     seanjc@google.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, joro@8bytes.org, bp@alien8.de,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com, dovmurik@linux.ibm.com, tobin@linux.ibm.com,
        jejb@linux.ibm.com, dgilbert@redhat.com, linux-efi@vger.kernel.org
Subject: [PATCH v6 3/5] EFI: Introduce the new AMD Memory Encryption GUID.
Date:   Tue, 24 Aug 2021 11:06:40 +0000
Message-Id: <1cea22976d2208f34d47e0c1ce0ecac816c13111.1629726117.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1629726117.git.ashish.kalra@amd.com>
References: <cover.1629726117.git.ashish.kalra@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0185.namprd04.prod.outlook.com
 (2603:10b6:806:126::10) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by SN7PR04CA0185.namprd04.prod.outlook.com (2603:10b6:806:126::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 11:06:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d163462-e9e9-4395-8c2f-08d966ef464c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2637443A42FFA3435D41591D8EC59@SN6PR12MB2637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVBffnSLbMtbxCuc65Brh6ZwHH8JTomT2Z8Ai0O/Y0MSWoSzxfUuP4xcRMJlduHaCxv9kO27hWwF51uRR6r2eISkXv5RKKF/FLPKxHF0aRkQWvCGpqjaSuefcECYWtFeqf8wLTyJWFL0tb060JTW0RPx7CNlVhlGj6XDCIUW9Xv27jW7wyPDZ3prJHb2QhC4sdcaRqfhoND0mvaqDSycuvkalNjAzDghmPW1MQA05yF6CpvRMvYbhFpk99L7CXbRGWTEva/M9L7ImgnGx6oCOox5oXmXHlHs4Ve2vI4XKfj0qxKsaNmB1TifGC3OfF7eUSoceSX1Vth59GyN7gp/dstB/U6YsxwxFK8j9gZKCmaLEffYAPuVx/qm2h49ujyCp8cgcxZEuni9DF4/e7+BiCWyDG6n3UEfa45igP+3HtyYBNBviPsjc7g8UXBDUeNcDCNImkKRoESlqB5rtx3wUznYy8brQWKQykkYy+EcKoScSj3DK+VmJq56CZQsnrmFSk0sNqdj9UCZB/l3C3ZszL5QDNUBiljGRvQxFODIGrifcLAoHU0l5ODKx4Zvnf0faKpp1W+2p7Fx6MA6A9o7F8VnQW58T0QYHewn+z2JElxJ41NYlqp7Fpak9SbZldokHxFLv/tjRO1LLyc3odIUsy4dqWOxrwsrm0FPq4eZ6MOGQESn/1HxoFlftzsb1/ynjHGIZi2hOSw0A3Dw1lhqDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(26005)(38100700002)(38350700002)(7416002)(478600001)(186003)(86362001)(8936002)(5660300002)(6916009)(6666004)(83380400001)(7696005)(316002)(6486002)(2906002)(52116002)(66946007)(4326008)(36756003)(8676002)(66476007)(66556008)(956004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sbkiJOO9R/W5w1/+kmgEzwlEwZwuv/EA81aY2dkDEpii61vyarV1Mmp0oJmK?=
 =?us-ascii?Q?aXhZtHIiCDSZwDFxPo+e6TeVi/ZEk5+1vixmcx4FoMqauhnJZcU0Bt18I1Zn?=
 =?us-ascii?Q?79yz7AWMEwUsbkrEAD7BqRZJ6HbwBUCIqHO3VmtPzhMtgnWMAW9tOOt+mHBH?=
 =?us-ascii?Q?DN037/vkmW8Rx1g39IuAf34tJNF38VQsU6e8HRYYjcVP/yJeSM/AXsBQQhh0?=
 =?us-ascii?Q?HFuVoZm0a+OVadIQbHFzRQNf+ryaQ4MbFX2W7YM7lEi+Mx6mpBrXZFybJ3xy?=
 =?us-ascii?Q?9Qac0BEGGSjtE9dJik+JvWYxbCjpVp5Um5zBDlRO203ZdiZVxbbqKKymerjV?=
 =?us-ascii?Q?LcymLMVWe7emy9JodzKclbd8T9SoIiQ4S+XKzd/zAEq394H+O7KJZqNSawmM?=
 =?us-ascii?Q?JwnuAHcEHZBhDvGDLUF3sJTM8iQH+Tw81sFFnAdDTwLqU8iP+b6ArjRWP9H8?=
 =?us-ascii?Q?WRavWlEK9dyk+gdVukjBrc3HpM9Zw+//JK6hsKv0nQI8VJUjpB41cmqO++aM?=
 =?us-ascii?Q?IaTXEnAZAtIBfqW3ixrf90SNxqBWtW4G66CA0XvuVNpVasYsLFy1qbPgCsiM?=
 =?us-ascii?Q?H3dIAquEMZCcbBtqddfE0ipFQuWUH0m5fr7gkFgd9D+16BFbQiYTi/cBq0Ui?=
 =?us-ascii?Q?OP6zXbRuajcyzUhdkVRYL0M7u0PoeqhiIbXYNfapao9Gd1Zq86299tJVwB0g?=
 =?us-ascii?Q?eQIl2qECFx3PTS6SchLjZVX4OFRHqN3H/1aiNO1Nojo8FXEmmmsbYNGrvPQh?=
 =?us-ascii?Q?sdui/Fecc3tktezABDNJ9811zUXtrWJoJpGLlp8WjOlH2Br7p+fTh5/lAdSc?=
 =?us-ascii?Q?7rWg0qKuWemxD17Wpx0EQuxR+q/h8XBtc6Ec/oON+9qCkMpGCVJeg7GJ0TTg?=
 =?us-ascii?Q?2Zd1C/48nnErzh28tPlPMvHsDNr0vHdxlDniVE5VzzNg0QDE6ifAMpKtYyl1?=
 =?us-ascii?Q?0JR0HXD5/Maa85Y+Nk3ZufE4Vpd4FF7MW/M56TiLkrkrXLaXJjunVgLbFlrg?=
 =?us-ascii?Q?0vcDWdWVcnKyE2i+1R0Mwu0SJtoW7K8nKAojD7XENHOhDP1Jy0vLkw4SqJYC?=
 =?us-ascii?Q?ejv8u1+73unotGCTXKKPqnpIqr9EuFSPEPB80W/q46DC5xgGKey0K0U73NXI?=
 =?us-ascii?Q?EUjZ0bvmAoZ5k0zuoOVuzyntjGEVfn8V7Mne+mk9NJkWzlRhz6gKkocr3xHy?=
 =?us-ascii?Q?9XMPnOtoeMMlyufJExC8l1fGCNk6RI47Z0umJxpZwv86pKjylLWEoh5cUhTt?=
 =?us-ascii?Q?a8sGbdjrO+jM/BDeqIFyCHLUwf85gMhaikfuhwESq1k8y3FBi7jw+K9Ul8LD?=
 =?us-ascii?Q?puKloDAaK2E/AXZSxBpIcWHQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d163462-e9e9-4395-8c2f-08d966ef464c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 11:06:51.3853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+IaSgxukaz8Q3N6D6oaXjpKVsqwjiHZCgDYVOJ59Vz2FSSJQVMRLo6o48mL1waU/xqG89e91QmSY58fSCADFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
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
Acked-by: Ard Biesheuvel <ardb@kernel.org>
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

