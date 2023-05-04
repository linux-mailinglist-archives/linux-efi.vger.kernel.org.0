Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D1D6F6E34
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjEDOxL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjEDOwd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:52:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C040173C;
        Thu,  4 May 2023 07:51:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344Dh14W012034;
        Thu, 4 May 2023 14:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=WwNT0O/JdqKolPOjy4XvFuByFTuJE4lTKpu9M0gwa/k=;
 b=e3l51rMS+m9kyEqX4HU7f7bAhfsqFL31PmE9GKrzRB8A3Mben/Z4/Cf8SBiA6kHgNhsQ
 eWHTQ6Y5RnabBxnzBVtv5oiBd8/H7BZ5wZ4WPYzSqXrlYKCO7c6MVId0YgFWHcytiLCE
 SXoA4dvClq8cJFjRGIMciRqsP/wxelsXGRLm0MTl0PDTMwi0slcaugSsLmqGfUQuG1lR
 jIe8EipYCXV8P0ptgfeih3fMTOos6bQXEDAIWztaJjmuZMkuMwByzAuezmWu9UABwTVK
 hZyg3q0znDucbn/Ty11kIsNQtdnE6nzpAZVVHQR2qFwSxL5c8IyNMHRoXriyPLjgLDEn YQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv1ydw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344E8wte040442;
        Thu, 4 May 2023 14:51:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8mrf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqwcIB6SvAkqSgRtu8nqqdlb/N7Yl0fC/ZrtBUiJiZKPHjPn218PYAkXTyTfvs31urnEIEmx2Mnm1qHRFb/iprUDm89O/83TifRnu53N5SYelubNnZ7AshajaqRCXYD3LLrRrSQehQHwSPPsP2Otkho/m8up8AFhywpZMZeLkqAzgVRkLK/BbEpNcMeUfw0UubZt4nYmQAp4ceasHbuIS4QVBFJS7/+r54BmrEJwmMf3zjqeUpO1cudhhH6pr9o0bMpsfvxnK4lVT0prsPePecH2Yt2LQjUMvis57l2734BBCuI4J9rlBrveOm2Ue4fAAn/e4UWgEHguqi3JXDPIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwNT0O/JdqKolPOjy4XvFuByFTuJE4lTKpu9M0gwa/k=;
 b=PLOpu7PBNV+6fUF11qKiumtuR4f6lST512eQwln8fQLaG+hs4h1+lys9ZSRxYq4CZOyVmRr9195NPIN5hfHKPb6ko4DOvbgGrpK3NgooSYZWKTYYiGFq4xNn3Q9RRSUHtVTA3EvWuSovD3jKvPz9WEz2UIcmYTOwNJDzDkrMcfHC6jPnOQUcH7dHf7Z90kpmiQx1pvN8HU/24w/xmjL2Slw7GgnEIOmfASYfWR+7AA9Q2zyBi+bEJfmEseVYV1wbeHO7XtAgJDu19k2Wmtopp5eSar/zNKvDM7n5kcw/A4qIuTwc/Juv9CC6N8zoqJhYPd1OmTvk1MlNAEmoGA3H7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwNT0O/JdqKolPOjy4XvFuByFTuJE4lTKpu9M0gwa/k=;
 b=EN4hqYuTW5HRubw3wfAI6OqNL5kZgKEFGa1dnXei87vbeRlMiqchT4GrnzMipYcxKM7xn1LIgD6d9hyOaOyzy/AjgQyGpDb1+ltXyvv5PVcraxYucMa1yaYMSEkc5iBKOvDmuJWdCEV/X1qMR7PvGYsIcp/A1SpCWLqwljjQKr8=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:51:03 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:51:03 +0000
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
Subject: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
Date:   Thu,  4 May 2023 14:50:16 +0000
Message-Id: <20230504145023.835096-8-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::22) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|DM4PR10MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: f6afa273-29da-4478-4835-08db4caefb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VoglExqjxhmZ0+qI2SLo1iQprq8U2j1LCXZwVoQGJjCXJfTzEgd19mZEJY0q/tR4KwOYa59A7GDBblPYJWoRKWUzlm7Ll16PyVEpTaqZTYWLMkTkylKCzh118qMFOAgNR5/PMvVwEMYESU31uOIKF8QSszg3S6I/21ED4O0DjvkZltHZftyuVSBF3v5tMV2+OGt94aWmKZl0p1MXBLhsZ8+2ETlF8buRBVng32gV9E2KqZkYppGyr+HxV5ZvY2zdQU9bUy+yHNzcVplO0W+wncoYkYivs8slcqVZF+wV1rINHoXnW+kgHYM0m4P+L0rYbaWSmma43uEMClePL0lyzrg/dHSiXesuZCajfdmumHhfvLlyQ+bwKY1PP1+m0jY+Xzkd2mZLMjWGz7iqIagSvi+cjDVCR7VE/02faa1UrJ7xB5qCf5NhXALPofk+KOSJCo+ds7Kksj7XyTR1Mmnpu4emxsTSGSv6cCkK67TPENpzdHeBe0EgJsNjNUpvUmV+8boXhPK6pyd8/AZM7U9u/TUfv6pYv/jflJ9EJGPUKk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(83380400001)(6486002)(2906002)(30864003)(478600001)(316002)(5660300002)(8936002)(41300700001)(8676002)(44832011)(66946007)(66476007)(66556008)(4326008)(38100700002)(7416002)(86362001)(36756003)(6666004)(186003)(1076003)(26005)(6512007)(6506007)(966005)(2616005)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yGrxDctq8ototTn2BxhoMrQtnlh3XBiljh2LBNYCi/axCtlDn0Br4EUwYRuO?=
 =?us-ascii?Q?b8vnHCaPVPgqJda/IzW49eJxGJRlieT55BP3sPvzvEbvBHT9gyCTVMTG7DV5?=
 =?us-ascii?Q?pxOvsyf2jjYwudL1WDObmpsbFtgK3qQWOFJ7XuawxT6movrxnXGSl6s4IFzR?=
 =?us-ascii?Q?YUkhkrjNne8golPtVt9RvOv1sboft6U4bkJvcOZ+ceOgQIF5Z7XDYg4lKNyl?=
 =?us-ascii?Q?7KLYjUcukasIWZXCPpeE8552Puf/qjC6u1T740rJDrGhxUq/B8jPR+9Rcg5G?=
 =?us-ascii?Q?ThXOJiJ3JvVcR4bNEeU+JEfxViRKPns6Tuugmxuh0cI7qKjqJSCuHyX64y79?=
 =?us-ascii?Q?rMXTHSFXd3qOCLLQ9cfH08FCMb54QJW99yG8Lw8AQeTPqldIkObE9byKsPg8?=
 =?us-ascii?Q?suBip2dLS+eG3Iog2NtrypRvSbpARoDfRIKHGgcG+ZXMrEETZoRZnLoKYxPi?=
 =?us-ascii?Q?UssaGuOZj5YFTMBGxKjiusvkEj8HLMetubpLffSkT/kYWdMDv1+4FlpPsJuz?=
 =?us-ascii?Q?wGuu7SSjP/MqCvkR+CEM3zvP2wB5t+ddxmPKgFiu0AvZF4SHTRatg3sahDPe?=
 =?us-ascii?Q?GoSTXOlbRuwJZA7Oszqa8+Imm8bT4lviDzXWTVmhxqLBhHO83Z6Iq9AKO7cQ?=
 =?us-ascii?Q?ar1pYEfmMsc/Vna6OW6LC8jpEzLP554u9PUFoQkH82E9068JIFhXuPyGwXBS?=
 =?us-ascii?Q?whnYda/9deNdSdmn6ebgta1ENbXP/0M0DyRATgZREiqbuYYwTVKXG7kn298U?=
 =?us-ascii?Q?OMIO/JrzXfnrB4Yudqd4tSOB9TkcaCQmghuKX7NdngSIgGgTiqfEnPw1Vsj8?=
 =?us-ascii?Q?hLwGNuwJ0LHV0vz+870rV9tWsyg+ONve7xJk7BLZItRlDHjlbNsYGamR/RrJ?=
 =?us-ascii?Q?IGhZaAi0vP5K9KGyb5LbeVxeW3FWW0rpAT12lRqC4vCUH1KGUBc5PnffEvqi?=
 =?us-ascii?Q?cR8TToET+g+lRDHr7MuqKE1f6va5/iw2LIdJHwgC8eMQkeqkgTq/JI4z68SY?=
 =?us-ascii?Q?2KLHj9kcg4dhOyBFL9xmViai7+FzRAQkd2s4vhDLbWODgR1poWVXPSh3OXh8?=
 =?us-ascii?Q?9E9R0RRan+9kQ6ZSpkavPjcusz5VKQWDBygnlA2jGKfDjrDGvrYzQtKsyMK/?=
 =?us-ascii?Q?Oz2eheN8jkFSOYQ91Q3NE9/ZcJ7brR27W2RjWr+eaRlAbF7Zu94IlbV2q85S?=
 =?us-ascii?Q?zxmhsF6XtfOKuH5Y8pkinxPajsy7qK0SZNsLUc/APnJtfw6zot4LlN629rk/?=
 =?us-ascii?Q?wRJmdUtOQeT1qpZO/AH3CBWd7+yHLlE+Mkk+VtJuC72gHeZUE7N1TJx9MbGs?=
 =?us-ascii?Q?i/sX4OjqDemeFanXHQD7BMAd8ReGnY4m9IlNbflxHAkv/yPUkmLkHaUBCkdO?=
 =?us-ascii?Q?J/OSLj8ztvHAn6E1hsp/B9tfQ1q4H6Kj8P9+rm5736k3gkM4vQzo06ragz7f?=
 =?us-ascii?Q?X4QbJgy5zizvTO/QJSGCdzEluoC9jW2SMFhAHnFyjnoKC7HiYL2BQgeeZMJ6?=
 =?us-ascii?Q?ZDugy8LRDJwXVuYgnNPeuJFDhloUenZtxRIguY+PLrh82pHXSj76L+9+2PXD?=
 =?us-ascii?Q?Ke/YkKHrCeFzTlbzRmaj39+TgYG1o1LjMuffdSh6MN94+2JBRSRoFKczF8Xs?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3D+Hb1PAY/2/Tcq771Ot8bCVOtX2M/bJtyL0Lj5vlX0JFALSLcIMKjnKhvPl?=
 =?us-ascii?Q?qrNwLjTUAyqMHrqSd14Gx/5RCX6L1suA/SnneqrEh3xt4XYkh1T+bpNUiv/u?=
 =?us-ascii?Q?4arVIcE0f+4UeWyP/VI8+w2L3lI4+njvAyzipiHa5/hed90PUDuk9U8r/hyE?=
 =?us-ascii?Q?1K8MLMRprj4DHISGxgj2TEdI603RGHpvfMO3RVlYGYKAiaGTxjzz2TrUZbOG?=
 =?us-ascii?Q?Fl9NqLoI7ZhDqo/UvVDQWxaJ8fiYbBcIFLODCcT0UlVY25lE13iBbKGyqvAG?=
 =?us-ascii?Q?Ic48N3S6QbtFR7wF3/WEVCDk6YWflQ2zsVrQReOMuBqgeO/dKRfAfUo214cT?=
 =?us-ascii?Q?bQLjDuVBsRyr2yOIVxPLwrqSihiGICRbrCSRqTTucfKG6IN92rPu9BJY1Ay/?=
 =?us-ascii?Q?gEQia2wQh/HhwPDUSnYybsJO2OWldkz/eZNnq/e8jFT8tBiylttRjQbPyuzs?=
 =?us-ascii?Q?kCQvy4l1tSwDD+PztfQ4Q+uX+XUk1aCM3tWcSpVezeI+zNk7SLFQBEc/Z2Hr?=
 =?us-ascii?Q?Gsvna2BjPmwmBV788ZLd5t7HIb0yo14bs8z7IVlGNCBNE5HdDKfuHU7yPNL+?=
 =?us-ascii?Q?7Y3H1N33WEIvo/8BvdlrVPiRbubRwcN8sSvxlSCx93TeKqMHatYr2JRKFMj0?=
 =?us-ascii?Q?h4+iYwTJekczqWJITP1d62jGWV64Pmn7A5uJ8w0pDJFOkeqqZFXUGRfpH2td?=
 =?us-ascii?Q?Ls4GYGQeKxgaiwKb83UiLKB1e4CcUbMwB8kGsGxJbV8jRVbchQuV5CgPpQ6Y?=
 =?us-ascii?Q?kinLk/sSQC2z+wNGTuxwxBsXcdW8hu5MEriv7TYkz3qfEf3kv1I8p6Za4T7g?=
 =?us-ascii?Q?6YvurUwql/L1+9+8D7vyUMr6AiHWTvp+drgOFmMl4KA7NWVdXr+Mt9YdVOpP?=
 =?us-ascii?Q?VVujlFfQR6ORA9vIHFeE3ySU428y3lLjQ24oYdHDBWkFAjUV4JuD2bv/Xj1p?=
 =?us-ascii?Q?v6mm8idgzY1UOZ2SqjbFZuJ+mZNn64tCx3YxZqKZ2SClbOjgEA7+hJ2D2n+n?=
 =?us-ascii?Q?JdvmYP7w/eY7yOZuwldWDi62cdFz9fCUJwFTtW1C1twCfzCs0kY27ybypQLm?=
 =?us-ascii?Q?/9p4n93eMh06514On635Dt6sHq+dB8Yj8v8dObIKtqCAIsnu5VG0zGYUhcFz?=
 =?us-ascii?Q?mquU2iVGLD2RSnHvLux6dyQbGX+naXHCiqx8YR0g2Y5hIDTlb42g3Zy08qMj?=
 =?us-ascii?Q?sC8K9xJjHCPpkI9TT0z3fB+g3uK2LgrynYE6RwdnnLFapuwfKDi4ZMO2DTVo?=
 =?us-ascii?Q?aZ7Aj3yRcMVoyWfYNbPXfypSNpIpUyQQpA+AfGcOeqR3NXZo7fy3sV1p4Tdd?=
 =?us-ascii?Q?E6Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6afa273-29da-4478-4835-08db4caefb77
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:51:03.2196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F32hrxYCbxSnPs6DUOwXgJh2wAyWE/M7TzHmOUgKYAOxYc9CMvCkst4fin9n1SgMCd4ab7FQB/oxRL8YrLrxonHCS0u6WEukM2kr+R/kX7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7505
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040122
X-Proofpoint-ORIG-GUID: vz2qW_hjoeD66SXPweu5yijKAzGBnMkR
X-Proofpoint-GUID: vz2qW_hjoeD66SXPweu5yijKAzGBnMkR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The Secure Launch (SL) stub provides the entry point for Intel TXT (and
later AMD SKINIT) to vector to during the late launch. The symbol
sl_stub_entry is that entry point and its offset into the kernel is
conveyed to the launching code using the MLE (Measured Launch
Environment) header in the structure named mle_header. The offset of the
MLE header is set in the kernel_info. The routine sl_stub contains the
very early late launch setup code responsible for setting up the basic
environment to allow the normal kernel startup_32 code to proceed. It is
also responsible for properly waking and handling the APs on Intel
platforms. The routine sl_main which runs after entering 64b mode is
responsible for measuring configuration and module information before
it is used like the boot params, the kernel command line, the TXT heap,
an external initramfs, etc.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 Documentation/arch/x86/boot.rst        |  21 +
 arch/x86/boot/compressed/Makefile      |   3 +-
 arch/x86/boot/compressed/head_64.S     |  37 ++
 arch/x86/boot/compressed/kernel_info.S |  34 ++
 arch/x86/boot/compressed/sl_main.c     | 599 ++++++++++++++++++++++++++++
 arch/x86/boot/compressed/sl_stub.S     | 690 +++++++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/bootparam.h  |   1 +
 arch/x86/kernel/asm-offsets.c          |  20 +
 8 files changed, 1404 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/boot/compressed/sl_main.c
 create mode 100644 arch/x86/boot/compressed/sl_stub.S

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 33520ec..90552f7 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -482,6 +482,14 @@ Protocol:	2.00+
 	    - If 1, KASLR enabled.
 	    - If 0, KASLR disabled.
 
+  Bit 2 (kernel internal): SLAUNCH_FLAG
+
+	- Used internally by the compressed kernel to communicate
+	  Secure Launch status to kernel proper.
+
+	    - If 1, Secure Launch enabled.
+	    - If 0, Secure Launch disabled.
+
   Bit 5 (write): QUIET_FLAG
 
 	- If 0, print early messages.
@@ -1027,6 +1035,19 @@ Offset/size:	0x000c/4
 
   This field contains maximal allowed type for setup_data and setup_indirect structs.
 
+============	=================
+Field name:	mle_header_offset
+Offset/size:	0x0010/4
+============	=================
+
+  This field contains the offset to the Secure Launch Measured Launch Environment
+  (MLE) header. This offset is used to locate information needed during a secure
+  late launch using Intel TXT. If the offset is zero, the kernel does not have
+  Secure Launch capabilities. The MLE entry point is called from TXT on the BSP
+  following a success measured launch. The specific state of the processors is
+  outlined in the TXT Software Development Guide, the latest can be found here:
+  https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
+
 
 The Image Checksum
 ==================
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 1d327d4..7f31473 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -112,7 +112,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
 vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
-vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o \
+	$(obj)/sl_main.o $(obj)/sl_stub.o
 
 $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
 	$(call if_changed,ld)
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 03c4328..d079d8d 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -492,6 +492,17 @@ trampoline_return:
 	pushq	$0
 	popfq
 
+#ifdef CONFIG_SECURE_LAUNCH
+	pushq	%rsi
+
+	/* Ensure the relocation region coverd by a PMR */
+	movq	%rbx, %rdi
+	movl	$(_bss - startup_32), %esi
+	callq	sl_check_region
+
+	popq	%rsi
+#endif
+
 /*
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
@@ -551,6 +562,32 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	shrq	$3, %rcx
 	rep	stosq
 
+#ifdef CONFIG_SECURE_LAUNCH
+	/*
+	 * Have to do the final early sl stub work in 64b area.
+	 *
+	 * *********** NOTE ***********
+	 *
+	 * Several boot params get used before we get a chance to measure
+	 * them in this call. This is a known issue and we currently don't
+	 * have a solution. The scratch field doesn't matter. There is no
+	 * obvious way to do anything about the use of kernel_alignment or
+	 * init_size though these seem low risk with all the PMR and overlap
+	 * checks in place.
+	 */
+	pushq	%rsi
+
+	movq	%rsi, %rdi
+	callq	sl_main
+
+	/* Ensure the decompression location is coverd by a PMR */
+	movq	%rbp, %rdi
+	movq	output_len(%rip), %rsi
+	callq	sl_check_region
+
+	popq	%rsi
+#endif
+
 	pushq	%rsi
 	call	load_stage2_idt
 
diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
index c18f071..e199b87 100644
--- a/arch/x86/boot/compressed/kernel_info.S
+++ b/arch/x86/boot/compressed/kernel_info.S
@@ -28,6 +28,40 @@ SYM_DATA_START(kernel_info)
 	/* Maximal allowed type for setup_data and setup_indirect structs. */
 	.long	SETUP_TYPE_MAX
 
+	/* Offset to the MLE header structure */
+#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
+	.long	rva(mle_header)
+#else
+	.long	0
+#endif
+
 kernel_info_var_len_data:
 	/* Empty for time being... */
 SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
+
+#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
+	/*
+	 * The MLE Header per the TXT Specification, section 2.1
+	 * MLE capabilities, see table 4. Capabilities set:
+	 * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
+	 * bit 1: Support for RLP wakeup using MONITOR address
+	 * bit 2: The ECX register will contain the pointer to the MLE page table
+	 * bit 5: TPM 1.2 family: Details/authorities PCR usage support
+	 * bit 9: Supported format of TPM 2.0 event log - TCG compliant
+	 */
+SYM_DATA_START(mle_header)
+	.long	0x9082ac5a  /* UUID0 */
+	.long	0x74a7476f  /* UUID1 */
+	.long	0xa2555c0f  /* UUID2 */
+	.long	0x42b651cb  /* UUID3 */
+	.long	0x00000034  /* MLE header size */
+	.long	0x00020002  /* MLE version 2.2 */
+	.long	rva(sl_stub_entry) /* Linear entry point of MLE (virt. address) */
+	.long	0x00000000  /* First valid page of MLE */
+	.long	0x00000000  /* Offset within binary of first byte of MLE */
+	.long	rva(_edata) /* Offset within binary of last byte + 1 of MLE */
+	.long	0x00000227  /* Bit vector of MLE-supported capabilities */
+	.long	0x00000000  /* Starting linear address of command line (unused) */
+	.long	0x00000000  /* Ending linear address of command line (unused) */
+SYM_DATA_END(mle_header)
+#endif
diff --git a/arch/x86/boot/compressed/sl_main.c b/arch/x86/boot/compressed/sl_main.c
new file mode 100644
index 0000000..23d7722
--- /dev/null
+++ b/arch/x86/boot/compressed/sl_main.c
@@ -0,0 +1,599 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Secure Launch early measurement and validation routines.
+ *
+ * Copyright (c) 2022, Oracle and/or its affiliates.
+ */
+
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/linkage.h>
+#include <asm/segment.h>
+#include <asm/boot.h>
+#include <asm/msr.h>
+#include <asm/mtrr.h>
+#include <asm/processor-flags.h>
+#include <asm/asm-offsets.h>
+#include <asm/bootparam.h>
+#include <asm/bootparam_utils.h>
+#include <linux/slr_table.h>
+#include <linux/slaunch.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+
+#include "early_sha1.h"
+
+#define CAPS_VARIABLE_MTRR_COUNT_MASK	0xff
+
+#define SL_TPM12_LOG		1
+#define SL_TPM20_LOG		2
+
+#define SL_TPM20_MAX_ALGS	2
+
+#define SL_MAX_EVENT_DATA	64
+#define SL_TPM12_LOG_SIZE	(sizeof(struct tcg_pcr_event) + \
+				SL_MAX_EVENT_DATA)
+#define SL_TPM20_LOG_SIZE	(sizeof(struct tcg_pcr_event2_head) + \
+				SHA1_DIGEST_SIZE + SHA256_DIGEST_SIZE + \
+				sizeof(struct tcg_event_field) + \
+				SL_MAX_EVENT_DATA)
+
+static void *evtlog_base;
+static u32 evtlog_size;
+static struct txt_heap_event_log_pointer2_1_element *log20_elem;
+static u32 tpm_log_ver = SL_TPM12_LOG;
+struct tcg_efi_specid_event_algs tpm_algs[SL_TPM20_MAX_ALGS] = {0};
+
+extern u32 sl_cpu_type;
+extern u32 sl_mle_start;
+extern struct boot_params *boot_params;
+
+static u64 sl_txt_read(u32 reg)
+{
+	return readq((void *)(u64)(TXT_PRIV_CONFIG_REGS_BASE + reg));
+}
+
+static void sl_txt_write(u32 reg, u64 val)
+{
+	writeq(val, (void *)(u64)(TXT_PRIV_CONFIG_REGS_BASE + reg));
+}
+
+static void __noreturn sl_txt_reset(u64 error)
+{
+	/* Reading the E2STS register acts as a barrier for TXT registers */
+	sl_txt_write(TXT_CR_ERRORCODE, error);
+	sl_txt_read(TXT_CR_E2STS);
+	sl_txt_write(TXT_CR_CMD_UNLOCK_MEM_CONFIG, 1);
+	sl_txt_read(TXT_CR_E2STS);
+	sl_txt_write(TXT_CR_CMD_RESET, 1);
+
+	for ( ; ; )
+		asm volatile ("hlt");
+
+	unreachable();
+}
+
+static u64 sl_rdmsr(u32 reg)
+{
+	u64 lo, hi;
+
+	asm volatile ("rdmsr" : "=a" (lo), "=d" (hi) : "c" (reg));
+
+	return (hi << 32) | lo;
+}
+
+static struct slr_table *sl_locate_and_validate_slrt(void)
+{
+	struct txt_os_mle_data *os_mle_data;
+	struct slr_table *slrt;
+	void *txt_heap;
+
+	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
+	os_mle_data = txt_os_mle_data_start(txt_heap);
+
+	if (!os_mle_data->slrt)
+		sl_txt_reset(SL_ERROR_INVALID_SLRT);
+
+	slrt = (struct slr_table *)os_mle_data->slrt;
+
+	if (slrt->magic != SLR_TABLE_MAGIC)
+		sl_txt_reset(SL_ERROR_INVALID_SLRT);
+
+	if (slrt->architecture != SLR_INTEL_TXT)
+		sl_txt_reset(SL_ERROR_INVALID_SLRT);
+
+	return slrt;
+}
+
+static void sl_check_pmr_coverage(void *base, u32 size, bool allow_hi)
+{
+	struct txt_os_sinit_data *os_sinit_data;
+	void *end = base + size;
+	void *txt_heap;
+
+	if (!(sl_cpu_type & SL_CPU_INTEL))
+		return;
+
+	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
+	os_sinit_data = txt_os_sinit_data_start(txt_heap);
+
+	if ((end >= (void *)0x100000000ULL) &&
+	    (base < (void *)0x100000000ULL))
+		sl_txt_reset(SL_ERROR_REGION_STRADDLE_4GB);
+
+	/*
+	 * Note that the late stub code validates that the hi PMR covers
+	 * all memory above 4G. At this point the code can only check that
+	 * regions are within the hi PMR but that is sufficient.
+	 */
+	if ((end > (void *)0x100000000ULL) &&
+	    (base >= (void *)0x100000000ULL)) {
+		if (allow_hi) {
+			if (end >= (void *)(os_sinit_data->vtd_pmr_hi_base +
+					   os_sinit_data->vtd_pmr_hi_size))
+				sl_txt_reset(SL_ERROR_BUFFER_BEYOND_PMR);
+		} else
+			sl_txt_reset(SL_ERROR_REGION_ABOVE_4GB);
+	}
+
+	if (end >= (void *)os_sinit_data->vtd_pmr_lo_size)
+		sl_txt_reset(SL_ERROR_BUFFER_BEYOND_PMR);
+}
+
+/*
+ * Some MSRs are modified by the pre-launch code including the MTRRs.
+ * The early MLE code has to restore these values. This code validates
+ * the values after they are measured.
+ */
+static void sl_txt_validate_msrs(struct txt_os_mle_data *os_mle_data)
+{
+	struct slr_txt_mtrr_state *saved_bsp_mtrrs;
+	u64 mtrr_caps, mtrr_def_type, mtrr_var;
+	struct slr_entry_intel_info *txt_info;
+	u64 misc_en_msr;
+	u32 vcnt, i;
+
+	txt_info = (struct slr_entry_intel_info *)os_mle_data->txt_info;
+	saved_bsp_mtrrs = &(txt_info->saved_bsp_mtrrs);
+
+	mtrr_caps = sl_rdmsr(MSR_MTRRcap);
+	vcnt = (u32)(mtrr_caps & CAPS_VARIABLE_MTRR_COUNT_MASK);
+
+	if (saved_bsp_mtrrs->mtrr_vcnt > vcnt)
+		sl_txt_reset(SL_ERROR_MTRR_INV_VCNT);
+	if (saved_bsp_mtrrs->mtrr_vcnt > TXT_OS_MLE_MAX_VARIABLE_MTRRS)
+		sl_txt_reset(SL_ERROR_MTRR_INV_VCNT);
+
+	mtrr_def_type = sl_rdmsr(MSR_MTRRdefType);
+	if (saved_bsp_mtrrs->default_mem_type != mtrr_def_type)
+		sl_txt_reset(SL_ERROR_MTRR_INV_DEF_TYPE);
+
+	for (i = 0; i < saved_bsp_mtrrs->mtrr_vcnt; i++) {
+		mtrr_var = sl_rdmsr(MTRRphysBase_MSR(i));
+		if (saved_bsp_mtrrs->mtrr_pair[i].mtrr_physbase != mtrr_var)
+			sl_txt_reset(SL_ERROR_MTRR_INV_BASE);
+		mtrr_var = sl_rdmsr(MTRRphysMask_MSR(i));
+		if (saved_bsp_mtrrs->mtrr_pair[i].mtrr_physmask != mtrr_var)
+			sl_txt_reset(SL_ERROR_MTRR_INV_MASK);
+	}
+
+	misc_en_msr = sl_rdmsr(MSR_IA32_MISC_ENABLE);
+	if (txt_info->saved_misc_enable_msr != misc_en_msr)
+		sl_txt_reset(SL_ERROR_MSR_INV_MISC_EN);
+}
+
+static void sl_find_event_log(struct slr_table *slrt)
+{
+	struct txt_os_sinit_data *os_sinit_data;
+	struct slr_entry_log_info *log_info;
+	void *txt_heap;
+
+	log_info = (struct slr_entry_log_info *)
+			slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
+	if (!log_info)
+		sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
+
+	evtlog_base = (void *)log_info->addr;
+	evtlog_size = log_info->size;
+
+	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
+
+	/*
+	 * For TPM 2.0, the event log 2.1 extended data structure has to also
+	 * be located and fixed up.
+	 */
+	os_sinit_data = txt_os_sinit_data_start(txt_heap);
+
+	/*
+	 * Only support version 6 and later that properly handle the
+	 * list of ExtDataElements in the OS-SINIT structure.
+	 */
+	if (os_sinit_data->version < 6)
+		sl_txt_reset(SL_ERROR_OS_SINIT_BAD_VERSION);
+
+	/* Find the TPM2.0 logging extended heap element */
+	log20_elem = tpm20_find_log2_1_element(os_sinit_data);
+
+	/* If found, this implies TPM20 log and family */
+	if (log20_elem)
+		tpm_log_ver = SL_TPM20_LOG;
+}
+
+static void sl_validate_event_log_buffer(void)
+{
+	struct txt_os_sinit_data *os_sinit_data;
+	void *txt_heap, *txt_end;
+	void *mle_base, *mle_end;
+	void *evtlog_end;
+
+	if ((u64)evtlog_size > (LLONG_MAX - (u64)evtlog_base))
+		sl_txt_reset(SL_ERROR_INTEGER_OVERFLOW);
+	evtlog_end = evtlog_base + evtlog_size;
+
+	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
+	txt_end = txt_heap + sl_txt_read(TXT_CR_HEAP_SIZE);
+	os_sinit_data = txt_os_sinit_data_start(txt_heap);
+
+	mle_base = (void *)(u64)sl_mle_start;
+	mle_end = mle_base + os_sinit_data->mle_size;
+
+	/*
+	 * This check is to ensure the event log buffer does not overlap with
+	 * the MLE image.
+	 */
+	if ((evtlog_base >= mle_end) &&
+	    (evtlog_end > mle_end))
+		goto pmr_check; /* above */
+
+	if ((evtlog_end <= mle_base) &&
+	    (evtlog_base < mle_base))
+		goto pmr_check; /* below */
+
+	sl_txt_reset(SL_ERROR_MLE_BUFFER_OVERLAP);
+
+pmr_check:
+	/*
+	 * The TXT heap is protected by the DPR. If the TPM event log is
+	 * inside the TXT heap, there is no need for a PMR check.
+	 */
+	if ((evtlog_base > txt_heap) &&
+	    (evtlog_end < txt_end))
+		return;
+
+	sl_check_pmr_coverage(evtlog_base, evtlog_size, true);
+}
+
+static void sl_find_event_log_algorithms(void)
+{
+	struct tcg_efi_specid_event_head *efi_head =
+		(struct tcg_efi_specid_event_head *)(evtlog_base +
+					log20_elem->first_record_offset +
+					sizeof(struct tcg_pcr_event));
+
+	if (efi_head->num_algs == 0 || efi_head->num_algs > 2)
+		sl_txt_reset(SL_ERROR_TPM_NUMBER_ALGS);
+
+	memcpy(&tpm_algs[0], &efi_head->digest_sizes[0],
+	       sizeof(struct tcg_efi_specid_event_algs) * efi_head->num_algs);
+}
+
+static void sl_tpm12_log_event(u32 pcr, u32 event_type,
+			       const u8 *data, u32 length,
+			       const u8 *event_data, u32 event_size)
+{
+	u8 sha1_hash[SHA1_DIGEST_SIZE] = {0};
+	u8 log_buf[SL_TPM12_LOG_SIZE] = {0};
+	struct tcg_pcr_event *pcr_event;
+	struct sha1_state sctx = {0};
+	u32 total_size;
+
+	pcr_event = (struct tcg_pcr_event *)log_buf;
+	pcr_event->pcr_idx = pcr;
+	pcr_event->event_type = event_type;
+	if (length > 0) {
+		early_sha1_init(&sctx);
+		early_sha1_update(&sctx, data, length);
+		early_sha1_final(&sctx, &sha1_hash[0]);
+		memcpy(&pcr_event->digest[0], &sha1_hash[0], SHA1_DIGEST_SIZE);
+	}
+	pcr_event->event_size = event_size;
+	if (event_size > 0)
+		memcpy((u8 *)pcr_event + sizeof(struct tcg_pcr_event),
+		       event_data, event_size);
+
+	total_size = sizeof(struct tcg_pcr_event) + event_size;
+
+	if (tpm12_log_event(evtlog_base, evtlog_size, total_size, pcr_event))
+		sl_txt_reset(SL_ERROR_TPM_LOGGING_FAILED);
+}
+
+static void sl_tpm20_log_event(u32 pcr, u32 event_type,
+			       const u8 *data, u32 length,
+			       const u8 *event_data, u32 event_size)
+{
+	u8 sha256_hash[SHA256_DIGEST_SIZE] = {0};
+	u8 sha1_hash[SHA1_DIGEST_SIZE] = {0};
+	u8 log_buf[SL_TPM20_LOG_SIZE] = {0};
+	struct sha256_state sctx256 = {0};
+	struct tcg_pcr_event2_head *head;
+	struct tcg_event_field *event;
+	struct sha1_state sctx1 = {0};
+	u32 total_size;
+	u16 *alg_ptr;
+	u8 *dgst_ptr;
+
+	head = (struct tcg_pcr_event2_head *)log_buf;
+	head->pcr_idx = pcr;
+	head->event_type = event_type;
+	total_size = sizeof(struct tcg_pcr_event2_head);
+	alg_ptr = (u16 *)(log_buf + sizeof(struct tcg_pcr_event2_head));
+
+	for ( ; head->count < 2; head->count++) {
+		if (!tpm_algs[head->count].alg_id)
+			break;
+
+		*alg_ptr = tpm_algs[head->count].alg_id;
+		dgst_ptr = (u8 *)alg_ptr + sizeof(u16);
+
+		if (tpm_algs[head->count].alg_id == TPM_ALG_SHA256 &&
+		    length) {
+			sha256_init(&sctx256);
+			sha256_update(&sctx256, data, length);
+			sha256_final(&sctx256, &sha256_hash[0]);
+		} else if (tpm_algs[head->count].alg_id == TPM_ALG_SHA1 &&
+			   length) {
+			early_sha1_init(&sctx1);
+			early_sha1_update(&sctx1, data, length);
+			early_sha1_final(&sctx1, &sha1_hash[0]);
+		}
+
+		if (tpm_algs[head->count].alg_id == TPM_ALG_SHA256) {
+			memcpy(dgst_ptr, &sha256_hash[0], SHA256_DIGEST_SIZE);
+			total_size += SHA256_DIGEST_SIZE + sizeof(u16);
+			alg_ptr = (u16 *)((u8 *)alg_ptr + SHA256_DIGEST_SIZE + sizeof(u16));
+		} else if (tpm_algs[head->count].alg_id == TPM_ALG_SHA1) {
+			memcpy(dgst_ptr, &sha1_hash[0], SHA1_DIGEST_SIZE);
+			total_size += SHA1_DIGEST_SIZE + sizeof(u16);
+			alg_ptr = (u16 *)((u8 *)alg_ptr + SHA1_DIGEST_SIZE + sizeof(u16));
+		} else
+			sl_txt_reset(SL_ERROR_TPM_UNKNOWN_DIGEST);
+	}
+
+	event = (struct tcg_event_field *)(log_buf + total_size);
+	event->event_size = event_size;
+	if (event_size > 0)
+		memcpy((u8 *)event + sizeof(struct tcg_event_field),
+		       event_data, event_size);
+	total_size += sizeof(struct tcg_event_field) + event_size;
+
+	if (tpm20_log_event(log20_elem, evtlog_base, evtlog_size,
+	    total_size, &log_buf[0]))
+		sl_txt_reset(SL_ERROR_TPM_LOGGING_FAILED);
+}
+
+static void sl_tpm_extend_evtlog(u32 pcr, u32 type,
+				 const u8 *data, u32 length, const char *desc)
+{
+	if (tpm_log_ver == SL_TPM20_LOG)
+		sl_tpm20_log_event(pcr, type, data, length,
+				   (const u8 *)desc, strlen(desc));
+	else
+		sl_tpm12_log_event(pcr, type, data, length,
+				   (const u8 *)desc, strlen(desc));
+}
+
+static struct setup_data *sl_handle_setup_data(struct setup_data *curr,
+					       struct slr_policy_entry *entry)
+{
+	struct setup_indirect *ind;
+	struct setup_data *next;
+
+	if (!curr)
+		return NULL;
+
+	next = (struct setup_data *)(unsigned long)curr->next;
+
+	/* SETUP_INDIRECT instances have to be handled differently */
+	if (curr->type == SETUP_INDIRECT) {
+		ind = (struct setup_indirect *)
+			((u8 *)curr + offsetof(struct setup_data, data));
+
+		sl_check_pmr_coverage((void *)ind->addr, ind->len, true);
+
+		sl_tpm_extend_evtlog(entry->pcr, TXT_EVTYPE_SLAUNCH,
+				     (void *)ind->addr, ind->len,
+				     entry->evt_info);
+
+		return next;
+	}
+
+	sl_check_pmr_coverage(((u8 *)curr) + sizeof(struct setup_data),
+			      curr->len, true);
+
+	sl_tpm_extend_evtlog(entry->pcr, TXT_EVTYPE_SLAUNCH,
+			     ((u8 *)curr) + sizeof(struct setup_data),
+			     curr->len,
+			     entry->evt_info);
+
+	return next;
+}
+
+static void sl_extend_setup_data(struct slr_policy_entry *entry)
+{
+	struct setup_data *data;
+
+	/*
+	 * Measuring the boot params measured the fixed e820 memory map.
+	 * Measure any setup_data entries including e820 extended entries.
+	 */
+	data = (struct setup_data *)(unsigned long)entry->entity;
+	while (data)
+		data = sl_handle_setup_data(data, entry);
+}
+
+static void sl_extend_slrt(struct slr_policy_entry *entry)
+{
+	struct slr_table *slrt = (struct slr_table *)entry->entity;
+	struct slr_entry_intel_info *intel_info;
+
+	/*
+	 * In revision one of the SLRT, the only table that needs to be
+	 * measured is the Intel info table. Everything else is meta-data,
+	 * addresses and sizes.
+	 */
+	if (slrt->revision == 1) {
+		intel_info = (struct slr_entry_intel_info *)
+				slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
+		if (!intel_info)
+			sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
+
+		sl_tpm_extend_evtlog(entry->pcr, TXT_EVTYPE_SLAUNCH,
+				     (void *)entry->entity, entry->size,
+				     entry->evt_info);
+	}
+}
+
+static void sl_extend_txt_os2mle(struct slr_policy_entry *entry)
+{
+	struct txt_os_mle_data *os_mle_data;
+	void *txt_heap;
+
+	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
+	os_mle_data = txt_os_mle_data_start(txt_heap);
+
+	/*
+	 * Version 1 of the OS-MLE heap structure has no fields to measure. It just
+	 * has addresses and sizes and a scratch buffer.
+	 */
+	if (os_mle_data->version == 1)
+		return;
+}
+
+static void sl_process_extend_policy(struct slr_table *slrt)
+{
+	struct slr_entry_policy *policy;
+	struct slr_policy_entry *entry;
+	u16 i = 0;
+
+	policy =(struct slr_entry_policy *)
+		slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
+	if (!policy)
+		sl_txt_reset(SL_ERROR_SLRT_MISSING_ENTRY);
+
+	entry = (struct slr_policy_entry *)((u8 *)policy + sizeof(*policy));
+
+	for ( ; i < policy->nr_entries; i++, entry++) {
+		switch (entry->entity_type) {
+		case SLR_ET_SETUP_DATA:
+			sl_extend_setup_data(entry);
+			break;
+		case SLR_ET_SLRT:
+			sl_extend_slrt(entry);
+			break;
+		case SLR_ET_TXT_OS2MLE:
+			sl_extend_txt_os2mle(entry);
+			break;
+		case SLR_ET_UNUSED:
+			continue;
+		default:
+			sl_tpm_extend_evtlog(entry->pcr, TXT_EVTYPE_SLAUNCH,
+					     (void *)entry->entity, entry->size,
+					     entry->evt_info);
+		}
+	}
+}
+
+static void sl_process_extend_uefi_config(struct slr_table *slrt)
+{
+	struct slr_entry_uefi_config *uefi_config;
+	struct slr_uefi_cfg_entry *uefi_entry;
+	u64 i;
+
+	uefi_config =(struct slr_entry_uefi_config *)
+		slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_UEFI_CONFIG);
+
+	/* Optionally here depending on how SL kernel was booted */
+	if (!uefi_config)
+		return;
+
+	uefi_entry = (struct slr_uefi_cfg_entry *)((u8 *)uefi_config + sizeof(*uefi_config));
+
+	for ( ; i < uefi_config->nr_entries; i++, uefi_entry++) {
+		sl_tpm_extend_evtlog(uefi_entry->pcr, TXT_EVTYPE_SLAUNCH,
+				     (void *)uefi_entry->cfg, uefi_entry->size,
+				     uefi_entry->evt_info);
+	}
+}
+
+asmlinkage __visible void sl_check_region(void *base, u32 size)
+{
+	sl_check_pmr_coverage(base, size, false);
+}
+
+asmlinkage __visible void sl_main(void *bootparams)
+{
+	struct boot_params *bp  = (struct boot_params *)bootparams;
+	struct txt_os_mle_data *os_mle_data;
+	struct slr_table *slrt;
+	void *txt_heap;
+
+	/*
+	 * Ensure loadflags do not indicate a secure launch was done
+	 * unless it really was.
+	 */
+	bp->hdr.loadflags &= ~SLAUNCH_FLAG;
+
+	/*
+	 * Currently only Intel TXT is supported for Secure Launch. Testing
+	 * this value also indicates that the kernel was booted successfully
+	 * through the Secure Launch entry point and is in SMX mode.
+	 */
+	if (!(sl_cpu_type & SL_CPU_INTEL))
+		return;
+
+	slrt = sl_locate_and_validate_slrt();
+
+	/* Locate the TPM event log. */
+	sl_find_event_log(slrt);
+
+	/* Validate the location of the event log buffer before using it */
+	sl_validate_event_log_buffer();
+
+	/*
+	 * Find the TPM hash algorithms used by the ACM and recorded in the
+	 * event log.
+	 */
+	if (tpm_log_ver == SL_TPM20_LOG)
+		sl_find_event_log_algorithms();
+
+	/*
+	 * Sanitize them before measuring. Set the SLAUNCH_FLAG early since if
+	 * anything fails, the system will reset anyway.
+	 */
+	boot_params = (struct boot_params *)bootparams;
+	sanitize_boot_params(boot_params);
+	bp->hdr.loadflags |= SLAUNCH_FLAG;
+
+	sl_check_pmr_coverage(bootparams, PAGE_SIZE, false);
+
+	/* Place event log SL specific tags before and after measurements */
+	sl_tpm_extend_evtlog(17, TXT_EVTYPE_SLAUNCH_START, NULL, 0, "");
+
+	/* Process all policy entries and extend the measurements to the evtlog */
+	sl_process_extend_policy(slrt);
+
+	/* Process all EFI config entries and extend the measurements to the evtlog */
+	sl_process_extend_uefi_config(slrt);
+
+	sl_tpm_extend_evtlog(17, TXT_EVTYPE_SLAUNCH_END, NULL, 0, "");
+
+	/* No PMR check is needed, the TXT heap is covered by the DPR */
+	txt_heap = (void *)sl_txt_read(TXT_CR_HEAP_BASE);
+	os_mle_data = txt_os_mle_data_start(txt_heap);
+
+	/*
+	 * Now that the OS-MLE data is measured, ensure the MTRR and
+	 * misc enable MSRs are what we expect.
+	 */
+	sl_txt_validate_msrs(os_mle_data);
+}
diff --git a/arch/x86/boot/compressed/sl_stub.S b/arch/x86/boot/compressed/sl_stub.S
new file mode 100644
index 0000000..2d8aa3a
--- /dev/null
+++ b/arch/x86/boot/compressed/sl_stub.S
@@ -0,0 +1,690 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Secure Launch protected mode entry point.
+ *
+ * Copyright (c) 2022, Oracle and/or its affiliates.
+ */
+	.code32
+	.text
+#include <linux/linkage.h>
+#include <asm/segment.h>
+#include <asm/msr.h>
+#include <asm/processor-flags.h>
+#include <asm/asm-offsets.h>
+#include <asm/bootparam.h>
+#include <asm/page_types.h>
+#include <asm/irq_vectors.h>
+#include <linux/slr_table.h>
+#include <linux/slaunch.h>
+
+/* CPUID: leaf 1, ECX, SMX feature bit */
+#define X86_FEATURE_BIT_SMX	(1 << 6)
+
+/* Can't include apiddef.h in asm */
+#define XAPIC_ENABLE	(1 << 11)
+#define X2APIC_ENABLE	(1 << 10)
+
+/* Can't include traps.h in asm */
+#define X86_TRAP_NMI	2
+
+/* Can't include mtrr.h in asm */
+#define MTRRphysBase0	0x200
+
+#define IDT_VECTOR_LO_BITS	0
+#define IDT_VECTOR_HI_BITS	6
+
+/*
+ * See the comment in head_64.S for detailed informatoin on what this macro
+ * is used for.
+ */
+#define rva(X) ((X) - sl_stub_entry)
+
+/*
+ * The GETSEC op code is open coded because older versions of
+ * GCC do not support the getsec mnemonic.
+ */
+.macro GETSEC leaf
+	pushl	%ebx
+	xorl	%ebx, %ebx	/* Must be zero for SMCTRL */
+	movl	\leaf, %eax	/* Leaf function */
+	.byte 	0x0f, 0x37	/* GETSEC opcode */
+	popl	%ebx
+.endm
+
+.macro TXT_RESET error
+	/*
+	 * Set a sticky error value and reset. Note the movs to %eax act as
+	 * TXT register barriers.
+	 */
+	movl	\error, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_ERRORCODE)
+	movl	(TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_E2STS), %eax
+	movl	$1, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_CMD_NO_SECRETS)
+	movl	(TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_E2STS), %eax
+	movl	$1, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_CMD_UNLOCK_MEM_CONFIG)
+	movl	(TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_E2STS), %eax
+	movl	$1, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_CMD_RESET)
+1:
+	hlt
+	jmp	1b
+.endm
+
+	.code32
+SYM_FUNC_START(sl_stub_entry)
+	cli
+	cld
+
+	/*
+	 * On entry, %ebx has the entry abs offset to sl_stub_entry. This
+	 * will be correctly scaled using the rva macro and avoid causing
+	 * relocations. Only %cs and %ds segments are known good.
+	 */
+
+	/* Load GDT, set segment regs and lret to __SL32_CS */
+	leal	rva(sl_gdt_desc)(%ebx), %eax
+	addl	%eax, 2(%eax)
+	lgdt	(%eax)
+
+	movl	$(__SL32_DS), %eax
+	movw	%ax, %ds
+	movw	%ax, %es
+	movw	%ax, %fs
+	movw	%ax, %gs
+	movw	%ax, %ss
+
+	/*
+	 * Now that %ss is known good, take the first stack for the BSP. The
+	 * AP stacks are only used on Intel.
+	 */
+	leal	rva(sl_stacks_end)(%ebx), %esp
+
+	leal	rva(.Lsl_cs)(%ebx), %eax
+	pushl	$(__SL32_CS)
+	pushl	%eax
+	lret
+
+.Lsl_cs:
+	/* Save our base pointer reg and page table for MLE */
+	pushl	%ebx
+	pushl	%ecx
+
+	/* See if SMX feature is supported. */
+	movl	$1, %eax
+	cpuid
+	testl	$(X86_FEATURE_BIT_SMX), %ecx
+	jz	.Ldo_unknown_cpu
+
+	popl	%ecx
+	popl	%ebx
+
+	/* Know it is Intel */
+	movl	$(SL_CPU_INTEL), rva(sl_cpu_type)(%ebx)
+
+	/* Locate the base of the MLE using the page tables in %ecx */
+	call	sl_find_mle_base
+
+	/* Increment CPU count for BSP */
+	incl	rva(sl_txt_cpu_count)(%ebx)
+
+	/*
+	 * Enable SMI with GETSEC[SMCTRL] which were disabled by SENTER.
+	 * NMIs were also disabled by SENTER. Since there is no IDT for the BSP,
+	 * allow the mainline kernel re-enable them in the normal course of
+	 * booting.
+	 */
+	GETSEC	$(SMX_X86_GETSEC_SMCTRL)
+
+	/* Clear the TXT error registers for a clean start of day */
+	movl	$0, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_ERRORCODE)
+	movl	$0xffffffff, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_ESTS)
+
+	/* On Intel, the zero page address is passed in the TXT heap */
+	/* Read physical base of heap into EAX */
+	movl	(TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_HEAP_BASE), %eax
+	/* Read the size of the BIOS data into ECX (first 8 bytes) */
+	movl	(%eax), %ecx
+	/* Skip over BIOS data and size of OS to MLE data section */
+	leal	8(%eax, %ecx), %eax
+
+	/* Need to verify the values in the OS-MLE struct passed in */
+	call	sl_txt_verify_os_mle_struct
+
+	/*
+	 * Get the boot params address from the heap. Note %esi and %ebx MUST
+	 * be preserved across calls and operations.
+	 */
+	movl	SL_boot_params_addr(%eax), %esi
+
+	/* Save %ebx so the APs can find their way home */
+	movl	%ebx, (SL_mle_scratch + SL_SCRATCH_AP_EBX)(%eax)
+
+	/* Fetch the AP wake code block address from the heap */
+	movl	SL_ap_wake_block(%eax), %edi
+	movl	%edi, rva(sl_txt_ap_wake_block)(%ebx)
+
+	/* Store the offset in the AP wake block to the jmp address */
+	movl	$(sl_ap_jmp_offset - sl_txt_ap_wake_begin), \
+		(SL_mle_scratch + SL_SCRATCH_AP_JMP_OFFSET)(%eax)
+
+	/* %eax still is the base of the OS-MLE block, save it */
+	pushl	%eax
+
+	/* Relocate the AP wake code to the safe block */
+	call	sl_txt_reloc_ap_wake
+
+	/*
+	 * Wake up all APs that are blocked in the ACM and wait for them to
+	 * halt. This should be done before restoring the MTRRs so the ACM is
+	 * still properly in WB memory.
+	 */
+	call	sl_txt_wake_aps
+
+	/* Restore OS-MLE in %eax */
+	popl	%eax
+
+	/*
+	 * %edi is used by this routine to find the MTRRs which are in the SLRT
+	 * in the Intel info.
+	 */
+	movl	SL_txt_info(%eax), %edi
+	call	sl_txt_load_regs
+
+	jmp	.Lcpu_setup_done
+
+.Ldo_unknown_cpu:
+	/* Non-Intel CPUs are not yet supported */
+	ud2
+
+.Lcpu_setup_done:
+	/*
+	 * Don't enable MCE at this point. The kernel will enable
+	 * it on the BSP later when it is ready.
+	 */
+
+	/* Done, jump to normal 32b pm entry */
+	jmp	startup_32
+SYM_FUNC_END(sl_stub_entry)
+
+SYM_FUNC_START(sl_find_mle_base)
+	/* %ecx has PDPT, get first PD */
+	movl	(%ecx), %eax
+	andl	$(PAGE_MASK), %eax
+	/* Get first PT from first PDE */
+	movl	(%eax), %eax
+	andl	$(PAGE_MASK), %eax
+	/* Get MLE base from first PTE */
+	movl	(%eax), %eax
+	andl	$(PAGE_MASK), %eax
+
+	movl	%eax, rva(sl_mle_start)(%ebx)
+	ret
+SYM_FUNC_END(sl_find_mle_base)
+
+SYM_FUNC_START(sl_check_buffer_mle_overlap)
+	/* %ecx: buffer begin %edx: buffer end */
+	/* %ebx: MLE begin %edi: MLE end */
+
+	cmpl	%edi, %ecx
+	jb	.Lnext_check
+	cmpl	%edi, %edx
+	jbe	.Lnext_check
+	jmp	.Lvalid /* Buffer above MLE */
+
+.Lnext_check:
+	cmpl	%ebx, %edx
+	ja	.Linvalid
+	cmpl	%ebx, %ecx
+	jae	.Linvalid
+	jmp	.Lvalid /* Buffer below MLE */
+
+.Linvalid:
+	TXT_RESET $(SL_ERROR_MLE_BUFFER_OVERLAP)
+
+.Lvalid:
+	ret
+SYM_FUNC_END(sl_check_buffer_mle_overlap)
+
+SYM_FUNC_START(sl_txt_verify_os_mle_struct)
+	pushl	%ebx
+	/*
+	 * %eax points to the base of the OS-MLE struct. Need to also
+	 * read some values from the OS-SINIT struct too.
+	 */
+	movl	-8(%eax), %ecx
+	/* Skip over OS to MLE data section and size of OS-SINIT structure */
+	leal	(%eax, %ecx), %edx
+
+	/* Load MLE image base absolute offset */
+	movl	rva(sl_mle_start)(%ebx), %ebx
+
+	/* Verify the value of the low PMR base. It should always be 0. */
+	movl	SL_vtd_pmr_lo_base(%edx), %esi
+	cmpl	$0, %esi
+	jz	.Lvalid_pmr_base
+	TXT_RESET $(SL_ERROR_LO_PMR_BASE)
+
+.Lvalid_pmr_base:
+	/* Grab some values from OS-SINIT structure */
+	movl	SL_mle_size(%edx), %edi
+	addl	%ebx, %edi
+	jc	.Loverflow_detected
+	movl	SL_vtd_pmr_lo_size(%edx), %esi
+
+	/* Check the AP wake block */
+	movl	SL_ap_wake_block(%eax), %ecx
+	movl	SL_ap_wake_block_size(%eax), %edx
+	addl	%ecx, %edx
+	jc	.Loverflow_detected
+	call	sl_check_buffer_mle_overlap
+	cmpl	%esi, %edx
+	ja	.Lbuffer_beyond_pmr
+
+	/* Check the boot params */
+	movl	SL_boot_params_addr(%eax), %ecx
+	movl	$(PAGE_SIZE), %edx
+	addl	%ecx, %edx
+	jc	.Loverflow_detected
+	call	sl_check_buffer_mle_overlap
+	cmpl	%esi, %edx
+	ja	.Lbuffer_beyond_pmr
+
+	/* Check that the AP wake block is big enough */
+	cmpl	$(sl_txt_ap_wake_end - sl_txt_ap_wake_begin), \
+		SL_ap_wake_block_size(%eax)
+	jae	.Lwake_block_ok
+	TXT_RESET $(SL_ERROR_WAKE_BLOCK_TOO_SMALL)
+
+.Lwake_block_ok:
+	popl	%ebx
+	ret
+
+.Loverflow_detected:
+	TXT_RESET $(SL_ERROR_INTEGER_OVERFLOW)
+
+.Lbuffer_beyond_pmr:
+	TXT_RESET $(SL_ERROR_BUFFER_BEYOND_PMR)
+SYM_FUNC_END(sl_txt_verify_os_mle_struct)
+
+SYM_FUNC_START(sl_txt_ap_entry)
+	cli
+	cld
+	/*
+	 * The %cs and %ds segments are known good after waking the AP.
+	 * First order of business is to find where we are and
+	 * save it in %ebx.
+	 */
+
+	/* Read physical base of heap into EAX */
+	movl	(TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_HEAP_BASE), %eax
+	/* Read the size of the BIOS data into ECX (first 8 bytes) */
+	movl	(%eax), %ecx
+	/* Skip over BIOS data and size of OS to MLE data section */
+	leal	8(%eax, %ecx), %eax
+
+	/* Saved %ebx from the BSP and stash OS-MLE pointer */
+	movl	(SL_mle_scratch + SL_SCRATCH_AP_EBX)(%eax), %ebx
+
+	/* Save TXT info ptr in %edi for call to sl_txt_load_regs */
+	movl	SL_txt_info(%eax), %edi
+
+	/* Lock and get our stack index */
+	movl	$1, %ecx
+.Lspin:
+	xorl	%eax, %eax
+	lock cmpxchgl	%ecx, rva(sl_txt_spin_lock)(%ebx)
+	pause
+	jnz	.Lspin
+
+	/* Increment the stack index and use the next value inside lock */
+	incl	rva(sl_txt_stack_index)(%ebx)
+	movl	rva(sl_txt_stack_index)(%ebx), %eax
+
+	/* Unlock */
+	movl	$0, rva(sl_txt_spin_lock)(%ebx)
+
+	/* Location of the relocated AP wake block */
+	movl	rva(sl_txt_ap_wake_block)(%ebx), %ecx
+
+	/* Load reloc GDT, set segment regs and lret to __SL32_CS */
+	lgdt	(sl_ap_gdt_desc - sl_txt_ap_wake_begin)(%ecx)
+
+	movl	$(__SL32_DS), %edx
+	movw	%dx, %ds
+	movw	%dx, %es
+	movw	%dx, %fs
+	movw	%dx, %gs
+	movw	%dx, %ss
+
+	/* Load our reloc AP stack */
+	movl	$(TXT_BOOT_STACK_SIZE), %edx
+	mull	%edx
+	leal	(sl_stacks_end - sl_txt_ap_wake_begin)(%ecx), %esp
+	subl	%eax, %esp
+
+	/* Switch to AP code segment */
+	leal	rva(.Lsl_ap_cs)(%ebx), %eax
+	pushl	$(__SL32_CS)
+	pushl	%eax
+	lret
+
+.Lsl_ap_cs:
+	/* Load the relocated AP IDT */
+	lidt	(sl_ap_idt_desc - sl_txt_ap_wake_begin)(%ecx)
+
+	/* Fixup MTRRs and misc enable MSR on APs too */
+	call	sl_txt_load_regs
+
+	/* Enable SMI with GETSEC[SMCTRL] */
+	GETSEC $(SMX_X86_GETSEC_SMCTRL)
+
+	/* IRET-to-self can be used to enable NMIs which SENTER disabled */
+	leal	rva(.Lnmi_enabled_ap)(%ebx), %eax
+	pushfl
+	pushl	$(__SL32_CS)
+	pushl	%eax
+	iret
+
+.Lnmi_enabled_ap:
+	/* Put APs in X2APIC mode like the BSP */
+	movl	$(MSR_IA32_APICBASE), %ecx
+	rdmsr
+	orl	$(XAPIC_ENABLE | X2APIC_ENABLE), %eax
+	wrmsr
+
+	/*
+	 * Basically done, increment the CPU count and jump off to the AP
+	 * wake block to wait.
+	 */
+	lock incl	rva(sl_txt_cpu_count)(%ebx)
+
+	movl	rva(sl_txt_ap_wake_block)(%ebx), %eax
+	jmp	*%eax
+SYM_FUNC_END(sl_txt_ap_entry)
+
+SYM_FUNC_START(sl_txt_reloc_ap_wake)
+	/* Save boot params register */
+	pushl	%esi
+
+	movl	rva(sl_txt_ap_wake_block)(%ebx), %edi
+
+	/* Fixup AP IDT and GDT descriptor before relocating */
+	leal	rva(sl_ap_idt_desc)(%ebx), %eax
+	addl	%edi, 2(%eax)
+	leal	rva(sl_ap_gdt_desc)(%ebx), %eax
+	addl	%edi, 2(%eax)
+
+	/*
+	 * Copy the AP wake code and AP GDT/IDT to the protected wake block
+	 * provided by the loader. Destination already in %edi.
+	 */
+	movl	$(sl_txt_ap_wake_end - sl_txt_ap_wake_begin), %ecx
+	leal	rva(sl_txt_ap_wake_begin)(%ebx), %esi
+	rep movsb
+
+	/* Setup the IDT for the APs to use in the relocation block */
+	movl	rva(sl_txt_ap_wake_block)(%ebx), %ecx
+	addl	$(sl_ap_idt - sl_txt_ap_wake_begin), %ecx
+	xorl	%edx, %edx
+
+	/* Form the default reset vector relocation address */
+	movl	rva(sl_txt_ap_wake_block)(%ebx), %esi
+	addl	$(sl_txt_int_reset - sl_txt_ap_wake_begin), %esi
+
+1:
+	cmpw	$(NR_VECTORS), %dx
+	jz	.Lap_idt_done
+
+	cmpw	$(X86_TRAP_NMI), %dx
+	jz	2f
+
+	/* Load all other fixed vectors with reset handler */
+	movl	%esi, %eax
+	movw	%ax, (IDT_VECTOR_LO_BITS)(%ecx)
+	shrl	$16, %eax
+	movw	%ax, (IDT_VECTOR_HI_BITS)(%ecx)
+	jmp	3f
+
+2:
+	/* Load single wake NMI IPI vector at the relocation address */
+	movl	rva(sl_txt_ap_wake_block)(%ebx), %eax
+	addl	$(sl_txt_int_ipi_wake - sl_txt_ap_wake_begin), %eax
+	movw	%ax, (IDT_VECTOR_LO_BITS)(%ecx)
+	shrl	$16, %eax
+	movw	%ax, (IDT_VECTOR_HI_BITS)(%ecx)
+
+3:
+	incw	%dx
+	addl	$8, %ecx
+	jmp	1b
+
+.Lap_idt_done:
+	popl	%esi
+	ret
+SYM_FUNC_END(sl_txt_reloc_ap_wake)
+
+SYM_FUNC_START(sl_txt_load_regs)
+	/* Save base pointer register */
+	pushl	%ebx
+
+	/*
+	 * On Intel, the original variable MTRRs and Misc Enable MSR are
+	 * restored on the BSP at early boot. Each AP will also restore
+	 * its MTRRs and Misc Enable MSR.
+	 */
+	pushl	%edi
+	addl	$(SL_saved_bsp_mtrrs), %edi
+	movl	(%edi), %ebx
+	pushl	%ebx /* default_mem_type lo */
+	addl	$4, %edi
+	movl	(%edi), %ebx
+	pushl	%ebx /* default_mem_type hi */
+	addl	$4, %edi
+	movl	(%edi), %ebx /* mtrr_vcnt lo, don't care about hi part */
+	addl	$8, %edi /* now at MTRR pair array */
+	/* Write the variable MTRRs */
+	movl	$(MTRRphysBase0), %ecx
+1:
+	cmpl	$0, %ebx
+	jz	2f
+
+	movl	(%edi), %eax /* MTRRphysBaseX lo */
+	addl	$4, %edi
+	movl	(%edi), %edx /* MTRRphysBaseX hi */
+	wrmsr
+	addl	$4, %edi
+	incl	%ecx
+	movl	(%edi), %eax /* MTRRphysMaskX lo */
+	addl	$4, %edi
+	movl	(%edi), %edx /* MTRRphysMaskX hi */
+	wrmsr
+	addl	$4, %edi
+	incl	%ecx
+
+	decl	%ebx
+	jmp	1b
+2:
+	/* Write the default MTRR register */
+	popl	%edx
+	popl	%eax
+	movl	$(MSR_MTRRdefType), %ecx
+	wrmsr
+
+	/* Return to beginning and write the misc enable msr */
+	popl	%edi
+	addl	$(SL_saved_misc_enable_msr), %edi
+	movl	(%edi), %eax /* saved_misc_enable_msr lo */
+	addl	$4, %edi
+	movl	(%edi), %edx /* saved_misc_enable_msr hi */
+	movl	$(MSR_IA32_MISC_ENABLE), %ecx
+	wrmsr
+
+	popl	%ebx
+	ret
+SYM_FUNC_END(sl_txt_load_regs)
+
+SYM_FUNC_START(sl_txt_wake_aps)
+	/* Save boot params register */
+	pushl	%esi
+
+	/* First setup the MLE join structure and load it into TXT reg */
+	leal	rva(sl_gdt)(%ebx), %eax
+	leal	rva(sl_txt_ap_entry)(%ebx), %ecx
+	leal	rva(sl_smx_rlp_mle_join)(%ebx), %edx
+	movl	%eax, SL_rlp_gdt_base(%edx)
+	movl	%ecx, SL_rlp_entry_point(%edx)
+	movl	%edx, (TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_MLE_JOIN)
+
+	/* Another TXT heap walk to find various values needed to wake APs */
+	movl	(TXT_PRIV_CONFIG_REGS_BASE + TXT_CR_HEAP_BASE), %eax
+	/* At BIOS data size, find the number of logical processors */
+	movl	(SL_num_logical_procs + 8)(%eax), %edx
+	/* Skip over BIOS data */
+	movl	(%eax), %ecx
+	addl	%ecx, %eax
+	/* Skip over OS to MLE */
+	movl	(%eax), %ecx
+	addl	%ecx, %eax
+	/* At OS-SNIT size, get capabilities to know how to wake up the APs */
+	movl	(SL_capabilities + 8)(%eax), %esi
+	/* Skip over OS to SNIT */
+	movl	(%eax), %ecx
+	addl	%ecx, %eax
+	/* At SINIT-MLE size, get the AP wake MONITOR address */
+	movl	(SL_rlp_wakeup_addr + 8)(%eax), %edi
+
+	/* Determine how to wake up the APs */
+	testl	$(1 << TXT_SINIT_MLE_CAP_WAKE_MONITOR), %esi
+	jz	.Lwake_getsec
+
+	/* Wake using MWAIT MONITOR */
+	movl	$1, (%edi)
+	jmp	.Laps_awake
+
+.Lwake_getsec:
+	/* Wake using GETSEC(WAKEUP) */
+	GETSEC	$(SMX_X86_GETSEC_WAKEUP)
+
+.Laps_awake:
+	/*
+	 * All of the APs are woken up and rendesvous in the relocated wake
+	 * block starting at sl_txt_ap_wake_begin. Wait for all of them to
+	 * halt.
+	 */
+	pause
+	cmpl	rva(sl_txt_cpu_count)(%ebx), %edx
+	jne	.Laps_awake
+
+	popl	%esi
+	ret
+SYM_FUNC_END(sl_txt_wake_aps)
+
+/* This is the beginning of the relocated AP wake code block */
+	.global sl_txt_ap_wake_begin
+sl_txt_ap_wake_begin:
+
+	/*
+	 * Wait for NMI IPI in the relocated AP wake block which was provided
+	 * and protected in the memory map by the prelaunch code. Leave all
+	 * other interrupts masked since we do not expect anything but an NMI.
+	 */
+	xorl	%edx, %edx
+
+1:
+	hlt
+	testl	%edx, %edx
+	jz	1b
+
+	/*
+	 * This is the long absolute jump to the 32b Secure Launch protected
+	 * mode stub code in the rmpiggy. The jump address will be fixed in
+	 * the SMP boot code when the first AP is brought up. This whole area
+	 * is provided and protected in the memory map by the prelaunch code.
+	 */
+	.byte	0xea
+sl_ap_jmp_offset:
+	.long	0x00000000
+	.word	__SL32_CS
+
+SYM_FUNC_START(sl_txt_int_ipi_wake)
+	movl	$1, %edx
+
+	/* NMI context, just IRET */
+	iret
+SYM_FUNC_END(sl_txt_int_ipi_wake)
+
+SYM_FUNC_START(sl_txt_int_reset)
+	TXT_RESET $(SL_ERROR_INV_AP_INTERRUPT)
+SYM_FUNC_END(sl_txt_int_reset)
+
+	.balign 8
+SYM_DATA_START_LOCAL(sl_ap_idt_desc)
+	.word	sl_ap_idt_end - sl_ap_idt - 1		/* Limit */
+	.long	sl_ap_idt - sl_txt_ap_wake_begin	/* Base */
+SYM_DATA_END_LABEL(sl_ap_idt_desc, SYM_L_LOCAL, sl_ap_idt_desc_end)
+
+	.balign 8
+SYM_DATA_START_LOCAL(sl_ap_idt)
+	.rept	NR_VECTORS
+	.word	0x0000		/* Offset 15 to 0 */
+	.word	__SL32_CS	/* Segment selector */
+	.word	0x8e00		/* Present, DPL=0, 32b Vector, Interrupt */
+	.word	0x0000		/* Offset 31 to 16 */
+	.endr
+SYM_DATA_END_LABEL(sl_ap_idt, SYM_L_LOCAL, sl_ap_idt_end)
+
+	.balign 8
+SYM_DATA_START_LOCAL(sl_ap_gdt_desc)
+	.word	sl_ap_gdt_end - sl_ap_gdt - 1
+	.long	sl_ap_gdt - sl_txt_ap_wake_begin
+SYM_DATA_END_LABEL(sl_ap_gdt_desc, SYM_L_LOCAL, sl_ap_gdt_desc_end)
+
+	.balign	8
+SYM_DATA_START_LOCAL(sl_ap_gdt)
+	.quad	0x0000000000000000	/* NULL */
+	.quad	0x00cf9a000000ffff	/* __SL32_CS */
+	.quad	0x00cf92000000ffff	/* __SL32_DS */
+SYM_DATA_END_LABEL(sl_ap_gdt, SYM_L_LOCAL, sl_ap_gdt_end)
+
+	/* Small stacks for BSP and APs to work with */
+	.balign 4
+SYM_DATA_START_LOCAL(sl_stacks)
+	.fill (TXT_MAX_CPUS * TXT_BOOT_STACK_SIZE), 1, 0
+SYM_DATA_END_LABEL(sl_stacks, SYM_L_LOCAL, sl_stacks_end)
+
+/* This is the end of the relocated AP wake code block */
+	.global sl_txt_ap_wake_end
+sl_txt_ap_wake_end:
+
+	.data
+	.balign 8
+SYM_DATA_START_LOCAL(sl_gdt_desc)
+	.word	sl_gdt_end - sl_gdt - 1
+	.long	sl_gdt - sl_gdt_desc
+SYM_DATA_END_LABEL(sl_gdt_desc, SYM_L_LOCAL, sl_gdt_desc_end)
+
+	.balign	8
+SYM_DATA_START_LOCAL(sl_gdt)
+	.quad	0x0000000000000000	/* NULL */
+	.quad	0x00cf9a000000ffff	/* __SL32_CS */
+	.quad	0x00cf92000000ffff	/* __SL32_DS */
+SYM_DATA_END_LABEL(sl_gdt, SYM_L_LOCAL, sl_gdt_end)
+
+	.balign 8
+SYM_DATA_START_LOCAL(sl_smx_rlp_mle_join)
+	.long	sl_gdt_end - sl_gdt - 1	/* GDT limit */
+	.long	0x00000000		/* GDT base */
+	.long	__SL32_CS	/* Seg Sel - CS (DS, ES, SS = seg_sel+8) */
+	.long	0x00000000	/* Entry point physical address */
+SYM_DATA_END(sl_smx_rlp_mle_join)
+
+SYM_DATA(sl_cpu_type, .long 0x00000000)
+
+SYM_DATA(sl_mle_start, .long 0x00000000)
+
+SYM_DATA_LOCAL(sl_txt_spin_lock, .long 0x00000000)
+
+SYM_DATA_LOCAL(sl_txt_stack_index, .long 0x00000000)
+
+SYM_DATA_LOCAL(sl_txt_cpu_count, .long 0x00000000)
+
+SYM_DATA_LOCAL(sl_txt_ap_wake_block, .long 0x00000000)
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 01d19fc..74e3e7df 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -26,6 +26,7 @@
 /* loadflags */
 #define LOADED_HIGH	(1<<0)
 #define KASLR_FLAG	(1<<1)
+#define SLAUNCH_FLAG	(1<<2)
 #define QUIET_FLAG	(1<<5)
 #define KEEP_SEGMENTS	(1<<6)
 #define CAN_USE_HEAP	(1<<7)
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index dc35763..960d471 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -13,6 +13,8 @@
 #include <linux/hardirq.h>
 #include <linux/suspend.h>
 #include <linux/kbuild.h>
+#include <linux/slr_table.h>
+#include <linux/slaunch.h>
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 #include <asm/sigframe.h>
@@ -127,4 +129,22 @@ static void __used common(void)
 	OFFSET(ARIA_CTX_rounds, aria_ctx, rounds);
 #endif
 
+#ifdef CONFIG_SECURE_LAUNCH
+	BLANK();
+	OFFSET(SL_txt_info, txt_os_mle_data, txt_info);
+	OFFSET(SL_mle_scratch, txt_os_mle_data, mle_scratch);
+	OFFSET(SL_boot_params_addr, txt_os_mle_data, boot_params_addr);
+	OFFSET(SL_ap_wake_block, txt_os_mle_data, ap_wake_block);
+	OFFSET(SL_ap_wake_block_size, txt_os_mle_data, ap_wake_block_size);
+	OFFSET(SL_saved_misc_enable_msr, slr_entry_intel_info, saved_misc_enable_msr);
+	OFFSET(SL_saved_bsp_mtrrs, slr_entry_intel_info, saved_bsp_mtrrs);
+	OFFSET(SL_num_logical_procs, txt_bios_data, num_logical_procs);
+	OFFSET(SL_capabilities, txt_os_sinit_data, capabilities);
+	OFFSET(SL_mle_size, txt_os_sinit_data, mle_size);
+	OFFSET(SL_vtd_pmr_lo_base, txt_os_sinit_data, vtd_pmr_lo_base);
+	OFFSET(SL_vtd_pmr_lo_size, txt_os_sinit_data, vtd_pmr_lo_size);
+	OFFSET(SL_rlp_wakeup_addr, txt_sinit_mle_data, rlp_wakeup_addr);
+	OFFSET(SL_rlp_gdt_base, smx_rlp_mle_join, rlp_gdt_base);
+	OFFSET(SL_rlp_entry_point, smx_rlp_mle_join, rlp_entry_point);
+#endif
 }
-- 
1.8.3.1

