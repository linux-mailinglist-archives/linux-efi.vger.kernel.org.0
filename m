Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108306F6E49
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjEDOyA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjEDOwp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:52:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1667D99;
        Thu,  4 May 2023 07:51:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344Dg4VU011901;
        Thu, 4 May 2023 14:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=4/EzCBzQiFAJ3X5MjU28bVc5KlXnKd4tbXU4uMU8OTY=;
 b=lNW8l0q6lRkDSyuFWSrRmEX4g96KRvJ9BRZ2wxVTAZrKdDpqruRkw3THQgRxsYukpfQn
 F+laLZZYkUQg/OWkGZu27j0Txjnr/VRnm5bX5+pXSngRWYMiJ6kOTdQOwPTAkZtGEITY
 kgszp0wmipRmIbw0NU6tFgQbVxcW86KiJwVhqLgzHLUHMSF2CPRlP+Fw8yfitoabKlWK
 SHqSy3Zy2dSTg28Yh9VB+fhV/WHAgCspd4uKlyDfs6mtQDk7L2OEsraKVbUjjBUDIXzA
 vSy0T1mmg/VxupUgrJ3+bPcDCh6EPggKQ6alERc36ajiXcyIFvJ40mxIEhUWQvoIQKPz FQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv1yfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344EPTTk020744;
        Thu, 4 May 2023 14:51:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8kes1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlYUKzsTUflgXEUs6pTzpA0q9/7CxymnV9n/hpyuj/pXwSxPXDMVjoIga3+AYFpF6r7AyBvnamiNoieciEGbYYe+EU2PKeoXG5DJeaKsofnflO0a/2PdnXDT54brlMS681sMpq7t2nFhBESQ13YxN4QSAkQ5KQppH4aNMKii2jh3SvvRi8vLCeSKEUkkgYv9Xbz73OwEMkRXORgEziYT5ES2JlQg7q+X3nvDS+UrN/A5BFVSWrmCu02/XFSzpyqGim9g0hSTo1uAuu5ezfUJTsrpWkZVc1G8LGYTQ/hnhuTLcnglSE838/V6CA75Zy/Z8nwaJZl/aiPfL9ICt2zIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/EzCBzQiFAJ3X5MjU28bVc5KlXnKd4tbXU4uMU8OTY=;
 b=bZJcl6LdTugxMyRwzBejGEf67bDIlP3EOM4S7C3fjUjXC1X73VLNQyR6+fAzqR++fj7G1dJ2X/yZUcxaGDyAfwSyx3tiNYGTO2sSHWoC0zKxiJP6s5jQxSPHb1D8Mhul8m4E3THhJgwN2d83b791zMzadRyQZY3acCftBXPipYLup0vaqlKz1TQqRkLPyMMinnciCHe9wi/SdqtGdkxfuJB0kSITO6jBkuWwOsBtM0ER47k5RaKNSNyORui3ORT2DdhxoWqQz0osyhLuY+yX/j3G4pDy8ieepZ1eo70jYXdBMPs42pzZW8z81dsYrcH1p4T9R5oz1vrucxGgEbfm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/EzCBzQiFAJ3X5MjU28bVc5KlXnKd4tbXU4uMU8OTY=;
 b=Qspa0c+4MzNLItSTsRWi9txQNpKwO5dvByQxvi481B4ZrpUw9m47Y1zcFgkZ63fb3t5VbXR0F/1NpcMgMKIqvWACfnDvhl6h7QHfiBQ6Lr4nQztjfV+lrlK5XQtVfIRFdkaGRA5PtBJX+qIqqG/OS6Enb1XE/5E7KLYV3t7vaVs=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:51:17 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:51:17 +0000
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
Subject: [PATCH v6 11/14] reboot: Secure Launch SEXIT support on reboot paths
Date:   Thu,  4 May 2023 14:50:20 +0000
Message-Id: <20230504145023.835096-12-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:5:14c::41) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: d11d3e4e-86be-461c-214d-08db4caf03b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsiI4t9UqdR/GEeY3JU9q0HAmdTJrD5pk6BBUTPuDyZHsP7KqwcjJFTVRjSR4bf3IQze0UUM3pNPgszeF3p0Nr0UNrTPPiolBfYVPAE2bEmuTHe4mLWM5PacvzkENeCNzXY9IeD+rJGI+cU/5mezd1Z/I72FYBQQ0qkRg5YRtyTAnsZ5fl6hjiY8BjcCLIuVrvguisWScFiD3LhrlWrweaBmycxuMnmF8+d/kf8Oqu1/pVJv+KttEbpTpclNJJtjTL01NLg6kDVGTD5ZwP4RhFYHNSVDyo4UfmRsj67tpelJoSMBBrFL18cRyn2IREjKtzjiAwE2z5+SCwYhm1dzGSYvH9mL3mg8Ugx6eSoCh5bRdq7zJQmTfXADz49cSkZ7FJ5cL48i3zDMQx0OIvkirp4oC/5R1lrrTHZKKRCiA8S6SDptylOEJm0BXPm4wp1EEblBci5mxsbvZPPGMWmLqSsTWlB9uWOHVzX+ir2bUR4NQHRk3bt4AIAoJ1JBAk3OC1KsRBxX/y1ClAH5oEEfjoPNh9vnafWdgdubKevQ1g4dhNG2HYgKH5nn38BYVa/z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(7416002)(2906002)(44832011)(8936002)(316002)(86362001)(4326008)(66556008)(66476007)(66946007)(8676002)(41300700001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(478600001)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c8VJQYARwTxld8PcaG4FCqRnX+55WfQqGqwcwu1jRUvnvoBtYjDjRQvoj++G?=
 =?us-ascii?Q?JBbHbJB6uAZb3FVoebQxp8gMTnfNvULK1T+z8mTMbN9g7j5fRwqlqgl4dDRf?=
 =?us-ascii?Q?ekpwxVejUxEgjtu7dqu7e1J34viSsM371TWmUTz4lVdVdjLoJC2EHvsl+kfE?=
 =?us-ascii?Q?+00eb/7n0tpaimvqgT0hSLy+HDrkwxqxcWAlgjf0a0SCQvG90wyMQjKnoSHD?=
 =?us-ascii?Q?jLRBStU+jgImrc9C2tkbj5AHFBBoJtB00n92pP3Y0ODAvRj4NBCdnjfByqH4?=
 =?us-ascii?Q?3ZNQE0zZIQWVLYvd/fPpZ/tJHhrQ7rTL3qJTP6shHWpddNxIGBvuRFfOaMor?=
 =?us-ascii?Q?vE5DI+23d1Dcrf2CvAd+f+kaHaLNov/s38aVLco+ss8MaeBmFTBpQyrrDmpk?=
 =?us-ascii?Q?20PAjDCDGXKrqlazdjqAmZbM3lzPSt7idbQWL16gxxhM2qF+yRy4tGkX4sOP?=
 =?us-ascii?Q?PnNq9Ul3hkkpafhXGJ70exRkoOzn7X2hEWfdbdJWiFqLOxklhde6N1ypftpg?=
 =?us-ascii?Q?HJT9B8AagffPMoQzw32eBhQypX/JsoKM/GLojWtGYehSlsgDD4xpMAqQV3HZ?=
 =?us-ascii?Q?sg9Pok2QatgUBgTNkZsB0X5z3s4DZdG7xGLN6NmW9uhFYUu4KGfvaymtEfeL?=
 =?us-ascii?Q?O7Hm8UY/ib+y+TO7gF52av41qGANtk2f4IufLRFl3ATQ4RsbYA1SgJPYh4rT?=
 =?us-ascii?Q?IeVGboShnixboY1Xhny4gC0UA/ga+Ei80KQA2AunWJgw5MoPtxoN3Df8B1DG?=
 =?us-ascii?Q?9V34G64AJBXFfkYCLXNM/KRVZcDjLV+p+t032ycSXPjRnfWbgaFUeKoTpUCr?=
 =?us-ascii?Q?WgtLwjd8F9QJVfHe92AfXsEocUWhXNbf/xGXUp8/t89ax8PHg+lmN0+zlneh?=
 =?us-ascii?Q?sosZNuDISvmESs7hj+cmIy8zG7dMNZbIfQ6lM2/XVElMMG2UYSNEb6K5wg3j?=
 =?us-ascii?Q?Tak6eTbDBqf35Oy1GawoR7InL5T8m7HqMQeTJA3fjFXTWPq9Dj4NLmRwqIdq?=
 =?us-ascii?Q?9o3TuGL2wz+nbIJj2fxuWohAnr3hTfICdsFZc8DCIv/gXDpCWFIJ5CfUaaoo?=
 =?us-ascii?Q?JzndClZBSt4L5jxs2CATzh+faN4YOtloPGuJM8H3MBtGbFWW8cct6wjsZo6b?=
 =?us-ascii?Q?gcAaliEsq5rHtyjLLnTG+nfDzpvOk8AgxIuE4oI6TeB+A9J2asbJ8lGM6EN6?=
 =?us-ascii?Q?aCmatCh9JhQvBD5zeJn68N+akewYU8P8ZpaTM/w+9py1nRxfgSN8qP3sQzKj?=
 =?us-ascii?Q?ZThEXbzkd06dLYEvnNdp3gxbZ7DI4T2KqFqzFJ7nmpPy/D7tdR+9GpQF3PpW?=
 =?us-ascii?Q?x5/n4tBWT7exH8EqNWfHuP8ogIBnvMT606VBDBcylnU7WY+q0tatrcG/KEPs?=
 =?us-ascii?Q?e/d+d4eqRs4mNEQDA97ZvwyTrAjDH9ra5IvgbTqRQThazajTvaMVavqQI0FA?=
 =?us-ascii?Q?t1oaD3DrFpf/w92sD040TMVTb7U5p9PQpDxtYNkwMyAepih84/34AB9dT6qU?=
 =?us-ascii?Q?ex4VfGVXRF7X2BWpEZv9lLIWp0sTV8z1aIS+osFgF0tqCo0VmnHy7Ns0r1wc?=
 =?us-ascii?Q?rRDQecnNpKr4CQgGW1lq7O/TWHHhf0Y2e6tIoNR32rLDK6icHJ5iVbZ5yTlP?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bG6SgMDR0vtHT0u2hRMjfx0bygvuuY5h0L0YVE38ZpDphDAfvh+1h0FVvr2a?=
 =?us-ascii?Q?vOOIfeBpPMiNTzzKRGJ7FJzhiZQuvCrmvpC0jneCmTjObs8K2hth61cjznVj?=
 =?us-ascii?Q?ikAWvMKsqUl/J7LuP77YgiFCeywPoHSzfKCoa5iWf205OoTP7P1QLZVIHJYV?=
 =?us-ascii?Q?InTox/7Y51ZuCrKa0VtX7g8Y38EmIb9l0ODi0Qy1qFmJIQ4j+6dloZTj7L/+?=
 =?us-ascii?Q?D6tPGMGONIYhPWYBOh0bUlbKC8bE7Oqv0kMlnIHykQ9umUv7G7682vewzzws?=
 =?us-ascii?Q?TgWf5FctRONMw1jBYPVg5wl3nMnDzd5xWNxtmI0/9BW1TDOjluooDP4e8Yau?=
 =?us-ascii?Q?ZUlHES5LbhGPgIqful0Lk85IONdRWtIaoNDwj3IcXEtdN73syKVwKn8JYbdk?=
 =?us-ascii?Q?fwEEO6u/t/Gg12AO9TEcUd71VTSTxzUq0j2DVRtidBKUMFxTR7/YYaRYQtl2?=
 =?us-ascii?Q?LmFFSsHDheu8G6O6B8E3l2KPs2Ndk9RmpI9DNWDNZLgeNStxaEVNKc72rxFW?=
 =?us-ascii?Q?6y/5E/6LzTeze53Y4KX74kj0hzLpw6VicnjWs6FdFTryeX1c5COVZ81FPmrk?=
 =?us-ascii?Q?IacueCz+2gzDttRyktVEP/iZR8bWHyb8DgEJeqwBKkVWP8Ly6qBGXNZ97qTT?=
 =?us-ascii?Q?ZnUof9zm0b/5l/IaePjtYR1QRt2Tfp/truBF2/nmcbCr97Jg9Tclc2/7wkgW?=
 =?us-ascii?Q?dSkq9HUTSUg03smoPedfzs74j+HNFllIyEqWqqEou1VhRNxuz0IqoMcx5BrO?=
 =?us-ascii?Q?CJVrG1Lso/RDSxFfq+yi0vD+aC5cn2hWbZrlNfI+BOOs3e5z4SJQ42UTngrH?=
 =?us-ascii?Q?HyGvRvRl5+2GoSRHoWtXBOJ04xX0/pvuVJhvQamnVbRfv/thPDF2BHfs741N?=
 =?us-ascii?Q?Ovx33MYR8pl2HuRnaTKFkKPZuhFf8ueI0DvE72o3y/okYN4kcdaBxdiZ7L/8?=
 =?us-ascii?Q?4cXi3CgylsEjpvZjzx7FQRYHJVoOMWJMRsoE46r71Sn9Vth1hik+sU+folmI?=
 =?us-ascii?Q?sVxXfOihtEN+Noyw+PzIgYemnhmPi+mybCXrFtgc+T/jlMGJIW4iVkfiY/JX?=
 =?us-ascii?Q?aMmZ2q0I13OK4rQlO8+knQ8WYXc5zwU2XiLy0GNLToVWEbo72ufBcEFRB4tc?=
 =?us-ascii?Q?kO1b6WXvav8dc1nfLWVMQyYJgyuXrCu6Cn9SU3UIU5h7Sz6ChxWL7UUQohxJ?=
 =?us-ascii?Q?haP2tvP2gXvliXbiVwA73SQBQsvOXX0YSPYiUrOJ09ATFadGlmeZS3xZRLmm?=
 =?us-ascii?Q?8suomXR/0pmO+3LdIsK5EaesYaq5xAa6JQWdU6fY7UvAdIKS/7Fxv8WIsDmw?=
 =?us-ascii?Q?s8k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11d3e4e-86be-461c-214d-08db4caf03b5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:51:16.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyDAK9hEKIUtv5FlJYTIPmUjxYK6FFQKaNEBy8FG7hypyXaOJH3nx1aOpnNhFMZenUsgc9sEpj6oP0rWO9arQzNBwsCBnPq26vTr7Ra4Urg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040122
X-Proofpoint-ORIG-GUID: Z1fz8zsqxNLa0xnLAGQQdiziAtzDP20v
X-Proofpoint-GUID: Z1fz8zsqxNLa0xnLAGQQdiziAtzDP20v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If the MLE kernel is being powered off, rebooted or halted,
then SEXIT must be called. Note that the SEXIT GETSEC leaf
can only be called after a machine_shutdown() has been done on
these paths. The machine_shutdown() is not called on a few paths
like when poweroff action does not have a poweroff callback (into
ACPI code) or when an emergency reset is done. In these cases,
just the TXT registers are finalized but SEXIT is skipped.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/reboot.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 3adbe97..732c81b 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/objtool.h>
 #include <linux/pgtable.h>
+#include <linux/slaunch.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -720,6 +721,7 @@ static void native_machine_restart(char *__unused)
 
 	if (!reboot_force)
 		machine_shutdown();
+	slaunch_finalize(!reboot_force);
 	__machine_emergency_restart(0);
 }
 
@@ -730,6 +732,9 @@ static void native_machine_halt(void)
 
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 
+	/* SEXIT done after machine_shutdown() to meet TXT requirements */
+	slaunch_finalize(1);
+
 	stop_this_cpu(NULL);
 }
 
@@ -738,8 +743,12 @@ static void native_machine_power_off(void)
 	if (kernel_can_power_off()) {
 		if (!reboot_force)
 			machine_shutdown();
+		slaunch_finalize(!reboot_force);
 		do_kernel_power_off();
+	} else {
+		slaunch_finalize(0);
 	}
+
 	/* A fallback in case there is no PM info available */
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 }
@@ -767,6 +776,7 @@ void machine_shutdown(void)
 
 void machine_emergency_restart(void)
 {
+	slaunch_finalize(0);
 	__machine_emergency_restart(1);
 }
 
-- 
1.8.3.1

