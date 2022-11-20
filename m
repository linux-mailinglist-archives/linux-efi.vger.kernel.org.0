Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2297B63122A
	for <lists+linux-efi@lfdr.de>; Sun, 20 Nov 2022 02:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKTBtk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 19 Nov 2022 20:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKTBtj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 19 Nov 2022 20:49:39 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B329B8FAC;
        Sat, 19 Nov 2022 17:49:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu2wg0E7E4quWFOLBI1G5X6Yb1PsD+UmAkjLX9M/2aHFjtrXXqMeW2ZA0xxsTj0R20MwsaKDXVlUg3Vm6or/SHtmKPjC7JJWWqGIBsvIbAqPSbZRc/rUlNha9ZWJR0ogR+Tww/mgjLPFfEkB373fYEslVewrWF4sCYwgW1IH/Mt4a2jALHsPFmcVgGc+YYftEC+cTl9CanvzQL6n2ehTWJ58Hwl/0zqwpHnYrkl6HzId9QTxEGYXyRnWVbnIrx2slrLovGpMh0D9IOeACqKI7pdcHl+j2PZrnSkAHk0LwXSsR2SCNXZrW1a/GE1EzpSjeHqhjbAtmsrII/IL1N5TCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hp9dEtxNs+t2sJlBB417b9lPyVSVf0ifQMEkjAtCgmw=;
 b=Et/+IhptgWGLuBH/Fe0SCtaAGOyVeuTTYvfSCfFzv6tFmEo6q6RvY3IMAmqUVU1B6t9I2o3kK70sduMAOlES/TjUOuV4rUTdaWx7sDXXbHrhnN0bulGlro4hEpcW39ir0WUjzWrLKJ91R1qCU6pa+xEcJ98DqltsoWN2BMOGbY5TnV3zm2tDMSdaysgxp4nqz3wuwFadvBkY4LaEwxgb7rrMHc16OHmgLuq1z5FwRl9tjsmNbx6Fujj3C3LeStductfxFxHiCdzhaLXuSEVtZjdKufiTg5iOV+JX8m2b5WwZl+1TbTfY9O6GakMRM1M+WclaybHKJ1k35GVyCvBnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp9dEtxNs+t2sJlBB417b9lPyVSVf0ifQMEkjAtCgmw=;
 b=eI07cZ7O+cVdu5q1svwuE/1/R3RLXnwX6cltTEoR0VmEXJROTfvzBWO9rFns4avIrJFNLkmd1OqyzfOp7sTyalV9Eanf5wEcbKoGFNTVpsMQpexK8ftTt74DuuxkEL3uVJJYjmvwbdd9+tBs8IinqxZJOVYk6RE6+EdVjuiRquE8Ll+FQCpLgiP0TB7wb5kLHZGm+uqNiGYNdRU49U52hSc+z34FQZYWW6Lt8ioGGmOsmHFWsOcdNdOcn5z4gWoqIpTENmS9zZ7X6lvPhwyeBGK3vFAZXEr1i2ZeZrA8JA9VCXaDEtzpWIFmt3xSqQlYJq3ogmFo427N9V2TarZtQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by VI1PR04MB7055.eurprd04.prod.outlook.com (2603:10a6:800:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Sun, 20 Nov
 2022 01:49:36 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::3cc9:78f1:6e76:b1ef]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::3cc9:78f1:6e76:b1ef%5]) with mapi id 15.20.5813.020; Sun, 20 Nov 2022
 01:49:35 +0000
Date:   Sun, 20 Nov 2022 09:49:19 +0800
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
Message-ID: <20221120014919.GV3967@linux-l9pv.suse>
References: <cover.1666705333.git.baskov@ispras.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666705333.git.baskov@ispras.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCPR01CA0002.jpnprd01.prod.outlook.com (2603:1096:405::14)
 To DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|VI1PR04MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bd8367-8c14-4186-7943-08daca997952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYRqgAI5WClgK/QN6PWJ0Fgl92fJS0+4pZw/xu7WbnGHmQhYM7BVVWV6dFrAxGgLhcpINd83uJ+BcmC3n2hEy3DgNHgdC4kxFgidb3a7Vkyd1jgipeY+NfE8KuOli+uH/3/uR6W5zreb5DgCUMHzPAoHbdmT6wglte7an9pCJYTS7hYn5JKy2XI2Vr2dGVal6liGrq/xGXCll3LUruiuolSYyEa7eoNt1WzPI1ZAsY13H4/jtPtlG00RwCYCwmvHh0YLJJc6uEuaVnjAMZeoR1Eh6Oi+Zf4DGAJJkMjbY/mYHFc892G/yggof4YDAO4S0FuQduVizV2gxB9kbuBxOSVRP4gBNUK7pJybONc5RY2Yk8jkwNZKqJayWYvjOBmehBEaWESOSY9ixjC/G+zBPCEd0PouRhd96SG2Pi1b3CJK7esLm9TBBDV7RcfOftqb09bIXbiXtoICURt2Zrpj70MnvXRi8oKsGdF6JCbDZzuA4d0BUIj6zCZ0kPfVmhb6FipNC1oKq9nBFkbpu5geCHbcz4Ec9u7Tg9S+l/g4UWGS7hmjnVfMm7V617IlGmNjflw7A42b17vitpbW9sBCNPsu7acL3cgh35lxUFCMvX9L/kaCqhcgfMzhRUn8luID
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39850400004)(396003)(366004)(346002)(451199015)(36756003)(86362001)(33656002)(54906003)(6916009)(45080400002)(6486002)(6666004)(478600001)(6506007)(7416002)(5660300002)(41300700001)(2906002)(316002)(19627235002)(8936002)(66556008)(66476007)(4326008)(8676002)(66946007)(38100700002)(1076003)(186003)(9686003)(6512007)(26005)(83380400001)(84970400001)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZXbCpcWn93lOvI8BGNDHKPPCj+einVhgtvpMlxEmN3EQfJb6yYfuP99I9h2J?=
 =?us-ascii?Q?/lej6+Yx/F7uISquoFtr2UWshPRcm15n/wPEKNiExWxfos2os7ncrt6XU82y?=
 =?us-ascii?Q?Hh3hNr0DbwIcpElmpNv6DRSS6Sg/jgNqcbNIUnGpAHG7Hn2nGzqghTSgRMDK?=
 =?us-ascii?Q?xBzJXkmeysuRMffq0dcK2wkr5VVW3aGfz4enTy0CRA8d3YGFN48RntJrrXWz?=
 =?us-ascii?Q?Sszllt0myQLxigc495r3dH3V1Q27/xbONjaLV3OFFyDLQmyqb67v46GZZgUt?=
 =?us-ascii?Q?8J6pBWWDhFd1Gg+Wh5EfjC9IOvTc0p3cqd8SnnTacAruU2iIWNaRqJK0IITX?=
 =?us-ascii?Q?zl/MHkzeMw7zqLeqCMN8dqTrif6MVLEBXd7z562IhZcNe96PoWOAs2fuJWh5?=
 =?us-ascii?Q?+YIbWxUO/2lBi8BGEHfelWbmtYjHzLHbJhW0CXJB1kUBGzMshg7t7BBT623T?=
 =?us-ascii?Q?Za8sau+alXWnZF9wX7jm+Vz53lMSEFs/NHhOHZwlSRU0z7JGcsVAvhEwdf6l?=
 =?us-ascii?Q?8NWEE3258EpXtGwFpH+S7Vck2XbkroGCkBw+4F3y5pcvV8CpFBnr+vu0yGgX?=
 =?us-ascii?Q?vFQUNERSlz8b5Bi3bthimdOYJvc9F2WNvK+yizJcvaUhyb2l6VOhJtciDEIu?=
 =?us-ascii?Q?swEdleFETulEk80DsM7lZT9syfSgM/06e2zWHcAeWFnKuN7Sm0r+tzDfCYcw?=
 =?us-ascii?Q?0eYZ2UKnARL7uBtlgPYxDWFziRAOVZnM9LK31RsSSVuYAcwGNzqQORW5gR3F?=
 =?us-ascii?Q?9n1UpHgp33/iP8lL1YISVQPqQOof3viVXTmrWoU4l4nsLnQ1fbuqpqKDHUVk?=
 =?us-ascii?Q?ZnVxm5RyTuxRR7m++xta7bV5MFbHqMGtjkyYQHZeYae7Rkt0OUKD/Pww7UDo?=
 =?us-ascii?Q?ZK/7wAZxp/xNqVg8CLfFRDyLtD2cFsAMNLGeLgjcsjCcTlo6TrMmFOZe+Lo0?=
 =?us-ascii?Q?wHS+su/X6OW7YhVLHAeX0Mgf6Mv3Yj1TYk/hHHGra9NQrtJl+zgBYmi2esQT?=
 =?us-ascii?Q?g9Cyzp9xbvuW0S8Xn6yTvuuMyRKlM460ute0+H7RA1WU2yDcaRitLOrpmfK5?=
 =?us-ascii?Q?jSXq01kTWeq5Zi2fuPFoWZwbsCOA1th1g8hkHGFkXPnCKWg2PajyIlOw4Es4?=
 =?us-ascii?Q?VeoBr8ykfdf5wtzG/HTWl2Y0u/pCsI3n7eqXx16cqS84Dz+QJ8068vdM73Ky?=
 =?us-ascii?Q?3OvMi0333S3YiTmFsd/yYhNuxIHqMLsxKiN99iAEsyNkHsFSGW7iSoFVZO+8?=
 =?us-ascii?Q?50VCop3N1QQYrd87vXdlpggjPncxt01Vxa5kCPlp/bdg+KkeR0yMy6Y1arUr?=
 =?us-ascii?Q?Y0qb547/rXos+u2dX8IU6F57lz0k0OaEHMalPnIRGhvHOLgU5Qc7PAi+fi/A?=
 =?us-ascii?Q?2OpXdpmkwrlQSY8VQjeKKVyr7IEqPpd4U2vPmwGH20KFFMSKZf/RzuObbUY9?=
 =?us-ascii?Q?2Ni+iUWtQRKDkmAaJyhxpB7fX+euBsEhKQ8DKx+F9uZ7FX7e9+IQDMZox/ey?=
 =?us-ascii?Q?4LYkytwZ7uEbUVfzjKkog7GjLBQmMIQN6QE9/xO16LZbnXPTGKQcgCSIQZBc?=
 =?us-ascii?Q?gmt0HEYqQYu3un4DlR0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bd8367-8c14-4186-7943-08daca997952
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 01:49:35.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQqteQsOMl6u5cUwbaZHNqDZdy82EZnQsgl1ZsQa4LsgesChi0UN5tZil8OEXezN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Evgeniy,

Thanks for your effort!

On Tue, Oct 25, 2022 at 05:12:38PM +0300, Evgeniy Baskov wrote:
> This patchset is aimed
> * to improve UEFI compatibility of compressed kernel code for x86_64
> * to setup proper memory access attributes for code and rodata sections
> * to implement W^X protection policy throughout the whole execution 
>   of compressed kernel for EFISTUB code path. 
> 
> Kernel is made to be more compatible with PE image specification [3],
> allowing it to be successfully loaded by stricter PE loader
> implementations like the one from [2]. There is at least one
> known implementation that uses that loader in production [4].
> There are also ongoing efforts to upstream these changes.
> 
> Also the patchset adds EFI_MEMORY_ATTTRIBUTE_PROTOCOL, included into
> EFI specification since version 2.10, as a better alternative to
> using DXE services for memory protection attributes manipulation,
> since it is defined by the UEFI specification itself and not UEFI PI
> specification. This protocol is not widely available so the code
> using DXE services is kept in place as a fallback in case specific
> implementation does not support the new protocol.
> One of EFI implementations that already support
> EFI_MEMORY_ATTTRIBUTE_PROTOCOL is Microsoft Project Mu [5].
>  

Because Peter Jones point out this patchset to me, so I tried it
on OVMF, and I set the EfiLoaderData in DXE memory protection policy:

Index: edk2/MdeModulePkg/MdeModulePkg.dec
===================================================================
--- edk2.orig/MdeModulePkg/MdeModulePkg.dec
+++ edk2/MdeModulePkg/MdeModulePkg.dec
@@ -1392,7 +1392,7 @@
   # e.g. 0x7BD4 can be used for all memory except Code and ACPINVS/Reserved. <BR>
   #
   # @Prompt Set DXE memory protection policy.
-  gEfiMdeModulePkgTokenSpaceGuid.PcdDxeNxMemoryProtectionPolicy|0x0000000|UINT64|0x00001048^M
+  gEfiMdeModulePkgTokenSpaceGuid.PcdDxeNxMemoryProtectionPolicy|0x0000004|UINT64|0x00001048^M
 
   ## PCI Serial Device Info. It is an array of Device, Function, and Power Management
   #  information that describes the path that contains zero or more PCI to PCI bridges


I applied this v2 patch set on top of v6.1-rc5 kernel, and boot with a shim which
set the PE NX-compatibility DLL Characteristic flag. I got a page fault exception:

Loading Linux 6.1.0-rc5-default+ ...
Loading initial ramdisk ...
!!!! X64 Exception Type - 0E(#PF - Page-Fault)  CPU Apic ID - 00000000 !!!!
ExceptionData - 0000000000000011  I:1 R:0 U:0 W:0 P:1 PK:0 SS:0 SGX:0
RIP  - 0000000076A3C390, CS  - 0000000000000038, RFLAGS - 0000000000210202
RAX  - 000000007D8CCDF8, RCX - 0000000076A3C390, RDX - 000000007DE86000
RBX  - 0000000076A3C000, RSP - 000000007FF0D2C8, RBP - 000000007DE86000
RSI  - 000000007F9EE018, RDI - 000000007DFD1C18
R8   - 0000000076A3C000, R9  - 0000000000000190, R10 - 000000007FF1D658
R11  - 0000000000000004, R12 - 0000000000000190, R13 - 000000007D8CCE00
R14  - 000000007D8C76B4, R15 - 000000007BF0CBD5
DS   - 0000000000000030, ES  - 0000000000000030, FS  - 0000000000000030
GS   - 0000000000000030, SS  - 0000000000000030
CR0  - 0000000080010033, CR2 - 0000000076A3C390, CR3 - 000000007FC01000
CR4  - 0000000000000668, CR8 - 0000000000000000
DR0  - 0000000000000000, DR1 - 0000000000000000, DR2 - 0000000000000000
DR3  - 0000000000000000, DR6 - 00000000FFFF0FF0, DR7 - 0000000000000400
GDTR - 000000007F9DE000 0000000000000047, LDTR - 0000000000000000
IDTR - 000000007F2E9018 0000000000000FFF,   TR - 0000000000000000
FXSAVE_STATE - 000000007FF0CF20
!!!! Find image based on IP(0x7BF0BAB5) /mnt/working/source_code-git/edk2/Build/OvmfX64/DEBUG_GCC5/X64/MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe/DEBUG/VariableRuntimeDxe.dll (ImageBase=0000000000F40E7C, EntryPoint=0000000000F767B8) !!!!


My question is: Can I just set EfiLoaderData in DXE memory protection policy
in EDK2/OVMF to test this patchset? Or which platform (virtual or physical)
can we use for testing?

Thanks a lot!
Joey Lee
