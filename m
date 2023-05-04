Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8646F6E0B
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjEDOvU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjEDOvS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:51:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE29444A4;
        Thu,  4 May 2023 07:51:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DvTrF013260;
        Thu, 4 May 2023 14:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=JwgGF11CRIVBl8unqz+HBuSAhTm/KYoQ9W7ESZdNCNs=;
 b=3PovmCX5RnseCHoXdjtzVxSVIxPx/ouZeVI2UX3fz45vXAWbIp9Kb+loa1X7J58z0YsH
 KrXVy9OASjvrzrr5IeQlQzkCXjRjE66h/521YpC18FzxM+18moJCyQQTB5ozcWFVvHI7
 qrdZK8mGdouKCsZtjL9+gbedUXsK4OyCR/XyAlExCHmnlhDxTkedgfxo6npEAqdssoCm
 cEVORIwdm6IXtcKsuz3MM9PWU+dYp7MHTUNx/jbibEp4C7on2GgsUKesSar9smOrtzHg
 0Ar/p8L2PloHUPSBIGlpMOdmBJLY4W+3DWHFoLt+cTBn0JvZZuNquawOjhSdlf+Q7OGQ yQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8snea1rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:50:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344EGkTq024931;
        Thu, 4 May 2023 14:50:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8tqmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaGfm2p9PNm2ae/ST2i0c3poyy/QxZKIkh4MeoqvPpFgrQq2Tw/sfl+4VXk4RhrzA6gZYDS3ekaDQ+DFLmQuPL0HayE854vDHG7jLsCmQOq/3WvrO+RgKp7vMFcMJokQ5B+7xoqn/Jn+2TafgEqqeLR0Ha+YQC5RdgV5IucTcX7FmPUy2369W+6K7L5blVVlMgETog1Sx/b88PS2s+xJum+u36cHLCov/D9mr38ZsGRhoO11XceBVgxL3OZjJO4MbOKG2giJSX1mzS0G8CfXTEYfGtI6wXsoKnIIKkTQLiJqUyX8SpMi/nRzRsDjOJNvqHB4szWDQbRm69pYmS5cUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwgGF11CRIVBl8unqz+HBuSAhTm/KYoQ9W7ESZdNCNs=;
 b=SjlA2RrbmjkXhcWxzxjL+mI4qrohT0lda+RjDdF6aUIAi+YGGlhFoZPzlikOh0gziEX1kCji6t8urf5HqZjfvoe9++zEV0+6lwQGc0WXUarKevRDlyXPA/Anz7V8yPQ4LXd6nhFoBcRTRLPlVmi2j5ptjUWr1Lot8MEqLXk1956/HmCSE1GVPXcIqeP+iyEErNWW/2ntfTJPs7H2uf7g0TU2r4btv2ySMTrhND7EFck4kQyWIXlBRdguG8eHy5W8BW+TA2ys11cNuij4ebUPZYpjRaqjCB+wgJ/R1ZQsVlfCMsgpa1zzDx9UM1envq+CJWg2O+FrHGcsON+Hqtd1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwgGF11CRIVBl8unqz+HBuSAhTm/KYoQ9W7ESZdNCNs=;
 b=M28CH6RIM02gxR7dTQtjFNp9izY1SkOz/npBu4LoLssCILuPnOmeZA8wUCo4IUk44eEtIoreaChdt+ZNu78x7VLoHbCYQvQxEN6Mi8D9GtFAuz3AOdpWlohMYTIJt+xhHbilH9iRT2k2BYtj3WaDOjsMpUxLPGZHU2sFJVvPPTY=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:50:47 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:50:47 +0000
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
Subject: [PATCH v6 03/14] x86: Secure Launch Kconfig
Date:   Thu,  4 May 2023 14:50:12 +0000
Message-Id: <20230504145023.835096-4-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0472.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::9) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: fe022bd1-cc0c-4a95-47f0-08db4caef208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2MVX/m4vB1zTtbBg+Umu9qI0Emb7j6z1vedAfYIAYEuI05BqO0h9vuMZIixneoSsXClK1qU611wSLilCa2iyiSAEE+9f9kK1iyYfTIQ09+X3FhqJiFyhhcPUL1D95MX01UzS9TcBpp6dHI2/ayL7wKJevSCo5k3nqw0B6XTUn+Dt9+ILqtS8zJQC7y6ueAR1dM5PzSWrybYcuD5cP2UyDH4QMEkojLMCptLb4bipnOw/EF5SUM7df0H5i8Z5SrV0yBB1fyZ+q8I2dvFUnVB63f/h1VEjapw3erYkTyERGgiSwDW7s02FE1bX3EdZu6A02dYVFUJZi/Kbz/Sc3cNQpMOcoPB+Vk5Ectj/6bvXi2rWTAY+m6FaQQlUz3zhxKkDPWsE/EXJFgCmpZKVPnN3I+3zGXcqplsnjL1q6YgzyHnLpBqhlTn/vYAY4h8PfGSWngYD9ydUjgsv1X1kB7V8EukZKg7ssu99e8kScNYBugT7D4Gq3euAcWYIB5yOITZtsZw/4//jeECnhObux3WCroVN70mENsg/ljMdBKCyH/5EEsMVBGGJRXdIqBhsNxe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(7416002)(2906002)(4744005)(44832011)(8936002)(316002)(86362001)(4326008)(66556008)(66476007)(66946007)(8676002)(41300700001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(478600001)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MTLP3mU63QNMPsAlGRpLBFvba7xnI7hAoFD3witVfRcEYmYeytR5TRApUKT6?=
 =?us-ascii?Q?tKdcYVPt3h9jphIDp9/6bicTip6OTpxVGf7HU5seRqz3Ayg641/fznvbxHvf?=
 =?us-ascii?Q?/LrwaSr2n+zYKAoc/1wnj7eg5cgNpNXWj1bcRALZIWbkLQw9qGVlF8/GkqaR?=
 =?us-ascii?Q?ZcyM5rtJ8DSqHaeclwINNdwskZMcl7gycX5+m0yYW5CzjrCx+fuRfXDAqduD?=
 =?us-ascii?Q?AZ5ZPEjgsZcURlxDWxizbg1qE6eglvhNeSw82B1ei65HESum2LQlHEHdM3ku?=
 =?us-ascii?Q?U1XBoHO0MGCb6Mns653yrULDVNqbW/Sght9gihehuYDWH37Shamow221CkRf?=
 =?us-ascii?Q?xk401kuLqPPYxf87RTIwmHRkcFJt2p8qHanfPs03hGd+aJcNm4i3Gg+SOO6x?=
 =?us-ascii?Q?yd3nDXG5WJZ22g27e/H5k24q2AbPr40rWDL3cux4J/36JuVJ2YzQbDmkAtW3?=
 =?us-ascii?Q?IElB+xsr9qiM2OjBIp/0whdC3IsAFYL+9oRJbFe7S7t+jIMYGZmc8Dx9VxTU?=
 =?us-ascii?Q?vJERqYuS6TMBw8lFmKMB7284anUi4Ex6DN403J/7pacLAwNkUOmn651RJeoJ?=
 =?us-ascii?Q?CM15sT1vriens1eO7p7VFATYZRDN9CtZa0OZuBd3pMUVa6EO1hFOyBMTiPIT?=
 =?us-ascii?Q?WOEg1oIBmxwwaSeJ5u4+Ubs2eH1q5rJ7YLSolPiAST6w98rwAEAGcHBzFeQD?=
 =?us-ascii?Q?h5Zwilk9TqdN/QM2df26Nm8Y0J1PWtqDoJQceMw+Kj931xb2HxxYOjpi2kGw?=
 =?us-ascii?Q?34Gy5a2QSeD69fn+ypyUB7hBBsDKeKg9N5JXcQnxXLILwjqYahmz9yyDzbul?=
 =?us-ascii?Q?wWap3zHAwV0UOmCVO7het1YPaT/OYkFbnyX4ByuOguR/AgJ95BxQ8UAxaPGn?=
 =?us-ascii?Q?Q10zxUuhXmRZMTwk/Xggt+4P/1Bpt7+Dhj6ik3zQIq6xEbhHP48CztJhfDTl?=
 =?us-ascii?Q?SajO3HpuTozy6mZZKUtP8tPUBHs3sUOan+VkZW5vT9ryjjh4jBFJNejSiRCQ?=
 =?us-ascii?Q?s7qth0p+K7bq5V4PkrNUcmJG4wbK7TQmIG0Vc9PaUOEHRXH3zTzJreoVZQ32?=
 =?us-ascii?Q?W50yqy+LlZEnkmxuOV5C+cS7mCwn++17LwMoVyTyjynWCOx2EUQBvM7+z858?=
 =?us-ascii?Q?p/LrD3DyGINHPToJhx1MFWXSgsvzFRwA3vYDMLn2z3GaVsCC9rpKWix1H3F8?=
 =?us-ascii?Q?+fMBL70UpSM0kosqnzRh8S4fd4NZxAVPzTfXKcSLLFdW7QCGq/Ddh61CJEms?=
 =?us-ascii?Q?1KvUvD64BRG2VNNNIKJfMa3/YSJ7JvJhAVyEZe9m2JZngtnlCHDlRTMO97JL?=
 =?us-ascii?Q?OjtESKzK7OxU2GoVJI9rKJpRnporWP0oThYzP30JSrAGPjwv8oWRJV/0KISy?=
 =?us-ascii?Q?KaXtKIKPl6035Z/DgCkfRsI2ibjLqaIxVN96EuonQDWBXHXrECc2FBuELDyZ?=
 =?us-ascii?Q?S5P61fR6YSN/ezwm7hU4CR1myVmq1ODzqMJpYRZ+uNmbq7YF4yY+FrM6ocdN?=
 =?us-ascii?Q?dgxH+mRE2BitFPBic1Azc/i6iLTfwSPPphL3kxncHytM5K1290GJAb2wqy6E?=
 =?us-ascii?Q?tcdDaLuQCmksKNlXi+X0IUyF1WJeRzdzbXSqi8oR9yNpFOwcl2gSM4ddk71w?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DboCeMF6dLceK9/nUy/izhetFojiijeyTnBNGgS4U5pFuTRa2BDZTIZVKKfH?=
 =?us-ascii?Q?Tq+3OtRDAMqUb7Qu8rolP+zcnwld3sq38aPbA/2UL1MWqtrgP4s5IHESvhGt?=
 =?us-ascii?Q?MMIdSYh491hrodv5VFcjCFqg+kKDexX0+tUZK3EHBR4Ez0Wiv6cxhJpcxulH?=
 =?us-ascii?Q?nWCV9bn6UUA4/eDyrblw0mVEvMoMzETFPgPS76UBXlNIKbsfCsuw/rqWUWtY?=
 =?us-ascii?Q?Tdhg5n2cAGXw/vurDwyLLrgP66paI8xew2zU77RhAGqk7MSkJQrjtNtG2g5T?=
 =?us-ascii?Q?PFOf/XuTZfRoqUR4Gs5CxnO3jPrw6OrPeWswItSECkBynbk45yqkLgwLcUr2?=
 =?us-ascii?Q?4sIBZ1J3KUblpkJ7za4CaQrCR68ppgE7ba7EmaG7WI1a9JPcyCV53XyKpfjz?=
 =?us-ascii?Q?nf8zF0S17lFBlxQoTsC6Yu6cJUstjunF/5prxoJ5vDyNeHIRWnV8fUbLMFOq?=
 =?us-ascii?Q?zYkI76Tt/dwdceWUjUW3fBjd383IMvLyjOoDa8kxANVznlDB4VVEpkEFcydE?=
 =?us-ascii?Q?aNgwbojucSlUki1wo69cdh7DexUc6Ztc1unfB6JF+mCUEGMdDVoOOeCx7F7l?=
 =?us-ascii?Q?w61ceukomYRn3ojbux19eFid6XeSxJ3pHxDNiBT45+KFclgWrTT40sR1AfL5?=
 =?us-ascii?Q?nTOtVrmHxjMxr3Solq1uI5iEjNAWqAFYCVUXMl9aJ6ekf5HCO5sjS1sz7C4c?=
 =?us-ascii?Q?6M4cPxW3NnS7fR30SxddE43ElltUxifMbdmCxq1bmaI+wfF+6OTSdoLqzT5v?=
 =?us-ascii?Q?gL3SXPLBAK5RlijBfDDXdrY27UR9SvsQo26h3hFKxtVBuRj3rSGAuL1+pf0n?=
 =?us-ascii?Q?dSJ9td2tYdEABBOlNCjtD/hJnzWtEuawbrWHd+pQbPUANbKYdyPkugmWzPUA?=
 =?us-ascii?Q?f7gsnqyQg3ZDe6v87SScwZxsDFamUU9Ez4JJRydkUoasKOWzZ5WUcIfQGT39?=
 =?us-ascii?Q?g9Yarm3kkGZca/0QyNVc0P6AXBtJgjsN+s8xEs4iX7CfRXiXZ/4tmut71k0m?=
 =?us-ascii?Q?dbaMTKaOz4V34UdWgsc1MOh1Iq9n4kGSQbJ1mliOB4q55lg3YPv+CaJYT6hI?=
 =?us-ascii?Q?7JB4tXPWdy16x4p3J2YSdfm7tlVr5Ub0ekmmUsIageQTMLJmvqit5X5hZQI0?=
 =?us-ascii?Q?XGSNhwIomdmMBjCZYleSoe2MTYTaj7H1tEO2aHQTPA5twOrnA3gYbzQ3q7Yq?=
 =?us-ascii?Q?8cBtYE9vug5Dpy7tnegVFYLgUPFgXsBjWITj6ryCxsIMRZjm3d90/Q9iq7k6?=
 =?us-ascii?Q?j02CAFiYcSsLUg37BXVL6NkgKSvYYXHmSS1DL4Q5+PjSSj/GrHo6vj3/zHxm?=
 =?us-ascii?Q?cx0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe022bd1-cc0c-4a95-47f0-08db4caef208
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:50:47.3827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgb69VVGMGNQ8MhLkEJqvtUPTLYsOR5H1zkY/5xsVizpKm6ktC0cfPhLa19MPQ2PDpNiwdrXT9bwhy6O2KcvZxY7baVzE/RUkYmYBv2PNc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040122
X-Proofpoint-GUID: xw6uBKKytzesxkMzohCJ6CIwthSLx683
X-Proofpoint-ORIG-GUID: xw6uBKKytzesxkMzohCJ6CIwthSLx683
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Initial bits to bring in Secure Launch functionality. Add Kconfig
options for compiling in/out the Secure Launch code.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53bab12..85ecf3f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2041,6 +2041,18 @@ config EFI_RUNTIME_MAP
 
 	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
 
+config SECURE_LAUNCH
+	bool "Secure Launch support"
+	default n
+	depends on X86_64 && X86_X2APIC
+	help
+	   The Secure Launch feature allows a kernel to be loaded
+	   directly through an Intel TXT measured launch. Intel TXT
+	   establishes a Dynamic Root of Trust for Measurement (DRTM)
+	   where the CPU measures the kernel image. This feature then
+	   continues the measurement chain over kernel configuration
+	   information and init images.
+
 source "kernel/Kconfig.hz"
 
 config KEXEC
-- 
1.8.3.1

