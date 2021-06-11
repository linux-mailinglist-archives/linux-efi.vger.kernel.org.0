Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3983A440F
	for <lists+linux-efi@lfdr.de>; Fri, 11 Jun 2021 16:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFKObH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Jun 2021 10:31:07 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:29664
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230346AbhFKObG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Jun 2021 10:31:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AugUPhsmH9itr9hphywU01Yz7FLHYyUbGlYEipX583Jshf3cncw3rEF8QbvEanGswI3x9WHap2WOk/Ie9/INiJK4gl51AgYvkKkTMalNPSh4pVY37IEum1b0R508xiSybeuT2rzQqoIKDpkfc7TOBpcUasyFaq1LzGlKpRzDx5Ndy4xgIKzIfDYxa7vWZhRrHeALRUH4B8tKtQXB2IebDRQaUTo4bsG7haGGQ4ze8o1jnR4wagYIz00cRtFwP/q1600UmMsc0TewBD7JteFH7lA23/6WCFQIZeywd07zvrm3RhrfVrfEZRUQ4Ax27oHczfg3elLfwaRr9esfqmyZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImYRURSA0MWns+++F1GteOzG2evYIUzjTgbdkzculhc=;
 b=Gu9WShkRvRC6RFU9txL6K8UnK4lqjVF21CENFva883OvHfBKJa9rwDfibWL2GeUwmFApetjsmNMfgkEUVc07s6JnL2wi+IGQI2dAP0Jx4/cZV3hpMkoMIur/j9hJ5lnJDOfEsRBaG10nKkkjMK0QoQYsis/ZDeZ/fS8XBqL8kOps7f7f/H2zkoYjag6Wou8zvxRQqEWy6aOgF/AH99/b9ocPgT9X+ft18k938/ssUyzaAUsOjSi4MvWzswdtSDIXsyX0fRl4S7Si6JP2n94EtJPFzkdY/P92IWvQkjMOfAl2DN6uVmGGXdt3sy2ee1g6nEhMuUzbuZa5WwYx9FYtvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImYRURSA0MWns+++F1GteOzG2evYIUzjTgbdkzculhc=;
 b=gtFNOYImn2S1NVgKtKre+lBk3Re/A9AUSstImgbkJciFkx/8BMZrN/jhivVWGSxPosOiVtU7f+W6evs2i9H46gOt9p645Z/oS5VO09vfmAwXjM1v6z06VuKbqFae7PQgVv0MyuEfQFHyhnjzbe2L1aeAuI+wMqCxJO7BTWVyNp0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Fri, 11 Jun
 2021 14:29:07 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::958d:2e44:518c:744c]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::958d:2e44:518c:744c%7]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 14:29:07 +0000
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     pbonzini@redhat.com
Cc:     seanjc@google.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com, linux-efi@vger.kernel.org
Subject: [PATCH v4 4/5] EFI: Introduce the new AMD Memory Encryption GUID.
Date:   Fri, 11 Jun 2021 14:28:57 +0000
Message-Id: <eb86793b6964dc813cd6105dfd5b551d3d2eff46.1623421410.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1623421410.git.ashish.kalra@amd.com>
References: <cover.1623421410.git.ashish.kalra@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR2101CA0018.namprd21.prod.outlook.com
 (2603:10b6:805:106::28) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server.amd.com (165.204.77.1) by SN6PR2101CA0018.namprd21.prod.outlook.com (2603:10b6:805:106::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.4 via Frontend Transport; Fri, 11 Jun 2021 14:29:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7516689-618a-4f96-da0a-08d92ce54517
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4382261A3ED69588862530918E349@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmjOq+4k44Es0y2oeHCZQ2HJmi75YcqntgcleG3fBO0aSLE4XrNEX1WQ4s2hmGPyIosOGCi6FFC72TfYyAPpOC1ZPUsah71oGkeibWXb4QAu35YLLxi+yJDQ5h4zErcUWFbA9IEv6wtv4Gas1nn6wUBZK/7PzOltfc6ttVpGNyX2TVJES+t4Xtf/UUzJl/8jL8EDW44nCY8AVQ1IF4kvoyC2Szwa90IN5xNvjj3WccKlpVYy/0q184lC3Ve//qriEvc6P7/g4QGJVEPAnEiSGdmExQOQOv3HE7dDyZh0YiDeDUy6W02CIE+K9Cpq+1XWTBstamkmxyax38gd5l9viICfmBv2jlg4kPXnbjjrm4xt5g9JIo0NQ9+VYBqANEHLNMJ87xCvkLkEnk5Ctz9IS91pptuskDm52KcFeDHbcK57vkKIjDc3cICzXSHX6wWhYgFl4COlc7Z6j8bLuKqfmOptqSQDXGSIgI9WdnvbrKjwrC6ahDJMFvrfc8e4z1JYjsm9usV3X6t4Q/82NpR7MCOCMSMQo+IxWt95JZiezs0hq/3Bwq/9ziEXdJjZJbZKaah2y8pxc7EJQqCHbrQcQ/LXwzeI2C1aTSkw2xRPofqbIoLilVN9hXRF24rqQ6kGDgLDAGpFupu8oYUeoZqWVvM9jSyMuRQcRj1PX6JjEdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(4326008)(38100700002)(38350700002)(2906002)(52116002)(66946007)(8936002)(66476007)(66556008)(7696005)(6666004)(186003)(16526019)(478600001)(83380400001)(6486002)(8676002)(86362001)(26005)(36756003)(5660300002)(2616005)(6916009)(956004)(7416002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TR5cMB65hKPJQuU5cZmYaRh283v9REdBJIwBodnHy36IwsvAlSKcjOK5l1Sc?=
 =?us-ascii?Q?IDf8yqdacvPPGh3as20r0vgCBSvuo9uu7TK8dwdiT+BIJUG1fGJtQM0u1Uqj?=
 =?us-ascii?Q?SKVNoImNOaEh59D0t3n1BujZ3+OZhzM/pAbkMxRw/mPvKwkD1sGrIFO5EuC/?=
 =?us-ascii?Q?yspvMBcI66uMXudGH/QwiPVoVhBUN4lAldv90+Q0nOgQQbP6G6S9RlerUGov?=
 =?us-ascii?Q?XIu4e71vedKtYoakxmhnetRQL3EP9HDZdFXAEiX3bedBovvrYufqafRxLsxP?=
 =?us-ascii?Q?TIVqMmhGdUWRJYNEP18UfqGvmN3vtdvnFUCt3yPM1o3S3ToT338T3bbLBl+F?=
 =?us-ascii?Q?Y7fqtNsf7IrFtwiDCcPrvO/cy8vhXJDzfM5QukdqT43g5wh6ei4446UV4NON?=
 =?us-ascii?Q?i7P40WMxYb8YuvRVAAqQt++ImW6646ji4zR7EDZ9PIs6Wsts0X+sdfipmXd9?=
 =?us-ascii?Q?uS6B1t3Virhe94diYW06J90nP1lm+r+tPa/2nfuQLec3he2R7Ppg9dGJON2C?=
 =?us-ascii?Q?NuJV/Oyg08/tiQTjesrZxGhQ/qg7UiaOIFkSNaDZ8kugqGL+F7csxQfO201p?=
 =?us-ascii?Q?7JBDJx1HgXLNqWp1bOMY3GgJEu0FUvxPHpYS6UisgQV7QKh198Q5/gX6Hoth?=
 =?us-ascii?Q?V9qH96oaZe7KS93MGXgbRUG3jat0jhO67F4WYVeRHqf5y3fBg+TjHkKzOIDY?=
 =?us-ascii?Q?O5aipjrAsRVgbacz11m7Tk7THZSz3xTFHm+ePamLkv94gj729lGjXZ+RcHZM?=
 =?us-ascii?Q?BjjhfIX7p/ml+vSmylC+0kAwma7VKxXC89Bw5GGokDURJbMrsbLdx14/yR89?=
 =?us-ascii?Q?2SCsVE+kmWGSEdokLBeeUuHiRdyAYLKkLdXVR24J2M+aTvd2QMCJIuuppQaq?=
 =?us-ascii?Q?FZDzPe8itTkPFcVkX9AJnmKTORe+quDH0aidzv/6+ywU0mBXdt3FDSc8hQvi?=
 =?us-ascii?Q?L5KXf/5eF8eth8D+tvYRs6y8UrYKR4pjJZIEleC2SXu1kQNl5gFmciT4VeLR?=
 =?us-ascii?Q?SfTn/Z1U7WoP6lZeRlDg3zZYzkVEW/omb5JlVldKzVOjvJfhJjSbFjDmxzVh?=
 =?us-ascii?Q?pN/l3p5VkqOGSPNeGYJXkew4RDEje5mHbF+0yPE7dyrID5Cp5yQK9HgTv2P/?=
 =?us-ascii?Q?MzoQWUUyBEhau6gEgPpj1nEk4rdD7XabPKohd5jHvLA7oN6cxNxO1CNdR5I4?=
 =?us-ascii?Q?dZnShoRqPs6eBleQB+IGDXzWPLI+CHakAyyrmf85+H57EurUsX1NR6ZdgRlz?=
 =?us-ascii?Q?ZligFwYf+NsuiFTHph1BVXSYbezBATLvAzZOb75rmJDMx0oFuun8pl7kNTpA?=
 =?us-ascii?Q?gAnNHDLnpkk52ISdRfmCOgJI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7516689-618a-4f96-da0a-08d92ce54517
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 14:29:06.9658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lz4TEbV4VvXhzkOasYC4rRINxRuUioJC2Ji4kSShMCkq5SN+BFa4uJfCqiZ5LFuMQELTzIhu3+foenNH9m/CtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
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

