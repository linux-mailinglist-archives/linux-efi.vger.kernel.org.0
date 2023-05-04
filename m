Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1B16F6E56
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjEDOyY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjEDOwu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:52:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5C67A9C;
        Thu,  4 May 2023 07:51:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344Dc4xp023340;
        Thu, 4 May 2023 14:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=SbY9StnBsERPevN5ZtxRX9lyrig6peZQxHKzNxzsXuo=;
 b=erEhbZvhZQEEekXuxQVT3tyiFKgEw2ts1V3+xiiwOdfPEJwEz6riWIljLlZ7MYm7kfUL
 NIdXV7Gn2W8j8Nrs+gtGV5n0k4hDrzS/zntXdk/y0RLyIg89mpAbU9D650f/MATEIVE6
 XG/TL6EUi8PZXpS7S+1zBZItd2leKxu9kRARzMmvzcmBtCTDbOI6SG6PP03NJwen1N6B
 QKr73EOGpAizeXCT87NZvOWXKj9iicIBisOlF39xQYhkGf+p0kINc+OUXbS77XxmOxfB
 gkUtdY7BxwDgM0RAv76xOK/W3RgbmTS7khVYT6nEjpeyCvzvrpAK7wrqjUt04F6LBKLC wA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4aswmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344EPTTm020744;
        Thu, 4 May 2023 14:51:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8kes1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USmI1usNE/v4QwqktME0p1WcneybXmpCwnf0AEfen0+T+AQWZVOEntWLaMVzM38WimotwQyLzOYKVkK6JOpu7HVu+nfjkj45pCmBTQAEzfOs7K2eGJQm4809txBHC5spNTxTi9Oymq17IwzcopGQwaeVv/wKXyC4dj4j2DROBh6iZcCEdb1wSXaP2uvRg2HKBe+QJyZe7Ng7idwJgj6TiUhw5KS4CBRrlWxVFdayTI6PacVAZdwy7pntntbQ2g/tnXrXclO5y2uU06uwt+TAZOSHPA3yj18QyyAd857sq5IxnQJnJCTV869XLyZOhjgufPg8r3L9ODl5vdL6/NkmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbY9StnBsERPevN5ZtxRX9lyrig6peZQxHKzNxzsXuo=;
 b=hH/5B9HoVtHWzDeshhyLnAgiedgbaZzhwwKOJIIN7wDo6Z9mbwcHtWqlqNxucHOWGNU5lpiLnyoRh8nJZwJs4lb93ps0Q70xrf74sqR7DNoqaFrZWvG3wDv3mU+bgdBKP9CJHyuBjzwWnExeinJC6rkpy9VodTg87yI/zgR4VLk95cdOe2AkRhjRw21N2BbRd9M3U5ICKQrFbYYAS/tTFjNlAJ3Q2bmP97eReVZgP4QDhQKAV7WhvXjdAbGlXMzz6BHqVaf9K2zry1LsN7LrCdiy9dIWaHITmg7cR2dfDGp+r4gOuom0Ju3InWmqt7tWsOEL4+XBuSS5athz8ZM29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbY9StnBsERPevN5ZtxRX9lyrig6peZQxHKzNxzsXuo=;
 b=CGRfyuyJ5JBx312IBnuJ33+lo7txMW+KDW4oDQ1Qvb5unCf00QBmw6PUVIlC1JhCENKhI6k55vjJ4csKLlYQit6KgoG2YXQ6tKvPokqOBnBq/a00ynYlWfpDVcztRgIPuTtaN+HcIppeXgdQNGLTD8IoEIrp2ofXlz+xZ1Gy0Jg=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:51:19 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:51:19 +0000
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
Subject: [PATCH v6 12/14] x86: Secure Launch late initcall platform module
Date:   Thu,  4 May 2023 14:50:21 +0000
Message-Id: <20230504145023.835096-13-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0069.namprd07.prod.outlook.com
 (2603:10b6:5:74::46) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: aec1c1ae-185f-4bc7-c13d-08db4caf04bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jL/CMHfd9bKvgkVmRRuo/RDGh53qSnv0Ub59DB/3opF0rLqVs9mH3h78kjSYaBxfSvZGy0SR439B1zUTj6hBLcZab8y7sghxsW3rIJV0+45VCAER8yVn6OHgj6coykBZNHj3F/Oc1yVYbdjjU0ZBhqf3r1bUUrJW/ZkVLlvEIXz4p4WHNFGVdT7sIdEIS5xYxKTFQ5pZAQTPAPq1SuYNm7pF2p1eJt673NxExH2DgDWkSekZf59eMMlxm84/M3YXMdRjf/mNkBTS1J2CFhEu104JwiPngFZabbiN8q5X+nxmQtcps9YQP9wG7MtUILCxnCPB+l9v5I+f13JDVbd+7321yQkzQnAE5/LERr27HBpIaIFZJUYtaRAPmR1vkmwrxm9sFVUkZFwPDw/Z2U18ZXl5EDCr9DD+1jb3VgyeSAt+JtwtAxwe85cMXjY/nZQablDBvFcPlRKhx6i29UAgika4g5UvfH2jCcWAjVesUjmtsdvV+DbgMVZPbFjvZ/XYiLL4ZuQFtzaj2/FkKMppOt3JMmpLRRNt1vxFADfyhgDGhqS3+aSp4qwrQSsvUrqP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(7416002)(2906002)(44832011)(30864003)(8936002)(316002)(86362001)(4326008)(66556008)(66476007)(66946007)(8676002)(41300700001)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(478600001)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1sZS9zr/zWYFD6Rc824t4XEiFew6uhmaj2n17WTlLrzwfSM/5VG0ajHf2pyP?=
 =?us-ascii?Q?W6l9Xu12ecRECgENbUE5ClrE7VXjaYEBbTR2D+f5HIssMHcZwpMeMHoZGAFu?=
 =?us-ascii?Q?ujOTxlUaVRYclsgOY+S04joGrpOcCq2IvNFp8+PidEQvCsl2w6iOLkesR1/U?=
 =?us-ascii?Q?jTYbrvfPvkrotic6j58gPfOtK72bXESz7wBuvtWbB+bKtl0VfqCset6gbTBI?=
 =?us-ascii?Q?Oqgr6xDuLZ66Pujmajot4P9On/Sv4k1NWp3ZfvxUhYYaLUyBgpt3T0k134q3?=
 =?us-ascii?Q?Ds8bKie5Rao4qZ58v4Nf9KT19HxKnc4dRy+uNdOhxxhp38UiEKBYmNpSZV1k?=
 =?us-ascii?Q?Dl6aNdL0XIMGC68UEV9pDA3c80BA23cdPKSoc0lNd2iC9LjLNYLLcRpxaR2B?=
 =?us-ascii?Q?raRDgISz3M3q7CUV1o7S0MF3iFfVvy/tlqhDx5eED7PXbcZbSZtqqAYD5c6C?=
 =?us-ascii?Q?7aBEKtGKsD+jD7K009gIzlEdu4V5+mC9Bz59Xj/1bFbMMcsZEab6iTgQtpuC?=
 =?us-ascii?Q?L1Dhb+QEpNx3pXUvSGdgHH5IHT4QvhXyCC8wScPLlbRZveHmIdBvBtAiHAng?=
 =?us-ascii?Q?WppOdswrdQ1M211Chxeprj6TKy8VqnzD6xXjX7OxakAFZ9MHryeqdqXUWnQ/?=
 =?us-ascii?Q?jqfZcePpIM0yBrjGvFBsSROoI0uwhrj/i+6UDbXYjj8ZSbXvuyYVToZyg/3v?=
 =?us-ascii?Q?QDKsIgedgKbpzW3lEPn8PWcSu0OHRSTCSKhzTAujLva599dEUi8Ftw2jFt54?=
 =?us-ascii?Q?7q01Zcx8yJWbhLvewzUsS8HjVvVfdU4fJtTl9kw+f9dnB8lyvAp4GIEo6+L0?=
 =?us-ascii?Q?i3i0sarWosm1RG7OZWOhMuW/uBiccTvTsnbrWgEqNPOlYh1P5TAMxUkIGFN6?=
 =?us-ascii?Q?xR9OWQ0Ff3aDF+pDGImQfZUYg/nb16smPFMFka77yHvJtlBVJWgib3WFdE0S?=
 =?us-ascii?Q?y/1pzXMeheHFX6ys1wefSgI71etmaJbeI/gj40TreXvNXa3hiNsYw/BekSO3?=
 =?us-ascii?Q?zwmwWdvoAjrljIQunFvsfOuZfoJXEZmKllm4/jfGn4e1qecUnIo9t4XgnhGD?=
 =?us-ascii?Q?nHIh3DLn+8Y4CQHGp5La4f8zAsXTrVWE8GhfNQ5i5d/v7UlJASvZGO7fR6YO?=
 =?us-ascii?Q?A8gdrDTEgl1esIJooToahMzyjkTQtUQ13UB+9uy6WM4icwldVFecrDYMOlDo?=
 =?us-ascii?Q?x1PoIrvGTJ+uuf/VK/oQHD+kUiyPxKoYGtKi9gkGmlUoTcLVsniKgUQLMXH/?=
 =?us-ascii?Q?Sjj3gn21PjHIOSszhbaF1RQOqY+xpstLDwykTalvisr1p5ioldsFI5z+P9WV?=
 =?us-ascii?Q?cWo89Ko0I4x4n7jYrIYwhMErGCWf75vgLvec3sZldHV++Dh92F+4yBIaALzF?=
 =?us-ascii?Q?8Xy3SLnK17f2ZvnKPxq9YJKQ3QNmGlh03xuL17ccDq/bXcvb5qodKrKI0FqV?=
 =?us-ascii?Q?GJ5+mTGU4sLt1FiuS4XLjK4GLYZH4W4eLSR5fTJ4XKkzhqc52IMmRqQlCQBq?=
 =?us-ascii?Q?sg6A4jSCM9a1DJRU3vRZHx/NWr/Gk39k+UdzkCER4hS+rQ22m3Fy/7PgrihJ?=
 =?us-ascii?Q?zHKI7OLjFk9PGlOCaN6/bOZu/I8EACyqkupFr738SUw6ut7boR/6TYU0j5Rz?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Xu5joiYdAWoENVrI6Sss8JuL06hDei4ef3+CgdcUxWTY+I9w4wFQx20nZ8wN?=
 =?us-ascii?Q?P0Hw2rKL2IxP3GWmls+gIbU14AKDAMYG7ac3lXBL8Yblii7GUZQ0+YJjJxbK?=
 =?us-ascii?Q?HrDPaZfeLJlCe7j+I+hTbskJOXZunYQN00I6n+3BO/PWGx13gYBCiAoY4y2F?=
 =?us-ascii?Q?CxDiX5PIHVqgEAeA2p+/mwLh31hl8rgj3YmDxfTjU8jAeV5Lo2F0O9jP5o2J?=
 =?us-ascii?Q?s4x+aiovsie8lru5hdI37b0KDQBwZnyfPkIsVSF4yckVrwO9WTeCFpLeJWQN?=
 =?us-ascii?Q?AtPdzJUx0Hpc5GeBtgcsG8KUcuJVAFMexxSzqPfgTcG3PWCBGj0EsAWY0gkl?=
 =?us-ascii?Q?0KFjnj+gYSMCS0qarxqJjYaOpW0UB5KZ9fZeyd1gRPh2IhZTJLYpSZZQrwGS?=
 =?us-ascii?Q?ZR6k9o5uRcMHKmAs4tdCtz2rTbnZ+oPcN6LNsvqxuXeIPFYdWSUun1TGPaKt?=
 =?us-ascii?Q?hsZQms5ACCS9v+bpL+J/DqPH8VUdZL4bWE6yF/4JtP/2IypORdrrYKycNmsn?=
 =?us-ascii?Q?ginj2pFJeU0GH26FvNtxEDPiTt20SEPPFGbzQDQEaC1DyKCOEqLSQpfcp6Jq?=
 =?us-ascii?Q?EM4oNKAYjQwG2CV1gp+jOQZEzQ6Oh4elqA+PZhvVBpB7cbV5sjgbv7s2vNBj?=
 =?us-ascii?Q?KNMNGc4SUnpNnh6ss2DoTQWkttcNSnSBCZNlIJKhifmyLg+wNb2ISNjcn3pe?=
 =?us-ascii?Q?xjmXal7yNsJHxXw9AJVkWsaCgDiYlxTS+r51GxVarv38AYqeKcmyefoKBIPh?=
 =?us-ascii?Q?BrP76oui4gQKD8HGMKTfZgot2hp4oaPHyuZgl9WMe+Uh0U96jPVTzMhE0tp7?=
 =?us-ascii?Q?CWxhJ9sPJP2UG+0UR95ZLZEvrsxFE1p7qYNAgTblZZ+b6V50gIUjJGAXc9qk?=
 =?us-ascii?Q?XRVDIkc3HLglZkslFscNLV/YxY3G3hsghbnqVUXbvlPOkIS7QOTQ2q8RSjzV?=
 =?us-ascii?Q?Hfb/G9v/flqEUP1aFtN6J6LCNjMZKX8lf8/UBaC5sR5UXsc5OQ3w0F3+41rQ?=
 =?us-ascii?Q?n27SoNl6TUF1/OTkE9wpIxIpsMafkj5C4fTMTbkViRRtxHZ/pOfgXeeT29V/?=
 =?us-ascii?Q?xUizdlS4Cak9ENXSGe3vE8+GyvzWJ6WAz6cW0Bb5KxpueIlkk14Fhrsvdb/X?=
 =?us-ascii?Q?kGS0wyCkZPPrrMJNabxHNC4VieX7PNGC/xPNp8yIFpSLP6bXwvQxwDX0hN6C?=
 =?us-ascii?Q?micZYDVXiqS6+uXd4AV6Qcc93PupJLsgsQ553QgCohW4cNEqI7u1vSpidkLt?=
 =?us-ascii?Q?5AXqximzRaZIakUfPVW8TXvI0wRDX25uMuahE7dpEqG+yhHyQMOlDZkYaJEB?=
 =?us-ascii?Q?GlA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec1c1ae-185f-4bc7-c13d-08db4caf04bd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:51:18.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QtfX56tpXyEXsyXk3fYEjDz5wxr+ST0FIvh3ZzZjdM98E2kDQRAEBxSeuUrJvrudSJy6uuG+/6lR9f2CpNszTp5kDE0Nbfl4kOb6bZQox4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040122
X-Proofpoint-GUID: 4WIR0k_dCL5-klYaLA47aEk0Wwgn-ob-
X-Proofpoint-ORIG-GUID: 4WIR0k_dCL5-klYaLA47aEk0Wwgn-ob-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

The Secure Launch platform module is a late init module. During the
init call, the TPM event log is read and measurements taken in the
early boot stub code are located. These measurements are extended
into the TPM PCRs using the mainline TPM kernel driver.

The platform module also registers the securityfs nodes to allow
access to TXT register fields on Intel along with the fetching of
and writing events to the late launch TPM log.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/Makefile   |   1 +
 arch/x86/kernel/slmodule.c | 520 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 521 insertions(+)
 create mode 100644 arch/x86/kernel/slmodule.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3d2a33e..ee3fe300 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
 obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= slmodule.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
 obj-y				+= stacktrace.o
 obj-y				+= cpu/
diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
new file mode 100644
index 0000000..70dcff5
--- /dev/null
+++ b/arch/x86/kernel/slmodule.c
@@ -0,0 +1,520 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Secure Launch late validation/setup, securityfs exposure and
+ * finalization support.
+ *
+ * Copyright (c) 2022 Apertus Solutions, LLC
+ * Copyright (c) 2021 Assured Information Security, Inc.
+ * Copyright (c) 2022, Oracle and/or its affiliates.
+ *
+ * Author(s):
+ *     Daniel P. Smith <dpsmith@apertussolutions.com>
+ *     Garnet T. Grimm <grimmg@ainfosec.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+#include <linux/security.h>
+#include <linux/memblock.h>
+#include <asm/segment.h>
+#include <asm/sections.h>
+#include <crypto/sha2.h>
+#include <linux/slr_table.h>
+#include <linux/slaunch.h>
+
+#define DECLARE_TXT_PUB_READ_U(size, fmt, msg_size)			\
+static ssize_t txt_pub_read_u##size(unsigned int offset,		\
+		loff_t *read_offset,					\
+		size_t read_len,					\
+		char __user *buf)					\
+{									\
+	void __iomem *txt;						\
+	char msg_buffer[msg_size];					\
+	u##size reg_value = 0;						\
+	txt = ioremap(TXT_PUB_CONFIG_REGS_BASE,				\
+			TXT_NR_CONFIG_PAGES * PAGE_SIZE);		\
+	if (!txt)						\
+		return -EFAULT;					\
+	memcpy_fromio(&reg_value, txt + offset, sizeof(u##size));	\
+	iounmap(txt);							\
+	snprintf(msg_buffer, msg_size, fmt, reg_value);			\
+	return simple_read_from_buffer(buf, read_len, read_offset,	\
+			&msg_buffer, msg_size);				\
+}
+
+DECLARE_TXT_PUB_READ_U(8, "%#04x\n", 6);
+DECLARE_TXT_PUB_READ_U(32, "%#010x\n", 12);
+DECLARE_TXT_PUB_READ_U(64, "%#018llx\n", 20);
+
+#define DECLARE_TXT_FOPS(reg_name, reg_offset, reg_size)		\
+static ssize_t txt_##reg_name##_read(struct file *flip,			\
+		char __user *buf, size_t read_len, loff_t *read_offset)	\
+{									\
+	return txt_pub_read_u##reg_size(reg_offset, read_offset,	\
+			read_len, buf);					\
+}									\
+static const struct file_operations reg_name##_ops = {			\
+	.read = txt_##reg_name##_read,					\
+}
+
+DECLARE_TXT_FOPS(sts, TXT_CR_STS, 64);
+DECLARE_TXT_FOPS(ests, TXT_CR_ESTS, 8);
+DECLARE_TXT_FOPS(errorcode, TXT_CR_ERRORCODE, 32);
+DECLARE_TXT_FOPS(didvid, TXT_CR_DIDVID, 64);
+DECLARE_TXT_FOPS(e2sts, TXT_CR_E2STS, 64);
+DECLARE_TXT_FOPS(ver_emif, TXT_CR_VER_EMIF, 32);
+DECLARE_TXT_FOPS(scratchpad, TXT_CR_SCRATCHPAD, 64);
+
+/*
+ * Securityfs exposure
+ */
+struct memfile {
+	char *name;
+	void *addr;
+	size_t size;
+};
+
+static struct memfile sl_evtlog = {"eventlog", 0, 0};
+static void *txt_heap;
+static struct txt_heap_event_log_pointer2_1_element __iomem *evtlog20;
+static DEFINE_MUTEX(sl_evt_log_mutex);
+
+static ssize_t sl_evtlog_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *pos)
+{
+	ssize_t size;
+
+	if (!sl_evtlog.addr)
+		return 0;
+
+	mutex_lock(&sl_evt_log_mutex);
+	size = simple_read_from_buffer(buf, count, pos, sl_evtlog.addr,
+				       sl_evtlog.size);
+	mutex_unlock(&sl_evt_log_mutex);
+
+	return size;
+}
+
+static ssize_t sl_evtlog_write(struct file *file, const char __user *buf,
+				size_t datalen, loff_t *ppos)
+{
+	ssize_t result;
+	char *data;
+
+	if (!sl_evtlog.addr)
+		return 0;
+
+	/* No partial writes. */
+	result = -EINVAL;
+	if (*ppos != 0)
+		goto out;
+
+	data = memdup_user(buf, datalen);
+	if (IS_ERR(data)) {
+		result = PTR_ERR(data);
+		goto out;
+	}
+
+	mutex_lock(&sl_evt_log_mutex);
+	if (evtlog20)
+		result = tpm20_log_event(evtlog20, sl_evtlog.addr,
+					 sl_evtlog.size, datalen, data);
+	else
+		result = tpm12_log_event(sl_evtlog.addr, sl_evtlog.size,
+					 datalen, data);
+	mutex_unlock(&sl_evt_log_mutex);
+
+	kfree(data);
+out:
+	return result;
+}
+
+static const struct file_operations sl_evtlog_ops = {
+	.read = sl_evtlog_read,
+	.write = sl_evtlog_write,
+	.llseek	= default_llseek,
+};
+
+struct sfs_file {
+	const char *name;
+	const struct file_operations *fops;
+};
+
+#define SL_TXT_ENTRY_COUNT	7
+static const struct sfs_file sl_txt_files[] = {
+	{ "sts", &sts_ops },
+	{ "ests", &ests_ops },
+	{ "errorcode", &errorcode_ops },
+	{ "didvid", &didvid_ops },
+	{ "ver_emif", &ver_emif_ops },
+	{ "scratchpad", &scratchpad_ops },
+	{ "e2sts", &e2sts_ops }
+};
+
+/* sysfs file handles */
+static struct dentry *slaunch_dir;
+static struct dentry *event_file;
+static struct dentry *txt_dir;
+static struct dentry *txt_entries[SL_TXT_ENTRY_COUNT];
+
+static long slaunch_expose_securityfs(void)
+{
+	long ret = 0;
+	int i;
+
+	slaunch_dir = securityfs_create_dir("slaunch", NULL);
+	if (IS_ERR(slaunch_dir))
+		return PTR_ERR(slaunch_dir);
+
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		txt_dir = securityfs_create_dir("txt", slaunch_dir);
+		if (IS_ERR(txt_dir)) {
+			ret = PTR_ERR(txt_dir);
+			goto remove_slaunch;
+		}
+
+		for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++) {
+			txt_entries[i] = securityfs_create_file(
+						sl_txt_files[i].name, 0440,
+						txt_dir, NULL,
+						sl_txt_files[i].fops);
+			if (IS_ERR(txt_entries[i])) {
+				ret = PTR_ERR(txt_entries[i]);
+				goto remove_files;
+			}
+		}
+
+	}
+
+	if (sl_evtlog.addr > 0) {
+		event_file = securityfs_create_file(
+					sl_evtlog.name, 0440,
+					slaunch_dir, NULL,
+					&sl_evtlog_ops);
+		if (IS_ERR(event_file)) {
+			ret = PTR_ERR(event_file);
+			goto remove_files;
+		}
+	}
+
+	return 0;
+
+remove_files:
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		while (--i >= 0)
+			securityfs_remove(txt_entries[i]);
+		securityfs_remove(txt_dir);
+	}
+remove_slaunch:
+	securityfs_remove(slaunch_dir);
+
+	return ret;
+}
+
+static void slaunch_teardown_securityfs(void)
+{
+	int i;
+
+	securityfs_remove(event_file);
+	if (sl_evtlog.addr) {
+		memunmap(sl_evtlog.addr);
+		sl_evtlog.addr = NULL;
+	}
+	sl_evtlog.size = 0;
+
+	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
+		for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++)
+			securityfs_remove(txt_entries[i]);
+
+		securityfs_remove(txt_dir);
+
+		if (txt_heap) {
+			memunmap(txt_heap);
+			txt_heap = NULL;
+		}
+	}
+
+	securityfs_remove(slaunch_dir);
+}
+
+static void slaunch_intel_evtlog(void __iomem *txt)
+{
+	struct slr_entry_log_info *log_info;
+	struct txt_os_mle_data *params;
+	struct slr_table *slrt;
+	void *os_sinit_data;
+	u64 base, size;
+
+	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
+	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
+
+	/* now map TXT heap */
+	txt_heap = memremap(base, size, MEMREMAP_WB);
+	if (!txt_heap)
+		slaunch_txt_reset(txt,
+			"Error failed to memremap TXT heap\n",
+			SL_ERROR_HEAP_MAP);
+
+	params = (struct txt_os_mle_data *)txt_os_mle_data_start(txt_heap);
+
+	/* Get the SLRT and remap it */
+	slrt = memremap(params->slrt, sizeof(*slrt), MEMREMAP_WB);
+	if (!slrt)
+		slaunch_txt_reset(txt,
+			"Error failed to memremap SLR Table\n",
+			SL_ERROR_SLRT_MAP);
+	size = slrt->size;
+	memunmap(slrt);
+
+	slrt = memremap(params->slrt, size, MEMREMAP_WB);
+	if (!slrt)
+		slaunch_txt_reset(txt,
+			"Error failed to memremap SLR Table\n",
+			SL_ERROR_SLRT_MAP);
+
+	log_info = (struct slr_entry_log_info *)
+			slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
+	if (!log_info)
+		slaunch_txt_reset(txt,
+			"Error failed to memremap SLR Table\n",
+			SL_ERROR_SLRT_MISSING_ENTRY);
+
+	sl_evtlog.size = log_info->size;
+	sl_evtlog.addr = memremap(log_info->addr, log_info->size,
+				  MEMREMAP_WB);
+	if (!sl_evtlog.addr)
+		slaunch_txt_reset(txt,
+			"Error failed to memremap TPM event log\n",
+			SL_ERROR_EVENTLOG_MAP);
+
+	memunmap(slrt);
+
+	/* Determine if this is TPM 1.2 or 2.0 event log */
+	if (memcmp(sl_evtlog.addr + sizeof(struct tcg_pcr_event),
+		    TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
+		return; /* looks like it is not 2.0 */
+
+	/* For TPM 2.0 logs, the extended heap element must be located */
+	os_sinit_data = txt_os_sinit_data_start(txt_heap);
+
+	evtlog20 = tpm20_find_log2_1_element(os_sinit_data);
+
+	/*
+	 * If this fails, things are in really bad shape. Any attempt to write
+	 * events to the log will fail.
+	 */
+	if (!evtlog20)
+		slaunch_txt_reset(txt,
+			"Error failed to find TPM20 event log element\n",
+			SL_ERROR_TPM_INVALID_LOG20);
+}
+
+static void slaunch_tpm20_extend_event(struct tpm_chip *tpm, void __iomem *txt,
+				       struct tcg_pcr_event2_head *event)
+{
+	u16 *alg_id_field = (u16 *)((u8 *)event +
+				    sizeof(struct tcg_pcr_event2_head));
+	struct tpm_digest *digests;
+	u8 *dptr;
+	int ret;
+	u32 i, j;
+
+	digests = kcalloc(tpm->nr_allocated_banks, sizeof(*digests),
+			  GFP_KERNEL);
+	if (!digests)
+		slaunch_txt_reset(txt,
+			"Failed to allocate array of digests\n",
+			SL_ERROR_GENERIC);
+
+	for (i = 0; i < tpm->nr_allocated_banks; i++)
+		digests[i].alg_id = tpm->allocated_banks[i].alg_id;
+
+
+	/* Early SL code ensured there was a max count of 2 digests */
+	for (i = 0; i < event->count; i++) {
+		dptr = (u8 *)alg_id_field + sizeof(u16);
+
+		for (j = 0; j < tpm->nr_allocated_banks; j++) {
+			if (digests[j].alg_id != *alg_id_field)
+				continue;
+
+			switch (digests[j].alg_id) {
+			case TPM_ALG_SHA256:
+				memcpy(&digests[j].digest[0], dptr,
+				       SHA256_DIGEST_SIZE);
+				alg_id_field = (u16 *)((u8 *)alg_id_field +
+					SHA256_DIGEST_SIZE + sizeof(u16));
+				break;
+			case TPM_ALG_SHA1:
+				memcpy(&digests[j].digest[0], dptr,
+				       SHA1_DIGEST_SIZE);
+				alg_id_field = (u16 *)((u8 *)alg_id_field +
+					SHA1_DIGEST_SIZE + sizeof(u16));
+			default:
+				break;
+			}
+		}
+	}
+
+	ret = tpm_pcr_extend(tpm, event->pcr_idx, digests);
+	if (ret) {
+		pr_err("Error extending TPM20 PCR, result: %d\n", ret);
+		slaunch_txt_reset(txt,
+			"Failed to extend TPM20 PCR\n",
+			SL_ERROR_TPM_EXTEND);
+	}
+
+	kfree(digests);
+}
+
+static void slaunch_tpm20_extend(struct tpm_chip *tpm, void __iomem *txt)
+{
+	struct tcg_pcr_event *event_header;
+	struct tcg_pcr_event2_head *event;
+	int start = 0, end = 0, size;
+
+	event_header = (struct tcg_pcr_event *)(sl_evtlog.addr +
+						evtlog20->first_record_offset);
+
+	/* Skip first TPM 1.2 event to get to first TPM 2.0 event */
+	event = (struct tcg_pcr_event2_head *)((u8 *)event_header +
+						sizeof(struct tcg_pcr_event) +
+						event_header->event_size);
+
+	while ((void  *)event < sl_evtlog.addr + evtlog20->next_record_offset) {
+		size = __calc_tpm2_event_size(event, event_header, false);
+		if (!size)
+			slaunch_txt_reset(txt,
+				"TPM20 invalid event in event log\n",
+				SL_ERROR_TPM_INVALID_EVENT);
+
+		/*
+		 * Marker events indicate where the Secure Launch early stub
+		 * started and ended adding post launch events.
+		 */
+		if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
+			end = 1;
+			break;
+		} else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
+			start = 1;
+			goto next;
+		}
+
+		if (start)
+			slaunch_tpm20_extend_event(tpm, txt, event);
+
+next:
+		event = (struct tcg_pcr_event2_head *)((u8 *)event + size);
+	}
+
+	if (!start || !end)
+		slaunch_txt_reset(txt,
+			"Missing start or end events for extending TPM20 PCRs\n",
+			SL_ERROR_TPM_EXTEND);
+}
+
+static void slaunch_tpm12_extend(struct tpm_chip *tpm, void __iomem *txt)
+{
+	struct tpm12_event_log_header *event_header;
+	struct tcg_pcr_event *event;
+	struct tpm_digest digest;
+	int start = 0, end = 0;
+	int size, ret;
+
+	event_header = (struct tpm12_event_log_header *)sl_evtlog.addr;
+	event = (struct tcg_pcr_event *)((u8 *)event_header +
+				sizeof(struct tpm12_event_log_header));
+
+	while ((void  *)event < sl_evtlog.addr + event_header->next_event_offset) {
+		size = sizeof(struct tcg_pcr_event) + event->event_size;
+
+		/*
+		 * Marker events indicate where the Secure Launch early stub
+		 * started and ended adding post launch events.
+		 */
+		if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
+			end = 1;
+			break;
+		} else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
+			start = 1;
+			goto next;
+		}
+
+		if (start) {
+			memset(&digest.digest[0], 0, TPM_MAX_DIGEST_SIZE);
+			digest.alg_id = TPM_ALG_SHA1;
+			memcpy(&digest.digest[0], &event->digest[0],
+			       SHA1_DIGEST_SIZE);
+
+			ret = tpm_pcr_extend(tpm, event->pcr_idx, &digest);
+			if (ret) {
+				pr_err("Error extending TPM12 PCR, result: %d\n", ret);
+				slaunch_txt_reset(txt,
+					"Failed to extend TPM12 PCR\n",
+					SL_ERROR_TPM_EXTEND);
+			}
+		}
+
+next:
+		event = (struct tcg_pcr_event *)((u8 *)event + size);
+	}
+
+	if (!start || !end)
+		slaunch_txt_reset(txt,
+			"Missing start or end events for extending TPM12 PCRs\n",
+			SL_ERROR_TPM_EXTEND);
+}
+
+static void slaunch_pcr_extend(void __iomem *txt)
+{
+	struct tpm_chip *tpm;
+
+	tpm = tpm_default_chip();
+	if (!tpm)
+		slaunch_txt_reset(txt,
+			"Could not get default TPM chip\n",
+			SL_ERROR_TPM_INIT);
+	if (evtlog20)
+		slaunch_tpm20_extend(tpm, txt);
+	else
+		slaunch_tpm12_extend(tpm, txt);
+}
+
+static int __init slaunch_module_init(void)
+{
+	void __iomem *txt;
+
+	/* Check to see if Secure Launch happened */
+	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=
+	    (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT))
+		return 0;
+
+	txt = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+		      PAGE_SIZE);
+	if (!txt)
+		panic("Error ioremap of TXT priv registers\n");
+
+	/* Only Intel TXT is supported at this point */
+	slaunch_intel_evtlog(txt);
+
+	slaunch_pcr_extend(txt);
+
+	iounmap(txt);
+
+	return slaunch_expose_securityfs();
+}
+
+static void __exit slaunch_module_exit(void)
+{
+	slaunch_teardown_securityfs();
+}
+
+late_initcall(slaunch_module_init);
+
+__exitcall(slaunch_module_exit);
-- 
1.8.3.1

