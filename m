Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2905063F82F
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 20:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLAT3i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 14:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiLAT3e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 14:29:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE01C7D34
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 11:29:33 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1IfuDx028841;
        Thu, 1 Dec 2022 19:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=JqVZmyq9N6/6BranIFM+E1JIkkGAtspftxmZ+OW+zsQ=;
 b=VpepYuRTgmeafXyRTZselGl7mMthDNAqMfCQ1FusGBywH125EZhvlXNcC7gycFzMD7Hv
 cwW3wQY5ImbgSxCEJ00uQH0TLraH2zx2J3Gl6Qy/+YJ/wv0SzrHFrd89HKoBJsKLx/YF
 S5MR8TKoQv0d6tE+i1+glCAqaIB2j7XvqKtwqIZloRZjk3/igHN0+scPtQjLMSRtlStd
 dl8qlthrLXi3Y02kYOKKL5iDIOZVIu8Ep314WM98zOR/MeAGZdBBVwn98nmql0o0BPHC
 5awYp0rw6PTczVKj1644jLdHpIRBUkF2XNFi8XeQzT+d4bX4pKZxhztkO5tesUQnUXKc 7A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m71s6049j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 19:29:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B1Hw0lK000585;
        Thu, 1 Dec 2022 19:25:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398hwudu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Dec 2022 19:25:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRaX1djGN1vesIxz1hw3p8Ml2VjeAHbp4KRiEr1OxnDhxcNeV+Wrau6uf4YghUjFTyx4HcX58bJsTCA0T9ebMSiwe2Xwgl8jPYlYHkBEl8T9GynvBfE0xSxfjQv+nq0mJBNZA/vuMOIjiRYKM6TUgxGo1yArUChL72YWdXQ8Tuo+q7Z8fnc/VCtOGMLzDkNumwkbTJ2MvQUt2+RarcY6GuzMCF/83JLz5La17HWIuPE74znXJoQcJuoH0Z6gaJle5CLNU+PPS1R7cDUg98/aU9LYSfWKAxbHORZoYpqJ5+N25KWN2tXNZM521m+97dzVkqkBRNsT+xXKDNV4euGbXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqVZmyq9N6/6BranIFM+E1JIkkGAtspftxmZ+OW+zsQ=;
 b=WGJWTyY2Z14Jam99fFr/DR/kMc8xmWKZLHAUwpW5kEueCRy1SFIcgTlkd8124ytg4/mLekyTmLjz9T+LlJp8K/Ws4VMTuoqb6tiTss1bplvlaQoiGrIDe0rXeta4Zke1Azlpu/UeW+wm8NYQWhPtbYKH9wt5mMS2Xzaqc61SWCH8B0KVTkzDrL7x6YwS53hBqntlq+UuUY1GyuAY/1jwDD3AtIWAylQyPyMZZtD91vT843zwy+mkAqO9/0Rj5nU9qhywzeRlsB0Yka0shNgfhh/MgDh5JdQkG3266m36rawugukp6PmLSLstZytlK073n1Qoqg4qy9WRBHstcTkBPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqVZmyq9N6/6BranIFM+E1JIkkGAtspftxmZ+OW+zsQ=;
 b=u9vx2atr8A5TQT65zJn1d8Ujd5JaRG0vLfuUjU2JmOwkdnsTv8troGZelumjI+stjLXKldDMW+spPLs9eKIBZC+nyeQ7FY8+ccj/Cfv4rsKJ7nyozA4NiOqVfasBIXqBZ942YYYz8NNZop71xyG4pwJoZ56+A6+ADXP7DSf29RM=
Received: from BN0PR10MB4822.namprd10.prod.outlook.com (2603:10b6:408:124::13)
 by CH3PR10MB6740.namprd10.prod.outlook.com (2603:10b6:610:144::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 19:25:16 +0000
Received: from BN0PR10MB4822.namprd10.prod.outlook.com
 ([fe80::8781:9b5f:7205:b8b7]) by BN0PR10MB4822.namprd10.prod.outlook.com
 ([fe80::8781:9b5f:7205:b8b7%9]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 19:25:16 +0000
Date:   Thu, 1 Dec 2022 20:25:10 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, grub-devel@gnu.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>
Subject: Re: [PATCH v2 2/2] efi: Put Linux specific magic number in the DOS
 header
Message-ID: <Y4j/luIc1PWd4tit@tomti.i.net-space.pl>
References: <20221129175616.2089294-1-ardb@kernel.org>
 <20221129175616.2089294-3-ardb@kernel.org>
 <Y4i6YExOV80rxdhq@tomti.i.net-space.pl>
 <CAMj1kXEzzicO_V=ZKBgvWWFAoa1XNSO5KRZaCPYO1boT9s+Vig@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEzzicO_V=ZKBgvWWFAoa1XNSO5KRZaCPYO1boT9s+Vig@mail.gmail.com>
X-ClientProxiedBy: BE1P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::9) To BN0PR10MB4822.namprd10.prod.outlook.com
 (2603:10b6:408:124::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4822:EE_|CH3PR10MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dba1066-2dd7-44b6-98ca-08dad3d1c6be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FMNkUessRsC3h5cYDqALQgGKY4Z8l8wgxP36JMJQp1SlCtWsZpzWf+3UnnQW9sfnD+u22amyFpbsb5egaJySYz4GtPUJxWTEq3lZGS/2GCsSezdxsbMAQsAs0MFA+pATOQVSC50cQCsm5A6BvU9hM1JRkJVqqyVi/pSs4X14nYy6rSxq2g38rtgGPygYkppiUSwNulFLmFhNwaFxhhbXyCqvBddGhrACiEo6tguO2IrhaBpUyhV6rk657H9A7p9616+tJl1gP0Kyub3WHMqJAThSyLrbGXwHxoxtVINFwpTDYaVDQ+CcuyOM1NTo+NcUF04YLkUdD9xm0CFQF4Da8c7E5BT3XxKP1Ao5ce8yFAaUXcL5N9DjQ+vGHDRePk41epRBPsVby2kgELcFVQ7USryIWOKtXTRYDkHhvpMgih7Qlvo8cAP2nuDjE+hH8H694xDRQaCer52aSc0wv0idke/jnTXvT3gSUny+s5jA3daWwBRMXBKXy2ASpmKLX679wXvA0R/FD8aEOpL3HXiTqFavXirPyMHm3R4y63N4eA0sSvdBI9Kv40U3jCyzX39Nl9Mbb6PS1HohziUKT4cDGAFdYPCyxG4+pmLlQ/4yh4loHLEGOkcGMoMbS0gvtM7m0yaVonpPIZfNFW11uOZXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199015)(54906003)(6486002)(186003)(41300700001)(478600001)(9686003)(6916009)(38100700002)(6506007)(6512007)(316002)(6666004)(26005)(86362001)(66556008)(66476007)(8676002)(8936002)(66946007)(4326008)(5660300002)(2906002)(44832011)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GnCmGCF+uw2opA8NlJvwVLnfdZrPJpdoJMX4XTkUvx4s9G0NnvcpraNsBgIj?=
 =?us-ascii?Q?EadIYSRNRzr1rqEQ+kIsHku+NPheEz7ACwAv9m20mgSxqyUwGBJ9athSsCHy?=
 =?us-ascii?Q?po1IiGuSVURsm5vUWVcPjJMaJLf0QjXV+0sD8aSfV/BF5VdL0+YzNWK4ns/c?=
 =?us-ascii?Q?ESvVWIn8+Xe3JNeLSFaIB9ReGYXj/H8C/f8d8tk0cImCu88bivAAketKehkw?=
 =?us-ascii?Q?lmw0BC8zZngxakQTpptYfWYTUAY5jU312g9tvYFrmGfeMKN1kNgCHGeYHXX7?=
 =?us-ascii?Q?+eFfzVV1j9f+u9jYrFFpZ4rP62KoE/vhyqOgqXXYhc36p7JE+fHosJP/OHgP?=
 =?us-ascii?Q?HnxKxQTu7/8xkGVsypNrBSHaifhU5PRmLtMloocGjPlvKdAHlzUn67P35k7/?=
 =?us-ascii?Q?/ioF2R3V49GPpKxrJRXasPFiniFr5M2gc5LYYhnyiXv7X6LGg6xFaN8uuTCP?=
 =?us-ascii?Q?0FWe+lWgUCTBJtDu/cmUSik8BxDI9PNRK6US/tHUHLc9huRHX6tc5APznE46?=
 =?us-ascii?Q?dZW5ExPuhrB1jJ09yutTmW82Dk6OidOATVd82RjZD2LTDNfURjjC+Ic4Tsrb?=
 =?us-ascii?Q?WCboyP8XOKFex+qgjlQXZvkzVwAj44mY6w41toe8aHmfZxu42Q4UjQ0Pz3S7?=
 =?us-ascii?Q?EvBp9OL9KrwPIOEdf26T6Co0Vd54PW0bSQ8KKAeiZ/DmOcp2O3heNNbO+PsZ?=
 =?us-ascii?Q?mwTKpGeANDoZgdO/PSvn3h5ecIuZAsLiDcFXEnxjWty7YdtH77/Y/aeG6laB?=
 =?us-ascii?Q?XPYLUDRCUyTpiS0fX8JT+Y0kt118TqyZep9husy3SUO4ZavP5e5KHWXLToK7?=
 =?us-ascii?Q?k2N9ckSr+GJuW37uHaA9VwmJK8BNv7sEu+/xRirC9N4oC1C49NICMlQJkCP5?=
 =?us-ascii?Q?a+TjlMSUtOpT5fAu87Qo2pv5sSudWThKcn5hgxlWttMrkoyHUPOvPQQ1JGNB?=
 =?us-ascii?Q?7cz/Ykf+T8wmZrgRLUFKAsGQUK46y3X6+nftGdiLqsrupOPSLLHZhaRJfqKE?=
 =?us-ascii?Q?KJVCSjGoJni88iANF6kS2wpHQxMMDYIg+eK4a0LXj1g2FsLzoResHI3FFwLC?=
 =?us-ascii?Q?t33iMeIVw5OQX24MVeuX3YAsrBKovy97DudJlq4CJeSaEzoSIBNBlLCo94R6?=
 =?us-ascii?Q?a112zFoAOHZTlXG354nNtwX3ErW7/C4KFOMGMK5KgnwR0Em4xHqNUMqP2+zp?=
 =?us-ascii?Q?Mxwp0do4NNQ/AypDbsxD6v7V8V2ub9P0zkgYMc6+zZNEM+GIeavbslZlv+G1?=
 =?us-ascii?Q?tRIYUdQBI8kSoHjcEaIDpWMjts0w3YMPt3KcJjWPua6l89CvBKAN3/VE3nHQ?=
 =?us-ascii?Q?OHgqxXxaoWwTTevc0K27akQXe5ygc7W401kmVTIkKQ0vKfr0Ru5fgq89g7Uq?=
 =?us-ascii?Q?desW8LAmFvzxdn2z1MxEgRHb4TvjuNsKhUnooQd4NetyNUA1J9gzoiow/Wku?=
 =?us-ascii?Q?VLpRp9uS2cnnwP0pbK9CFzz9OO8YbRjDrR3e5SavGOW2+lxoJzFekbmel7Od?=
 =?us-ascii?Q?RgktklaJ4OgmJyLVcNe3fUIGZ9fbSXhBkPGewH6Cr8WcR3rpxHcDllOyo+TU?=
 =?us-ascii?Q?nc0svenzEfOSFxBRt9Z72H8N+k0/B3jDACJbqLoM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fiBC0Owiu4foj1ZVFAA3ogj1WMlt/24ShZvx0soDAGjmpt5j88BBI/7TxsV7?=
 =?us-ascii?Q?nj6elUMv+Ndw0MJgHTGUHgfpaPpXQXDXMLF1fuwpguYCLRJFQMqas/KGAguv?=
 =?us-ascii?Q?KAa/YCXjXY3moyS5PvgXUpWf1RvR5yMtz2o+Qw7+4t5cAnl2oqVh3wsTTb+c?=
 =?us-ascii?Q?LX60hcIZtiHcJNi5qOTk9n2Fr+zWbySKoSlv1GPiZTUhKUPq6ERe+3FNuO/l?=
 =?us-ascii?Q?H3przj9f5eeZbBjj+tdylNS0jj2Ao7iJNe3W8g7KzGwt3uO/L2RWhnppcuyn?=
 =?us-ascii?Q?35DNpCM087ED1BFr4UxY0UCrUrPtKgjVNPxu7ZwOU/JV1sFFCRe3PYDAZb6e?=
 =?us-ascii?Q?t4ismW0Jw5AfCsyxjKmSs430f6Jc/uoHeVAdpc6SqrZCSz7h3riTS6jcbcBB?=
 =?us-ascii?Q?xYNxMxRhbf4KwPks9Ge0wxcxaK+DOLrUS2H/Hxzyi4Y8LeU3v/od9cQ7aFVo?=
 =?us-ascii?Q?2gb7Z3kPhKfft0nj9GAHclGNI4t0Uo+Uir3qhb4BNicdBkAE8R9RuXwAJXbc?=
 =?us-ascii?Q?cHfTAkoN64f7NweWySdE4/USQuLVkFFLvTuZPFAdwPv2G4CJI8o7VdqxGo84?=
 =?us-ascii?Q?W58NbfxwSg5kdY686ic5hOzRa5eYzQBZWqOCd2B39MV5y+TUN9Wx+lK1+WZa?=
 =?us-ascii?Q?ePZnYm+LwQ2Com03Q8d1x8elr8GmTgfplYeM6/DrXqfd5UPor12HliXdiDU5?=
 =?us-ascii?Q?tvE9luk7QiyqShMziflahNjBmiWI3HxP5cMwrETRfDncYL0ak578ESpU4IMG?=
 =?us-ascii?Q?h20o1lsybjCPiGFi4LsLUQK2Wdw56vO8yx2i2uMTKEvcckQFfI6FSRVEVcC7?=
 =?us-ascii?Q?dxl2xDQMSajcD31GB6kfH1BKOXZ5Er+Vy41oimSlta6UaLAMNtEy6P/sW9jV?=
 =?us-ascii?Q?iwP5bJnXI0yAXy2iBgIl25SD3Azi/rRk+IndLuINpScr4f+aoBnKsNscFmGe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dba1066-2dd7-44b6-98ca-08dad3d1c6be
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 19:25:16.4695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5bcdvM/mcZmmuv4/a/w8K4QQFau+9mGAMqBAaGJdARJ98vFVtJ7kl4UTFka+QM4dTD6pi2zlCyIAfQ3sGk2jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_14,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010148
X-Proofpoint-ORIG-GUID: aVksAeaTC407LcYSddwGQtqBipc1u-8b
X-Proofpoint-GUID: aVksAeaTC407LcYSddwGQtqBipc1u-8b
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 01, 2022 at 03:48:12PM +0100, Ard Biesheuvel wrote:
> On Thu, 1 Dec 2022 at 15:30, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> >
> > On Tue, Nov 29, 2022 at 06:56:16PM +0100, Ard Biesheuvel wrote:
> > > GRUB currently relies on the magic number in the image header of ARM and
> > > arm64 EFI kernel images to decide whether or not the image in question
> > > is a bootable kernel.
> > >
> > > However, the purpose of the magic number is to identify the image as one
> > > that implements the bare metal boot protocol, and so GRUB, which only
> > > does EFI boot, can only boot images that could potentially be booted in
> > > a non-EFI manner as well.
> > >
> > > This is problematic for the new zboot decompressor image format, as it
> > > can only boot in EFI mode, and must therefore not use the bare metal
> > > boot magic number in its header.
> > >
> > > For this reason, the strict magic number was dropped from GRUB, to
> > > permit essentially any kind of EFI executable to be booted via the
> > > 'linux' command, blurring the line between the linux loader and the
> > > chainloader.
> > >
> > > So let's use the same field in the DOS header that RISC-V and arm64
> > > already use for their 'bare metal' magic numbers to store a 'generic
> > > Linux kernel' magic number, which can be used to identify bootable
> > > kernel images in PE format which don't necessarily implement a bare
> > > metal boot protocol in the same binary. Note that, in the context of
> > > EFI, the MSDOS header is only described in terms of the fields that it
> >
> > s/MSDOS/MS-DOS/ to be consistent with other places in the patch...
> >
> > > shares with the hybrid PE/COFF image format, (i.e., the magic number at
> > > offset #0 and the PE header offset at byte offset #0x3c). Since we aim
> >
> > s/the magic number at offset #0/MS-DOS EXE magic number at offset #0/?
> >
> > "the magic number at offset #0" itself is confusing in the context of
> > number of "magic number" phrases in the patch... :-)
> >
> > > for compatibility with EFI only, and not with MS-DOS or MS-Windows, we
> > > can use the remaining space in the MS-DOS header however we want.
> > >
> > > Let's set the generic magic number for x86 images as well: existing
> > > bootloaders already have their own methods to identify x86 Linux images
> > > that can be booted in a non-EFI manner, and having the magic number in
> > > place there will ease any future transitions in loader implementations
> > > to merge the x86 and non-x86 EFI boot paths.
> > >
> > > Note that 32-bit ARM already uses the same location in the header for a
> > > different purpose, but the ARM support is already widely implemented and
> > > the EFI zboot decompressor is not available on ARM anyway, so we just
> > > disregard it here.
> > >
> > > Cc: Huacai Chen <chenhuacai@kernel.org>
> > > Cc: Atish Patra <atishp@rivosinc.com>
> > > Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > Cc: Daniel Kiper <daniel.kiper@oracle.com>
> > > Cc: Leif Lindholm <quic_llindhol@quicinc.com>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/loongarch/kernel/head.S                | 3 ++-
> > >  arch/x86/boot/header.S                      | 3 ++-
> > >  drivers/firmware/efi/libstub/zboot-header.S | 3 ++-
> > >  include/linux/pe.h                          | 7 +++++++
> > >  4 files changed, 13 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> > > index 84970e2666588963..caa74439700eee93 100644
> > > --- a/arch/loongarch/kernel/head.S
> > > +++ b/arch/loongarch/kernel/head.S
> > > @@ -25,7 +25,8 @@ _head:
> > >       .dword  kernel_entry            /* Kernel entry point */
> > >       .dword  _end - _text            /* Kernel image effective size */
> > >       .quad   0                       /* Kernel image load offset from start of RAM */
> > > -     .org    0x3c                    /* 0x20 ~ 0x3b reserved */
> > > +     .org    0x38                    /* 0x20 ~ 0x38 reserved */

Sadly one more thing... :-(

s/0x20 ~ 0x38 reserved/0x20 ~ 0x37 reserved/

Daniel
