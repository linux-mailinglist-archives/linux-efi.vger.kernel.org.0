Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD27C39FE8D
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 20:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhFHSHa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 14:07:30 -0400
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:58048
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234170AbhFHSHL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 8 Jun 2021 14:07:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fviXwwVANXMAIWJGV7XV71R/hWyxAMq0il+Trzkh10CR+5CPipXBvQne/HrcJ9iNegB2fAyv3PWcq085VqNnJ0RvJgTtyk+53UvXmazTH+vTH2P9QFCaOqHSKl+TpyL4yEojnQqMqFkmNtF+ZlxY0f+BhqXkZv7rKbv4R6/cWs3oy0ejqNt8JND7SrYrblDiX35PVtn9+N6BqUEAsEnIJNnVGZToTqQQ3HzT28yZk+/mTJ9/6lZjATEqnvG8/VSnWhvZZeaC7zCU49/DTzaBlYT7ZDSG8BXFGXYq9v+zBg7a+Gn8EpXXFOR5cB+FqEARQUd4uL+mGmn2tucCaYlnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71w2WvjfOyEyJSKPVmVWP9ZIo6gg0K6c1BvxLeK5tSs=;
 b=enn1TKYI7E/6go+BVm956CGqVAssczmXDrpfpO85qzYVL2S9IO3+LcN7n9/oL/HZTfrjfOZ0YoGN+bakLGfVmDMp38sPNw2iWxvLL5b/S2oGddtFUeaDy2AOtivurqOhrdIWWe1aiPC4WcDpJdaCyawpbqEiY+ioZsJIWKXJdJloiqIZ+k93h2o080pbPAAKB3qHg8RLtZ/IQb3xqAdkxsfeP7CIhvkoDz42V3R0yiaBBWTqxHi2IDTw7BkPkrvNZPu3IB5PyXr9BaH0dPoG2ELRrl2l3c74nxRmJ934HXkckVA6FcFOx6iJrTMkPucj1Z14ZnOdg5G1XJC0whpyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71w2WvjfOyEyJSKPVmVWP9ZIo6gg0K6c1BvxLeK5tSs=;
 b=VcCgTOzWrMUA7V68EKQKfDABPYSU6Ki8Lcqp/DusZ1KV7BjM76ScnQ7EXUUfaBn50E6r8rKT00UWbUrhSu7vueAQ6lxZSHDDy1pjx9oUfSkuHvN5mGWx+0bg+bSh/xUj3OwUFC0ObJ4mPEouWybv/kSndzxy1UifBJV1qQ12fFo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2759.namprd12.prod.outlook.com (2603:10b6:a03:61::32)
 by BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 18:05:16 +0000
Received: from BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::ed9c:d6cf:531c:731a]) by BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::ed9c:d6cf:531c:731a%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 18:05:16 +0000
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     pbonzini@redhat.com
Cc:     seanjc@google.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com, linux-efi@vger.kernel.org
Subject: [PATCH v3 0/5] Add Guest API & Guest Kernel support for SEV live migration.
Date:   Tue,  8 Jun 2021 18:05:04 +0000
Message-Id: <cover.1623174621.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA9PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:806:24::9) To BYAPR12MB2759.namprd12.prod.outlook.com
 (2603:10b6:a03:61::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by SA9PR13CA0094.namprd13.prod.outlook.com (2603:10b6:806:24::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.12 via Frontend Transport; Tue, 8 Jun 2021 18:05:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3877c2e0-db4a-428c-200e-08d92aa7f822
X-MS-TrafficTypeDiagnostic: BYAPR12MB2888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2888085A22329B03974F45738E379@BYAPR12MB2888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHBE+xGzw9+xqzhAAr6248yJXImuvlpPBnYN0nCQI/EF4PlQ5iDiib0Fg551mhV3hWuIxKer4z8OQ77w/f1GNs86Zz7H/2kprGsBdChCKYwoj33l+ckCh2DzxjeR6grsgPlYBXKYcBMms67HVOkAF1Up4WCNn2RHGmpX0AndQQ+uXOrzMAKxU3dKI4CEzCOnPavufLYpjuft3NOuYFdBzRx0+MQbAQhEar7WuzpHagUyZiGpnYo4wIPc7B9NC6HBLo5iTahyFYj/2EFUdPdStebkemM4cfvCNsCzUOeP+/VtVvIX2IuTsH5jOwyUChSc/5/U8dzU+R+OlWbnEgKVj4t56bOWs1YyR36l6e8lwB9ObkfjaPuW1UNuFpiIu00MDL8pPAkpu5r3Qgah0yXXma9ZqZ9f8f4vGWXUJ5ycIiPZ6KyABdPnXnKRGNaswVwedaIyvEm8uUEtihtk1LhS5URxuBM9TMJIHQVwsj9VdvrZvxFNtDjiDry9EpS6X9B40nDe8/60Bn1ALSbPmenP7sjY38x6e+J04Q78vi0aHsG2vvDq3912liR+8/JcZvOkb5YVrq9IgdObpQLHLxbhVLR2zkh0nggFy337MA3CoZjRTDvt1kBntwMlTrjrNXI7fxJyGp0FJcQwuodi36JYZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2759.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(66556008)(6666004)(36756003)(4326008)(26005)(8936002)(38100700002)(2616005)(5660300002)(8676002)(83380400001)(66476007)(956004)(478600001)(66946007)(6486002)(16526019)(6916009)(86362001)(316002)(7696005)(52116002)(2906002)(38350700002)(186003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qk2ATc7HmlDNNi2KtAUZBYmYZT2ZhAjTGH1W5D+ZVRkZdZFtjDXNoU0dObgG?=
 =?us-ascii?Q?VK7VupeshgVibl9Bbr+3/0xTsvXbfyqpf0gy1FZxMeSVAOVjnGzNHGaYKYos?=
 =?us-ascii?Q?GzTQpoaJD0inDHmTP5UNmjwt6E2DpYD3Bl6fPcLp4G+wKLwvX3DE3h/ygen7?=
 =?us-ascii?Q?ad0Ekip6IZ87neTYsyFvMinS5kPo2tmE5Mpu8zWKvB8NlitKu6mN2WzXXULl?=
 =?us-ascii?Q?j//TcsAbrXGt0Iti265c3V67vc2yj4na829ib2tRbYVod+3PEQP2idu5BeiU?=
 =?us-ascii?Q?OR83t6Cl7YK3NVE0TRoThQc1G2vb91kk3V5kXo83qXmuvEF5Pja606bM3kG+?=
 =?us-ascii?Q?n7mBHBa1L7KmUQFeLm0TthxdTmMhPkNK+Jg4h7RyvNZ0/sZITttzkkAxjGNw?=
 =?us-ascii?Q?Hbj/zenYfNR1mzB8VEiTYYsoj7jhUfsqbnAD4DRtB1Uq7tY0iNzQR7Q1o/8d?=
 =?us-ascii?Q?wB5HItT8Pgq9hVWqnfEs2tuxwWKfgPUVTfEzlwdihaD9oVTncMAsXnA7sJ7P?=
 =?us-ascii?Q?ryX3F0NaX+ZL8vomezmc+UfxZc2DLNPcNAhSLTWVmPGrTFNFK1YPCf75n3RZ?=
 =?us-ascii?Q?96SIQzuxvju7ZO1Jx/bzgg+hqmnx1TqBCOWn1heGSscAic+HFbkliODYZkFS?=
 =?us-ascii?Q?QsPK5cUGNa7yawZf6xLoUkYJCOZwWOnkiAbDppyjY2PD7qtlmXYCdMQwBIDr?=
 =?us-ascii?Q?33ch0evIyZXoFHilUet1WyW9TwCeNbc0PbWkqFCoMB8GojdAtku9mGEQWUJY?=
 =?us-ascii?Q?KYtt9+SL1LmGyCjT1RaNZsM7jZ1P2Wp/qmv1stoGlzvYIl7vftrrxZs0QNB4?=
 =?us-ascii?Q?ZyYizRy7TietKV4sdfvzCLtX9Fan6dXcjXVTk0iwMwknWgZJWuUaP5lP8eo/?=
 =?us-ascii?Q?5XnWCpfMZAPssBna/IWgi9STPI8ZoCBEVuQxDymHnpQLQUZoax2n5458iagW?=
 =?us-ascii?Q?DZab5HzWPuCwbHhGMnq0pA+XBC8JsEKnPJA8A+4Vf+NI46J9i0S8XOiee4mH?=
 =?us-ascii?Q?xpgJx/6iuBnxQhC+2liYZ53NT8BW2kt6/TlYyb2wH70Dp8cPYlPJtBuk7F7Y?=
 =?us-ascii?Q?SHqjuKTNyuU2Rs0YTgUNd8jz5S8HCjkNnZnqUzNfJvctH0WSBUVtwEov4gHs?=
 =?us-ascii?Q?Gv0QbZXQ2yZaWedTUYmeI+mSjKB43/QzvBqoF8NcYtrbONt4bsIW6zjswA1z?=
 =?us-ascii?Q?iUETditxPlq/UeORpoQvrKRbVP40g3dn9gBip7KkeS9CRIaTgPDZAEzkXfmB?=
 =?us-ascii?Q?uvPmkamL5QbFP/oqxWSC9R+eU7Xvy1gDBlYIURbJtZGuxe0ab9SYCBfd56nN?=
 =?us-ascii?Q?pi5F2xEipndj2CsMMBfXLccq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3877c2e0-db4a-428c-200e-08d92aa7f822
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 18:05:16.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luLq717uycI4rvUgfq+2jemfVlTnwhp+Ow+C0AOa8vLcsjDzwRObxrkH9WS+f46ZboVPv+mVbxrmJEjW0bg5mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2888
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ashish Kalra <ashish.kalra@amd.com>

The series adds guest api and guest kernel support for SEV live migration.

The patch series introduces a new hypercall. The guest OS can use this
hypercall to notify the page encryption status. If the page is encrypted
with guest specific-key then we use SEV command during the migration.
If page is not encrypted then fallback to default.

This section descibes how the SEV live migration feature is negotiated
between the host and guest, the host indicates this feature support via 
KVM_FEATURE_CPUID. The guest firmware (OVMF) detects this feature and
sets a UEFI enviroment variable indicating OVMF support for live
migration, the guest kernel also detects the host support for this
feature via cpuid and in case of an EFI boot verifies if OVMF also
supports this feature by getting the UEFI enviroment variable and if it
set then enables live migration feature on host by writing to a custom
MSR, if not booted under EFI, then it simply enables the feature by
again writing to the custom MSR.

Changes since v2:
 - Add guest api patch to this patchset.
 - Replace KVM_HC_PAGE_ENC_STATUS hypercall with the more generic
   KVM_HC_MAP_GPA_RANGE hypercall.
 - Add WARN_ONCE() messages if address lookup fails during kernel
   page table walk while issuing KVM_HC_MAP_GPA_RANGE hypercall.

Changes since v1:
 - Avoid having an SEV specific variant of kvm_hypercall3() and instead
   invert the default to VMMCALL.

Ashish Kalra (4):
  KVM: X86: Introduce KVM_HC_MAP_GPA_RANGE hypercall
  KVM: x86: invert KVM_HYPERCALL to default to VMMCALL
  EFI: Introduce the new AMD Memory Encryption GUID.
  x86/kvm: Add guest support for detecting and enabling SEV Live
    Migration feature.

Brijesh Singh (1):
  mm: x86: Invoke hypercall when page encryption status is changed

 Documentation/virt/kvm/api.rst        |  19 +++++
 Documentation/virt/kvm/cpuid.rst      |   7 ++
 Documentation/virt/kvm/hypercalls.rst |  21 +++++
 Documentation/virt/kvm/msr.rst        |  13 ++++
 arch/x86/include/asm/kvm_host.h       |   2 +
 arch/x86/include/asm/kvm_para.h       |   2 +-
 arch/x86/include/asm/mem_encrypt.h    |   4 +
 arch/x86/include/asm/paravirt.h       |   6 ++
 arch/x86/include/asm/paravirt_types.h |   1 +
 arch/x86/include/asm/set_memory.h     |   1 +
 arch/x86/include/uapi/asm/kvm_para.h  |  13 ++++
 arch/x86/kernel/kvm.c                 | 107 ++++++++++++++++++++++++++
 arch/x86/kernel/paravirt.c            |   1 +
 arch/x86/kvm/x86.c                    |  46 +++++++++++
 arch/x86/mm/mem_encrypt.c             |  75 +++++++++++++++---
 arch/x86/mm/pat/set_memory.c          |   7 ++
 include/linux/efi.h                   |   1 +
 include/uapi/linux/kvm.h              |   1 +
 include/uapi/linux/kvm_para.h         |   1 +
 19 files changed, 318 insertions(+), 10 deletions(-)

-- 
2.17.1

