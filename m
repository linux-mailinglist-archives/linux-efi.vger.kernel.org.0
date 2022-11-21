Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01ED631D0D
	for <lists+linux-efi@lfdr.de>; Mon, 21 Nov 2022 10:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiKUJmT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Nov 2022 04:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKUJmS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Nov 2022 04:42:18 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1266593712;
        Mon, 21 Nov 2022 01:42:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnQDHuEGtzHtsygBYSf5jRZa94RvGMpSZ9V7lbZLn6sAGYy789OjqSJrmoaXFv7XYduKyRIm3H9GxpgeG77LpL6cwRbwkO6/VO8IkR+8Zcv94xJOinh9JTkDs3p6+TkM4uwbimyFcsteLbrkjjtCePSqY6fYsOatCjLjZJUJDhsHdljsFdkvObBTJaxFogWX2X4I+qu0VgCTch8SIwrCWiyud40m0vnelRKnEMVQE3/VyaAkFkzNsecoWeWqK9uwl5fpEQzHbGLTL2dFRn+IJjt0izIh50NPvIy99Fn4KMIA33CgSILWq+xIGXOIzPKVOlCZV1YQo0d/mlsoahyRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5/uyf/g301nGqMRQDJv9c9Z6XN/Na8HIJY5bm+B+WA=;
 b=gqp66tXK3yrCEGheeYIKmxgXxrV2A8SfrajBJT+dQVdlmqs4Oo0cDCbzjg4b2Hkm35OQ0pxBTQdM/0fUJas78mx/uOY2frM3FaIYBOmqwByAuQLaeRuhJm+a+7gDTO478/loO4altHpv6eDMoePlKdBySUAfQ3/h6tAr1Y1HyC/7Hkz4OF3MuMDOGuoe2C3vnYD1DRZzV25hKTiQXUfHDl61VoX3QJEogTEbQPNV0K9SjWdwuL32QJSsHtk6G62gg8l7Xnq/gZ1pcmixgwIupuakSRpUIVMKm5N12zMWz6NUspknB2tsdb0b/y0c1r8tPZ/1JFXpIpDYI7BnfLInFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5/uyf/g301nGqMRQDJv9c9Z6XN/Na8HIJY5bm+B+WA=;
 b=2uDT2mm8tWwwUz7goQTDJX23xtV71dM3AsWiofKZwjjFHXrC6Qt978MBTLeIlR9xgXcBiN1ixsbKh2djJAUMjQouIIgrBheLatR0yHE+awxT61Wx3PqGdxvNeJloGwF/9t+cGEMPSSg6ME9rFU+6PlKzREhOc2mfp0cmPxYWUdBaKXM4N5EhyzJDDbAfzdT33vxuJHzImzuqEwChJOdQ8OSFIaEMNLAicTGF/B0KUoHuZJ79mWUy9Zi84/ILJw2ftkd3W9a2rcURbYnCTvGhr/odLDiZurytFsjnFdlsZfB/qrTAJSyDWwhy9R/6zMfttpK++AdkSMOx/I+XEinymw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 09:42:15 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::3cc9:78f1:6e76:b1ef]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::3cc9:78f1:6e76:b1ef%5]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 09:42:15 +0000
Date:   Mon, 21 Nov 2022 17:42:06 +0800
From:   joeyli <jlee@suse.com>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 00/23] x86_64: Improvements at compressed kernel stage
Message-ID: <20221121094206.GA3967@linux-l9pv.suse>
References: <cover.1666705333.git.baskov@ispras.ru>
 <20221120014919.GV3967@linux-l9pv.suse>
 <50aa7df3f34f55ec435c4f489d8f3df3@ispras.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50aa7df3f34f55ec435c4f489d8f3df3@ispras.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|DBBPR04MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d120ff-63d9-46de-3348-08dacba4ac00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xu1cBaX/sAJccDihFsiXxN1Dm5ASG7LW4mUhOO9RHsI8cs8lTG+4WdqWt1dZzEifHr7Q7AVfoWcDBcBdu/hXGtpiIvKwTxUFq+jZqabl6Z2MO1DHfl+1mWBJGVXuFpsxZWWi7s4Nup1z3AJZ+S0Jwyk65cdpG7tp3+VSJnQONXxjZeKJy7MmRG5bvMQ+lrlgLXkTOGvnZnLmkiLLNULxpmPplBEYSxi4XTt36VgWO/NDN+A2WfcQVZZ6fwXQtbni0seNwTW6qq1bocqCsHE1agRslPAAHDmaFL746KB+2cw4cxXkn2ci0MIB6+9/ZjzPI6McIDatxeG2yPP6xCtb4l87XPMuzuncoZSbS7TNaGUvW6wWrW5OGoY1+qPZqWiX4oMvllHcdNmcwBZmODaIUCi6rvOs4MzOV837giDl3Z5Ts5czavxs21Dz13jyGG2LEDHLNpZ4ABn86nWW85Z772Ntmzd5zuYRBmPAE2qd58F2y2Objv0jPgsRPBNa/9uKg+7jXwiCPS67xVerUgkPbvUcToHh8zfLFHLtkxAPiBVeVlAB11v5ZVHxoJ+6YZCqgoh/hGQeYAe9z9eNZ9RyQFalIQX1c5ejOq/uGidQv5dlOORImzPGd2LXF9AyEZM0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199015)(86362001)(36756003)(66946007)(66556008)(41300700001)(66476007)(33656002)(8676002)(1076003)(4326008)(186003)(5660300002)(8936002)(7416002)(6666004)(478600001)(26005)(6486002)(9686003)(19627235002)(316002)(54906003)(6916009)(6506007)(53546011)(38100700002)(6512007)(2906002)(4001150100001)(84970400001)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5couVqSnmfx60vz8qwlMDO4s1vi1wy3Z1N95K8DS67sop9T/k6JppO7tnvvr?=
 =?us-ascii?Q?Hd5a7ddQHx0SNzqHFblHT/rDQ+q1EI6GkzNbA6yAEIWmhdapR7WYXNJOW/Sr?=
 =?us-ascii?Q?9+GPhR03h3Vj/8iTK2Nua+4SUO7GQdeS6LKdi32ytFozWT2Oe+uQGQ5KWZtu?=
 =?us-ascii?Q?fHtesths/LASCPlO8SzCIHys+ByiomEv6j7fiBhSWS0YjUFjwoeeuPitj7G7?=
 =?us-ascii?Q?oIF4Wg38Tq6pSk6jV7xI/IZkdIxrGS4m0GyKgoKEQgNSXXwHCaYtiRU36FwB?=
 =?us-ascii?Q?LJRaaphR/1rAy3boX+ZQf5yd/M70sSo5rB6v6TZTGk4cjqB6BgPS/qTg8Wrr?=
 =?us-ascii?Q?wdVIYgEp6zUXfTrnI/H2XnqDvFOAMGAP+FrpJWfIlcF1T8jj4h6TXhN5aYTX?=
 =?us-ascii?Q?Ygb54RbekIFOKsWsnZtFs00OLXWwDGsXjOXkDY3gwp9TU5bsvVLaIqxvGCCl?=
 =?us-ascii?Q?1R2LsJpV3sLg8A4zWam3pSJCeMmgwfA6LoR8m6TKtY/J542WLgXtHoeaEsYP?=
 =?us-ascii?Q?oGHD2OS8eFaBxJXbemac31mmKow7Ko2DliSrwnrfuWnTcNoK94FpNZoYSSZu?=
 =?us-ascii?Q?LDW4qkEQIcAAvVPwTssDX3+t5qyDV1sHcKUW3B6qShdjgVN5ktUPEDHKrzFM?=
 =?us-ascii?Q?NI4vnNnNP9pAirC9fKjRIVIdsrJgPdMHV0Y+aMuCW94OKPQSn8AejfzqQLjg?=
 =?us-ascii?Q?RRjtP1pgcH/sUTZgHUN6r9HAK63C+JYKhJTO1zcm/JXgHRmd5Nz2vZcRDtIm?=
 =?us-ascii?Q?YNAh0Ao/rizr2H10sCCkIduE0yVXG+RO6TgSYeZHcYIC1Y8ryl+0/J3DIZ7N?=
 =?us-ascii?Q?A56482ogP6By9GgdVtfOdJ4S/WbZsM+1+zYVmeG1C8Jhd0r1JYRMXhSQ6k1I?=
 =?us-ascii?Q?5jIIgDkHFWK8CT0XY32Zh4mF73/PQBuUXCZnkJFTFRyN4d83peS3PX42aFkh?=
 =?us-ascii?Q?1gilsOanlRxl0UVT9/Y5w4bVm5dyTZurh61DIXkH4v03CMs4pG3fiZsEEMwL?=
 =?us-ascii?Q?eVjf5NJVzHXPDzP8RZA3iACXoYWg9YaA7DzipjZueceSdM+LfcrxQrmI0oCr?=
 =?us-ascii?Q?6c752yY7Zd+qy/v8CLVz82Ocs/ILaEgK5ef7oYuTUmfFPDuM5Ib7GtXVweIH?=
 =?us-ascii?Q?LRrvpuv1K/OOFXKmA+PPCe9Vag0CyYa8FxsHvzS+DasNAiLwHxLQIBv7Bfoo?=
 =?us-ascii?Q?HZs3ErOTOgXGqDu1C64auNekHCETKgWlddqKPPKwNSegW2sSDmgNxifUZd43?=
 =?us-ascii?Q?u1GOWZokdUPw3RDGEuM+XclyZF5ogD51xed4oUclcgfwqsRDIcHNZ62ptwqn?=
 =?us-ascii?Q?ylQ8Jm5qjwPcQWC7jb3eW3Rpv4nqr9AVhDFgPxybfFA3Q52AfXWEVBmcOzJh?=
 =?us-ascii?Q?NOUp/bYPSL0Ws7az2rSNJUHPwSV5L17mdhdnUOEyRcC5ggNjHQn0Z3cCq7zQ?=
 =?us-ascii?Q?IzurnCdeU9tRI/ly9PSsLzjneWE1+wI3ihHtjdpchQnf1l0k5OVcUl99rp34?=
 =?us-ascii?Q?AeqS3fZInWIWiceD1Fw1CsfYS+wEjN9Wrpx8EQAu8JuJYQEm11v8EDFrNrk3?=
 =?us-ascii?Q?mWZSRMleFvprepDtGEw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d120ff-63d9-46de-3348-08dacba4ac00
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 09:42:14.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tc1viM41jw3MoOijy6X9cCSLRG6rffVCxMzTPPWebvaZyVSiy5yGf7/Md5j436F/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Nov 20, 2022 at 06:37:40PM +0300, Evgeniy Baskov wrote:
> On 2022-11-20 04:49, joeyli wrote:
> > Hi Evgeniy,
> > 
> > Thanks for your effort!
> > 
> > On Tue, Oct 25, 2022 at 05:12:38PM +0300, Evgeniy Baskov wrote:
> ...
> > 
> > Because Peter Jones point out this patchset to me, so I tried it
> > on OVMF, and I set the EfiLoaderData in DXE memory protection policy:
> > 
> > Index: edk2/MdeModulePkg/MdeModulePkg.dec
> > ===================================================================
> > --- edk2.orig/MdeModulePkg/MdeModulePkg.dec
> > +++ edk2/MdeModulePkg/MdeModulePkg.dec
> > @@ -1392,7 +1392,7 @@
> >    # e.g. 0x7BD4 can be used for all memory except Code and
> > ACPINVS/Reserved. <BR>
> >    #
> >    # @Prompt Set DXE memory protection policy.
> > -
> > gEfiMdeModulePkgTokenSpaceGuid.PcdDxeNxMemoryProtectionPolicy|0x0000000|UINT64|0x00001048^M
> > +
> > gEfiMdeModulePkgTokenSpaceGuid.PcdDxeNxMemoryProtectionPolicy|0x0000004|UINT64|0x00001048^M
> > 
> >    ## PCI Serial Device Info. It is an array of Device, Function, and
> > Power Management
> >    #  information that describes the path that contains zero or more
> > PCI to PCI bridges
> > 
> > 
> > I applied this v2 patch set on top of v6.1-rc5 kernel, and boot with a
> > shim which
> > set the PE NX-compatibility DLL Characteristic flag. I got a page
> > fault exception:
> > 
> > Loading Linux 6.1.0-rc5-default+ ...
> > Loading initial ramdisk ...
> > !!!! X64 Exception Type - 0E(#PF - Page-Fault)  CPU Apic ID - 00000000
> > !!!!
> > ExceptionData - 0000000000000011  I:1 R:0 U:0 W:0 P:1 PK:0 SS:0 SGX:0
> > RIP  - 0000000076A3C390, CS  - 0000000000000038, RFLAGS -
> > 0000000000210202
> > RAX  - 000000007D8CCDF8, RCX - 0000000076A3C390, RDX - 000000007DE86000
> > RBX  - 0000000076A3C000, RSP - 000000007FF0D2C8, RBP - 000000007DE86000
> > RSI  - 000000007F9EE018, RDI - 000000007DFD1C18
> > R8   - 0000000076A3C000, R9  - 0000000000000190, R10 - 000000007FF1D658
> > R11  - 0000000000000004, R12 - 0000000000000190, R13 - 000000007D8CCE00
> > R14  - 000000007D8C76B4, R15 - 000000007BF0CBD5
> > DS   - 0000000000000030, ES  - 0000000000000030, FS  - 0000000000000030
> > GS   - 0000000000000030, SS  - 0000000000000030
> > CR0  - 0000000080010033, CR2 - 0000000076A3C390, CR3 - 000000007FC01000
> > CR4  - 0000000000000668, CR8 - 0000000000000000
> > DR0  - 0000000000000000, DR1 - 0000000000000000, DR2 - 0000000000000000
> > DR3  - 0000000000000000, DR6 - 00000000FFFF0FF0, DR7 - 0000000000000400
> > GDTR - 000000007F9DE000 0000000000000047, LDTR - 0000000000000000
> > IDTR - 000000007F2E9018 0000000000000FFF,   TR - 0000000000000000
> > FXSAVE_STATE - 000000007FF0CF20
> > !!!! Find image based on IP(0x7BF0BAB5)
> > /mnt/working/source_code-git/edk2/Build/OvmfX64/DEBUG_GCC5/X64/MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe/DEBUG/VariableRuntimeDxe.dll
> > (ImageBase=0000000000F40E7C, EntryPoint=0000000000F767B8) !!!!
> > 
> > 
> > My question is: Can I just set EfiLoaderData in DXE memory protection
> > policy
> > in EDK2/OVMF to test this patchset? Or which platform (virtual or
> > physical)
> > can we use for testing?
> > 
> > Thanks a lot!
> > Joey Lee
> 
> Hi,
> 
> Thank you for testing!
> 
> The EDK2 OVMF with adjusted PcdDxeNxMemoryProtectionPolicy
> should work with the kernel itself.
>

Thanks for your information. And yes, I have tested v6.1
kernel with this patch set success by direct booting EFI but
by firmware's EFI boot manager
 
> As far as I can see from my testing with EDK2 OVMF, this
> #PF occurred inside GRUB code before the first instruction
> of the kernel. You can try using GRUB master branch, where
> allocations are changed to use EfiLoaderCode type and with
> PcdDxeNxMemoryProtectionPolicy=0x0000004 it will still be
> executable.
>

Thanks! We will check new grub2!

Joey Lee
