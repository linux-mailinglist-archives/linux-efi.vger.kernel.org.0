Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6326F6E3A
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjEDOxO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjEDOwe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:52:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEF0359B;
        Thu,  4 May 2023 07:51:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DWdJx012298;
        Thu, 4 May 2023 14:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=+yi1DE2X5405XOfX9/VflVILB4453zBu4NPy5I4cN4Q=;
 b=nt5dC9s+btsNu7DN4G4QOTZeDWyRfyBojxlLJAV08DpeRTz6DyXKbRzbiKadzXDyZCox
 dcey0DDPemqHRoXR4tZNh+UXgi/l2JFxXOYIV/QmINtMP6TS53/DleTC0mjE83jH6+FN
 l8io+lUERX89KXx+7GExw1/N3nWWCkTbFpCRnNlKZnoOhydaO0VqPnyve9tp79T/sFBn
 n4Drt6B64u+aeafjZlv9Qv0nYLeY0MYKjaU+hLwdEwaIwz37wN3axWKxLFLNE0VgV7am
 6eOXd+VJfExBOTQI34w4FSyY9wbYqSh61sx7dW7Ef/OPpVetl8yxRpqJCNP/59/X4UQn Mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv1yex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:16 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344EcjSX024871;
        Thu, 4 May 2023 14:51:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8tr7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHQd7K4HSeSp8+hX5qfZqn5UFndPStNwVu+YU0uaCvIq6Q5r0WZe2IC8CjEtRS+Bpl8LKLwG5aA+7ZefZSlvV6JOrWbXWi8+HV6nbzJsXuspQOQOlDH5e+13X9sc6ZhziEkAvUYCYiP+LTKIXFYJnZPz31WeuOvGDC9JUxStBPQAvV8r6WnVxJThsP0zNGR26oS1PnQo1UJzVrJOQpD2cbFBhbdRTRLV++RQVoSSEhihAlfYJumZVjWYOZXSdp7oV8KfN47LThy4XMOaMzkseVLi3DRNPi176s5xeVxOg9oGIF+X6n68ZAtAXe5Ty8QJvkryVkb7gYtG3ACUvOqWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yi1DE2X5405XOfX9/VflVILB4453zBu4NPy5I4cN4Q=;
 b=YKqVjo0ZU3U3CnpGZendVocId6HvaSfpKm7ZcuYX6DnzMexGDGlbNH2rZcOBNV6tVJ4adnOxM0Z+vceYbh/L02PCB6qMSA93T4yfwPZ6CGFmxvguQOcoZC1R6aPKCe0kYHICjWJqeDrAdOnXNqYr+2kFBWYiYtGEVSV0Nw31t8rkRvhsXfx7zC5sH/iQ4fsaQjPJR4UejJcc3+T+Iaa+KXrmDAWc/01k6gqZMLulV4Lb0r5O2aoZf4r0PK+ct6Iff7187yeXf62jjyU4WWudRVV5aKTj2P986iZr/indsTpkwoVL2dirljdETwm1FqAayYsNyTuysKxJ55m4oOEg3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yi1DE2X5405XOfX9/VflVILB4453zBu4NPy5I4cN4Q=;
 b=ByCczsuMFqlzKRaxJiZQ1HqK8XCOt4vMZHwHyGRVyrZjMxHv/hs+YMmuWgJ+YsquXWyAdI+wNGqVe6jjGQXcblMqYD+FfSpFmGwjpadmRMqjfSkfxLKudqNZAQQTLAJAJ59GiIxp7Jr9M4TiC+jkXjWvO5q5PBnsH6itIwMIsVw=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:51:13 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:51:13 +0000
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
Subject: [PATCH v6 09/14] x86: Secure Launch SMP bringup support
Date:   Thu,  4 May 2023 14:50:18 +0000
Message-Id: <20230504145023.835096-10-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0310.namprd03.prod.outlook.com (2603:10b6:8:2b::9)
 To BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbe0f70-53f7-4605-e54f-08db4caf0165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUYnvbmslh6d4yVbCAzJMhzssHZVdwMJZrqJngQMToeaFXB92qtyhVbQ869/ad7iUfJx0slNK0qtaMOdzxfZCXKIB7lMo0UfRFM9XgE0p9dHchpbDIJqMrTDGbZ4ZKyQfEQ/XCj7RJPLbR6pKIsPPdF+B+pBxFkhAbp3mY30/oPQDpZeDFTiIenYGPrLN+qMPzY5CtHLaVBgRMTxKrTXScPS+BDVuzTDedXMJB5GgA9X7MzU0/6blTzYZj304J/GsdEqtlSeOsx/NjuIc4FK7NHJh1Mc4NzfJpFLOahqcofDL1dVVALWz0A+ogMk+mv42HY7UfmnSLTnXiVGtSt2p8o0cc6O3utpMpXDnYQJuxWkT9g8BOxNaKXzVRhX5wcdOUtf4YD+0rnrUDTg04z8lO8axxhdo0c0xWUyuk1ho443m6WsxSJfrvd7GQuItHofv6TponL+xqu4TBjFpe9/3JnaEN4OPqH7eSo32EXcm8k4XGikYo1ZKy9lvt3DCU3fAqCBmd++coZ7GzzrNBkgqNyTRt+JhxemlLrkkfLiE1nsueOKl+fCuWCAmN7/cfo0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(7416002)(2906002)(44832011)(8936002)(316002)(86362001)(4326008)(66556008)(66476007)(66946007)(8676002)(41300700001)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JpXEDiDYjlCKgUdPVynfHjPe8grYwIpEStG2A2NKlTemEoKBwDIoxDTRi+XI?=
 =?us-ascii?Q?ySFR45l+mGCOrA+aNp8eUDOFPT8x2d8BM0P0Qpnd3MpmrF/OduSIo/7wMhmn?=
 =?us-ascii?Q?jqQ374TC5tCbxpaDjhqSX3FYnaNll+MJpttuSHSCmF6VB/C1BEl2gUetumMY?=
 =?us-ascii?Q?KX3GRrwx2u2GsfwzOBMHsuEYCSRwZ5OjbFuCT3pLYJ5nmtK5wKhRhk+fwRGo?=
 =?us-ascii?Q?y9nEaoAN7FmKn1NV/hZFkNq7mFxV6y9EBdgsfBAk3vO0I9V5PYCTn77ySurb?=
 =?us-ascii?Q?77sWrK+ANuExAMxK7YWGTj/6xrmFZuOGNcwZujNRYNqmwVaB3U3K7/jC6vKu?=
 =?us-ascii?Q?WU50lmBtUt9SWNkCQGN9DWrkyTbTuLkn8wlCcmsqiXQc/9d2+suGNNSJRwnA?=
 =?us-ascii?Q?FvjmojHwJuaTxM7ldFDLy0GA/achmIF8hIfLFIGctqiOS+pu+iRK4cD2hLh5?=
 =?us-ascii?Q?Bn8nBboae0RaMzodnzuSnH0uCNWwmgri+km1yzWNeFzBzW/jW46mAXzO3V6b?=
 =?us-ascii?Q?tFURH7pUu9fYwuH3KqEU+Rj4pU5d149mN3WHei0322buo8z3DRK8aXsVgJc2?=
 =?us-ascii?Q?Gtfcf09hDjRidEXr6pKJULRVRklEOncZ+P9Vm5jBz6B7KL+FhV7ncGhZPyCV?=
 =?us-ascii?Q?+WLoVlVAw6rnNmtnxoPmNBGDETeHvGIRRfYA8zeRA2fTlkiS8kX5NjT9dQm0?=
 =?us-ascii?Q?HogkvGpzd5vuHsPRzs8gkqYKIwWKME+TWsoJaPaSK4jqu/M2RvAzHx6tgPcA?=
 =?us-ascii?Q?yvaVVKWkqMXAttazNUm82VAF+0QF/+x364yz3tUbvNUVguMhlPbwsWdQYvUK?=
 =?us-ascii?Q?MN2zYJa3cZtu50RgfyzCXsc4C1j1D3/PXXx8Ik1+DnkmzZDjIH/an6MCnoOP?=
 =?us-ascii?Q?OnXqJjFCxdY3gli8omtmtPShfxhbeBy8SJCDMSoQgtIdKIvMit+naBmDU/5g?=
 =?us-ascii?Q?6XGGsgj0Uq5+ILwYMDTv0FF2OJKzlMB/7XS52czeMzKBNfQdIp430s/tfq4G?=
 =?us-ascii?Q?Ldd4T8ipBrhgVHxwbCMvNxfUwdGs0oE4N8AC8WRVffX48cNr+/mBsOmTLU6O?=
 =?us-ascii?Q?Ib4XnHNKxOtPy32AH9c7qC8grqQiLk5b0rtb7+fv3TkuuoppfmdOgB1hwqJC?=
 =?us-ascii?Q?b8jn/M+sGbkNEb6eq+XFFgQIF1Zm7pE0vU32slumfqO32IOgrFawvI1z9UQE?=
 =?us-ascii?Q?Y+WWWoMDBMbBk1OVvZ/e0BmvSD6X/9eLtZNWbm/01jWC3nTSB4J0pOmRIJaU?=
 =?us-ascii?Q?jtO9rpi7uE44RuvYIIc/LXUU6ELHIbVhhX+3JYYZoLejtLSgeKggkvxyherT?=
 =?us-ascii?Q?Cb8YRVKdatP0zXesP4zqGxE9u3OKcBs7gCnaNQ070nYk9xoR95PFZ7kp4mHi?=
 =?us-ascii?Q?F7/+J5o/fUYfvj5dLYy0+/G7FYNhChNtgr1XCZ1EmlQrMH0pKym/J3LeOKtp?=
 =?us-ascii?Q?UXryGfhXt9CNaYXJo++q6OcvUliMEHf5+9/yhqJuKM4M931iRwvam+mIf1w1?=
 =?us-ascii?Q?k2HFpQdoPwCm+0DdWeW27gVXVdQ8h0U/iMGUgm+ApEyHCtGd/b20m4fKO3ss?=
 =?us-ascii?Q?BAZlOXLsVPqxHX5JDeVBbMea8iwkTIjm4rjt8xVwPKiCzanc0AIZfzGfegt+?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+Fc0tamgSSIMiE14kS1ZjIeruaIsqRtlEG4f4UL4LEUuS0ADXI2h/AnIYNk2?=
 =?us-ascii?Q?3uJAt1CXaEZ7+wHBIo5aCRtWVOqCD5yebn+zNEMK9mSrKq+OByxNhUr7NgQo?=
 =?us-ascii?Q?VKGPHkEE0UDMTplrabm8N9SiFm+MasH/TrAUhRt2DkUa3sxhukLhCGiJkP6Q?=
 =?us-ascii?Q?8xf7IWT0wjU9WkY0QlslxjogNnvmTn/UNwr3BKaljXorMqnsMjrqdcsWTV+0?=
 =?us-ascii?Q?POtyNmItoNl0LhLbytuEqEt4T2QWrYIoqYR1+ZypzZmg6c/DgMNQCULJLEqX?=
 =?us-ascii?Q?rk7v2SpYSHAZc75ScIH21IuY+KSXFOHnpwhAKAt+LWMnMOGtxFB8F8X0naph?=
 =?us-ascii?Q?RDF2pZVYziRUeVtBQor4Du+q6CY19U7KvEtW3UF6nkoppaA19Zx/56kOEkzi?=
 =?us-ascii?Q?v6E8yY4r3UX9yAhE39ku6ef8BVQslXOYleuD4sA3Q8AYUiADnXzPqFto3jEx?=
 =?us-ascii?Q?jsVpVPDAygnXeXQAMjf66XxxI8Ju3HXNK8St6RlsdrC0bhIh4fKXc0PQyGRs?=
 =?us-ascii?Q?NzUe0Lm0qCudlDnQ13pysd8rE+JRbwmCy4p+3/Qf0AgJc75CAQgRHiiMeoi6?=
 =?us-ascii?Q?aNbMa/QQQbowxEtTuau1ah+zPaidGgPxbJ6gCZTvNf4VnauVDPC2Gr2LA8Lf?=
 =?us-ascii?Q?3ULG3zMrOdMuKieE62ZtFzKbGJNL8skD0dRInM3b+tCi679eRSofmVCAzwCJ?=
 =?us-ascii?Q?lxYHtgLbbhfKaUdtsQl56y85+4OrDwFazM0NAWMWKwhBPB14H7l2EXW3eVDc?=
 =?us-ascii?Q?AYCbj6tikv9R+1ttYOJC41uoJH/HJgJUIpriJEVCDQOZqeFgoh+bgkSic7sK?=
 =?us-ascii?Q?ZHJTUKzur+FsUgx75FSeG7cabsqXFoix43+xQyC2nXNfrXT1HR4/5IA+X2qg?=
 =?us-ascii?Q?IYwBYcfe+LAMxkumNS/wZ6hBmHZzdOLaTJCZFUW0BzSmHZJXm2431jPRdRxQ?=
 =?us-ascii?Q?tu43eqxprfeBZMAf3EDKoFX1LlTRSW/0MLuPs6YASPLhW4HVwdg3X9VY3PCI?=
 =?us-ascii?Q?f7wm7ULd7mHeiwSlaPmsZ+6RlEURrGVT61djlKNMMGuo0axGzwZqkykj6v/I?=
 =?us-ascii?Q?4+6gXapvjbxNDz3hYGYZWzNSc09kBXtjPZtj5B6QM5QHuVu0xYtvp3rAESEB?=
 =?us-ascii?Q?8CiZ/T2Da+7uQhko3R7f8tLs99wFW+75GFyIaJ6hyGfVqQeNjDI6Li9OSqlQ?=
 =?us-ascii?Q?EndD3qqpjvx/J8EA3o4B+DkZKy/DDdxVddjixfUM77mQSCuADZUHjoicPrJ0?=
 =?us-ascii?Q?sPmqcWSQfzegTTxECZeMASDIruL+XHBJhJDm4L83MGpRN13s+I06EufJAEQ6?=
 =?us-ascii?Q?QBw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbe0f70-53f7-4605-e54f-08db4caf0165
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:51:13.0730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yV3d8Ww2Ze8k3Nrw6dv6NWf1r5ti3NS6Z5iXd3log2BTzXrHEuxAdcogSN79gzLeY0LIkMHnHK6Bd6bY80aAg3Nbj22A0bfsxcn5hjasMy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040122
X-Proofpoint-ORIG-GUID: XNJER54jRL_vDVxarEuwtZ-W-VsCqRKV
X-Proofpoint-GUID: XNJER54jRL_vDVxarEuwtZ-W-VsCqRKV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Intel, the APs are left in a well documented state after TXT performs
the late launch. Specifically they cannot have #INIT asserted on them so
a standard startup via INIT/SIPI/SIPI cannot be performed. Instead the
early SL stub code parked the APs in a pause/jmp loop waiting for an NMI.
The modified SMP boot code is called for the Secure Launch case. The
jump address for the RM piggy entry point is fixed up in the jump where
the APs are waiting and an NMI IPI is sent to the AP. The AP vectors to
the Secure Launch entry point in the RM piggy which mimics what the real
mode code would do then jumps to the standard RM piggy protected mode
entry point.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/include/asm/realmode.h      |  3 ++
 arch/x86/kernel/smpboot.c            | 86 ++++++++++++++++++++++++++++++++++++
 arch/x86/realmode/rm/header.S        |  3 ++
 arch/x86/realmode/rm/trampoline_64.S | 37 ++++++++++++++++
 4 files changed, 129 insertions(+)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index f6a1737..576fe62 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -38,6 +38,9 @@ struct real_mode_header {
 #ifdef CONFIG_X86_64
 	u32	machine_real_restart_seg;
 #endif
+#ifdef CONFIG_SECURE_LAUNCH
+	u32	sl_trampoline_start32;
+#endif
 };
 
 /* This must match data at realmode/rm/trampoline_{32,64}.S */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 352f0ce..07d740be 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -57,6 +57,7 @@
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
 #include <linux/stackprotector.h>
+#include <linux/slaunch.h>
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
@@ -1068,6 +1069,83 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+#ifdef CONFIG_SECURE_LAUNCH
+
+static atomic_t first_ap_only = {1};
+
+/*
+ * Called to fix the long jump address for the waiting APs to vector to
+ * the correct startup location in the Secure Launch stub in the rmpiggy.
+ */
+static int
+slaunch_fixup_jump_vector(void)
+{
+	struct sl_ap_wake_info *ap_wake_info;
+	u32 *ap_jmp_ptr = NULL;
+
+	if (!atomic_dec_and_test(&first_ap_only))
+		return 0;
+
+	ap_wake_info = slaunch_get_ap_wake_info();
+
+	ap_jmp_ptr = (u32 *)__va(ap_wake_info->ap_wake_block +
+				 ap_wake_info->ap_jmp_offset);
+
+	*ap_jmp_ptr = real_mode_header->sl_trampoline_start32;
+
+	pr_debug("TXT AP long jump address updated\n");
+
+	return 0;
+}
+
+/*
+ * TXT AP startup is quite different than normal. The APs cannot have #INIT
+ * asserted on them or receive SIPIs. The early Secure Launch code has parked
+ * the APs in a pause loop waiting to receive an NMI. This will wake the APs
+ * and have them jump to the protected mode code in the rmpiggy where the rest
+ * of the SMP boot of the AP will proceed normally.
+ */
+static int
+slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
+{
+	unsigned long send_status = 0, accept_status = 0;
+
+	/* Only done once */
+	if (slaunch_fixup_jump_vector())
+		return -1;
+
+	/* Send NMI IPI to idling AP and wake it up */
+	apic_icr_write(APIC_DM_NMI, apicid);
+
+	if (init_udelay == 0)
+		udelay(10);
+	else
+		udelay(300);
+
+	send_status = safe_apic_wait_icr_idle();
+
+	if (init_udelay == 0)
+		udelay(10);
+	else
+		udelay(300);
+
+	accept_status = (apic_read(APIC_ESR) & 0xEF);
+
+	if (send_status)
+		pr_err("Secure Launch IPI never delivered???\n");
+	if (accept_status)
+		pr_err("Secure Launch IPI delivery error (%lx)\n",
+			accept_status);
+
+	return (send_status | accept_status);
+}
+
+#else
+
+#define slaunch_wakeup_cpu_from_txt(cpu, apicid)	0
+
+#endif  /* !CONFIG_SECURE_LAUNCH */
+
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
@@ -1132,6 +1210,13 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 	cpumask_clear_cpu(cpu, cpu_initialized_mask);
 	smp_mb();
 
+	/* With Intel TXT, the AP startup is totally different */
+	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) ==
+	   (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) {
+		boot_error = slaunch_wakeup_cpu_from_txt(cpu, apicid);
+		goto txt_wake;
+	}
+
 	/*
 	 * Wake up a CPU in difference cases:
 	 * - Use a method from the APIC driver if one defined, with wakeup
@@ -1147,6 +1232,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		boot_error = wakeup_cpu_via_init_nmi(cpu, start_ip, apicid,
 						     cpu0_nmi_registered);
 
+txt_wake:
 	if (!boot_error) {
 		/*
 		 * Wait 10s total for first sign of life from AP
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 2eb62be..3b5cbcb 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -37,6 +37,9 @@ SYM_DATA_START(real_mode_header)
 #ifdef CONFIG_X86_64
 	.long	__KERNEL32_CS
 #endif
+#ifdef CONFIG_SECURE_LAUNCH
+	.long	pa_sl_trampoline_start32
+#endif
 SYM_DATA_END(real_mode_header)
 
 	/* End signature, used to verify integrity */
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index e38d61d..8bb4b0d 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -104,6 +104,43 @@ SYM_CODE_END(sev_es_trampoline_start)
 
 	.section ".text32","ax"
 	.code32
+#ifdef CONFIG_SECURE_LAUNCH
+	.balign 4
+SYM_CODE_START(sl_trampoline_start32)
+	/*
+	 * The early secure launch stub AP wakeup code has taken care of all
+	 * the vagaries of launching out of TXT. This bit just mimics what the
+	 * 16b entry code does and jumps off to the real startup_32.
+	 */
+	cli
+	wbinvd
+
+	/*
+	 * The %ebx provided is not terribly useful since it is the physical
+	 * address of tb_trampoline_start and not the base of the image.
+	 * Use pa_real_mode_base, which is fixed up, to get a run time
+	 * base register to use for offsets to location that do not have
+	 * pa_ symbols.
+	 */
+	movl    $pa_real_mode_base, %ebx
+
+	/*
+	 * This may seem a little odd but this is what %esp would have had in
+	 * it on the jmp from real mode because all real mode fixups were done
+	 * via the code segment. The base is added at the 32b entry.
+	 */
+	movl	rm_stack_end, %esp
+
+	lgdt    tr_gdt(%ebx)
+	lidt    tr_idt(%ebx)
+
+	movw	$__KERNEL_DS, %dx	# Data segment descriptor
+
+	/* Jump to where the 16b code would have jumped */
+	ljmpl	$__KERNEL32_CS, $pa_startup_32
+SYM_CODE_END(sl_trampoline_start32)
+#endif
+
 	.balign 4
 SYM_CODE_START(startup_32)
 	movl	%edx, %ss
-- 
1.8.3.1

