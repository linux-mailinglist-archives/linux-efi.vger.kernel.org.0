Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F36262376F
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 00:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiKIX1s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 18:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKIX1r (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 18:27:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5CE2D76A
        for <linux-efi@vger.kernel.org>; Wed,  9 Nov 2022 15:27:46 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9NPCRA029771;
        Wed, 9 Nov 2022 23:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=aQYGOuov8DxKXV4NSxyMd5mpQ9hOOH28B3dSzayt+sg=;
 b=PX82IFs3QkUf8IF7X6yiZS3nUML76SgKUFTwxOxTP0oogEOCLbMg9Y9KPYs23RD+PoEM
 hZIZz11RrRJpZuzJGGz0lhxn1Jj9D/oovQ+9yX0tV3nTn04QZ2yL3YiNa6ovL/1JIwQm
 ZDC3B3StX5+40Aw/4YPVefBz/xcWj/ZE6jrYFgsPkiakEhItPyuOm72zUT/oFR72BMMp
 Wv5KrJEYRqp5WffQDSFQLRmhJ1YrfFXU/mjhYf//Ovq5827wwrDIsBUz+dmPQO3SC2IS
 mahkWHh6qQNHjN+VgOAfq5+mtSvwJhQQBseXpbcDnMTg2fK3B2QP98dBeYI+x8P6rDeR Kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3krnuyr008-110
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 23:27:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9L4UeW039924;
        Wed, 9 Nov 2022 22:05:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcqj4d6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 22:05:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXJSr5bT0vkpdgmLhL9DKitRuPtbCvFCTjEcTaWkW/0iDZxnWTSxUJBxFtcmyncPnB/HTIQE9wFRRBwnbEV4R1MDZsrHjygbggqlQ5IZ6OoQDCtgl0J9eQb9roU1dm60cjhequg+fori8+NCerhQtEdsXcmtfGgq0V9NnbZToPQb124jKVf9q6BdVkJEpPkm6j0oP6fY16K0E0SGt8ezy1U/nTN5JwkXSdnFBBGJV/mXS7VrlqxkE4qR3rm2w6BpuwEo0F+bRV8ghg7lHiu5fc6SFcluoDGPEBW5X2XpZl0It3WxfSRXWt7R+pBm9G6GId0scXsw1fLgrbCCQ8e9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQYGOuov8DxKXV4NSxyMd5mpQ9hOOH28B3dSzayt+sg=;
 b=hhNEPjXDEXkoY59OrnqKyJL9A0QlcLVicsji3W22aVihNkVodr5qqljPf2xSLkcNq0AQ9vdv/GY6NgAzL5gBqgrQuEfdoXNxkpeleiWbPM5wdPujncjFmxGIYpKceu9OZxFYafmldMUsKQnUVEbzr0A3a+j/SM01HTI3JlaYLHc6FTbfgi6Lm/j82Ngtaf5jz96o/oUnjvvdCdI17GkGF/jDPWWZYku6swMzbfb2GfI9ZAF+pL8xopA8/+UniBrTEJkk/cbNLAAL54gPK+nH2yM7QPSW6q0weqt2m/l6YXMqv9dC86tmrJnVMAy9i9NgdzyFlwyZJU01s349p+GMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQYGOuov8DxKXV4NSxyMd5mpQ9hOOH28B3dSzayt+sg=;
 b=NBTmLwVm9Wnfn4/sRy5Tfc1CkzkO5yAKYnzB6ti9+csVg/TgL2vgFbpXp7dr398p/A0JoRGjX8oAYzuRpA8EV1Urj1hrRMNmAcAPWG9+Oe2hXH8du5E3K2Xz3vTsYRSw4+hLXaAHXagZhdrfqF4GJWkntmN2mVqT+hg2FvrPEgI=
Received: from BN0PR10MB4822.namprd10.prod.outlook.com (2603:10b6:408:124::13)
 by MW4PR10MB6680.namprd10.prod.outlook.com (2603:10b6:303:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 22:05:21 +0000
Received: from BN0PR10MB4822.namprd10.prod.outlook.com
 ([fe80::57f4:23ef:5614:96a0]) by BN0PR10MB4822.namprd10.prod.outlook.com
 ([fe80::57f4:23ef:5614:96a0%2]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 22:05:21 +0000
Date:   Wed, 9 Nov 2022 23:05:14 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, grub-devel@gnu.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>,
        linux-efi@vger.kernel.org
Subject: Re: [RFC PATCH] efi: Put Linux specific magic number in the DOS
 header
Message-ID: <Y2wkGmGEja5hUpZR@tomti.i.net-space.pl>
References: <20221109141611.2788009-1-ardb@kernel.org>
 <594e304d-38f0-ed37-a2a8-7479ff850c8c@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <594e304d-38f0-ed37-a2a8-7479ff850c8c@canonical.com>
X-ClientProxiedBy: BE1P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::11) To BN0PR10MB4822.namprd10.prod.outlook.com
 (2603:10b6:408:124::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4822:EE_|MW4PR10MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: e65cbba6-0337-4e42-62e1-08dac29e7e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1700+aNZnHPFJzoA4iIuWkMaVrbBKTcGqH2NEbnudBRL+Gnfdcswmukr2ehgzcuwuo0RNHIqJDsw2XhIZ4aIB+4tO75nRt1Yru/r7wqGBXxVhehGuNTmzO4R0DgUzd1PuVmv+xAJKLG/6/eie5QM6Iy7hdF/+Zp1tVa5FFBbMPuDEqJHb3aEjb4VSTdKWrrtI1SOUsNkuyRQjkudZDcPiJ0y0d5z6hdIbmD3jES7a5EJCAZ4ipF6JwcmurV+zraac0Yy7iadd7zJlxV39S5jSFDRg/Wz1qlAxTyJklRtZsSzuaUpyNUGjaR6AjuQRY5yrA4TBlWuOOWWHdaL7iVpPZ+lBL5Kn00OfE1aUYGu/z1MpiaMVUi9A5vLBg8/ebY7j42eF0TCpnc0JRSDjDkHloWvDHnvmDtprxM0F1qbAePh+MEpK4cc6GMzIO+HkT2FPHD1/PYuiNhRWMNehL9Hko8LsEO3nHh4UuwKNRsXwP9dDQwA5ogLRbShJt2gI4NGT7YLPAEjqxdgRa3DZa9J7jbQUmDgMZpVrUmm2uxaFKOdU6ws+CmWrid6nWDtO/XVHC9iTdjuPW8ZUjxeXdxQrZQjY0sZbyEamBkd72nUAYFTL/LOCdO8x3jfVTNcPGsjT/mJeGDv5y0KpZpALHOUwNJMFlj7yaLmvsXQsiL200C3m25n2Sjw5DGadnAAuzwyL5EMM+FbGetI8AM8SdOaS/u5+wrSHuwp40+jxsS6UeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(54906003)(66899015)(316002)(8936002)(5660300002)(66556008)(66476007)(966005)(26005)(6486002)(83380400001)(2906002)(186003)(8676002)(44832011)(66946007)(41300700001)(478600001)(4326008)(6916009)(38100700002)(6512007)(53546011)(9686003)(6666004)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HL75EU7ojmOjNlEgTCL4x+ABVm0pSvgTzetLDIQeCi7pn3hnxFq3TOvwmv/U?=
 =?us-ascii?Q?jBl/qs2IP8lspanV69fzLI2Nw1sotvU4OZP5tGbkUQds5ofytKbAOdTQfbwQ?=
 =?us-ascii?Q?Uq5pFxslNk/JgSwQO4vgCBYTqUReNNBQ/fGmIYfd17nRuNE6Uf1y70LhaAQW?=
 =?us-ascii?Q?H7gkt0r0JbzClpXEKcnII5NFE3899nbJJeflOmB1S/RMThjkSlmmvZtnYHD/?=
 =?us-ascii?Q?K+qQRaiJz3EpBSylBb3t89MmJtxoI0dKHvABWinpuPCeT/eZv8r3BL+JZSwi?=
 =?us-ascii?Q?XhCruVdSSiD1zmsirag0JOYyAaVF2zIcxH2zK3CGVuC7Z/wN1U1W9j6mIUpo?=
 =?us-ascii?Q?QSGeXgHGSTrAimJheynHukqb3qlD5H0+2cxNgEQtcBywQ+c2zXjgvoMHqwQ2?=
 =?us-ascii?Q?QFuyCKWa6oy4dYZLRW4kfBEwunnLMI4VMNObxoncwaCyGxVXMa14PkvLe/59?=
 =?us-ascii?Q?sqzy1b6atX2t4597yOfk9j22E9sD6gErCDnL2evXb0OvT+OqMuGWpkVghZ1S?=
 =?us-ascii?Q?3X4R6AvE2Hdh3htTxpN+7m5nA7p1KsBIxSvQ/WF/DMx0n1mBn7i8uAluMZbi?=
 =?us-ascii?Q?Bv6gRleFgW7fOtOVQmZiOKbWNycIFsfG8JKf9tWFYpYcLO/oEPPvnBkXO0iX?=
 =?us-ascii?Q?b4CnqtWd9X0VdASTlMGQitQIxF8wjieR+ynUU9bmVQYBE9GAjm1MSCR9LLrU?=
 =?us-ascii?Q?qwhE/Lkqaxc6tdUXTbr5nTdxKxDqQsapau6sb3e1I3bsfoxD7pT1GuQVq9ey?=
 =?us-ascii?Q?CFg6trmGsHrP9z48HbrspdUQMdzxk1uGI48B89kcQxE4tsZWfo5m78vF/WiB?=
 =?us-ascii?Q?GmezNOQmgXjNCWVzgOeZEbmdRsNqN64GGhUnvWUGme3aZsdwe4BfCm7fY2h3?=
 =?us-ascii?Q?gvKUmZQdoNJYzSNruEGB9SqjDki0E3YLafQ4B5sOOqnIJbfG3PX/UlclcNmp?=
 =?us-ascii?Q?Eth1ztUxqOPYBANpDtvxZwFShgRVFoY/IVAR1xMUZvQ2HNpMYtZyRdGvsXJy?=
 =?us-ascii?Q?90MXVS6XRmpkv33ETYkbYUJIwNJ0/t6Rqz/H1LM/XAvPsnJBit1ax6knXFSW?=
 =?us-ascii?Q?XvS+ImMuTOmqX1r/NOIOUCDlc9qFkg3ortW9AN2Q+xtA64+UY6Kzo9fDR/Cs?=
 =?us-ascii?Q?Z60mnnwuVFOtov1SbiompPWozlpUJhYuqkrQVGy8K3bs/8zY3s8sr9UINRQ3?=
 =?us-ascii?Q?d2oKhrzFUXeqmyVIQtYxmaD0Fe5gI+lZyQcLjs26pbc1ZuYuNn3B+7FTPD+q?=
 =?us-ascii?Q?5hIRTdguNocyJ4QCf/BsTpXAUTgUTmc8mM5ah6u6pUecoSZbhOm5QSiDHsv3?=
 =?us-ascii?Q?YdqXTqTvo6Iy6vDugxitDkA0khcS0Ai3/USUxr8o+Wu5soviy1GvipHAj909?=
 =?us-ascii?Q?xQQHOI+EGJHDx7Cpl3jxzLJi1OhAsnqZAZKycq9k94/FrmAbAAPxlOtfGAZB?=
 =?us-ascii?Q?YFeFPCyLH5nsaQUXAld5lHU2Vawj/M+9cwCFUu9Cp4nGG9KdDxE3xk7tuKyS?=
 =?us-ascii?Q?QY1nhU3LDp3GOubaJT4+7eBIdj1CH9/c8phtMA35Jn68acRZXlwQ04DgwyDO?=
 =?us-ascii?Q?pqycxUYfNrTJ37iGmOqv8sprjpeljzLaPgx1p5Uw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65cbba6-0337-4e42-62e1-08dac29e7e9e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 22:05:21.5338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQzyWsvSqEc1K24HY3GbD6EGE0fRiXvnxGSwosGoWWFsWLrT0UrYcdfE2yictPIQwaa0CWQ3OKaP/PmnklGUJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090166
X-Proofpoint-GUID: PozJ-Xk7y9KWrbogkTyh7Khp1twd-22w
X-Proofpoint-ORIG-GUID: PozJ-Xk7y9KWrbogkTyh7Khp1twd-22w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 09, 2022 at 04:01:27PM +0100, Heinrich Schuchardt wrote:
> On 11/9/22 15:16, Ard Biesheuvel wrote:
> > GRUB currently relies on the magic number in the image header of ARM and
> > arm64 EFI kernel images to decide whether or not the image in question
> > is a bootable kernel.
> >
> > However, the purpose of the magic number is to identify the image as one
> > that implements the bare metal boot protocol, and so GRUB, which only
> > does EFI boot, can only boot images that could potentially be booted in
> > a non-EFI manner as well.
> >
> > This is problematic for the new zboot decompressor image format, as it
> > can only boot in EFI mode, and must therefore not use the bare metal
> > boot magic number in its header.
> >
> > For this reason, the strict magic number was dropped from GRUB, to
> > permit essentially any kind of EFI executable to be booted via the
> > 'linux' command, blurring the line between the linux loader and the
> > chainloader.
> >
> > So let's use the same field in the DOS header that RISC-V and arm64
> > already use for their 'bare metal' magic numbers to store a 'generic
> > Linux kernel' magic number, which can be used to identify bootable
> > kernel images in PE format which don't necessarily implement a bare
> > metal boot protocol in the same binary.
> >
> > Let's set the generic magic number for x86 images as well: existing
> > bootloaders already have their own methods to identify x86 Linux images
> > that can be booted in a non-EFI manner, and having the magic number in
> > place there will ease any future transitions in loader implementations
> > to merge the x86 and non-x86 EFI boot paths.
> >
> > Note that 32-bit ARM already uses the same location in the header for a
> > different purpose, but the ARM support is already widely implemented and
> > the EFI zboot decompressor is not available on ARM anyway, so we just
> > disregard it here.
> >
> > Cc: Huacai Chen <chenhuacai@kernel.org>
> > Cc: Atish Patra <atishp@rivosinc.com>
> > Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > Cc: Daniel Kiper <daniel.kiper@oracle.com>
> > Cc: Leif Lindholm <quic_llindhol@quicinc.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> > The idea is that, with this in place, the existing arm64 support in GRUB
> > can be made generic, with the arm64 variant of the arch image header
> > typedef being made generic as well.
> >
> > Any code that attempts to identify EFI images as kernel images should
> > check for the arm64, RISC-V and generic values, and if the latter, look
> > at the PE machine type if it wants to know the architecture.
> >
> >   arch/loongarch/kernel/head.S                | 3 ++-
> >   arch/x86/boot/header.S                      | 3 ++-
> >   drivers/firmware/efi/libstub/zboot-header.S | 3 ++-
> >   include/linux/pe.h                          | 7 +++++++
> >   4 files changed, 13 insertions(+), 3 deletions(-)
>
> We need files in Documentation/ that describes the meaning and value of the
> field per architecture.
>
> We already have:
>
> riscv: Documentation/riscv/boot-image-header.rst
> arm64: Documentation/arm64/booting.rst

I think we should add something to the Documentation/x86/boot.rst too.
Probably in or after "EFI Handover Protocol (deprecated)" section.

> But other UEFI architectures are missing.
>
> Otherwise I am fine with the change.
>
> Best regards
>
> Heinrich
>
> >
> > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> > index 97425779ce9f3499..e1deea93aaafa069 100644
> > --- a/arch/loongarch/kernel/head.S
> > +++ b/arch/loongarch/kernel/head.S
> > @@ -25,7 +25,8 @@ _head:
> >   	.dword	kernel_entry		/* Kernel entry point */
> >   	.dword	_end - _text		/* Kernel image effective size */
> >   	.quad	0			/* Kernel image load offset from start of RAM */
> > -	.org	0x3c			/* 0x20 ~ 0x3b reserved */
> > +	.org	0x38			/* 0x20 ~ 0x38 reserved */
> > +	.long	LINUX_PE_MAGIC
> >   	.long	pe_header - _head	/* Offset to the PE header */
> >   pe_header:
> > diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> > index d31982509654dcb1..9338c68e7413d6e6 100644
> > --- a/arch/x86/boot/header.S
> > +++ b/arch/x86/boot/header.S
> > @@ -80,10 +80,11 @@ bs_die:
> >   	ljmp	$0xf000,$0xfff0
> >   #ifdef CONFIG_EFI_STUB
> > -	.org	0x3c
> > +	.org	0x38
> >   	#
> >   	# Offset to the PE header.
> >   	#
> > +	.long	LINUX_PE_MAGIC
> >   	.long	pe_header
> >   #endif /* CONFIG_EFI_STUB */
> > diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
> > index 9e6fe061ab07a008..97c2637337d79913 100644
> > --- a/drivers/firmware/efi/libstub/zboot-header.S
> > +++ b/drivers/firmware/efi/libstub/zboot-header.S
> > @@ -20,7 +20,8 @@ __efistub_efi_zboot_header:
> >   	.long		__efistub__gzdata_size - ZBOOT_SIZE_LEN	// payload size
> >   	.long		0, 0					// reserved
> >   	.asciz		COMP_TYPE				// compression type
> > -	.org		.Ldoshdr + 0x3c
> > +	.org		.Ldoshdr + 0x38
> > +	.long		LINUX_PE_MAGIC
> >   	.long		.Lpehdr - .Ldoshdr			// PE header offset
> >   .Lpehdr:
> > diff --git a/include/linux/pe.h b/include/linux/pe.h
> > index 1d3836ef9d92dcd8..fa176c24167c301c 100644
> > --- a/include/linux/pe.h
> > +++ b/include/linux/pe.h
> > @@ -31,6 +31,13 @@
> >   #define LINUX_EFISTUB_MAJOR_VERSION		0x1
> >   #define LINUX_EFISTUB_MINOR_VERSION		0x0
> > +/*
> > + * LINUX_PE_MAGIC appears at offset 0x30 into the MSDOS header of EFI bootable

s/0x30/0x38/?

However, it means you go into reserved part of MS-DOS header [1]. This
should be safe here. Though I think it should be mentioned in the commit
message and/or documentation.

Another question which bothers me is: why do not use "OEM identifier"
[1] and "OEM info" [1] to achieve what we want? IMO this would be more
natural but on the other hand both fields are not well defined...

Finally, current approach do not allow us easily encode info about
images which support more than one boot protocol. Maybe not big deal at
this point but I would ponder on it at least a bit...

Daniel

[1] https://wiki.osdev.org/MZ#PE_Extension

> > + * Linux kernel images that target the architecture as specified by the PE/COFF
> > + * header machine type field.
> > + */
> > +#define LINUX_PE_MAGIC	0x818223cd
> > +
> >   #define MZ_MAGIC	0x5a4d	/* "MZ" */
> >   #define PE_MAGIC		0x00004550	/* "PE\0\0" */
