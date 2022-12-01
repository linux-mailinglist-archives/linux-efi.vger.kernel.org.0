Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D16A63F2E1
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 15:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiLAOad (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 09:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiLAOa3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 09:30:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3F7A895E
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 06:30:26 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1ESsOf002743;
        Thu, 1 Dec 2022 14:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=vOkVWHuSBo4UhQwNyVgKGs6o73Eekae87IJskYv1D+g=;
 b=nCRJXVtG3zEvj3phXmEcnKG3LqY46l/Foa3Ggqai90AOWmHVMJ6bX/J3Pu0VjdDE4ghw
 KhVGaFtisporTx+FuRbiLJRj14Rnl2S8RQEb8T2Djql2zdXGcLk7fbmlrlGIQWAWkqpf
 grc/W3B9fYNuAANRe7AxYs6+zzH9Lg/Al4Kr4o+fOMP7UuDx02MAk7gJGbLOsR3uvngG
 xWCBM+mihfz2woydnvaIXGSW4Y8jlhyH4E7ypiX1hrYVOwZUUKWE3vA7GLgzoDcj1+B2
 PZW0/KcLMMlDKq0NY5KUYnpKLCPI/Dr7nXL4qXX4OvHnbqgx61LnpLdQPQ+ZDC9Oio3s Ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3adtdqa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 14:30:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B1DCB68000487;
        Thu, 1 Dec 2022 14:30:01 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398he7kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 14:30:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/CI26ItGmEXQDJI23xMs1lyJxx+p95GPsMFVaaOJB3toTCCz0l4b6Woh6kvW+vI2ADdBBQ5kKvCaGYhGYOU9rxDmH8/tgN3jFP7/G4BfJkEne0KlYz7ohAIsr/x8KfS/RsiQcDkqoceBPWV2VacN2nfN/R+twSeX08hzUhUqzS48LAYO+R5mwZBRKQD90GJ9pEgMZb7qsjkrxPOc4pEobcBkOv6eKIl2Ff1VqTWcu/3OF3xpCxTsbaTfe21ecmM4wsNKmg/Znv8WhZk94zMB6oZiimUkeiOQhUrddi42C3+jDHJJY1EEMPo+r66asE2JcxU6memiE3CClmv5Gofjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOkVWHuSBo4UhQwNyVgKGs6o73Eekae87IJskYv1D+g=;
 b=odmnxq2oZcvpgxL0KbBoUFqfZQrF1nUZEZDEE6wi8psxkC+2YEmJU0gb5pG4u2qYIbYDM/mvZaD8mNtseH82szO3lTK2Kuzh440OFSUFSuDD4u+xueB81mlThNZBHR7VrXIlnxbBxzVXK0YfN8sVCdr2oQKG4ddxcHexMqxNmDDLHDZy07UZF88VkTOp4NpC60reHm5hNpgRCQO68kx19aXHAAfpSWu66ieZxBSR0d0QL8B0jU2zyajMDrRKJW64fIQatVQ9GBCna7ysrf/kUjfGvZsJjS6zeKl1NFPT9JHIgXDkjo5AT1w4k/QqDfvkY3w47Cm/C4gXI1TafWL2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOkVWHuSBo4UhQwNyVgKGs6o73Eekae87IJskYv1D+g=;
 b=LuMjQzQhFRBKiHxDoXoW0j7zvRlWuVLfREVod7v+Wx1htxmho8EnshlmqLmhuHGh+43lbpeBorgV3lFQzeWqojCS0NUVsvj7XNS+xhuv0xE0ZbKb1KnzleeBOtg8woKY2BxznAg71ThdzVjRhu7KUo9U2/cEqB/YE/gkfUgnzF0=
Received: from BN0PR10MB4822.namprd10.prod.outlook.com (2603:10b6:408:124::13)
 by PH0PR10MB4807.namprd10.prod.outlook.com (2603:10b6:510:3f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 14:29:59 +0000
Received: from BN0PR10MB4822.namprd10.prod.outlook.com
 ([fe80::8781:9b5f:7205:b8b7]) by BN0PR10MB4822.namprd10.prod.outlook.com
 ([fe80::8781:9b5f:7205:b8b7%9]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 14:29:59 +0000
Date:   Thu, 1 Dec 2022 15:29:52 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, grub-devel@gnu.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>
Subject: Re: [PATCH v2 2/2] efi: Put Linux specific magic number in the DOS
 header
Message-ID: <Y4i6YExOV80rxdhq@tomti.i.net-space.pl>
References: <20221129175616.2089294-1-ardb@kernel.org>
 <20221129175616.2089294-3-ardb@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129175616.2089294-3-ardb@kernel.org>
X-ClientProxiedBy: BE0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::17) To BN0PR10MB4822.namprd10.prod.outlook.com
 (2603:10b6:408:124::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4822:EE_|PH0PR10MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aca6fc1-1cfb-4e27-dc65-08dad3a8866a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mo2SwMl9YuWVvqzchgQ58Jz83yh32ZnjwZd4YkANpnbzGT7OlHjqH6dz58fzsrpAbyymGcR/e+7ATKBXWlkb04ueLGD+uSUSQ7L+9uRK5EvnXyqVIPnko9NnpEzgfPH86DFu2Do+SncXOet9uO0ZUKebMgDhxtAn7KXRcoMOfeQ2iwqr/+5zSU4+L5yHKbyw/nu8vQXFz4494qO/BWzl9JMG0PN5PPbfFrvQB2nLcL4xA8mZhYzBr4Xhv2bNhUQHlHI1DyXPeQeIwi2E7FZo7Vbp4yPWAmXUvfOx4cZDg3DpfW3KyEwvff29DiPrw6sDzJ0GQZdVOXqbYAaxh/9u4VseEUFBeBhp7TC1eTrkhSFT2ZKtK3DKP7KJooUtourRykbsyjp+I8SFMCkr2dqCH/jNkDnzSoIt/t/N64zrDfQBkIXwD74Pt0y87uyrl6WlrlnvMbXL8+jnMCxOVBYTAKpA0W6lT2Dogtzx9rqktktTHlke0gZ8VVbEiZ2kjzf9SGuQn+FCmwAngzy4v0Nh6cxmK6jAAjmsr6zInEn8zg/XaDvCZc3/qAbLzBwfQKzk2CZtAeVb2QS3MWrfWfsfqQ3e1qUi9+boLfKpEuTWwsPe9AnhixmgKuMiRgD0A6FHeEW4+aMLUgbnNMloa2BE7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199015)(4326008)(66946007)(8676002)(38100700002)(66476007)(66556008)(6486002)(478600001)(6666004)(6506007)(26005)(9686003)(6512007)(86362001)(83380400001)(54906003)(6916009)(41300700001)(2906002)(44832011)(5660300002)(8936002)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QK2bUi1FOkPiK2VS42IbT/mIJ46cckCTJDBZjYPKIA+7av/5LjoseM8R2VOk?=
 =?us-ascii?Q?srnBwvWcbemSdJWGXvvIMPOekHkalnj2roABhBrMtlwIGqv2IeAg5Kt2lf/A?=
 =?us-ascii?Q?nHgobibSrm+ALO+16Xd5QpQmf0Zx7uLlNnmGkjzh84Nuc/16DWN4syQQQI7o?=
 =?us-ascii?Q?9TwIyjWTvf3cOOf/L5RCdPoDMx3Q5GfNlf4Uf3Vd3AAfsrjVdkzmJC1DRzPZ?=
 =?us-ascii?Q?QTn7zvBaARsuT2muy56xnB8YoUycg3Xaa5fGXjaMeI/8t9h8AhvhqInXe/VD?=
 =?us-ascii?Q?E5BzOcNlXq4Qy63nEkfcKQHpCB5NQsypLOCju5R6R/oaUyvxPpuKixTSUEOY?=
 =?us-ascii?Q?xZgVQsGfMO9yzvb0f5EA+5HyuH34cE+xUbwy1smIF+r4dovLvpV57YS3/grh?=
 =?us-ascii?Q?9OdLZBWaE+Rf8nSY5oI9hgcnmjI0RHtiB0hrgho2HPzMy89QqRodFXKBLcEs?=
 =?us-ascii?Q?h0gcP69JdwHH2AuWIPqFIKp4PcYB0hbtpVW8jfGN8q8BcvWgTtZhXxyDIvAb?=
 =?us-ascii?Q?jcParY5YT/SPNkuUbz9rrSm2HP19NL1f4xBfi6c7YMG5rodzs576jaFaREFr?=
 =?us-ascii?Q?5q6DPZI0e+3sVIqICJZzCEUsGCwCDZY3StEUHUYWfnXZCXppK5H6+9fAnh5v?=
 =?us-ascii?Q?OjyX0Y6sbRtV5TabYZB/vChWt2xFhl5DCpeFX+pXDIG66pgkIO0Xw+HP8d0C?=
 =?us-ascii?Q?/5enbNnW5CDPyrgjqFll1bkS+NDuFo7iZjyzuuc2XsrqTw9VvSMP2x7sipWX?=
 =?us-ascii?Q?SCa9oS6XhmDVGaX6uqhvMi5pjb7Wds/G08o8iSzRcaOZQjKhX7YTKghaFlw3?=
 =?us-ascii?Q?d77Q9KD+qggtXv+G88+tfyL41XHeJuy/N131+H/oKo50ZwhQbwCUU6QM19/2?=
 =?us-ascii?Q?e1o1VN1P6DnGcDBxcAkZBRCWV1bz1IQFxRLz3Ffnl87gKj9ZQXoYnU9bWOFD?=
 =?us-ascii?Q?t1O6J38S3Cq3YZ7njDoe3Al5C4KyLuDCtl6sgjP0g8fuHaIPKVnUrcEDStuK?=
 =?us-ascii?Q?hTA7K5WLFGcs/INQM6DbDogqsr7Vj4hPuF824fQNbMeB/IjQwooOrLuRE3rT?=
 =?us-ascii?Q?CrHACxhFhfGTXrRShLN58BOAtZObZeVLzEFNylwjhtseyGjL9x4ptDT8uUIu?=
 =?us-ascii?Q?KVOzII/VhF+MySBxADKuSvagDmv+fhLEDbxH2XJ8EVL0PobJ6FWYoYg34Fuq?=
 =?us-ascii?Q?sAByvkHWRYf7mpRppN9bFhnPW3qHpz7VtWXZ3jbX9h0ojuuM/DAYO/95tTzK?=
 =?us-ascii?Q?DBIN/C4HtN0mGTKuSu6Wt2v28cawRfrf1o+GmBKzLM4/TTeXzCHSHElXhL7P?=
 =?us-ascii?Q?61Xzt8zorA3fKlUFgDxmDN36mVNolnKA+vpNpiJ22W2FzixHZuabSo4uh1Yg?=
 =?us-ascii?Q?8Z0rYNrbwlH6E4ExD+BXNPreBWRQtApYh117RUb7sn5vBidB1Cc2E0mo3aix?=
 =?us-ascii?Q?CGvykw/gkgMtOMEYuHHCzZ1JhzfQg5MHBUQ2pQMavC4s/DZKZAGf6bhhFQc+?=
 =?us-ascii?Q?cYznUObm30R5AWz3IBdtWShvtP0HgfZ60wnGaDCWI+0hiom8rRzEwRc6qPVG?=
 =?us-ascii?Q?5V63f6TzpcwaB+3EV1KYvNJjBRfkOF8nlmili02o?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?btTmuOSsQmJAJ1qBkjEFW5B463acswSu83UsR6cdIerrLYr/iP+6QAmsTliD?=
 =?us-ascii?Q?Y++7z8B4gZjuMe0wqMnkFKI1Nce0qFQJHCYE1+qJr8nSwNaK1fRenLUG8RWP?=
 =?us-ascii?Q?+M3c2VE5VoDFcjPkHWfnkYAit8hhdf1gCGesXwkl+SzAL3RTy1E/6TYSjTc0?=
 =?us-ascii?Q?jnGwCVfiam4wkEBVH1vC6X9azwytjz2AVWQvHiasQsjVu/lzqjxZokEknG5c?=
 =?us-ascii?Q?AGlMO2MfbAo7v94lM00QmYSZwDjeoH/iTZhrtySqBhoVqidxtH5FfA89A8+P?=
 =?us-ascii?Q?RQIwB/u0sDC+cN2FC6pKsMAask5ph2Qs+IMkMQrWKZPqr8TuuBjeJ5eDvMXD?=
 =?us-ascii?Q?epuRKE7oGT7A39WW4+YrHgNYCRFt5I5XxFxM2ChZ303GRU+pb7xtK5cspco6?=
 =?us-ascii?Q?zMw5FZ52Rb0ei3aa2tZOuq7QkU+/Qg3r9C0jDbOLiZ3u50ibV3RXi/oCobUj?=
 =?us-ascii?Q?qLbOvAAR6rw8tiStWjwRaTOyxMwIl8GLKPksMOSnKrW7B0Cho8/1wWzhmWxY?=
 =?us-ascii?Q?LDq8MBjAUyhfrKAB+8lY9ubHoVvOipMVgBw+rboyYpi598MEkgndxA1PUj5o?=
 =?us-ascii?Q?ZouzZZYYI5pmFAGXjzKCQ2O/86hvH/JtoOEC77vXM6tYSzJ61VYoQJi2ZStr?=
 =?us-ascii?Q?KC9jEnIzjsTGiueVZ/KXVenZTSHl5A3VUI8n1cvQpHO+uwdYZaCQHc0oRbbi?=
 =?us-ascii?Q?a+2ZS0d+KzKCGG7Mk/SQFmRa/mTelmQ7PkzpXkWUTR3SweOg8giOhJWTTEy/?=
 =?us-ascii?Q?seAvOdUuX01PoJdZk5PIFjPYPxplqnzpLjsRnQR1eEJqwBQt8IGTeY/QYafF?=
 =?us-ascii?Q?48NHaCxq6NTVMGBEi4XlRuo/f72hUzLW4K3TPRN3ry+AyjKz0PgmUSvKJS6h?=
 =?us-ascii?Q?F+Bd2Y9bgq0imXLP9AS37qARzCOds3NqGNu5WtRS2khzBNS5sCtyX5bzh9xL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aca6fc1-1cfb-4e27-dc65-08dad3a8866a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 14:29:59.0869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6jx90Wpqxc8PnL73bOmg6XdvgN8eoe5h1eOtyzgdEVhPRQMWmiCxUpQCbDAMgetY6O8RBwK0OcEyVsJ+xcMqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010104
X-Proofpoint-ORIG-GUID: p1MQ4Ut3zulo85yT-mIC3GuEN-MbAhrf
X-Proofpoint-GUID: p1MQ4Ut3zulo85yT-mIC3GuEN-MbAhrf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 29, 2022 at 06:56:16PM +0100, Ard Biesheuvel wrote:
> GRUB currently relies on the magic number in the image header of ARM and
> arm64 EFI kernel images to decide whether or not the image in question
> is a bootable kernel.
>
> However, the purpose of the magic number is to identify the image as one
> that implements the bare metal boot protocol, and so GRUB, which only
> does EFI boot, can only boot images that could potentially be booted in
> a non-EFI manner as well.
>
> This is problematic for the new zboot decompressor image format, as it
> can only boot in EFI mode, and must therefore not use the bare metal
> boot magic number in its header.
>
> For this reason, the strict magic number was dropped from GRUB, to
> permit essentially any kind of EFI executable to be booted via the
> 'linux' command, blurring the line between the linux loader and the
> chainloader.
>
> So let's use the same field in the DOS header that RISC-V and arm64
> already use for their 'bare metal' magic numbers to store a 'generic
> Linux kernel' magic number, which can be used to identify bootable
> kernel images in PE format which don't necessarily implement a bare
> metal boot protocol in the same binary. Note that, in the context of
> EFI, the MSDOS header is only described in terms of the fields that it

s/MSDOS/MS-DOS/ to be consistent with other places in the patch...

> shares with the hybrid PE/COFF image format, (i.e., the magic number at
> offset #0 and the PE header offset at byte offset #0x3c). Since we aim

s/the magic number at offset #0/MS-DOS EXE magic number at offset #0/?

"the magic number at offset #0" itself is confusing in the context of
number of "magic number" phrases in the patch... :-)

> for compatibility with EFI only, and not with MS-DOS or MS-Windows, we
> can use the remaining space in the MS-DOS header however we want.
>
> Let's set the generic magic number for x86 images as well: existing
> bootloaders already have their own methods to identify x86 Linux images
> that can be booted in a non-EFI manner, and having the magic number in
> place there will ease any future transitions in loader implementations
> to merge the x86 and non-x86 EFI boot paths.
>
> Note that 32-bit ARM already uses the same location in the header for a
> different purpose, but the ARM support is already widely implemented and
> the EFI zboot decompressor is not available on ARM anyway, so we just
> disregard it here.
>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Atish Patra <atishp@rivosinc.com>
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Cc: Daniel Kiper <daniel.kiper@oracle.com>
> Cc: Leif Lindholm <quic_llindhol@quicinc.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/loongarch/kernel/head.S                | 3 ++-
>  arch/x86/boot/header.S                      | 3 ++-
>  drivers/firmware/efi/libstub/zboot-header.S | 3 ++-
>  include/linux/pe.h                          | 7 +++++++
>  4 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index 84970e2666588963..caa74439700eee93 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -25,7 +25,8 @@ _head:
>  	.dword	kernel_entry		/* Kernel entry point */
>  	.dword	_end - _text		/* Kernel image effective size */
>  	.quad	0			/* Kernel image load offset from start of RAM */
> -	.org	0x3c			/* 0x20 ~ 0x3b reserved */
> +	.org	0x38			/* 0x20 ~ 0x38 reserved */
> +	.long	LINUX_PE_MAGIC
>  	.long	pe_header - _head	/* Offset to the PE header */
>
>  pe_header:
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index f912d777013052ea..be8f78a7ee325475 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -80,10 +80,11 @@ bs_die:
>  	ljmp	$0xf000,$0xfff0
>
>  #ifdef CONFIG_EFI_STUB
> -	.org	0x3c
> +	.org	0x38
>  	#
>  	# Offset to the PE header.
>  	#
> +	.long	LINUX_PE_MAGIC
>  	.long	pe_header
>  #endif /* CONFIG_EFI_STUB */
>
> diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
> index bc2d7750d7f14174..ec4525d40e0cf6d6 100644
> --- a/drivers/firmware/efi/libstub/zboot-header.S
> +++ b/drivers/firmware/efi/libstub/zboot-header.S
> @@ -20,7 +20,8 @@ __efistub_efi_zboot_header:
>  	.long		__efistub__gzdata_size - 12		// payload size
>  	.long		0, 0					// reserved
>  	.asciz		COMP_TYPE				// compression type
> -	.org		.Ldoshdr + 0x3c
> +	.org		.Ldoshdr + 0x38
> +	.long		LINUX_PE_MAGIC
>  	.long		.Lpehdr - .Ldoshdr			// PE header offset
>
>  .Lpehdr:
> diff --git a/include/linux/pe.h b/include/linux/pe.h
> index 056a1762de904fc1..1db4c944efd78f51 100644
> --- a/include/linux/pe.h
> +++ b/include/linux/pe.h
> @@ -31,6 +31,13 @@
>  #define LINUX_EFISTUB_MAJOR_VERSION		0x1
>  #define LINUX_EFISTUB_MINOR_VERSION		0x1
>
> +/*
> + * LINUX_PE_MAGIC appears at offset 0x38 into the MSDOS header of EFI bootable

s/MSDOS/MS-DOS/

> + * Linux kernel images that target the architecture as specified by the PE/COFF
> + * header machine type field.
> + */
> +#define LINUX_PE_MAGIC	0x818223cd
> +
>  #define MZ_MAGIC	0x5a4d	/* "MZ" */
>
>  #define PE_MAGIC		0x00004550	/* "PE\0\0" */

If you take into account these minor things mentioned above you can add
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com> to your both patches.

Atish, could you respin your GRUB "Unify ARM64 & RISC-V Linux Loader"
patch set when both Ard's patches are in at least "efi" Linux kernel
branch? Hmmm... I am not sure it will go through "efi" branch. Ard?

Daniel
