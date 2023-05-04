Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627A36F6E13
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjEDOvf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjEDOvT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:51:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A46D7;
        Thu,  4 May 2023 07:51:18 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DeFli011077;
        Thu, 4 May 2023 14:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=AgfLFGdE6rrSurm61uLHPL1UaO98TOYAEit6wg3NKOQ=;
 b=UvhGIzs+Xbb2Sr58ME316pqO3r5xhc6VDvtCIqX77UCZ41a5VzAGtbWRdFdlD60KnMGi
 dUDmmOLoHSZdrLfZiHQd4Ja7EWGpbnkouHF9NdE70LT4EGf7WvV/Uw6uOS7mw1EPvgJO
 U+1gOuUsfT0+oX4cLf00eXLIrMuMg6nGPtcSC0Tq9t+tN6rJwaCi+yuVQxYaShHYowey
 2WLTqNecol+XJBpeBYp79EIENU+VEOZHX6DFhAGroED9M09/fJvwzU26CJJPSrisqU58
 ThUv65Efi3njXxchRQZM/MczJ+BOKjxP5CosD6cQNc8vmFQ5Xd2ZeBv5Em1k43VWLDk5 Lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5ft21k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:50:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344EPINg027145;
        Thu, 4 May 2023 14:50:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spevpkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:50:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0xkQeyO0tuMkf9Kse0d9AWJvLWWff1IHTnoOUDjoyaX8eWD1EyAn4b7whLmlfieunxcgNrNOE4mIWciH9+ZiYjJuAGssMjcLhj+UtYglv/nVL26OZk3YiP0RreJ6ycVU9XiWmCzLaorY2sWZEJlt5MiZVBAKuZnXdZFz++ICoSw3IhzEiVEHq5MpBTDRmCp3KdrSXQr1pQMd1Glzf9+3Zt8mRKFjoNO4okeb7cvpANsJBSP7PceIJahIC5C6y84A0czQTqk3vQOvUmgLrwLFQV+W4QthUKOcSGOgJGM/Ywt7n9HbP0/WbCqNwtdlXnXFC5CCPOHF1sZlaDGeRzpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgfLFGdE6rrSurm61uLHPL1UaO98TOYAEit6wg3NKOQ=;
 b=KuYGYta/NOzA2KTHeTrnojise1ml9RffaDeAEeS8pqwocfNeZUv/OPUx9qONTJJi/osT1zF5+RdKEYB52kYQNghSLkU78VU/TcqFBISjPYeVQGNgND2L0i3zoIxBCriOTt4LruBGn4Z7ffE8t3z6EAt73y7q5k/2VJ+JNZzWdiGoP+0IY3CH6Z+vJu3NUR8Bh3rh6w+cdgmTTTygSxzXUF7clDj3epODd1otR9DjyqInIMsO/Ta4+m20vMj3tAJjjO8ZmaQPPeLPIC3mrSbeKCCqyAN4H061Gy2xt6g8d1OAUywqCIv/SFXB+IuQvWSubpK9BbXExq4E0MPTQKtmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgfLFGdE6rrSurm61uLHPL1UaO98TOYAEit6wg3NKOQ=;
 b=qyw4ifSzj2iCnY1sQHdxVYhgjwpLbpPDvD5E+elGL3BrtLPw990qXFmS7lvam1rcx1uumXtaro7syTrPs3LRcIAtMi3hBrv75YViPv9mWttHv90f3kYKqLDPglM5UurzDndi6v2kYMwlGYGB/VL7fcPrs5O3C+sdGp8O3aNTH3U=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:50:53 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:50:53 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
Date:   Thu,  4 May 2023 14:50:13 +0000
Message-Id: <20230504145023.835096-5-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0163.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::6) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dfc258a-9949-4259-8630-08db4caef562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hz8WXuh3qCDjAc4lbLYgu5BkdrS51Mnws83LGsPqnnprwFbbeYRvZ80MhXSdbp1/+YC9269fGVftsN6behDuKqyCucE/bew34Uf+I/Iwp2lpr8Dfqxiarke7y0mlt9mNCs5R7bgxoN4uJ90JMQ3xes/wG8pTfeLWNYs00V5NBMiJEag107+i6RKw6GpF+DkFAnnXPdFyTZHbfe8taNpwQcEtweBu1M0SSiCSqSNv9icqJKhMjwVHCLjGdPV0xiN5wlbLxrDenG6ZwyuA1ifq/u2n+Mng3FOEsod1NF3pZArDaWBcIVqcWWe0Aa2K5o+650KF2JC9VIPzF8xPf9XJnH98HHT6CnsYOCVXmZtwNFQLi5usP6kRazRonbeVVeedGg+R1W1N8Kt6/fFcitARBdn7tEVLNsZYBNUUg6QW5tdBPiJ2B1IekgSKTbDYwAt1RrZyfN/UgaWNChyf/GWjXZ0FpzAwIlVH3SMC61qCjIpCCWJz/vi8+D/PpeQyapGHaMzs3GnPcWrYh8xwIOJTXNyETD+nkWzBpoR8bnYSDcRAFzwJvgY6kuNGCZDIotw2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(7416002)(2906002)(44832011)(8936002)(316002)(86362001)(4326008)(66556008)(66476007)(66946007)(8676002)(41300700001)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(478600001)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vDQiZ+AyjTnhUtcYCpx6mdxWPCUxHpKUh0U7iy8c0FDNhD1Q8ZJg5wK3s/ZQ?=
 =?us-ascii?Q?dOB2rbBw8BiD/hnnchRSwwfd/x7ejjqJVCsNtHrDS3jIQIq5bXIEJoDqzrhx?=
 =?us-ascii?Q?ztSRrMVojHQM3R7BHMwQKyG8ux1KZJvsnrrCHKJSQ8BTFzUEOHxNaQSwrsI0?=
 =?us-ascii?Q?5kaHyxHfxBfS8YXcvW7BRqlDY3lCcA3ZreydCXBwZ+4GDgOjeUNNUorkc1iY?=
 =?us-ascii?Q?hQV2/JRavWzKZDIWhBEkrz0+I1wlBn926iC0ab78z8yqPeE81KimxX8g5uXs?=
 =?us-ascii?Q?hE5yQyH/+J1AF9viUGeIa/4sPEilnO9EMbDti3ZBTvnIRlEcq98jicpf7Lcw?=
 =?us-ascii?Q?/9wgBcHVu7v2EGWChf+OCa5qOTO5T/SFaAOPuRZHbCkOLlhXXcQpPB3ZNKgr?=
 =?us-ascii?Q?ppB6jFXWi18GG+Bfu4arAM8xiuON6RXCDXA2ffyNMHJ3foNhy9tYd2f6CvQJ?=
 =?us-ascii?Q?Ss/2TfF0+jfJoR95D/ncjlXDxnM7Qp799YKy76Zb1yEAVzHtGkIqlj9NJawk?=
 =?us-ascii?Q?XTqh4IOEX8hbXCgQWFol+tORuBuZmgGKChKC0mFW4eXGkUiyWlyXKXLz5MqO?=
 =?us-ascii?Q?QSSg3kmhebODZ0uwgLysyAhptXu3KnIB4PUR+gdvb+XNlUYptHnORhMZ3TED?=
 =?us-ascii?Q?boLMoAQ+nVJsRxEa9D1pk93o8B0mpVbfM8tHA+mZQgOdPGzRXFf1yBcnU7Eo?=
 =?us-ascii?Q?9VArw0Hwf2Reo/gZLitSU0A7lTAOsuD2iAoEOrapMwFZM2shrcX03sh5NZu2?=
 =?us-ascii?Q?RvGtFdEpvvVESCgbXekQnjFQPCZHhggWBkzphjcMe5IcWXVttlypMjdcWjkC?=
 =?us-ascii?Q?iCNyu6Vv3k3PVzBKLQToPu5o3Qx46r/0jrinPXZ4BuKXWl64Wy0Wct0f+CPB?=
 =?us-ascii?Q?U4aOoHd3rjPWuP8HUvL9+GK9slOkyWyrhyZXxooRxXvJuFpFIcw6j/+vLhVu?=
 =?us-ascii?Q?k3zYkddu9qyDDi2egiIVB5YNpnpE4LNEnHFdUJbrm4jjM1OSG2x8AisXcG+p?=
 =?us-ascii?Q?eYbueYEqbxooYik5lv4WEQhK66jKJyrl0bZW9ZJxy7fDBrKg065Ye1iM954c?=
 =?us-ascii?Q?JztpZUpar2IramucALzLwErDA0KFLUIrdgiCgoCsgLSjWepXyq+y5pGNMP1+?=
 =?us-ascii?Q?HtOCqE6FFPChu86+L6aQQffqzw/FQfMKS0qbwZnr/i45+K2DeDK34XIQz4hS?=
 =?us-ascii?Q?BLwEEvwvv0Yb5WMjPaqzzrKYmEVxiayIXBr6hSMgsuJ+KgmfE+kzh2rrdUA/?=
 =?us-ascii?Q?JEntf8+auZVEWa4VVdGnWWHGhfntHxEGRJTdIoFQ33pNTiojB+XHzEACgwQ2?=
 =?us-ascii?Q?i7YAoVaYz8edtUdUDsGMeLM/ZyzIvak6S+SuvFgeBCqpxBi1epTO4iqAoq31?=
 =?us-ascii?Q?jC5kSZGA9B1Se+PsGJv5NLFbrhHrl+aE16PQnX1QuwEI/Xx0QXZS3unmNOn1?=
 =?us-ascii?Q?uwJnklsjFx7cchsfnT6PtnwwtrunDJRySaeQhSwYoXypvTF3WCb+RN8r/NAg?=
 =?us-ascii?Q?ZtbdCjWtCaUeXl8i50i6jGB/FLSCvqFNopaQhJZYs7RlW9Fph9eLtyczYx+O?=
 =?us-ascii?Q?t+OsPrGqgSe7XjJ0u/fYQBP76tOFQ6I08OtmsRnzU8avvlgG51Vqq/8N925/?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?juJqLmFK+miSzX6HMHYuc7irY+Nb+h6LUgPXEzCSrmrE4xiB6q/jPUA5BMC+?=
 =?us-ascii?Q?ZJ+lAifVebZEPzTHnzZ6tKoyH5wI4X3NkqxmdKhClIuPAREo+lttmvC8ydL6?=
 =?us-ascii?Q?nD85rfuKhWoBA06/4ckNzyLmiWjiQoBW/kibuJ1nYoPgPJT9T8GNytqlcEl0?=
 =?us-ascii?Q?FG7mszN/+tcmY+qwUdRQaPOzXtSFgXomIh1Wm2+xsZFkXlZz3Ozt0Gu5NZDW?=
 =?us-ascii?Q?DJ0RuKMFSStLH0Y0yZlQ5IL4NcJnz3A1oBCIRfAriSCN1Sz1Y/kagRSt5UG/?=
 =?us-ascii?Q?WYXzvj/L4rGi4UBQSZ+dY+YMQMPG6rXOfxxF6Y4khpYTdx/RPTmPDUZ3UKhS?=
 =?us-ascii?Q?9Qq1mxvV57AAXPFVqR0bmK+KFF2Eb9t5ZZOeGOhSeBZNo7W1lZnaWlseTLT8?=
 =?us-ascii?Q?bmHJzj8mjmUQKVdSKGmgsHyslZ95vgqCpBwjr+NhJUVG/RNhOCli+drRJpPm?=
 =?us-ascii?Q?0UD9tuUdYJzrlD9frjzv7z9sQFvMArRW/BD4raoeR7DtxEqDubAi/bU4GwFn?=
 =?us-ascii?Q?1POWrWoR5ltLGDFbtfd7tHtpQSPoJ3gH7ozMMeDBV7aN6mAWMzT4UIH2S048?=
 =?us-ascii?Q?gH14/9r1x+63ju7au/083qSUK6oDZD6DY3JaPCZUmh7DxLff3H0OpXZk3R2+?=
 =?us-ascii?Q?9IxwinwRwHS5h3MF3i3sJpvTVDVZ4zxmGqm4FjlcqfGbiCW9ScWtK+LBcEiA?=
 =?us-ascii?Q?PCvx9oVkJhARqEOlqPQViwFnI97gt7xOrDsIDo1wIK7bNsV/l5KjyYn2CdW8?=
 =?us-ascii?Q?pjfqBFGenQOp9DMzs/1y8oWHifVgGKI4pUxSBAevhAnUyF8FbRKzRFI3Km4q?=
 =?us-ascii?Q?UN6tLaLhR/hQC3AHWOaAmUFfni/rLuhKV3lgmnlggGJY2wmRTatD0Qcohvde?=
 =?us-ascii?Q?5XUAtPhnMW+jbFNluG/BGsLLrDsDR3lg9Mgvcs6V4mMNPgsh8R2ALAZM09Fj?=
 =?us-ascii?Q?shY3Auj3d/u7Xtrd9Kvd/V0HinE2KvbOEjMn9r5tfQRC50InrvG2j45zMBAb?=
 =?us-ascii?Q?sCLA8wwKPGwQYahxomwWkz7OEwvJtHh0gEOsypNcwGfgwPTRaKd+Gw/ffVf6?=
 =?us-ascii?Q?onVgPseuCEjKruKvqXviRjOVY3of6arqK8ikGQSF48kXHnqq6f/TjSKojjpW?=
 =?us-ascii?Q?KOSRlW2ie8R8P/x+hTOyEgO2ks6C5WLwcJNV19LZrQOwZHrQAR31mmUILnpM?=
 =?us-ascii?Q?Zm2NZuQw3U8Tg+uduQEWd6wuRbLdQYwshG22psvFOCqMl/PnIU5UV+BBe5mR?=
 =?us-ascii?Q?ZNEljHh3lUZ2ywsY0Ce89Ain+oKafZrS66goEBujdu5UBVg2pj1LJkN0Cd3N?=
 =?us-ascii?Q?TuI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfc258a-9949-4259-8630-08db4caef562
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:50:53.0305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCNkEolGjrtq87ExmNAqruxeCBbKDwy46ozrm6aL4pzzF0Y4XnMgbSQTg8SzLyTunhsg/rsKHuDLrE8ONn/U7Ctw1TtaBVNrotZJkiebVhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040122
X-Proofpoint-GUID: mWALsQ1zHX1h7ye4ZzfeD1fCUfAoaWE1
X-Proofpoint-ORIG-GUID: mWALsQ1zHX1h7ye4ZzfeD1fCUfAoaWE1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Introduce the Secure Launch Resource Table which forms the formal
interface between the pre and post launch code.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 include/linux/slr_table.h | 270 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 270 insertions(+)
 create mode 100644 include/linux/slr_table.h

diff --git a/include/linux/slr_table.h b/include/linux/slr_table.h
new file mode 100644
index 0000000..d4b76e5
--- /dev/null
+++ b/include/linux/slr_table.h
@@ -0,0 +1,270 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Secure Launch Resource Table
+ *
+ * Copyright (c) 2023, Oracle and/or its affiliates.
+ */
+
+#ifndef _LINUX_SLR_TABLE_H
+#define _LINUX_SLR_TABLE_H
+
+/* Put this in efi.h if it becomes a standard */
+#define SLR_TABLE_GUID				EFI_GUID(0x877a9b2a, 0x0385, 0x45d1, 0xa0, 0x34, 0x9d, 0xac, 0x9c, 0x9e, 0x56, 0x5f)
+
+/* SLR table header values */
+#define SLR_TABLE_MAGIC		0x4452544d
+#define SLR_TABLE_REVISION	1
+
+/* Current revisions for the policy and UEFI config */
+#define SLR_POLICY_REVISION		1
+#define SLR_UEFI_CONFIG_REVISION	1
+
+/* SLR defined architectures */
+#define SLR_INTEL_TXT		1
+#define SLR_AMD_SKINIT		2
+
+/* SLR defined bootloaders */
+#define SLR_BOOTLOADER_INVALID	0
+#define SLR_BOOTLOADER_GRUB	1
+
+/* Log formats */
+#define SLR_DRTM_TPM12_LOG	1
+#define SLR_DRTM_TPM20_LOG	2
+
+/* DRTM Policy Entry Flags */
+#define SLR_POLICY_FLAG_MEASURED	0x1
+#define SLR_POLICY_IMPLICIT_SIZE	0x2
+
+/* Array Lengths */
+#define TPM_EVENT_INFO_LENGTH		32
+#define TXT_VARIABLE_MTRRS_LENGTH	32
+
+/* Tags */
+#define SLR_ENTRY_INVALID	0x0000
+#define SLR_ENTRY_DL_INFO	0x0001
+#define SLR_ENTRY_LOG_INFO	0x0002
+#define SLR_ENTRY_ENTRY_POLICY	0x0003
+#define SLR_ENTRY_INTEL_INFO	0x0004
+#define SLR_ENTRY_AMD_INFO	0x0005
+#define SLR_ENTRY_ARM_INFO	0x0006
+#define SLR_ENTRY_UEFI_INFO	0x0007
+#define SLR_ENTRY_UEFI_CONFIG	0x0008
+#define SLR_ENTRY_END		0xffff
+
+/* Entity Types */
+#define SLR_ET_UNSPECIFIED	0x0000
+#define SLR_ET_SLRT		0x0001
+#define SLR_ET_BOOT_PARAMS	0x0002
+#define SLR_ET_SETUP_DATA	0x0003
+#define SLR_ET_CMDLINE		0x0004
+#define SLR_ET_UEFI_MEMMAP	0x0005
+#define SLR_ET_RAMDISK		0x0006
+#define SLR_ET_TXT_OS2MLE	0x0010
+#define SLR_ET_UNUSED		0xffff
+
+#ifndef __ASSEMBLY__
+
+/*
+ * Primary SLR Table Header
+ */
+struct slr_table {
+	u32 magic;
+	u16 revision;
+	u16 architecture;
+	u32 size;
+	u32 max_size;
+	/* entries[] */
+} __packed;
+
+/*
+ * Common SLRT Table Header
+ */
+struct slr_entry_hdr {
+	u16 tag;
+	u16 size;
+} __packed;
+
+/*
+ * Boot loader context
+ */
+struct slr_bl_context {
+	u16 bootloader;
+	u16 reserved;
+	u64 context;
+} __packed;
+
+/*
+ * DRTM Dynamic Launch Configuration
+ */
+struct slr_entry_dl_info {
+	struct slr_entry_hdr hdr;
+	struct slr_bl_context bl_context;
+	u64 dl_handler;
+	u64 dce_base;
+	u32 dce_size;
+	u64 dlme_entry;
+} __packed;
+
+/*
+ * TPM Log Information
+ */
+struct slr_entry_log_info {
+	struct slr_entry_hdr hdr;
+	u16 format;
+	u16 reserved;
+	u64 addr;
+	u32 size;
+} __packed;
+
+/*
+ * DRTM Measurement Policy
+ */
+struct slr_entry_policy {
+	struct slr_entry_hdr hdr;
+	u16 revision;
+	u16 nr_entries;
+	/* policy_entries[] */
+} __packed;
+
+/*
+ * DRTM Measurement Entry
+ */
+struct slr_policy_entry {
+	u16 pcr;
+	u16 entity_type;
+	u16 flags;
+	u16 reserved;
+	u64 entity;
+	u64 size;
+	char evt_info[TPM_EVENT_INFO_LENGTH];
+} __packed;
+
+/*
+ * Secure Launch defined MTRR saving structures
+ */
+struct slr_txt_mtrr_pair {
+	u64 mtrr_physbase;
+	u64 mtrr_physmask;
+} __packed;
+
+struct slr_txt_mtrr_state {
+	u64 default_mem_type;
+	u64 mtrr_vcnt;
+	struct slr_txt_mtrr_pair mtrr_pair[TXT_VARIABLE_MTRRS_LENGTH];
+} __packed;
+
+/*
+ * Intel TXT Info table
+ */
+struct slr_entry_intel_info {
+	struct slr_entry_hdr hdr;
+	u64 saved_misc_enable_msr;
+	struct slr_txt_mtrr_state saved_bsp_mtrrs;
+} __packed;
+
+/*
+ * AMD SKINIT Info table
+ */
+struct slr_entry_amd_info {
+	struct slr_entry_hdr hdr;
+} __packed;
+
+/*
+ * ARM DRTM Info table
+ */
+struct slr_entry_arm_info {
+	struct slr_entry_hdr hdr;
+} __packed;
+
+struct slr_entry_uefi_config {
+	struct slr_entry_hdr hdr;
+	u16 revision;
+	u16 nr_entries;
+	/* uefi_cfg_entries[] */
+} __packed;
+
+struct slr_uefi_cfg_entry {
+	u16 pcr;
+	u16 reserved;
+	u64 cfg; /* address or value */
+	u32 size;
+	char evt_info[TPM_EVENT_INFO_LENGTH];
+} __packed;
+
+static inline void *slr_end_of_entrys(struct slr_table *table)
+{
+	return (((void *)table) + table->size);
+}
+
+static inline struct slr_entry_hdr *
+slr_next_entry(struct slr_table *table,
+		struct slr_entry_hdr *curr)
+{
+	struct slr_entry_hdr *next = (struct slr_entry_hdr *)
+				((u8 *)curr + curr->size);
+
+	if ((void *)next >= slr_end_of_entrys(table))
+		return NULL;
+	if (next->tag == SLR_ENTRY_END)
+		return NULL;
+
+	return next;
+}
+
+static inline struct slr_entry_hdr *
+slr_next_entry_by_tag(struct slr_table *table,
+		      struct slr_entry_hdr *entry,
+		      u16 tag)
+{
+	if (!entry) /* Start from the beginning */
+		entry = (struct slr_entry_hdr *)(((u8 *)table) + sizeof(*table));
+
+	for ( ; ; ) {
+		if (entry->tag == tag)
+			return entry;
+
+		entry = slr_next_entry(table, entry);
+		if (!entry)
+			return NULL;
+	}
+
+	return NULL;
+}
+
+static inline int
+slr_add_entry(struct slr_table *table,
+	      struct slr_entry_hdr *entry)
+{
+	struct slr_entry_hdr *end;
+
+	if ((table->size + entry->size) > table->max_size)
+		return -1;
+
+	memcpy((u8 *)table + table->size - sizeof(*end), entry, entry->size);
+	table->size += entry->size;
+
+	end  = (struct slr_entry_hdr *)((u8 *)table + table->size - sizeof(*end));
+	end->tag = SLR_ENTRY_END;
+	end->size = sizeof(*end);
+
+	return 0;
+}
+
+static inline void
+slr_init_table(struct slr_table *slrt, u16 architecture, u32 max_size)
+{
+	struct slr_entry_hdr *end;
+
+	slrt->magic = SLR_TABLE_MAGIC;
+	slrt->revision = SLR_TABLE_REVISION;
+	slrt->architecture = architecture;
+	slrt->size = sizeof(*slrt) + sizeof(*end);
+	slrt->max_size = max_size;
+	end = (struct slr_entry_hdr *)((u8 *)slrt + sizeof(*slrt));
+	end->tag = SLR_ENTRY_END;
+	end->size = sizeof(*end);
+}
+
+#endif /* !__ASSEMBLY */
+
+#endif /* _LINUX_SLR_TABLE_H */
-- 
1.8.3.1

