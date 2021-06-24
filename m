Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E593B3108
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jun 2021 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhFXONr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Jun 2021 10:13:47 -0400
Received: from mail-sn1anam02on2076.outbound.protection.outlook.com ([40.107.96.76]:38598
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229878AbhFXONq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 24 Jun 2021 10:13:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meskm5TiAQ/C/7Xm/kqR4dLmCsCDg0xn/2o7euuK0JFIgKSDd0f2Wor7A7MwwAYWzCieGFImAbnNZ1cu1M0NkaZx8rIpUxCMpRhDg5q10d/AbvMkNy8qyLGbDaX2EVxuNv96aAvyQe3/Ka1QTggeOyQuVtAnikeFZZCFgn0eGx4whUTHhB3FIkGaoIqUNCOvzknJa3UvrIrChE2bDiU8kNTeKWRx3f9fqgKqB87H59ZWJFYr/PdaOAD4KD+snigAh/a7CZFObY5bhsQQWJuQrbEw2CEk4Y+ZftZmkBxKC8ErDg/2MNHrYrj4UocPYEJ9iy3nukgC/61FbNwEYOXz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1h3sf8A0CgIHV/Mrz/hDjiHhpIrKxHeMkkijg2ivhg=;
 b=ENaaSXIc1SXxRWSAmQ1kw9RtVKRuUDd7ZQBiypYFKiTwixfGImCj2xEDVcdSUZ66z+hjOPX5ObMWI/GKQig928CKu3texSRAmZpSS72WrCSRJoaNH3y+CAR1YOFEtbr1dR0zssFXrPjqIACjWmWo17cYFdriMf4nnZnAVgzPQVW8GgDlVzZ2owSY5HDUQLUS67Fp5fN5THUcyP+nNMT4+/86ssFnkQxrzHSY9s0brYwec9ThbhpsTPyzakOgXvYmhhU4cH864DFdgEdNB2I6LM332GmDtObRzAfltqzN7jmjcN5Fyhet1FjWVPOjfHvG8gWoc2jfWssqScjgGvPQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1h3sf8A0CgIHV/Mrz/hDjiHhpIrKxHeMkkijg2ivhg=;
 b=j4PYoR5Ss9jiMtAWBsMcjSbk9CH4wVq6Vx8wZcJRuhwPInLA9xtf2lVQccvoim1dRWO3Ccv8l2o9pmO6Palz8uexsRfrbzFOIPYJr1cJDI+/Ly43f4mdYkBLcuIhCBB2Glq8F4b7irmuHxwoa6GKc7gahb6+bv34FAiVejbZ5yg=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 24 Jun
 2021 14:11:22 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::181:e51d:a4f7:af62]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::181:e51d:a4f7:af62%5]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 14:11:22 +0000
Date:   Thu, 24 Jun 2021 09:11:11 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 20/22] x86/boot: Add Confidential Computing
 address to setup_header
Message-ID: <20210624141111.pzvb6gk5lzfelx26@amd.com>
References: <20210602140416.23573-21-brijesh.singh@amd.com>
 <YMw4UZn6AujpPSZO@zn.tnic>
 <15568c80-c9a9-5602-d940-264af87bed98@amd.com>
 <YMy2OGwsRzrR5bwD@zn.tnic>
 <162442264313.98837.16983159316116149849@amd.com>
 <YNMLX6fbB3PQwSpv@zn.tnic>
 <20210624031911.eznpkbgjt4e445xj@amd.com>
 <YNQz7ZxEaSWjcjO2@zn.tnic>
 <20210624123447.zbfkohbtdusey66w@amd.com>
 <YNSAlJnXMjigpqu1@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNSAlJnXMjigpqu1@zn.tnic>
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA9PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:806:6e::31) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SA9PR11CA0026.namprd11.prod.outlook.com (2603:10b6:806:6e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Thu, 24 Jun 2021 14:11:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b8f8792-1d28-4b96-4a24-08d93719f1cb
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3925F036169B35BC8429BAEB95079@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DKgEZihJoi+GBcu6nDx/a29cR6OacUwBvKcRSbHvhAA7dmrf3hU2HIE3BkcJ+7xoYxigCUIv6x9fEm2medhgVqFKW0vsAYD/uZG2ucMu/VmOqRyWSciheNRBjSYlPk1SKLKCMfPWz2tmrNU9A5tRyXQNsRpcw3sSiNNylF/ayVGlYAAPEdQ+Msrnb4rimr2ljpbQ2FiHllZeHaIVamd2FGlbgtWpPoGaVLZflVzblLmepYB2BfxEjThnC2p77JEBr1poKA22OuxCNQTlDF/eYheWLLFRczLF+ntuR5BXNiDZYSBs9xGEl992OAJq31ww2eKRS80qslTLCdrRvNGhwJ+WxoD+vCgxWd79w1gd5c2JYgziUTBpYJo3LH2THWjTV7WzsrfAcv4n6ZafEou0mhihhwaulOMH6w8oAxX/p14HUFIGIq/6I/C9dpuLSK2aNLuGVzx++Lr8l/3aL70vhu38K/iS+OlXWoR06+x0g+igKTJhYsq/fE+L74B4DidZTbNALekU+FjdjR6Out1U8GR/3WJHci3cNP063x8sLNFQV9TlXwuPXNPeIZaW/SqB7l3FYH7GpLeVJka34AlxzCzwPLAYPsaXKxX9kRSeJPcxgSQ7unoqKivM0K/4U0GviRZlJtd1WB4aVHaJFHiD/e/Up5KVDNKDad0JkVjXuj6BU8NIdAP6rsd4NlQok97gKLMc8fci2gMfMRaeZrErf1z05hbS7DADciDssXX6YNQvZIpTcAS4F1CjW2uvF3dAbN8UO2dFo4Qo/SouwsvbL87K8Msy7xS9P+LBCV2+AijzwHXR8qr1YycFYpfiwSUoavea30GdAcH+N8Lrd+7RhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(6486002)(45080400002)(54906003)(2906002)(478600001)(6496006)(5660300002)(83380400001)(52116002)(966005)(7416002)(36756003)(38100700002)(38350700002)(1076003)(26005)(6666004)(66556008)(66476007)(66946007)(186003)(16526019)(4326008)(6916009)(8936002)(2616005)(44832011)(8676002)(316002)(86362001)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W2xjVeBi4h/gcCZjJmQlyer8J8MLK+VXM0zr9MRrbCZ+to+mgzrr8/wK6ieO?=
 =?us-ascii?Q?HC1qR5Ko7MHb1i4fW1rAxgmOztLpnENRWSk5lf3w3iHP7VmAELb1cLo6v5wZ?=
 =?us-ascii?Q?qeEBUXTe6qavRy6sY45St33SgIlQoteeeU1sn90KiKnr/7LEIQ1P2M8UiG8H?=
 =?us-ascii?Q?Q5jmxi0TACorntBGsERTeEg45haPVf2ClyXlevHF+5J3k778LA/a2GWaGgc+?=
 =?us-ascii?Q?9w9sU3Jm4ZnMItJP5L3fj96LTWzrkLcMzlPmXPYr5/gobXKqqRamZKbr4WJV?=
 =?us-ascii?Q?S1PF831ZdWXWSSOZm/SlS7mYobBOhiQSBKrOH4ZLNkMLek6wf1iQjE5rgOyZ?=
 =?us-ascii?Q?A3OkewrpQ6GfAJ1jIZ1UYpyyq+K8NQS5jOlJqyw6JEFsazlEPNzGRGeWT4RG?=
 =?us-ascii?Q?FYCObpZhXux038JaKYt+psmX+I+10Kk+ChBqNtST92wjYbVskAalxnawCleX?=
 =?us-ascii?Q?suKBQBwiLsX2v6V86eZ6vvccOkcLpbgSgGXn6qAqQ7k+Xq4JFR+yQD1qfIXc?=
 =?us-ascii?Q?rjhDdkLDjj23Py7Mv/Oi2rlTsTDfw58oxFkO7DuwNAbdG4obUeltbR9LFEOK?=
 =?us-ascii?Q?B33hWU6jysG/lwuiJ3XsDPWCRAL5hF6PGf+51tfcTp2d7Pn4SG6Er39KOsXR?=
 =?us-ascii?Q?hiCJpYfzV9YhMq0xdRWMnVMg5lBheDdaK31/UZkFhpqmXBDpHteOw43YMKg9?=
 =?us-ascii?Q?YqQao6V5/XMpZUjSwwxr5ExIGv9BpCn+qFaOxeE1zdFUR5h5XzwJIjOXLhUf?=
 =?us-ascii?Q?PudY656mQPMsTguVKXj3275RGdSydSyEKcSTO8VQOpjDolfhLm4lV7NhXzkn?=
 =?us-ascii?Q?vHx/ZGJPQ3SzxDMraWkraXxmkojEOrO9ddLxhKq+6OkeFgVOd2m7/QrzjHGF?=
 =?us-ascii?Q?ej3vIi6VsVHEXZg8nElbwUwZtd2VE+QxUOzFb91Zoatn3Nh65lWgVtuwzbIr?=
 =?us-ascii?Q?m77vJt927UdLhZ2StpDQilJOHCi6kXH8HwALMysDdeobvywCTnMdA0PSZxcd?=
 =?us-ascii?Q?cISdIMWJTBRF5reoe5i+dRXMQ+ZGPgW3pnTktJd7q7maRTKZB+6+bRoowhz8?=
 =?us-ascii?Q?ju8YcF59sKt+3q3EjUbeZtueuzOAHYJf+mZf4ONfdTnka2A0ixI6KYKiiGID?=
 =?us-ascii?Q?/fPZr31J6hC/dB2jzMwnJInVCaBptUSq13I1bYl3zC/SiRjWbsn5vsdifGA6?=
 =?us-ascii?Q?XQofv6w1EJlvem/da3QWG9Fe6a3o+ActA2qjMzeDW6Wkultv1I8qZD2UM1/0?=
 =?us-ascii?Q?gbIEEctju/HUBkSO1QanjZvPYEghNwC1bL5xcPJbFFKMa+vi9nfmVCf5tvpI?=
 =?us-ascii?Q?P31pIr4cBNRj8ySxyyKwtio2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8f8792-1d28-4b96-4a24-08d93719f1cb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 14:11:22.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPx4yLxZdv7fqd8g67dIh43OIWapQDwbcdc8hrb7VL6OvHBQc/SRRBAb5UmViZ3EAuYaGeGeLsJmh6AAuyvIHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 24, 2021 at 02:54:44PM +0200, Borislav Petkov wrote:
> On Thu, Jun 24, 2021 at 07:34:47AM -0500, Michael Roth wrote:
> > Well, that's sufficient for the boot/compressed->uncompressed parameter
> > passing, but wouldn't actual bootloaders still need something in
> > setup_data/setup_header to pass in the CC blob (for things like non-EFI
> > environments/containers)? I was under the impression that using
> > boot_params directly was more of a legacy/ad-hoc thing, is that
> > accurate?
> 
> /me goes and rereads your early mail.
> 
> I'm more confused.

Sorry for the confusion, hopefully I can explain better now that I've
had some coffee.

> 
> You're talking about parsing an EFI table early which contains the
> ccblob and in it is the CPUID page.
> 
> Now above you say, "non-EFI environments".
> 
> I'm guessing you want to support both so you want to either parse an EFI
> table on EFI environments or pass the blob in a different way in non-EFI
> envs. Yes, no?

Yes.

> 
> Also, you want to pass the previously parsed CPUID page address to
> kernel proper. For that I suggested to use boot_params.

Yes. (though I'm actually passing the whole CC blob address so kernel
proper can get the CPUID address from there. That gives us the option of
using that field to get at the secret page in very early boot of
uncompressed/proper kernel as well).

> 
> What else?
> 
> How about you explain in a lot more detail what exactly the requirements
> and the use cases are so that we can have a common base to discuss it
> on.

So for EFI case:

  We don't need anything in setup_data/setup_header. We can access the
  CC blob table via EFI config table. However, parsing EFI config table
  early in uncompressed/proper kernel has the complications I mentioned in my
  initial response. This is where using a new boot_params field comes into
  play (similar to acpi_rsdp_addr), so boot/compressed can pass
  uncompressed/proper kernel a pointer to the pre-parsed CC blob so it doesn't
  need to re-parse EFI config table during early boot.

For non-EFI case:

  We need a "proper" mechanism that bootloaders can use. My
  understanding is this would generally be via setup_data or
  setup_header, and that a direct boot_params field would be frowned
  upon.

So your understanding of the situation seems correct.

By bringing up the non-EFI case I only meant to point out that by using a
field in setup_header, we could re-use that field for the EFI case as well,
and wouldn't need a seperate boot_params field to handle the
boot/compressed->uncompressed passing of the pre-parsed CC blob address
in the EFI case. But I don't think it makes a big difference as far as
my stuff goes at least. Maybe for TDX though this needs more thought.

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7Cd913249cd25d44e389d108d9370f40ab%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637601360942853147%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ghw22DdACcxZsfaWd%2FyAuhlr4NwJY8b63bXPvB1MvTY%3D&amp;reserved=0
