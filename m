Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6960D58FB71
	for <lists+linux-efi@lfdr.de>; Thu, 11 Aug 2022 13:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiHKLfn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Aug 2022 07:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiHKLfl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 Aug 2022 07:35:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA64252BC;
        Thu, 11 Aug 2022 04:35:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B95q6Z032436;
        Thu, 11 Aug 2022 11:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Xc1Yxxw681d1YKKcRHXV+DxbU0/R+VlmevYABBbzS6w=;
 b=uKaxQ0TvhHdSx4a78oq6YImyQa4S1T2f5UKYzVryOE4lpH0b5oFsRkdKpME72W0WbRVj
 7EO+6TdCoT379O+34BBJcjdXbmyTiX5vcYQ5qVQ1zBm2r32aedpwNe058GJzQVeID1Hv
 zRYXuu56ZZjLpviZxw9lkcSbU4d730YHMaBGpCXvh2e/0sXLGzDk5B1Z1dMRS9AcAruU
 84JoIaeSgqkifoTJtvpQNhQYZUndSqMip+/hDqa9STeLNzF1eC4OztXYYaEUM3jkZ1jR
 YA2ush8mUaWtGUsV5GZsSLxHWiIsq6mbiWj9v49eWPD+ifxGjgG2+faVdQIhGjFPrGR/ EQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqdvfs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 11:35:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27B9I0Ii019071;
        Thu, 11 Aug 2022 11:35:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqk0vw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 11:35:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIZwS8e6U4zyjNxGyZ7HIqXg4EBshVls0Cdx4zK/DOYTY/AhPFcQuyVdg2HKbO9gyIIWiTbVZzw7pg5Ih7SkXYZ5XdEiyTGYkEjPtsZ8vWY5CioeB5usjqQquVzbLFnZAXWEBSr0ovtZRIybiu40u+IyTyZLfvzShc1SG+/paCfgiIreVEBr/GYwcVcoFZTt5tuCZKpCdpDgXOMslxD14Od+B0xNCi6KTeE0Wt2LPOffgaC2yzuMMXqfp7vWLdCIYPuc77hhoDM6kyyhcUOsFqh2P0RsAMthau1Tx7JMe6KeJ2LgwUq+GXHWYq5iDTzzII6oz7vR9MLnyq0g3zqMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xc1Yxxw681d1YKKcRHXV+DxbU0/R+VlmevYABBbzS6w=;
 b=fGszLPrI69uQ4Xrjbloh9AmI44xBxkw82RZNfxxM+6Cyi/boKPu8UfwqTSuKeHnYzEil4ZaVXdqFSQGFtj30SyDB1CynUvHuy3ll144wrCn75Q2rme6mBdo3G9GcbtFIq459fUWEnH+grK7sl3EXX3YIMGcmvTSyfeaQdKkyop+k0/YUuqIy1bPQ3sOmpZUl9/f+6/Yz/6PprkTMRV6jvpPJshRe3GYBpnYsCybPvPlWDtVqOgS5QEFUPwitlVrULV5oLGRs/2NWq6kkU3MVQ3Jd81u2j9inWTNHUWV7W/PePwmuvVEwi9mXmrTyE8eZcA67/dEY1t2m92pKwVhEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc1Yxxw681d1YKKcRHXV+DxbU0/R+VlmevYABBbzS6w=;
 b=lQ5BrjpVOdMrWnVFacEHAEch7tYV5qEB7Y/DYYWssfQjISzQUeTB5uqyvg4qZMnrFzAIxXloVc19sjpG0YUVCC4aL8x/hSlFAxr8V798x2CvetR61MSfDC2/tbJI1NR9+he0dc72I5EiKJasjb9nx7Mqmzm6HNGgf7eC63yM2DQ=
Received: from BN0PR10MB4822.namprd10.prod.outlook.com (2603:10b6:408:124::13)
 by DM6PR10MB2812.namprd10.prod.outlook.com (2603:10b6:5:66::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 11 Aug
 2022 11:35:04 +0000
Received: from BN0PR10MB4822.namprd10.prod.outlook.com
 ([fe80::4c6e:d814:c9fe:1578]) by BN0PR10MB4822.namprd10.prod.outlook.com
 ([fe80::4c6e:d814:c9fe:1578%6]) with mapi id 15.20.5504.023; Thu, 11 Aug 2022
 11:35:04 +0000
Date:   Thu, 11 Aug 2022 13:34:56 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Brendan Trotter <btrotter@gmail.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        The development of GNU GRUB <grub-devel@gnu.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alec Brown <alec.r.brown@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "persaur@gmail.com" <persaur@gmail.com>,
        "Yoder, Stuart" <stuart.yoder@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "lukasz@hawrylko.pl" <lukasz@hawrylko.pl>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morris <jmorris@namei.org>, dpsmith@apertussolutions.com
Subject: Re: Linux DRTM on UEFI platforms
Message-ID: <20220811113456.dweldtx6gespvrwn@tomti.i.net-space.pl>
References: <7aab2990-9c57-2456-b08d-299ae96ac919@apertussolutions.com>
 <CAELHeEfZ-feZnexp7Gx3VAJPerENcoO1Uccbe3xxUX95jvLUdA@mail.gmail.com>
 <b1e7b545-8e66-5dc0-ff5a-9f69d1751a5f@apertussolutions.com>
 <CAELHeEcEN=4YrPJROvzHoOiqqe5Bk0f8pDCZDnQ6aS=2LdwNow@mail.gmail.com>
 <f09fe749-e139-db6a-b2ad-45db76da04ae@apertussolutions.com>
 <CAELHeEe5H8BNf8K22XRm3hXf=_imHBnf-MHcFYvPCXX7GYkt4w@mail.gmail.com>
 <203110bb-b70b-b4f1-9453-46136659f84c@apertussolutions.com>
 <CAELHeEe2CiTXfMf3OYu3bzc_kH=rs4qzC-4XQL12AM=Nq8Csjw@mail.gmail.com>
 <20220810174638.GA7906@srcf.ucam.org>
 <CAELHeEdNgYCh_kQwWpEc4aXw-YL-KGrAeDCL-VaG3ChFs6LNVw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAELHeEdNgYCh_kQwWpEc4aXw-YL-KGrAeDCL-VaG3ChFs6LNVw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: BE0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::14) To BN0PR10MB4822.namprd10.prod.outlook.com
 (2603:10b6:408:124::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a542c522-dcba-4a70-5fc7-08da7b8d88cc
X-MS-TrafficTypeDiagnostic: DM6PR10MB2812:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4iHgWqbmRjUYw8/dzTZRyO3yvzpfMiOShMGj/EXgXXNigJWuvZlq7qOeQB4GC6M4f5CkrHSwPnDOqDaolwQCF1nycVAszce09jepj1FZw5dD/Qp0MoeEaQQfrSpB24SYMSK/heiUtdVFR7Y2qupuBr9e5b82H1RGCKpTlIQ25z62W0OmoKpaHx/Ti3YNWAp5kltnKduc806iMlZdT2KRGDOAEzw66waC08QI7ZG2ZwkScYatuPRUQ46mZ1/brEV/frKYlet3rENXV41AsHdDnkle5+reGIG1YyO/3sUDxqDyjhKm/ZIjVK+3wV0l/kSdlkTbjkWI0yyvNPkKlfE0pmtE0uK8mxxZefASUUFhWs7AEZ+vpes+AHdFiI/Ui1Wu2mDnXS7zWICRaJX0pqCgQvYBucSShqpTW8iRrzpTOZHoP+ifycndlHo6b6jaGA9IcJ9LwQVT3E75Q6c24LRZQnDL9BrqO3b37JVnjDHUwyNWEs0/M0H7m9iFJF/80S2EZkuo8InlIqtQ6bMsJO5R0UIRV7+2/QBaQvAKFUKoMy8KwNx05XTCrGW3fZCmUqEG8KtnD542YLoX6tTJlP7urJjOLJ9jIbA36ZmgDVxGiqol9BVhPck7ivaeAc2/hHvs+oCo9dlWBDNa4i0ExJJeN9RAHJtwkZe1ROKqosW0WK8PmQKypuWHSCfpaWeMJQ8L/LMm90B6geYn3jprsYjSlQfnRMwKCYylQPxnAIrWIFK3YOUyAy/5oHYWb9+gjJlXOzEDcxLpoTCMelxcbxYgu944qpBWXGMr1o5CIRTCdB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(366004)(136003)(346002)(66946007)(83380400001)(8936002)(44832011)(7416002)(2906002)(8676002)(66556008)(66476007)(5660300002)(4326008)(54906003)(6916009)(316002)(41300700001)(6666004)(6512007)(186003)(9686003)(6506007)(26005)(52116002)(53546011)(6486002)(38100700002)(478600001)(86362001)(1076003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zrZETpjZWPv1vhB076DC+cjXzHap0Fkq9AJpJaflNL0RuPCa6+rgEJSAhNmG?=
 =?us-ascii?Q?y788agIc6dbVSIP+V6xThu2Ac4WJzwUYfd4uDgN4Qd8gJ7KXX5dK38mFZQMX?=
 =?us-ascii?Q?yS15laqovAPFsrFnxfNCkPOrXCb20h56LMbOayjklkBZyqpS+M+xaD2Gdsot?=
 =?us-ascii?Q?kXFD4w4y5LHdHv/DCysoZ5iHhEXq+fSQ0E3/4gaTzGHAXa1LC8AodEZrdYlt?=
 =?us-ascii?Q?da4Mu7A7u0Ip5cwOnR8iicY6OkZBQ0K5S42tzB5EtoEsK+tZ/HA36O01c+QR?=
 =?us-ascii?Q?4eUhOhwpu75xbo4C+TnQ+Y5fD59wBq9L0Qht9ESkL63E56gIJmvJ65w5I2m3?=
 =?us-ascii?Q?fm4lrnDRGyGnAEL43OwWKAqrJhr4+TLTy8nLOP1vjTIaqEhlYeCqwWcJq7of?=
 =?us-ascii?Q?XkWNnxjkm77l/tqZ0/HbQVrCxJNAXN/s+rRELfwW21cXqpI7VgaDqZbi8iKH?=
 =?us-ascii?Q?Jp2SuuzOa41ZnqOr6sBbCDot9BCjSBM6XKQBzVmALxsZN6BacurpMTbwYwC8?=
 =?us-ascii?Q?qlXJPnDEY4MFATE40sazctdvIORd2jit8vE3e2xAd9r4Kl9+tCKxcIaeuZFE?=
 =?us-ascii?Q?gFz0urfEB1yyJZRCEsFBwqDmZSKFw62pKlX5F7O3Dj9ydZOQZHch3QOFHrZ2?=
 =?us-ascii?Q?ZdHy/DyIsN6/engcL8gvxDXiZozjQU5BTXhs7A8DWBd8xJKZGSnbH4uuG9VD?=
 =?us-ascii?Q?TVaVb6V3EhzEkSMYoviPHPKgBlM814I2AjopBXziCk3S0vfJd85dJxiy+EHw?=
 =?us-ascii?Q?SLbUHG5X7Cy2UFNJl+Ftklo0PyTwOmVdgp63zqfBqqV3HeFXjutFT+FWDv/K?=
 =?us-ascii?Q?B0ZxVpzC2Bswo6yPF2O1yx5Y+Q5Dt9qVaY9mp9HrUxc80UhVePWHSCxj6E+l?=
 =?us-ascii?Q?gMne2N5iCzk4aofiLmTfQ2kzMFoT83psTZ4muyv9+I5OhI198Z1PQTRP0zQK?=
 =?us-ascii?Q?OJEdrxtat2/UEXYvlwlUbkI3q30oylXWuVEzSIsqPsbF/YlEm/Tgw5QFFqTp?=
 =?us-ascii?Q?MUd+oNx+C/UugvXpKVxf78EhmYEip+67cZEuZk9C+Yzy8Io88Qn8F1zghdhf?=
 =?us-ascii?Q?XxLgRIv3nlnjxFSO3tg2x3Rt9aQKXZGsKGHNI+cUAWCrMEAHs1zxX5I8Kjd9?=
 =?us-ascii?Q?Z3wtXBpZ4DUgNFq+dQhlVIWLtkCgfsnTeYhk3N4n2ctY3If6KbKlNcrx3S0l?=
 =?us-ascii?Q?qy20PKCGZLKEkkcP1ThWtfMeOQ3HKfo+5xQ4CdXqXogErQki94TQeBp/Fnag?=
 =?us-ascii?Q?YrLLr81kSiO885z5KIpmpUH4DKM+wRlc2GL9JQ6Ad+WhVgEnhsO2c4cbECWw?=
 =?us-ascii?Q?wNvSBO2WJg1pWFI09mbu9C7nBLWDyY2kSabvhAmnM38UgblXy0x6ioDk6jyq?=
 =?us-ascii?Q?wSv939rhR69MM/st1qcM0ouSPqzxHU7UYXyrjQ8zUexMaI9i+r2cHB4Pv49x?=
 =?us-ascii?Q?7f5hcOjMAqeygFeTPcXJqQH3Y9pvEMQ1AL7oAN3zUyUVVjRIOoD4Ti/HZCXB?=
 =?us-ascii?Q?p4VsJ5b+oivZ4mJCb6XVE/GrYzroY8zcuqZkRWHk0Hx/cQm5pCeVtGU3m7dm?=
 =?us-ascii?Q?kY+j6btxNB53AoWZclH7Qn3i2CGCMoaOHaCmHrtw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a542c522-dcba-4a70-5fc7-08da7b8d88cc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 11:35:04.3935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITeAziEL0zuZogbqJgOeecZ3WVsUMXlWlF9dq0SxU+Kpp08zCXRdoLG2+xSM6nKvBm5sfhIPNmkkuqJZzUB0/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=660 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110034
X-Proofpoint-GUID: 8G6Z-ySl35Bct6PZ-z-z0udTKD3NuT4m
X-Proofpoint-ORIG-GUID: 8G6Z-ySl35Bct6PZ-z-z0udTKD3NuT4m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 11, 2022 at 07:25:58PM +0930, Brendan Trotter wrote:
> Hi,
>
> On Thu, Aug 11, 2022 at 3:16 AM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > On Wed, Aug 10, 2022 at 06:37:18PM +0930, Brendan Trotter wrote:
> >
> > > [1] doesn't provide any useful information. How does a kernel know
> > > that the callback provided by boot loader actually measures what it's
> > > supposed to measure, or even does anything at all?
> >
> > The kernel has no way to know this - *any* code you've run before
> > performing a measurement could tamper with the kernel such that it
> > believes it's fine. This is just as true in DRTM as it is in SRTM. But
> > you know what the expected measurements should be, so you're able to
> > either seal secrets to those PCR values or rely on remote attestation.
>
> In this scenario the kernel has no idea what the measurement should
> be, it only knows the measurement that a potentially malicious boot
> loader felt like giving the kernel previously (e.g. when the kernel
> was installed).
>
> > > [1] doesn't provide any useful information. Senter and skinit don't
> > > provide a method for kernel to detect that (e.g.) a MiTM boot loader
> > > has always measured a forgery and has changed unmeasured code in a
> > > different way every time you boot.
> >
> > Measurements are not opaque objects. If you're not able to reconstruct
> > the expected measurement then you're doing it wrong.
>
> OK; so to detect if boot loader has always given kernel a bad/forged
> measurement; the kernel repeats all of the steps involved in creating
> the measurement itself exactly the same as the boot loader should have
> (but might not have) so that kernel can compare a "known
> good/trustworthy" measurement with the useless measurement that the
> boot loader created for no sane reason whatsoever?

Could you tell us where exactly boot loader creates measurements for the DRTM?

Daniel
