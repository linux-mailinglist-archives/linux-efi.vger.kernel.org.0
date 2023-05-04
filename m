Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AAE6F6E25
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjEDOwd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjEDOvg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:51:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7651635B8;
        Thu,  4 May 2023 07:51:26 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344Df0RY005132;
        Thu, 4 May 2023 14:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=8UMPBPTYTbtgzHA5Tae5gHr+dSmZRtU0MoU2SQlgcJ0=;
 b=SJTFCmO0XzaesNc9oZKCGQ1rtGCHw+/7TnOvaAc/StXghXpzH8vPrjB9dLyyrPwsdUuw
 W5DfxBk7sDVXDtYuwSGyewHCV9f3K3MntYu1x4/dTI2Uzky6QQSA0ydm7W2Swms0pSy/
 iHHQEgh9x3hiF4MwaNyciv8DsciYT+5dfsw7bfSs9B6cEAkDUN3viLOnBpBYRvHiRkbt
 F6WECvjIytBjZhtUYoyqvFxePG5qmU8AY6mTviRxHNp0nBZkWTCv+JpiPWqumZDMb2Bi
 u2buAK69kPjekqjNqKOo21a8KUBl1V7RgDoZFtUy1JCfz2DCMEUokcpas+EX8nRezZc/ ZQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8su1t1wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344EnZHr026971;
        Thu, 4 May 2023 14:51:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spevpt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjhONv976et5t8Ke4CEW00AvSqdk559cUJfwtri4eQpaz/ziKNV7X62QFWbAhpKbB0mprU1dDGYgis2vdSIyCHuF3sjznDt25yIOl1SNMtuEp4hb13xDsrJM+OX3LV4H8ok4SZOHrkMr7xk3Nr7Kg0b69LyWqFGk294cXoggb1geYZqKFm2kqj6gFkoTBya22HNbQtD3NHB3apJsz36rAUasHg0AwrmkmdV+805C85j0Yvr9rXDeJjugC3NulovJlutwhGvGJDUD3QTJBUsjVGsQTxp3cBKpejt5sMSwfwWR0Ko71f0T1EnawGL08GcAWHWv8rWljhgjqWQ61eitrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UMPBPTYTbtgzHA5Tae5gHr+dSmZRtU0MoU2SQlgcJ0=;
 b=eQ7BA41mPRrwhk4mcgrF/2vSoYTpsLAi/ndkkO1C8evlhit0H1QlQR6zHQ4EwAmWBPHXalaJG15xlGthiiSI3mGXcf0D9jcRS9S8qrywfg5kERZBy9d78ShFwmxaxb4ik2KLtqR86FiII/jvvNOOSS5mLQ8Ub94mB42KMrmVMdms7HDqnWsGZxuL55Gpk1KJcvZ8lxzhJemDoX+s2IrEFjIjgQuhlfHNZt8VNZxLj/WiGXKn3Vyq+pf+sghe4+rodTVDJTd/U7pb4Z0U1bidQi7stIw2i3Mwy+O8Ls8ZAv5DsI5CsJI8rr/2+7+/GjHKFVzAVAztqaJwcYwxj4OCDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UMPBPTYTbtgzHA5Tae5gHr+dSmZRtU0MoU2SQlgcJ0=;
 b=vzIljSVAtmrW4V2kUe3Prd0FTYmx4SRVUUwmGngPW2UoYBFhCw4xBbBCj4t/N1HXFX5VX2Su/TEyFnmkAcaGw1XuatF/WZXJvO2bRyDSUWu1hFWRTNz2vvICAX9A1A8DApEUmJ3OTXkUjk+g79V5kQ4/0jEbLUtImXwAvFlWlZM=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:51:01 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:51:01 +0000
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
Subject: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch early measurements
Date:   Thu,  4 May 2023 14:50:15 +0000
Message-Id: <20230504145023.835096-7-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::25) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|DM4PR10MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb60c99-24cd-439d-97c7-08db4caefa3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsRDFFG0U1FFDHhBUcgJqZtHgPE6SX+KO8Vn5KSjXhK8i4Wik215+d94HBPKm/dMPQbI9eo7C5VMUhD+jfxdlfe7ojMlvdvWyyW3IsHrdobVUgoo/3U2+MwcxuBBlc0YDwhQCZZ3wu1/9q86kcou2C1LgjOUeZTV8P9bu1uysf5tKEy4J6DaFG5TAXDTkccZHUYN4Gip02dGOMez9eof3wBWovlrpMbXDvbVZ85ng9AjZw0R5TZ7HKoo4rTj3GyDFjw7yO9z8T51y52LOfLgziLJgONSzcGGzHYJKxF6SsSjRMXyMCzjd0nyNAcP005iNxMAgHliNYceapdnz4nYe+ti0/I6LhHxAFfdwo6rTJBP04xyYuLdyniRSfBDm1Qbnvn7ChZ0bQlDRnRdkFgBSxZ9IV2ZOOjzLEsU1nDdaqgJbRStO9Ox+4Oh4Lhx8z4fiJqjmLtnSLSnbD/KXnP6Nmtg0V3zmKBocljfArp3/49lZQfnjJOXeMy/dMxB9uwEBEIppY26IPOeLWXzp8Yv5XhzmEDGwNQ72EKqsLszAC+JkIhFSC/IoR7vwUSr02KH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(83380400001)(6486002)(2906002)(478600001)(316002)(5660300002)(8936002)(41300700001)(8676002)(44832011)(66946007)(66476007)(66556008)(4326008)(38100700002)(7416002)(86362001)(36756003)(6666004)(186003)(1076003)(26005)(6512007)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/0i/+sMAO//M4PC3CJE2cr37llUd8+Q90HNSLV+B8oBy9bHuEdCMmy3LhNI0?=
 =?us-ascii?Q?QeMehV9tFDcA1HOV+ke/VtSJDa43nn2gMwoO5R6gZsC/dUcb51lNjIxfhe1H?=
 =?us-ascii?Q?VTJmirxFa0MVUfj/fBtWmTMb83qPQnCrmHxwwtd0awEHnenYLiVB2vb8NZwQ?=
 =?us-ascii?Q?mmdsBXlwqcAf/rAg8HIA92dcfhJ6Xx/D+c6EOHiS8+bT7mer9K/p8wMqtWlQ?=
 =?us-ascii?Q?Ay8BM/j5dTlY5VUG/bazp1sdtRT22sQ4BmFCMGTNHGbx7UrCWfb6bWOuIJAJ?=
 =?us-ascii?Q?U2czWpsFKdqp+moYRVL1C1r6SSOCIIHZShr78RjrsYuouOAzlz8Lqe91ycPm?=
 =?us-ascii?Q?H3BbRXKyKFxHS9WR5lj1CbiWjcEHElnHO46P4gQY0IXeeVGSas1RN/zaSu8w?=
 =?us-ascii?Q?9m/E41/6maBuM3lNFFd6cuKdMRFABai881sJrRl+U2YrcHcxyUja3SjFXMM9?=
 =?us-ascii?Q?7zqcDbSZuYhVrGaPMDlbRI+wf3vfhIVfHevLgj3oSlawztW/tyrdGgH8XeBz?=
 =?us-ascii?Q?dq53Qtw3ef0c5GUJAtRAuccqR3UbwqxzrBKyT8XP0JSR/o29VgVEfa1WDLEG?=
 =?us-ascii?Q?dnkkW3HYEfSgdhY2o3xi2sbpKKmRDnbRVAZ1Evxfd3oVj5H8wMlL/m8CRDya?=
 =?us-ascii?Q?Rl6ufReePkIQISxBGe+NlV/6+LGUjwgw11Bdr+4ebmUqDJkJPdnIvtyWhgpu?=
 =?us-ascii?Q?KTG4uDzME74Mw9N0Z483WZfR/Q0J9l+oA/O5U5xNYk4MzOUNxqO+W4EhPRiV?=
 =?us-ascii?Q?92/LZyCk5EhAdSwTfn5bvDcVPFL9bLQLe9g1qCP5diGYhoRtOvA2PkhbiS0E?=
 =?us-ascii?Q?GIxY3tOFldspndrMVL9t96SsagxVuX9yeInlSp3m9qZsKglSgqT4g8d8UO61?=
 =?us-ascii?Q?oVzbh3V1QUBVb8dFxNpJp5xb1cKLaMTHJNLGyqXGTr+PaWn8RJSyiy+AhQ8/?=
 =?us-ascii?Q?s0wTsdl/Bc7PIe6cFT4fs1WsYj1RtNLLzFzRWi6njM73Vx9f1jsZeQw7X3/M?=
 =?us-ascii?Q?AUGNVCvaPE92+jJ0b8A9SP94Xvy08Wb6XZSyDP7kLJ+2zCBjFoFGG5fknVCC?=
 =?us-ascii?Q?YlUZnUYHBBJ03KvKeeYxxL3isvxJuqQR1HoxTAFHq4wti5fslZrFSjJa8kxO?=
 =?us-ascii?Q?iKigAJqkq8noPxgd/8egOB0Gy/Tc82TgaGPhuiAnmAHMEK6dirvOnzpx6pEG?=
 =?us-ascii?Q?Ef5I07JFstZ7g/x5FGbubZ9NewuUJ0j+O+QuE+bBcmN/vBuv069Y+sKyKDaY?=
 =?us-ascii?Q?YsKkbyo88knsPUdL+Wq3CQyEHOHMUnrnpryr7cTImlPvPQ9xqC3/HcYgjLcH?=
 =?us-ascii?Q?qxp5uMCSarlhckfXfVLeptHjtYp9w4bywclxXYKwvrlA9aYu9AUb5rmIbSPM?=
 =?us-ascii?Q?m7WNw77RVqPlmzDhOnBAYCPpixIWRnzgXihE354XrOkDbI4bxCG08/IUDK73?=
 =?us-ascii?Q?QVy09LQ8ZZCqvYwxu8tyHzVmalAQ5MnvUZ2EqWHoKzQBiOjc244Mb+yJDtN3?=
 =?us-ascii?Q?CF/rTwyR+3sQb5SSqG5oR9khhHpSxg12uGf0L5ADsXD3UOuLEAA2ISuv//ZO?=
 =?us-ascii?Q?j9LTgQ4aqq2tq0K4VKDlLEnhvYRRdc4Udcr3Jgmsg8YiMzbJ7iZX1FlDAyv5?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hDTcbQHxnQfGHJY65vcIK2Q6Uc9lWrInXOLrGIKwREwRWJ+BIchRJZAWUPXD?=
 =?us-ascii?Q?87NG2VWXpRs+mnx4T/6LymGjewwXxPrGqH8sMK09DShlV8hmnNzO07HikzCE?=
 =?us-ascii?Q?Ch9CMWc4Ym94cRFb0IQobGq4G1KMKjU8FND+/hb2z4Lox7CwKYqdQR+mPnaU?=
 =?us-ascii?Q?OXJQs2s+yGfyPky03jNDphY6bcMJruxWzMsfQbCX8cmUmboMr7EXxt8gaqGk?=
 =?us-ascii?Q?LjmawNkMhwylQaQVroI4CmkWMoGDd78wO5UWrPzDo98cDVDNATNHPL8FHAAs?=
 =?us-ascii?Q?11jufxU9xg/94Nh33aZwGndzpPP9OnT028JhDJvgvQReCBEMqvP8xIwUUJv4?=
 =?us-ascii?Q?zRF9RUarYfDIv5hczZMsjPDCsRpfgrWJIUZv3+ttVXGa/VMpDFODImMG6q2Y?=
 =?us-ascii?Q?xqOJ1SrwSV+6UCbq4RgXVvIOs5eoSaSaU4oeIbzn0Oyjpox82VsjufcNLQdu?=
 =?us-ascii?Q?t04mhjyh6th4od4xr5+5afD1rRtv43zTNy1NelrPoFc+ZD1qbxNpOlKCUBHW?=
 =?us-ascii?Q?+50UbvMd0rOH/hZk/ISSx1wPfx/zsMR1/2vKDXpSqPyBZXhzCgWiGSouEnmS?=
 =?us-ascii?Q?JMoZvfyFWwq3EnGki6H2x9K6L5wHKZOxx7hqs39OyPjpuEWizRG5R8Xl1RgO?=
 =?us-ascii?Q?d2Gi3P7HDMc0PTP1f1MdIGNrRTMsvcBwJy5ihk7eWABLMB/aLO5r1qz65x/P?=
 =?us-ascii?Q?9/a5iRWSaxMdG8pDk8BSHBcC4lvKiq+aXRlJZAxJIGYdSLVFpW8rpg/j4bjW?=
 =?us-ascii?Q?hPIWB6cKWvOLGySsAN8RHZ0Fib0UVgoa/cYhDY8HAqwU24HDwBuClWLZnNQx?=
 =?us-ascii?Q?kpEOvC7nGD5YHx8wW++9hExGGmcQzuOX6RjFPpvZ56ixkIHnp+7jK7QZeImv?=
 =?us-ascii?Q?q3BtnxyFxPJicUPqXvt0RBebUQr+4vHU+EVL0LMbMPJ9qblhamE3qWkQ62j/?=
 =?us-ascii?Q?P97Hm3lcjX/TQZCdBB65fEe2IwwsPU5k4T0tTx4zV9LiueyhNMDFaopDuxLm?=
 =?us-ascii?Q?JEW9HtWoJz4PyepOnbfxtPidXX/suI3npSTWADc7ucFoYhhQvVucqlW84Nab?=
 =?us-ascii?Q?UPLcTFgUdxh4ckIVvX61qFPnVXtbOx3NkM6kkTVUSZa6e7evkVF73YiWEErc?=
 =?us-ascii?Q?0rMkdaPsQ7uwL8MPAPyXxDIy0apJAlO9xSBFALKvQEDM8Ak0R29ABrqFs7jo?=
 =?us-ascii?Q?wVDh9i81cbEhL/kHg5582G5w27esVkDc+jIkm+QYFeNzB3+k+/zzDwPCOSHb?=
 =?us-ascii?Q?G8D4QVUdzsuf9QTmBYENQmYfqShFI9lZLp98lOFLivgCcwxtjQBUkgtlPG/g?=
 =?us-ascii?Q?EU4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb60c99-24cd-439d-97c7-08db4caefa3c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:51:01.1620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cj/U7r+I5FvHJtd6OgHWIztHlPah0GRYKFOKHHH7MxLrW7SZ5fn4rn3B9sHj8KwhhBgVvFwJZBR5IA7cU6ur8pVb5pid9nGuR7Brs7R5WFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7505
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040122
X-Proofpoint-GUID: t04aoHPAa9C0qiRu-B5n4z5DZ065AEyB
X-Proofpoint-ORIG-GUID: t04aoHPAa9C0qiRu-B5n4z5DZ065AEyB
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

The SHA algorithms are necessary to measure configuration information into
the TPM as early as possible before using the values. This implementation
uses the established approach of #including the SHA libraries directly in
the code since the compressed kernel is not uncompressed at this point.

The SHA code here has its origins in the code from the main kernel:

commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")

That code could not be pulled directly into the setup portion of the
compressed kernel because of other dependencies it pulls in. The result
is this is a modified copy of that code that still leverages the core
SHA algorithms.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/Makefile       |  2 +
 arch/x86/boot/compressed/early_sha1.c   | 97 +++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/early_sha1.h   | 17 ++++++
 arch/x86/boot/compressed/early_sha256.c |  7 +++
 lib/crypto/sha1.c                       |  4 ++
 lib/crypto/sha256.c                     |  8 +++
 6 files changed, 135 insertions(+)
 create mode 100644 arch/x86/boot/compressed/early_sha1.c
 create mode 100644 arch/x86/boot/compressed/early_sha1.h
 create mode 100644 arch/x86/boot/compressed/early_sha256.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b6cfe6..1d327d4 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -112,6 +112,8 @@ vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_mixed.o
 vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
+vmlinux-objs-$(CONFIG_SECURE_LAUNCH) += $(obj)/early_sha1.o $(obj)/early_sha256.o
+
 $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
 	$(call if_changed,ld)
 
diff --git a/arch/x86/boot/compressed/early_sha1.c b/arch/x86/boot/compressed/early_sha1.c
new file mode 100644
index 0000000..524ec23
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha1.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Apertus Solutions, LLC.
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/string.h>
+#include <asm/boot.h>
+#include <asm/unaligned.h>
+
+#include "early_sha1.h"
+
+#define SHA1_DISABLE_EXPORT
+#include "../../../../lib/crypto/sha1.c"
+
+/* The SHA1 implementation in lib/sha1.c was written to get the workspace
+ * buffer as a parameter. This wrapper function provides a container
+ * around a temporary workspace that is cleared after the transform completes.
+ */
+static void __sha_transform(u32 *digest, const char *data)
+{
+	u32 ws[SHA1_WORKSPACE_WORDS];
+
+	sha1_transform(digest, data, ws);
+
+	memzero_explicit(ws, sizeof(ws));
+}
+
+void early_sha1_init(struct sha1_state *sctx)
+{
+	sha1_init(sctx->state);
+	sctx->count = 0;
+}
+
+void early_sha1_update(struct sha1_state *sctx,
+		       const u8 *data,
+		       unsigned int len)
+{
+	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+
+	sctx->count += len;
+
+	if (likely((partial + len) >= SHA1_BLOCK_SIZE)) {
+		int blocks;
+
+		if (partial) {
+			int p = SHA1_BLOCK_SIZE - partial;
+
+			memcpy(sctx->buffer + partial, data, p);
+			data += p;
+			len -= p;
+
+			__sha_transform(sctx->state, sctx->buffer);
+		}
+
+		blocks = len / SHA1_BLOCK_SIZE;
+		len %= SHA1_BLOCK_SIZE;
+
+		if (blocks) {
+			while (blocks--) {
+				__sha_transform(sctx->state, data);
+				data += SHA1_BLOCK_SIZE;
+			}
+		}
+		partial = 0;
+	}
+
+	if (len)
+		memcpy(sctx->buffer + partial, data, len);
+}
+
+void early_sha1_final(struct sha1_state *sctx, u8 *out)
+{
+	const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
+	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
+	__be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
+	__be32 *digest = (__be32 *)out;
+	int i;
+
+	sctx->buffer[partial++] = 0x80;
+	if (partial > bit_offset) {
+		memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
+		partial = 0;
+
+		__sha_transform(sctx->state, sctx->buffer);
+	}
+
+	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
+	*bits = cpu_to_be64(sctx->count << 3);
+	__sha_transform(sctx->state, sctx->buffer);
+
+	for (i = 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
+		put_unaligned_be32(sctx->state[i], digest++);
+
+	*sctx = (struct sha1_state){};
+}
diff --git a/arch/x86/boot/compressed/early_sha1.h b/arch/x86/boot/compressed/early_sha1.h
new file mode 100644
index 0000000..adcc4a9
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha1.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Apertus Solutions, LLC
+ */
+
+#ifndef BOOT_COMPRESSED_EARLY_SHA1_H
+#define BOOT_COMPRESSED_EARLY_SHA1_H
+
+#include <crypto/sha1.h>
+
+void early_sha1_init(struct sha1_state *sctx);
+void early_sha1_update(struct sha1_state *sctx,
+		       const u8 *data,
+		       unsigned int len);
+void early_sha1_final(struct sha1_state *sctx, u8 *out);
+
+#endif /* BOOT_COMPRESSED_EARLY_SHA1_H */
diff --git a/arch/x86/boot/compressed/early_sha256.c b/arch/x86/boot/compressed/early_sha256.c
new file mode 100644
index 0000000..28a8e32
--- /dev/null
+++ b/arch/x86/boot/compressed/early_sha256.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Apertus Solutions, LLC
+ */
+
+#define SHA256_DISABLE_EXPORT
+#include "../../../../lib/crypto/sha256.c"
diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
index 1aebe7b..771ff90 100644
--- a/lib/crypto/sha1.c
+++ b/lib/crypto/sha1.c
@@ -121,7 +121,9 @@ void sha1_transform(__u32 *digest, const char *data, __u32 *array)
 	digest[3] += D;
 	digest[4] += E;
 }
+#ifndef SHA1_DISABLE_EXPORT
 EXPORT_SYMBOL(sha1_transform);
+#endif
 
 /**
  * sha1_init - initialize the vectors for a SHA1 digest
@@ -135,6 +137,8 @@ void sha1_init(__u32 *buf)
 	buf[3] = 0x10325476;
 	buf[4] = 0xc3d2e1f0;
 }
+#ifndef SHA1_DISABLE_EXPORT
 EXPORT_SYMBOL(sha1_init);
+#endif
 
 MODULE_LICENSE("GPL");
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 72a4b0b..e532220 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -149,13 +149,17 @@ void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 	}
 	memcpy(sctx->buf + partial, src, len - done);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha256_update);
+#endif
 
 void sha224_update(struct sha256_state *sctx, const u8 *data, unsigned int len)
 {
 	sha256_update(sctx, data, len);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha224_update);
+#endif
 
 static void __sha256_final(struct sha256_state *sctx, u8 *out, int digest_words)
 {
@@ -188,13 +192,17 @@ void sha256_final(struct sha256_state *sctx, u8 *out)
 {
 	__sha256_final(sctx, out, 8);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha256_final);
+#endif
 
 void sha224_final(struct sha256_state *sctx, u8 *out)
 {
 	__sha256_final(sctx, out, 7);
 }
+#ifndef SHA256_DISABLE_EXPORT
 EXPORT_SYMBOL(sha224_final);
+#endif
 
 void sha256(const u8 *data, unsigned int len, u8 *out)
 {
-- 
1.8.3.1

