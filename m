Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8078A337912
	for <lists+linux-efi@lfdr.de>; Thu, 11 Mar 2021 17:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhCKQSw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Mar 2021 11:18:52 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38334 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbhCKQSv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 Mar 2021 11:18:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BG4jcZ105882;
        Thu, 11 Mar 2021 16:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=KtyHqXPZ79ESYGuOnnUO2z6qlSzVyQrw30syJeyKTUU=;
 b=ApTf9r4a5KEdGpLMPwV77hrqNNu4B8byGHmAJKSDoGArs2NiV7vq9PdsqAlpmSF+g6+i
 h5Z5Xe2/iDh1aRoh0NVb3vxGFbCEh9w3ugZt9iMupNoMK20/qYccTh5V908nwUh6Ldi+
 HQ0AS72KCz6wViZdjJusxa+kSOS/cn5KJ26hC/3ELfUB5NOwKdZDWHG4BFL3D8Oi7zTr
 pOu70cs6Kq25lNpUXjFk8o8sUcKt3axZimRoYlBD/xiNHIzE306JdR0HnELskAJIy5Lm
 1T0Bvfm83uYE/NBGBnPm4f6Ykrvr1Wx+GbbUVMvyrtyWwCEbmxIK2So634qddFkgfBNT JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3741pmq4yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 16:18:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BG5btD128444;
        Thu, 11 Mar 2021 16:18:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 374kn2r6w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 16:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KepDBG2A6fO2uqHgBdJ4o6WzXzH59YcmrzTf1q+RQtqKnNrZfOrgCmG+vXR6wfj4ysX1492pAC2yrOPmr5sk0zcE9D2K/CxfugtKHH2UHKaUcoNAKj/+i002emRbWXsqNdjSNGgqniUHpZ5awBaf9/o2l+S/8gd746v2G5ep0JzjkOl/WMYXYehb+JJA/DqYC04juLlnbUuKox8kKTE1Cg/D5s5Of4vZroFDo+38hI8twvrGbk6P9DyqapQA+7+TkQNZjwOSNSxQbwEgCPdPB9xTh1nzl2wHKqQoWt2NywuPOgyhxqrN0uDDined93Sbxzpvqp7bR+HqXoBVCyKBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtyHqXPZ79ESYGuOnnUO2z6qlSzVyQrw30syJeyKTUU=;
 b=f0MaPKbUeK2dzI7l7z4LC+kldwLopFazV6DqgHFjVyyWQOIrNnd6Rj2tEQKA3jszcdy8TtmJJ3BfOYeGvcYposTIRAfNzbTXc/owMBYv+tGo7l1Qh6Jbum7pnL22NhkVaVzH8UO+uKnS0gKDfuAa9P00UxLqaLwFj72qDaP2Ol5tFHO7MOvD1cnm2Xvl8TJOreEPK8DhGmlcxdz4a4hTGN++jyRg6JXxBZB6iPV8GtGG0J8e/F9MTiB/E2bUpv7e6YlKrrvPGbRzDOBDfCiJGTHKaJteOFlPWMJ9ba0pUprTFOsDgL6tYqqYCUTjptoZ9fCT8AmOJ+tQIMIRS45BqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtyHqXPZ79ESYGuOnnUO2z6qlSzVyQrw30syJeyKTUU=;
 b=Ja0cKWhJOWq4sI0iM0ENcB71fKCb0birvY9E5E7ZP+tqV+iEqrNzaIf5Ofz5kztaZk4/cfEzS9XxqGOa7MelrC34ia3Z1iBHHk6Uy6hUCbPgOL4ygw0VCLZM3at4gRGkrKb2sPwcVmekxCBdqVt+bgnnZ3rTaA1PL4kdmguY3lo=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR1001MB2228.namprd10.prod.outlook.com
 (2603:10b6:405:2e::38) by BN0PR10MB5317.namprd10.prod.outlook.com
 (2603:10b6:408:127::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 16:18:20 +0000
Received: from BN6PR1001MB2228.namprd10.prod.outlook.com
 ([fe80::a06f:8b3f:14dc:8af5]) by BN6PR1001MB2228.namprd10.prod.outlook.com
 ([fe80::a06f:8b3f:14dc:8af5%3]) with mapi id 15.20.3912.031; Thu, 11 Mar 2021
 16:18:20 +0000
Date:   Thu, 11 Mar 2021 17:18:12 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc:     linux-efi@vger.kernel.org, grub-devel@gnu.org, leif@nuviainc.com,
        javierm@redhat.com, pjones@redhat.com, pmenzel@molgen.mpg.de,
        dimitri.ledkov@canonical.com
Subject: Re: [PATCH v2 1/8] linux/arm: fix ARM Linux header layout
Message-ID: <20210311161812.mc3pqxvxhaq4dt3l@tomti.i.net-space.pl>
References: <20201025134941.4805-1-ard.biesheuvel@arm.com>
 <20201025134941.4805-2-ard.biesheuvel@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025134941.4805-2-ard.biesheuvel@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Originating-IP: [84.10.22.86]
X-ClientProxiedBy: AS8PR04CA0099.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::14) To BN6PR1001MB2228.namprd10.prod.outlook.com
 (2603:10b6:405:2e::38)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tomti.i.net-space.pl (84.10.22.86) by AS8PR04CA0099.eurprd04.prod.outlook.com (2603:10a6:20b:31e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 16:18:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af2f58f5-2c1d-4f1c-1dab-08d8e4a9492d
X-MS-TrafficTypeDiagnostic: BN0PR10MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN0PR10MB5317E4CF0DCCAF2AC26895C5E3909@BN0PR10MB5317.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jd62jBij5vFZhymDLRr2NxACth5hzPAGAeIVGCvAttFPHnggtQgiOqLOtkRAX9U7wypi4GPWsxnCcLyE9/+CRacvPXWP/Nj2z8Zjt45DUwhYjiLd/3XtmGOT3YRv8VB6jNGC6I8gcvYszPVjD29QPT8WjQQjAsRElBK52uyBd7Ih6dbG+VKJv5OZGY7PJPWOSYXGOJeGpgoODscF+Wx5A9GjpHymA85mrBJFwk01bNoOqCnlZvup9KXEbxffPlTl6cvBQuH+NUqZCfjqxeBrUm2SYXM4mq9bezJxrPSo1KwmVJ44RVkIlvI8RpUJaDcDJ/e/d3zS1BQ+j/w+5B7ZYQ6Ll2+VsAKceeB6dX/7Mmb2jq8bogIpL3dDWx5yE+IhMkx69EKrcPg+ziJKJ9hNLyJ9CF9/tjoluozqxZ97fNuM/sP5xQy3pLXz8jiw0Q0rUiM9ttbetAe1LWb5nJTPfdNa7xZvrTp/KuEged0jdpGXeKIUPDXdTtNu6nQnqzRx+b6KnKmkpXRKyCar4+EqVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1001MB2228.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(136003)(376002)(5660300002)(8676002)(1076003)(55016002)(956004)(44832011)(186003)(316002)(86362001)(26005)(7696005)(52116002)(8936002)(6506007)(478600001)(16526019)(2906002)(6666004)(6916009)(66556008)(4326008)(83380400001)(66476007)(66946007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Kn0e5QJPkdMz1ZkJB+/Jx1D1xzZ8WvaDaioi56X/1KucyV/G82UaPmOrhghS?=
 =?us-ascii?Q?CFKCnx+0v83HUFHc6NG88bMxbE5zwzmQfJtnoc4TK0ePAFbO2smFGyfI1psI?=
 =?us-ascii?Q?bi0DlvPkZj7w+WkS42Gox+RVLPwcY773/k/ddGaGZKOkuyYKcE4u0bHrX4Y7?=
 =?us-ascii?Q?jebF9P6NtYXVuaKTuS/b0iB19hniGhSAUeF0lBAObAmBmfrJmHwUxLrSoZX4?=
 =?us-ascii?Q?1CYekAZGHfu4YsRpEJR+0mFM6Gv1xAKU9/J4vH+Fk0ks9fQoVorRQJypkjj1?=
 =?us-ascii?Q?KGWgk+T1XJpdOqj8SBIvmxqEjLsqmotf7fs14efM+GyTnM/nNjGyLwB8cYc4?=
 =?us-ascii?Q?Xemwp9gCEUAGXBSv9OTKYIQugHnAROPUHGM4owZJ2vqMagLHE5RRKuKu1c7j?=
 =?us-ascii?Q?of5ln5oLI5vm/m8PeRY6h0mh8lFS25NRFVz1A0FJ63Ippx1kA9YiV6MT7tRa?=
 =?us-ascii?Q?OMHd2yGAdA4e3VYTdUOuSoTocYvnLHVghqBKHmdfc+QiiDqhBhsGJ9JKAfa9?=
 =?us-ascii?Q?8ITV+EQkcGw/VFew++/jsAjtyqSWikFAi9RPeakuYptSwRFkF2G0OrXPnn2d?=
 =?us-ascii?Q?+iM9qipTZOwTUSb0iG/O9s6GK7nsNDS2uI1mBsxxeXLqZYOCV9erLVtYAkWj?=
 =?us-ascii?Q?O0hjwNy2K3t76H9GNjD1HWlvIoSkePIp3m/o4M6CtgXjcq3n3CC5JGq70Ji1?=
 =?us-ascii?Q?Ab3kRPP5K91NLIhrExcw2oz0lXx0ZRePgNBH4RLQwOJsRFaJX3+YzyPzVtqb?=
 =?us-ascii?Q?VRO10ZjG9nMtjOBL+Oi0nzI6GZHrmfjYSt0NQdhOrBgtenXX6Y6wbYv2Budc?=
 =?us-ascii?Q?Mif8X0doQXBPXOHYCkkXkweciyu1bMSXWpKWUQSLnvk+1KSRZRXBZVZXi2X2?=
 =?us-ascii?Q?NZ7LR1G8T+U8ya2UTsPecbvc1jVJW5FOtezXmb2iB3XyF+vHVz/I26nCQcLM?=
 =?us-ascii?Q?UOBfPO3bFFc/DpqycnoBleF15943mEvMC8qaOoXgoArDqPS/y2QrLgSdnURO?=
 =?us-ascii?Q?dYajc9t+LXut3zzGp8fpbICzz08d6FSwXRm2WD9X55k6yyXACaguZl+Id6T9?=
 =?us-ascii?Q?ndXqqM2kJuGkKrMwtNFBVxVesWxPu9CFG8GH4jEjKvzde3Xz6kFNtjV9vEoq?=
 =?us-ascii?Q?LX2iRYlT9KIVp6sXqLh229yBi03RwANlyht0AGZosTDnd2V7n7ETKSpUqxH2?=
 =?us-ascii?Q?LV2+6v3FTLCPL6P5r/2+TomRPUIsSONfmVCpTcTc0LfywEzWcl9uSUt+/jm8?=
 =?us-ascii?Q?k0vjowBjXBSwQBRC7gS6mYZkGmzyNbwYmmPUBm2QjsIq329RAzpFOSc8uc8Y?=
 =?us-ascii?Q?29vnv72tVVOmK4QiO3qyMjGP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2f58f5-2c1d-4f1c-1dab-08d8e4a9492d
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1001MB2228.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 16:18:20.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GO4ntbvRY6oo5xD8VUbRXq6bVnhAte0MFwKoBVqqjZpzAuI6We+Ehkz4k7HeAFc9KSIqkK01RA+RyuBnwZguQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5317
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110086
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110086
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Oct 25, 2020 at 02:49:34PM +0100, Ard Biesheuvel wrote:
> The hdr_offset member of the ARM Linux image header appears at
> offset 0x3c, matching the PE/COFF spec's placement of the COFF
> header offset in the MS-DOS header. We're currently off by four,
> so fix that.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>

I was asked by Dimitri to take this patch. I double checked it. It
looks that it impacts only one grub_file_read() and one grub_dprintf().
So, there is no or minimal risk at this point and no big advantage
for upstream. Though, due to low risk, I will take it for downstream
advantage.

So, Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Until I hear any objections in an hour or so...

Daniel

> ---
>  include/grub/arm/linux.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/grub/arm/linux.h b/include/grub/arm/linux.h
> index 2e98a6689696..bcd5a7eb186e 100644
> --- a/include/grub/arm/linux.h
> +++ b/include/grub/arm/linux.h
> @@ -30,7 +30,7 @@ struct linux_arm_kernel_header {
>    grub_uint32_t magic;
>    grub_uint32_t start; /* _start */
>    grub_uint32_t end;   /* _edata */
> -  grub_uint32_t reserved2[4];
> +  grub_uint32_t reserved2[3];
>    grub_uint32_t hdr_offset;
>  };
>
> --
> 2.17.1
