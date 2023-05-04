Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5496F6E00
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjEDOvJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjEDOvI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:51:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D1910E3;
        Thu,  4 May 2023 07:51:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344Dnovb005356;
        Thu, 4 May 2023 14:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=qg+QmQAr7G2Du8jRUNp9LdSED4njF2lSJssP8nuN8+w=;
 b=2PZMoBdB7WordqHmlwvoJ7mvOqrIIxCMTRR5nQACGOoKGb82FvAHEQt65vK0HyVrxWIj
 k3O271cO6f+gXDngBeia3AtC7DEiJ43HEqeVREoNZmJO/2Fu/GdfBW9Nwjp8upG3yQn/
 IedbviYyMX4fykm/oe873xAm9spFWXNWdFdvNowSysrzzV2i9FafekYa6SiUpoSUH6MQ
 wwSYDmCcVZVrtHBmm9AIGb2jMK97E8ToQn+ZgAoe0JCZ9tg/P+lQVC+cf0Kt5SZhA9X7
 wkL9PtU33Ssdt4QgrHhiBQhJwyR+nDhUXd/mqljWSABBWtBHCTFXEeiYuxHWfx1KM7SH iA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t1424bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:50:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344EG6hF026777;
        Thu, 4 May 2023 14:50:30 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spevny5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:50:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWo1eGXld7mr1QbncQ+skXBpefkQZgIiyIYtEmgV/tKshl9dZ+btsXazxbIIsX78yk+AlX0iPwVe4VOY3V1bP8GgJsIaNHakuoHU6uiuLtpQNv/70YbKBVghewAraCvlr+uioHbcNy/s35DvNyxOUcWA2L+CsB+IT1K3F/uaD6a0yCz1DbvrwZc9TcMv00ozq7Pa6B0cGRwitnAjtJ0BAIMUumpck3m4imz4dTAGjLYNEUtFdouH0t+GBQ4ZB6e5irB5yLwQRmTb8qXR/OvaJlvuZwzen9b5nWB1y+EObw62OxniRneZlvm0uaalejdFV0pJH8JuuaxMxZd5BwYTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg+QmQAr7G2Du8jRUNp9LdSED4njF2lSJssP8nuN8+w=;
 b=TxajO8b2f1S9whAvjMJ8mUhzuFChLK8N+F+Trl4iaXx2Zffw8wF1Da80pKZfFJokp24jlqIB9xtKsVuiJAS/tFGRmVFrMBFVbbSGhnkq43vTG255NF6FCne1UDzXM8MUcOe3TH6kosvwu9xU26X+31oQQoPxzM4s14OwwTVk3PEPpOyR+TvII0+bzSuvQHN096fU9InVdNMriEO33oIE6skFxMnZ+No3OXP4wsTP2g6paWyVvz3nyhFOg2h5GPci52weaSM+++YQ21XRWyWVf7t1vXGZnojMo+/e6U03rz8CZoD76+HdTiCy4T53LscCYGUQKGM7MYqQknqUofe+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg+QmQAr7G2Du8jRUNp9LdSED4njF2lSJssP8nuN8+w=;
 b=FqbH59PjIeYB6Hp/eF3Bi2x4HNcGKVPZyZW3wQbupqcPkFRUysgeyxkPkj2mRKAkJDGQLsoYf+VtTgz33IK/PG4wbRalT5/pvt23nXVdG21ykaqayagNeNGtzhz4xLBGZhLVNadyNu+r27IbQZgjlK8LGL/VK2WaJWG+QWl3Hvg=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:50:28 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:50:28 +0000
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
Subject: [PATCH v6 01/14] x86/boot: Place kernel_info at a fixed offset
Date:   Thu,  4 May 2023 14:50:10 +0000
Message-Id: <20230504145023.835096-2-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:5:190::30) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|DM4PR10MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a7c5cf-949a-4ebf-f32a-08db4caee693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYSoaTWDhBqctPxMoYisLVlxrcbUT72eeENKiSHiuauQ5o2m9NtDwW0NhX4XLUNYobZ4LvBX3Lo5tswhQTWlShQ/wf0xmEMlywmzvtyj7yw/ht12EIh2gaGq4e06xYl/H92uUz9pUFipcZVdXLpHlSulhzYUgFLk7sr3WaFKNxlhb6xLyW2WqGHEGnPR7C7+76QMFaco/iJsjhOvdfskncbc+yQTRdhgeJuhu8+MgKzsykz5xJ6sLdIKthmP6Rw+suWgketPZtDTDID0385n6A/y6WN86t3pBKlRo9sUz/br4BLfaAZYBwUVWrTZ2BsFF2Azp/5x4wHeldBGPmkPgTPwAkb3YywcNxtKbUP/nX9t6lc0rXxrtBY6cMJW0kGfqM/xO5j3KEZ+1KGqQK3d5+A7cszydAo2dqxOqHG4a07A7JXGzpoaIEWe9/fhwgiJz5Nq/DkmZN3DFUQD4J6CXAEcDsl+7L+ZuPINAFnqejvHWoRmh74xgTsH7a7CC6pJ7ZcNP90WE6pUo1Yt0aaTVua3cFYuVBjP/iaoqSEh8WwybalyOuvDNz4KuLKk8P4F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(83380400001)(6486002)(2906002)(478600001)(316002)(5660300002)(8936002)(41300700001)(8676002)(44832011)(66946007)(66476007)(66556008)(4326008)(38100700002)(7416002)(86362001)(36756003)(6666004)(186003)(1076003)(26005)(6512007)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gwcc0gJxsCbU52NCwdzzFtKJ+quf05zqJzOkYhfQHEhgPHXci32w7Ru4iAro?=
 =?us-ascii?Q?oV4m7cO7KhCvl7X1zsoeGAhgJoPhr0hUGRiWLh4ZMVDmFFeub7YsvDyKln51?=
 =?us-ascii?Q?mtckzeDz4mF+IEENZitvH3RaICDaAcwYYynS6lNdKl5D9yA0fko/c0+RlsmQ?=
 =?us-ascii?Q?UwBEOsndd+OMN49+BRG+HiJcnSgrmnsnNX++jxszr3x3p6rd7zYBzQnTYpHx?=
 =?us-ascii?Q?Rcc2YMx4CI9zD0jPEbmWK0aVOvHo2Cl/MBboeDcFI43WreV5sTJaqVjM0azm?=
 =?us-ascii?Q?mDQQ5wcTz+T33mazZPC2uLjsVpKjDkW8x28pA1B4UDeUbGEK3mRUpbRGvkwO?=
 =?us-ascii?Q?KdDfpr0oJii6TZfIGgV92ZUw8uW5vxvm5HtojYyXJ/mv011tPbbY9oGMZXjn?=
 =?us-ascii?Q?L54sgj/FvntWNc6ww3ZczV6jca2C49L2nU5mJGty0X0tl3BopsmpplX32WrI?=
 =?us-ascii?Q?6AXB3HmqeTudeRYWt0e5iMmhnOM3nzRbhIuYTCDavg99ZHpNBzCzmey0xnzt?=
 =?us-ascii?Q?W6rpgVmypqskE8EsLo+OqynWVo5+mRWcqF+9g5nPsmYmgu+l1XD9J45y5wIl?=
 =?us-ascii?Q?6qh58DqyR65yH9L0WCThhtul/EYagbp1frhIzHKt4YlcVI4O23intHHOqP4n?=
 =?us-ascii?Q?OQfobZpoLC/ZmnKd1SD0OUviDIP0t7lxUR1lhpW302+HKR6QIe2tZAxFuAlk?=
 =?us-ascii?Q?AXNxdwL4SSUx0vUX372MlqLLo5LOQfskZ+36EwqOb6N8V/uO+3iMrwUg9md5?=
 =?us-ascii?Q?tq1AGWOAWYpj3Pcp8jmKvP2LoyrsbIrDdWWGBTQdDisIHC5c9dYvkc6J9D48?=
 =?us-ascii?Q?8QPNVYqHJqoNcHXfgXZfQ2EsLj6dtGPBom8Cw3i9scKalbAq9YAgteSZYbSg?=
 =?us-ascii?Q?MoH4RMG72V/RkUUukBGYcZtnIzRRTngEvoShJvjvg3Kl0iEtAOZKRfuTP1K1?=
 =?us-ascii?Q?44a0Mjrk0zF5bgTX6NG26Li8UreVSEmSrYgwEJyO7vUT1I5JJUWqRFtXS2cb?=
 =?us-ascii?Q?fNeQsoCVispflHEdM1NRBvuWD2Lg1jpOd6n+3M+fso6s9+y6dAhYV6a6gUdh?=
 =?us-ascii?Q?x33NgNDwKu7r7o8ABXhbT+h+MzDntVVI4EDFcvJBbLrFMCIuHTk/ZARw3N2C?=
 =?us-ascii?Q?ZtkRwVTe93Psuh8D4uOHNSHNO1erP5rQPyhJI3uA7NOgEFDvuRPjWv2GXa+b?=
 =?us-ascii?Q?H4ZYFtMn9x7vSHj5YHkc9B3TuAaMqW+mT9jKBcr/nYCVrjqHdraBSP0Yw0Pi?=
 =?us-ascii?Q?WxYrrPlNiaF2ugoGI3g/iMUwC7aBSOc3gDn/vvfK/TFhyuZvRMfkNiIjtcbm?=
 =?us-ascii?Q?DHnaQsSsYWptSbmiWEprocsUTKnBUsujvjEjY6gFdtFy/FfBATCGH/yPR/GI?=
 =?us-ascii?Q?Sh4Kcma7SQHIieULIMMZskOk4HDjKRlHEIUASTecbBZq5LJ7qK4OPG5m0fW9?=
 =?us-ascii?Q?PL6IPZ1sXEU5pwDQXdMQfnr/rvsRnZ7QeogQJd8LF5nZZkYZiNw5llAR4JP4?=
 =?us-ascii?Q?Qmab1N/jkpxybxaUqMiLHSVxQ3wnPOCrls/c2XGf5TbCRlpbsa61hm0TlHYb?=
 =?us-ascii?Q?VDIN2f1B1hvK4ZsP+5WhJagfYD+aN4lM7eXnFuR6zfOende15jE/X/+vVkLk?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KNcU9Suytxr9/R2tsKz/ns0vdvbZEX4LsLsTgdBIYPLIW3podVdwVGR3iJEU?=
 =?us-ascii?Q?DvOMOtEZdTefyauTd8Y0uaDEOgPFyQqqj9F9RsG37opfNf3ui2DDzz79VKd0?=
 =?us-ascii?Q?mA+IS/Gou5rF3Rq9aPR7PAd28SQc4LWWSlvxhf+0Q3kj6/iKqwhhcA2EsK9v?=
 =?us-ascii?Q?+6uhh1t7LxshUmTYe7PS1ePsjFcPU9+zAevjl5NdAWfNhq8jP8zTF/i8vPbQ?=
 =?us-ascii?Q?6AkrD736dGWB6u747wYXPgkuiK3HZLHTFA5y8B/ciY9sJjgG9svLmHH61e/J?=
 =?us-ascii?Q?mdunJfgUQ6Q2TLHa5/WhylPFBIHTcozO7xG9I8VpG7/9DXnH5DiO86cJNVKD?=
 =?us-ascii?Q?dsu/HN70LzBfldGql4ak/xEwP2CJSe7Bmz0yYIqtPOkbqqnhEGLl1m3cQoeO?=
 =?us-ascii?Q?WKd+j5uVBK1XsD77/GSZizZOuFOXa4gCwin/wQQ/6SBfocKHYWmGX7VeiHhM?=
 =?us-ascii?Q?ymp0FdSqoDTFpsyUXjtX+FyB0DrfPVhDcYfhcUiZApdJB7T37+xVzAvWZ3Xj?=
 =?us-ascii?Q?Aj1jLcH4JmeeolCk72eF/P42GvqxOuL70OQ9JVXa9VSSprlbLwZxEOzmNsKq?=
 =?us-ascii?Q?+ZqEY5MK1pll7PQhXporZMuTpVhRhbJ7UW8DPRPfVkifrUL3oFjJ5VlCYIkJ?=
 =?us-ascii?Q?NmGbPGW3mE33ss3/JgH7Yw1NLi1q0GKog84NCpjet7s1ESfZwDiysrfhwfmz?=
 =?us-ascii?Q?r2ieTYlGOFfaPcRWRE71NcFYdImMBWX1hk0AxQBNDp+TgAjbVYpjgEG8l0JR?=
 =?us-ascii?Q?VparXWENgB3TTatSdNinsMdX0IIRWzN3M8sXZV9XUdpEyMBpE9vQzkPAxOAs?=
 =?us-ascii?Q?25zpRTZLuYEhhC9wGtUx8+EsXS54U/ziyHVd9mrXR/ZZ2f39QO++j1W7Oq5F?=
 =?us-ascii?Q?4rS/7/9CdmytPxBl7dwRbrHRIQnnUsQs+wCNjW+1AEUI2qJmx4NVSaTnYvnn?=
 =?us-ascii?Q?SkaHEZjzQgoVy20uqA2YOBMo4dSTH+noidklr8VMDl/Kq0WOD6b3rneGfeIG?=
 =?us-ascii?Q?TddwnzUu2YiQ34hnbPI6p1Jh08SdNcW80bH5Mf7OMSsqCxlOQoCy6jzrHcaf?=
 =?us-ascii?Q?zRUf9Fp5te7oEBktT+jmKnKnnlJD6INgVIuze/wEyVuoIJWaTJJEbcmVYozN?=
 =?us-ascii?Q?IBO7VqpUHRbgrnyKYhw5jkvS3aI04o84szSkHAMtpK44t/LlF+gozPCG2V3n?=
 =?us-ascii?Q?Qtl0uVJpeBLgAR1ZMIQ0wB17hw48TObLAMo64RbpdrFr3AcUJXOF1uQ5dW1K?=
 =?us-ascii?Q?KMYPhqCXLkT2kQOdKjGqCXIPmoorcqLiYvmfiogOeEexGHKFe/p3mAPt85L7?=
 =?us-ascii?Q?Kcs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a7c5cf-949a-4ebf-f32a-08db4caee693
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:50:28.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhLIlcPHlxhro4uZOdIT23UvFxmvIZQnESvKp/l5FkXFDwM6X8Df1MiXmZH14ZozEo2FAbWJboHxJfdKKfmxrhjieVRoDFLabg95hwx6y/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7505
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040122
X-Proofpoint-GUID: IxaWVgAASc4In9T5KoE_kFBjH55EL3GD
X-Proofpoint-ORIG-GUID: IxaWVgAASc4In9T5KoE_kFBjH55EL3GD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

There are use cases for storing the offset of a symbol in kernel_info.
For example, the trenchboot series [0] needs to store the offset of the
Measured Launch Environment header in kernel_info.

Since commit (note: commit ID from tip/master)

commit 527afc212231 ("x86/boot: Check that there are no run-time relocations")

run-time relocations are not allowed in the compressed kernel, so simply
using the symbol in kernel_info, as

	.long	symbol

will cause a linker error because this is not position-independent.

With kernel_info being a separate object file and in a different section
from startup_32, there is no way to calculate the offset of a symbol
from the start of the image in a position-independent way.

To enable such use cases, put kernel_info into its own section which is
placed at a predetermined offset (KERNEL_INFO_OFFSET) via the linker
script. This will allow calculating the symbol offset in a
position-independent way, by adding the offset from the start of
kernel_info to KERNEL_INFO_OFFSET.

Ensure that kernel_info is aligned, and use the SYM_DATA.* macros
instead of bare labels. This stores the size of the kernel_info
structure in the ELF symbol table.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/kernel_info.S | 19 +++++++++++++++----
 arch/x86/boot/compressed/kernel_info.h | 12 ++++++++++++
 arch/x86/boot/compressed/vmlinux.lds.S |  6 ++++++
 3 files changed, 33 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/boot/compressed/kernel_info.h

diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
index f818ee8..c18f071 100644
--- a/arch/x86/boot/compressed/kernel_info.S
+++ b/arch/x86/boot/compressed/kernel_info.S
@@ -1,12 +1,23 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <linux/linkage.h>
 #include <asm/bootparam.h>
+#include "kernel_info.h"
 
-	.section ".rodata.kernel_info", "a"
+/*
+ * If a field needs to hold the offset of a symbol from the start
+ * of the image, use the macro below, eg
+ *	.long	rva(symbol)
+ * This will avoid creating run-time relocations, which are not
+ * allowed in the compressed kernel.
+ */
+
+#define rva(X) (((X) - kernel_info) + KERNEL_INFO_OFFSET)
 
-	.global kernel_info
+	.section ".rodata.kernel_info", "a"
 
-kernel_info:
+	.balign	16
+SYM_DATA_START(kernel_info)
 	/* Header, Linux top (structure). */
 	.ascii	"LToP"
 	/* Size. */
@@ -19,4 +30,4 @@ kernel_info:
 
 kernel_info_var_len_data:
 	/* Empty for time being... */
-kernel_info_end:
+SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
diff --git a/arch/x86/boot/compressed/kernel_info.h b/arch/x86/boot/compressed/kernel_info.h
new file mode 100644
index 0000000..c127f84
--- /dev/null
+++ b/arch/x86/boot/compressed/kernel_info.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BOOT_COMPRESSED_KERNEL_INFO_H
+#define BOOT_COMPRESSED_KERNEL_INFO_H
+
+#ifdef CONFIG_X86_64
+#define KERNEL_INFO_OFFSET 0x500
+#else /* 32-bit */
+#define KERNEL_INFO_OFFSET 0x100
+#endif
+
+#endif /* BOOT_COMPRESSED_KERNEL_INFO_H */
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index b22f34b..265c88f 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -7,6 +7,7 @@ OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
 
 #include <asm/cache.h>
 #include <asm/page_types.h>
+#include "kernel_info.h"
 
 #ifdef CONFIG_X86_64
 OUTPUT_ARCH(i386:x86-64)
@@ -27,6 +28,11 @@ SECTIONS
 		HEAD_TEXT
 		_ehead = . ;
 	}
+	.rodata.kernel_info KERNEL_INFO_OFFSET : {
+		*(.rodata.kernel_info)
+	}
+	ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
+
 	.rodata..compressed : {
 		*(.rodata..compressed)
 	}
-- 
1.8.3.1

