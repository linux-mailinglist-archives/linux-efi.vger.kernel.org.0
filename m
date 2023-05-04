Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6356F6E2C
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjEDOwu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjEDOwa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:52:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE2A4ED2;
        Thu,  4 May 2023 07:51:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DfaxY023330;
        Thu, 4 May 2023 14:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=F3Y5bJMdDw3F9WIGdnqVyEDywojjV3Tmyh7zHIBAFWw=;
 b=BSYKF6deP8Pa60dTuLJKbV9VQvqP2yBqmg4Dlrj7HDeyDLJKzbRijzrsdzXZU6oSgOl9
 kfksL6BRxnV3c7TRI+1/+qBG0GQPd5LsXiIsW3PWWNJ7NgiuFLQCoK3wHrcyY9KlZZqv
 0cjdwF2YOXASZaXuulmtRFJmmusnlXPW4VJnjYU7m8W3JWRfgouWuXSQDEQkQkX/D5NZ
 Elk9UtOPJ3k4kxnLadJZt2oY95iwpVxinUQ514MQzYRSuIu6N/LFiw06kLFfrmKcHz7h
 OxyyVAQ2kyGEUYNerrZq1X9ICcU51RP7KewVjIkXJ8H3o680iw3cIybcBYB1iXdrEYi/ fA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4aswjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344E8wtf040442;
        Thu, 4 May 2023 14:51:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8mrf4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZqyI0In2+M6l5zwm10/lEBR6q5rjMyvw0lkSJLh1L7Z51Pd8sJNNpHBtRs2MyFMWRUNK5yo+09guoI0iMKIm+blMl6lYpUF7xRhp2o0SX8sw5MLOqXlaOYYYYNYuRPxbWe4fPYIKP3Vbt3Ha9CPkiAUXM4lFw/IaLLtbRbxU6Y98/10b+EhZLVXo8Bh5cT1kXeMdaEbzaih5I/2qQ0cGFYvcMun+pVdIBSbQW4au1U16XzJ0bKlG/HuLKKmk4i/rLJUcluzImfklbsj+cnJjSojtNTVaRKifl4qsq2p/Wzg2g7Y54zA3t868+nJ3wwVjbe9vB2J9z/52xyOxJS5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3Y5bJMdDw3F9WIGdnqVyEDywojjV3Tmyh7zHIBAFWw=;
 b=nY3W+tDI9WRCtAZdTi+9cpHwMSGkabRAPInf8mF/8FYbNLrOVzbasuInklhcRHj3a0/gwZPc9R86OXZBGws8z9GgXTuKKnoq2ZLpSZe3uGuMULGzMfTeSAxW7FH+8NCjKp3GYoQLRj3gJXLzh9w9fO/+jOmqyLU/xRuYyH+gtg76ohVfbKSpCM0A25eyegJ1QZir+ZnJsRwvumCVF74IEKAjGGQeBbDfYYN1TuV50eUcEuKAz2neYDjic/f8yX8LxrHBSOMR89a5/rAGUBY8H8iWV/nr/Sivkv9gVXfYqEUi8Y657JF0D9uWwalYOXoKAG76YunKjM3J8rCVUtHGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3Y5bJMdDw3F9WIGdnqVyEDywojjV3Tmyh7zHIBAFWw=;
 b=qcsLL5sqTQx36BMoipCSYvC5NQgvnzyi4KkqfslB4Wb/Q9EB38MZPqfXUIU893+wuKJ5FO3SsselYughHV+T6rkkhtDlWY+FseP8J/MQz9UUuPFrl/i3eyIyENqk1Nwm3iQJhVYwqlXfHm+e4iD9wyr4lQr8uoMYdA2L8e+KlFA=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:51:05 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:51:05 +0000
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
Subject: [PATCH v6 08/14] x86: Secure Launch kernel late boot stub
Date:   Thu,  4 May 2023 14:50:17 +0000
Message-Id: <20230504145023.835096-9-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::35) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|DM4PR10MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a860d2c-6f3f-41e3-aac9-08db4caefca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWsNc4Mz4jJL5DILfJ+xeo44IzKSJjJ9RcYzGYYwRDhA47ZXXNIk54nU0xydQw/mzF8gu8IrB+nju2nW/jMHTikgXXsSzVnxnN1o3MjE1RZP5eSNhnWvZaPxepr7WxHdkg8AYqgf/kaK0Y9cHYzwMbVUzfFzkW24GJGYPMQOi04MjDx0tBMA7zN9iM8TbFByKo2m1F0lIN6EWxkJ+s5jDRZC3mISty25aeqS0cI+Ekym9GKy5f0Ml7sHxT5GR1cn///AbpGRdEocvwxlH3B+roWrct4TtQ+VVK1A0+pyfDjO8T1DoIijzjEs+WGSTLsez19FVnXNrhMs2C95hWxy5IvquNthHbHMstyzKdNRgf0MUKe7YB72X0c1dxch1N5cm5jNusG2d9bAHpQwz9awFJQ2lUmnwzYJkuFwzm1hQNihmaERVii53m4xm5SiGK5I9bGr8N4UEUenh/sXxF3wUsBEiW9UuPBk7wQXMIbdJi/XB6qmOs7XnzKDK/dmTVROhu9LPm1MumNrsoALNbIlyAGVBPabWvZkXeBmbxIXe9q5oFZHwjYNPoOJqBfDtPiJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(83380400001)(6486002)(2906002)(30864003)(478600001)(316002)(5660300002)(8936002)(41300700001)(8676002)(44832011)(66946007)(66476007)(66556008)(4326008)(38100700002)(7416002)(86362001)(36756003)(6666004)(186003)(1076003)(26005)(6512007)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kbux+yLtvE85655wm3CXB62vbxsgMD3/NFjkHbbZMkmANQG7OhEKfh2uDyyw?=
 =?us-ascii?Q?xuNJGiFQW8/DIpoQ70vCgII7n9Q9k/NpUnUfOovb9RAvWz/nEjC0yF8C8fYj?=
 =?us-ascii?Q?ZjZAHXLlThfcn+53jHcKgBtjWotGNInz33g5m+yY5cOmX+TuuZuMkcVIUJA7?=
 =?us-ascii?Q?csq4d3b8LWoQC8DXSv4LUlgjF99ex3uCNHKJtOvZyN/yunHloZkw7p1VvRrV?=
 =?us-ascii?Q?3uhSsunjwVkQApNllZHd9jovbac+6DpfQ5p7U80LaJ/7VZhS9ZBquwDb7oTc?=
 =?us-ascii?Q?/2FAz7Mp4hMyFQ9zIeVs8iWsmHhP4KM6SPLJS/FQ3AxYHTyknCwbvb86avwl?=
 =?us-ascii?Q?0FDM7D/svj+kgs6WSVsEYv4pQHb6TLVS4NXLiKyNTTXQ3/+Ph4ywMXrS1RJe?=
 =?us-ascii?Q?ZvyAXnmxxY0BViYWA4qKA/uFTs3K47veS6wabiQx2jpLgsRpO13/wK8VZEnp?=
 =?us-ascii?Q?wY5tNWWDXwx75invhkZtaN5KnxfdOESWvhBI/hr7VTCa9cEyk4td8YffRDHN?=
 =?us-ascii?Q?CnxhwmzqNHxVLpwa2z/xkEXuCzf8UHXI7k9/cld23EVYRfL00Hl2YxOEIGy0?=
 =?us-ascii?Q?wvyCSU1rWlcmxfFMu0Y0C5l0OwoqhudCoeA+zPsikK+K3R51XAfvM1Rp4IJg?=
 =?us-ascii?Q?VwneSSTplaS+Y8ydmNhB0fVNWy71QSu2bY9M7b8W+qVR7RMRym71QOws1kPk?=
 =?us-ascii?Q?5h+fUAuNtjk04SGhSMeDJp0KjGFYCdyJKANXOOz9y9yR3x90+rcEe8AhgJ4X?=
 =?us-ascii?Q?N3B0c6R7pAUVZ0kkdP8/ggDc983E7iPV3mKdVPjZ6+N8QFKP0EerHmDNbYt7?=
 =?us-ascii?Q?NcO4pWwnO/a9yFMfuY2O+EbquGWI/qFn8MpHSDxqzFixXWH3Ehm3KS0q/OdX?=
 =?us-ascii?Q?tLPgDhDudcNDMFd1nEYJhbzB/tkOg9m8GzI/gss/uRnLEl2fQNImRWSjzfr7?=
 =?us-ascii?Q?fwYlkfKhfoWm9Lm/DMaudibw+6c5XfeJjpsiZI/57yBqoMKhLV9mjPkpTn62?=
 =?us-ascii?Q?TluVaVRHMjiiqmtqCATfRnjbjdIVnhukt8en1QFW7pzMg415XrKvTtz8tuVX?=
 =?us-ascii?Q?41fdyMXThfObOyivfr8u7v9kdr1QKVuTjD1qvLHw6ZTZ/k8a9WspY/HWnqqD?=
 =?us-ascii?Q?URnImm0gyABl7oEV8d7OL+4p1ALsPWDYe+PO0TDZO3Ab6w2Pweion/m5/SSx?=
 =?us-ascii?Q?3jroP8IGDRYXiJElLkzS2NLuM/IIWakNR8gdIwhDwDqzpCLKwgCESlJX/jev?=
 =?us-ascii?Q?/UBPv5bGZWK0+cF3tMtK47x5hsVG9pR8IjT9lKnw02398+vuPEIAQXJZ1gi4?=
 =?us-ascii?Q?o51wHRt6xzBJFd54+QvdsoTflrj2qdSkGo84x4mNpfTiBK4lxsvvWOOyY6Gp?=
 =?us-ascii?Q?xks4BnzJfjXjvX5Iye8vSxOoOsd/JSj+zhW+iB/oo0gLwLsdKG3vJSOBytC2?=
 =?us-ascii?Q?tBsxTai+qcUJbNSZkA8WlODCK/GKac6p8aEM9ZdBMynxAPekAhM1caq1OVYj?=
 =?us-ascii?Q?cp9nL0Y0QJDobqI07gXpIkkJQHI8RjTahysNVUnOxhFoSiZxQwY3wTQvCufn?=
 =?us-ascii?Q?xT5HJlyvFM/LUZhcDk/063W1P6AfZ7VEvVsTVckxLxf2/ItAXwxXPR6yWl6j?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?x/SQimnBaUmAq+lxkOFNedBzRFlc5RhhCGCKR7mcPpFlXMn08rUzb2p+ieeZ?=
 =?us-ascii?Q?UhSV4pE+y2QjDNdzL0S6BbZ/qLSbToNImzKIV+pF8BrzZdeeQor12MtYiyVx?=
 =?us-ascii?Q?LmUkjxpOr18huoLeZKZvFD6h/VHZxyE0f9kkLqDoew3o/X7g97T7m+cGsYAU?=
 =?us-ascii?Q?C4ezBhYbdWGz/BUAHK2lFYWVqfJYdRbZQUbKxxFOXyT4Rt9Zs9O4wSnlwCuH?=
 =?us-ascii?Q?q1f6EXWNO7yvc7YRFVHH6QO/Y+3BKgPdSg15gHScCLZ9FP2FYcpVwmbP0YCn?=
 =?us-ascii?Q?YJk7FKWFlbotOy8mQ3O5rNDdrUsLzY0dxwn15reb986cRrLeHzwM9qLYoTlj?=
 =?us-ascii?Q?yKhLmHuWuO2BAAOsqQtA74kE9reFuG2qOscKDAsWt+5UgRndfYH9RaM3pxa7?=
 =?us-ascii?Q?IVFcDjhTK1gR3R3W700HJak9COax/Jzsa5+5emZI/kWms+g+41AXmEWfeCmw?=
 =?us-ascii?Q?lP/5OY52rolsnIWSnjdfbTjEkpTyCGA8PicrQl5FKjRuQBxnYW7icpB0gyuL?=
 =?us-ascii?Q?vE4Ffv69k9Hy0pg+zCHkii3gPZmcwwR5fUu3ExoPsxY5guYgLkVQkJ2J4JdU?=
 =?us-ascii?Q?7M+ZN/WogfFbfDaCy+xplB2RPoZ2k5XxZRG7PvQ1fUzUwJXnUGIpNSh58Inh?=
 =?us-ascii?Q?5wFe6NbEq7TEpBq7QCA4e5K4KC1xHM5xuJISibFKlejunn3JRVyNZIlZJwST?=
 =?us-ascii?Q?lkG5K6c1TXYShQbbFnpKCVigrfJnuvWcszKFR6M1FsrSQdcjDxpDj3PO/D/k?=
 =?us-ascii?Q?OtbqbD2nCTWIVJ+CNPF569y9jZljt7lOvL9T0RiKc/OTU6PYhZbAG3zhbXD+?=
 =?us-ascii?Q?FDYATS+tUI0z6tYqb/0ko5ANUJ3Pn00pkJoVLZXkH89bgbKves6DbCQwIjGV?=
 =?us-ascii?Q?Zug2yfEclp/2rfC2Q+GSY26y2vOOgxj+H4CjPEgPXNte4WmjcP2AhIoyY/BE?=
 =?us-ascii?Q?p3GvSymU1FEmxKFkqZZx+UlPWJYy69RvS9BQl5Lipt/LSzcCjAHPdqPExvGT?=
 =?us-ascii?Q?7++V8vqlYv1d3xwR4iMwFYcEd6mD/FysOWrWDPyiQPkybzvHoNIjfUFEmHvl?=
 =?us-ascii?Q?poC/qFK7IHx/Kq5pQ7od7PuYOLH8eLOjusf+96Edq7vey9WYFyiQQ+4w294A?=
 =?us-ascii?Q?rynW+Qhz26Q6ALN2oBRkpgZNxpedBgNcqH8rTy57wleZiQwBK5SGVIObRVqf?=
 =?us-ascii?Q?LWaNeLf3me8GtDOaYruRYJU3PSqtOyAj1kxcPhFbpSt2d8kv1ATy00rDJtL4?=
 =?us-ascii?Q?UuMUvpWrEs1PpsSWOLhpToPReHAIKyPZBCYKrFquowrGYTUoUtWKhXHVluLx?=
 =?us-ascii?Q?sdw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a860d2c-6f3f-41e3-aac9-08db4caefca3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:51:05.0903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rboCq2PQfO4hgr30eLDKdqwa5nkbjABliYtacSEI1iCSD0ZstlpwEH0oiXgS7NEJ7bkB3d5AToPELfwCLeQItTabeOzUp1bCA/k3Togw224=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7505
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040122
X-Proofpoint-GUID: BajF9862jfVZwQHYY1x-dXmo0ZHBbZzU
X-Proofpoint-ORIG-GUID: BajF9862jfVZwQHYY1x-dXmo0ZHBbZzU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The routine slaunch_setup is called out of the x86 specific setup_arch
routine during early kernel boot. After determining what platform is
present, various operations specific to that platform occur. This
includes finalizing setting for the platform late launch and verifying
that memory protections are in place.

For TXT, this code also reserves the original compressed kernel setup
area where the APs were left looping so that this memory cannot be used.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/Makefile   |   1 +
 arch/x86/kernel/setup.c    |   3 +
 arch/x86/kernel/slaunch.c  | 497 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/dmar.c |   4 +
 4 files changed, 505 insertions(+)
 create mode 100644 arch/x86/kernel/slaunch.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index dd61752..3d2a33e 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_X86_32)		+= tls.o
 obj-$(CONFIG_IA32_EMULATION)	+= tls.o
 obj-y				+= step.o
 obj-$(CONFIG_INTEL_TXT)		+= tboot.o
+obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
 obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
 obj-y				+= stacktrace.o
 obj-y				+= cpu/
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 16babff..592c09e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -21,6 +21,7 @@
 #include <linux/root_dev.h>
 #include <linux/hugetlb.h>
 #include <linux/tboot.h>
+#include <linux/slaunch.h>
 #include <linux/usb/xhci-dbgp.h>
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
@@ -1063,6 +1064,8 @@ void __init setup_arch(char **cmdline_p)
 	early_gart_iommu_check();
 #endif
 
+	slaunch_setup_txt();
+
 	/*
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
new file mode 100644
index 0000000..7dba088
--- /dev/null
+++ b/arch/x86/kernel/slaunch.c
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Secure Launch late validation/setup and finalization support.
+ *
+ * Copyright (c) 2022, Oracle and/or its affiliates.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/linkage.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+#include <linux/security.h>
+#include <linux/memblock.h>
+#include <asm/segment.h>
+#include <asm/sections.h>
+#include <asm/tlbflush.h>
+#include <asm/e820/api.h>
+#include <asm/setup.h>
+#include <linux/slr_table.h>
+#include <linux/slaunch.h>
+
+static u32 sl_flags;
+static struct sl_ap_wake_info ap_wake_info;
+static u64 evtlog_addr;
+static u32 evtlog_size;
+static u64 vtd_pmr_lo_size;
+
+/* This should be plenty of room */
+static u8 txt_dmar[PAGE_SIZE] __aligned(16);
+
+u32 slaunch_get_flags(void)
+{
+	return sl_flags;
+}
+EXPORT_SYMBOL(slaunch_get_flags);
+
+struct sl_ap_wake_info *slaunch_get_ap_wake_info(void)
+{
+	return &ap_wake_info;
+}
+
+struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar)
+{
+	/* The DMAR is only stashed and provided via TXT on Intel systems */
+	if (memcmp(txt_dmar, "DMAR", 4))
+		return dmar;
+
+	return (struct acpi_table_header *)(&txt_dmar[0]);
+}
+
+void __noreturn slaunch_txt_reset(void __iomem *txt,
+				  const char *msg, u64 error)
+{
+	u64 one = 1, val;
+
+	pr_err("%s", msg);
+
+	/*
+	 * This performs a TXT reset with a sticky error code. The reads of
+	 * TXT_CR_E2STS act as barriers.
+	 */
+	memcpy_toio(txt + TXT_CR_ERRORCODE, &error, sizeof(error));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+	memcpy_toio(txt + TXT_CR_CMD_NO_SECRETS, &one, sizeof(one));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+	memcpy_toio(txt + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(one));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+	memcpy_toio(txt + TXT_CR_CMD_RESET, &one, sizeof(one));
+
+	for ( ; ; )
+		asm volatile ("hlt");
+
+	unreachable();
+}
+
+/*
+ * The TXT heap is too big to map all at once with early_ioremap
+ * so it is done a table at a time.
+ */
+static void __init *txt_early_get_heap_table(void __iomem *txt, u32 type,
+					     u32 bytes)
+{
+	u64 base, size, offset = 0;
+	void *heap;
+	int i;
+
+	if (type > TXT_SINIT_TABLE_MAX)
+		slaunch_txt_reset(txt,
+			"Error invalid table type for early heap walk\n",
+			SL_ERROR_HEAP_WALK);
+
+	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
+	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
+
+	/* Iterate over heap tables looking for table of "type" */
+	for (i = 0; i < type; i++) {
+		base += offset;
+		heap = early_memremap(base, sizeof(u64));
+		if (!heap)
+			slaunch_txt_reset(txt,
+				"Error early_memremap of heap for heap walk\n",
+				SL_ERROR_HEAP_MAP);
+
+		offset = *((u64 *)heap);
+
+		/*
+		 * After the first iteration, any offset of zero is invalid and
+		 * implies the TXT heap is corrupted.
+		 */
+		if (!offset)
+			slaunch_txt_reset(txt,
+				"Error invalid 0 offset in heap walk\n",
+				SL_ERROR_HEAP_ZERO_OFFSET);
+
+		early_memunmap(heap, sizeof(u64));
+	}
+
+	/* Skip the size field at the head of each table */
+	base += sizeof(u64);
+	heap = early_memremap(base, bytes);
+	if (!heap)
+		slaunch_txt_reset(txt,
+				  "Error early_memremap of heap section\n",
+				  SL_ERROR_HEAP_MAP);
+
+	return heap;
+}
+
+static void __init txt_early_put_heap_table(void *addr, unsigned long size)
+{
+	early_memunmap(addr, size);
+}
+
+/*
+ * TXT uses a special set of VTd registers to protect all of memory from DMA
+ * until the IOMMU can be programmed to protect memory. There is the low
+ * memory PMR that can protect all memory up to 4G. The high memory PRM can
+ * be setup to protect all memory beyond 4Gb. Validate that these values cover
+ * what is expected.
+ */
+static void __init slaunch_verify_pmrs(void __iomem *txt)
+{
+	struct txt_os_sinit_data *os_sinit_data;
+	u32 field_offset, err = 0;
+	const char *errmsg = "";
+	unsigned long last_pfn;
+
+	field_offset = offsetof(struct txt_os_sinit_data, lcp_po_base);
+	os_sinit_data = txt_early_get_heap_table(txt, TXT_OS_SINIT_DATA_TABLE,
+						 field_offset);
+
+	/* Save a copy */
+	vtd_pmr_lo_size = os_sinit_data->vtd_pmr_lo_size;
+
+	last_pfn = e820__end_of_ram_pfn();
+
+	/*
+	 * First make sure the hi PMR covers all memory above 4G. In the
+	 * unlikely case where there is < 4G on the system, the hi PMR will
+	 * not be set.
+	 */
+	if (os_sinit_data->vtd_pmr_hi_base != 0x0ULL) {
+		if (os_sinit_data->vtd_pmr_hi_base != 0x100000000ULL) {
+			err = SL_ERROR_HI_PMR_BASE;
+			errmsg =  "Error hi PMR base\n";
+			goto out;
+		}
+
+		if (PFN_PHYS(last_pfn) > os_sinit_data->vtd_pmr_hi_base +
+		    os_sinit_data->vtd_pmr_hi_size) {
+			err = SL_ERROR_HI_PMR_SIZE;
+			errmsg = "Error hi PMR size\n";
+			goto out;
+		}
+	}
+
+	/*
+	 * Lo PMR base should always be 0. This was already checked in
+	 * early stub.
+	 */
+
+	/*
+	 * Check that if the kernel was loaded below 4G, that it is protected
+	 * by the lo PMR. Note this is the decompressed kernel. The ACM would
+	 * have ensured the compressed kernel (the MLE image) was protected.
+	 */
+	if ((__pa_symbol(_end) < 0x100000000ULL) &&
+	    (__pa_symbol(_end) > os_sinit_data->vtd_pmr_lo_size)) {
+		err = SL_ERROR_LO_PMR_MLE;
+		errmsg = "Error lo PMR does not cover MLE kernel\n";
+	}
+
+	/*
+	 * Other regions of interest like boot param, AP wake block, cmdline
+	 * already checked for PMR coverage in the early stub code.
+	 */
+
+out:
+	txt_early_put_heap_table(os_sinit_data, field_offset);
+
+	if (err)
+		slaunch_txt_reset(txt, errmsg, err);
+}
+
+static void __init slaunch_txt_reserve_range(u64 base, u64 size)
+{
+	int type;
+
+	type = e820__get_entry_type(base, base + size - 1);
+	if (type == E820_TYPE_RAM) {
+		pr_info("memblock reserve base: %llx size: %llx\n", base, size);
+		memblock_reserve(base, size);
+	}
+}
+
+/*
+ * For Intel, certain regions of memory must be marked as reserved by putting
+ * them on the memblock reserved list if they are not already e820 reserved.
+ * This includes:
+ *  - The TXT HEAP
+ *  - The ACM area
+ *  - The TXT private register bank
+ *  - The MDR list sent to the MLE by the ACM (see TXT specification)
+ *  (Normally the above are properly reserved by firmware but if it was not
+ *  done, reserve them now)
+ *  - The AP wake block
+ *  - TPM log external to the TXT heap
+ *
+ * Also if the low PMR doesn't cover all memory < 4G, any RAM regions above
+ * the low PMR must be reservered too.
+ */
+static void __init slaunch_txt_reserve(void __iomem *txt)
+{
+	struct txt_sinit_memory_descriptor_record *mdr;
+	struct txt_sinit_mle_data *sinit_mle_data;
+	u64 base, size, heap_base, heap_size;
+	u32 mdrnum, mdroffset, mdrslen;
+	u32 field_offset, i;
+	void *mdrs;
+
+	base = TXT_PRIV_CONFIG_REGS_BASE;
+	size = TXT_PUB_CONFIG_REGS_BASE - TXT_PRIV_CONFIG_REGS_BASE;
+	slaunch_txt_reserve_range(base, size);
+
+	memcpy_fromio(&heap_base, txt + TXT_CR_HEAP_BASE, sizeof(heap_base));
+	memcpy_fromio(&heap_size, txt + TXT_CR_HEAP_SIZE, sizeof(heap_size));
+	slaunch_txt_reserve_range(heap_base, heap_size);
+
+	memcpy_fromio(&base, txt + TXT_CR_SINIT_BASE, sizeof(base));
+	memcpy_fromio(&size, txt + TXT_CR_SINIT_SIZE, sizeof(size));
+	slaunch_txt_reserve_range(base, size);
+
+	field_offset = offsetof(struct txt_sinit_mle_data,
+				sinit_vtd_dmar_table_size);
+	sinit_mle_data = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+						  field_offset);
+
+	mdrnum = sinit_mle_data->num_of_sinit_mdrs;
+	mdroffset = sinit_mle_data->sinit_mdrs_table_offset;
+
+	txt_early_put_heap_table(sinit_mle_data, field_offset);
+
+	if (!mdrnum)
+		goto nomdr;
+
+	mdrslen = mdrnum * sizeof(struct txt_sinit_memory_descriptor_record);
+
+	mdrs = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+					mdroffset + mdrslen - 8);
+
+	mdr = mdrs + mdroffset - 8;
+
+	for (i = 0; i < mdrnum; i++, mdr++) {
+		/* Spec says some entries can have length 0, ignore them */
+		if (mdr->type > 0 && mdr->length > 0)
+			slaunch_txt_reserve_range(mdr->address, mdr->length);
+	}
+
+	txt_early_put_heap_table(mdrs, mdroffset + mdrslen - 8);
+
+nomdr:
+	slaunch_txt_reserve_range(ap_wake_info.ap_wake_block,
+				  ap_wake_info.ap_wake_block_size);
+
+	/*
+	 * Earlier checks ensured that the event log was properly situated
+	 * either inside the TXT heap or outside. This is a check to see if the
+	 * event log needs to be reserved. If it is in the TXT heap, it is
+	 * already reserved.
+	 */
+	if (evtlog_addr < heap_base || evtlog_addr > (heap_base + heap_size))
+		slaunch_txt_reserve_range(evtlog_addr, evtlog_size);
+
+	for (i = 0; i < e820_table->nr_entries; i++) {
+		base = e820_table->entries[i].addr;
+		size = e820_table->entries[i].size;
+		if ((base >= vtd_pmr_lo_size) && (base < 0x100000000ULL))
+			slaunch_txt_reserve_range(base, size);
+		else if ((base < vtd_pmr_lo_size) &&
+			 (base + size > vtd_pmr_lo_size))
+			slaunch_txt_reserve_range(vtd_pmr_lo_size,
+						  base + size - vtd_pmr_lo_size);
+	}
+}
+
+/*
+ * TXT stashes a safe copy of the DMAR ACPI table to prevent tampering.
+ * It is stored in the TXT heap. Fetch it from there and make it available
+ * to the IOMMU driver.
+ */
+static void __init slaunch_copy_dmar_table(void __iomem *txt)
+{
+	struct txt_sinit_mle_data *sinit_mle_data;
+	u32 field_offset, dmar_size, dmar_offset;
+	void *dmar;
+
+	memset(&txt_dmar, 0, PAGE_SIZE);
+
+	field_offset = offsetof(struct txt_sinit_mle_data,
+				processor_scrtm_status);
+	sinit_mle_data = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+						  field_offset);
+
+	dmar_size = sinit_mle_data->sinit_vtd_dmar_table_size;
+	dmar_offset = sinit_mle_data->sinit_vtd_dmar_table_offset;
+
+	txt_early_put_heap_table(sinit_mle_data, field_offset);
+
+	if (!dmar_size || !dmar_offset)
+		slaunch_txt_reset(txt,
+				  "Error invalid DMAR table values\n",
+				  SL_ERROR_HEAP_INVALID_DMAR);
+
+	if (unlikely(dmar_size > PAGE_SIZE))
+		slaunch_txt_reset(txt,
+				  "Error DMAR too big to store\n",
+				  SL_ERROR_HEAP_DMAR_SIZE);
+
+
+	dmar = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
+					dmar_offset + dmar_size - 8);
+	if (!dmar)
+		slaunch_txt_reset(txt,
+				  "Error early_ioremap of DMAR\n",
+				  SL_ERROR_HEAP_DMAR_MAP);
+
+	memcpy(&txt_dmar[0], dmar + dmar_offset - 8, dmar_size);
+
+	txt_early_put_heap_table(dmar, dmar_offset + dmar_size - 8);
+}
+
+/*
+ * The location of the safe AP wake code block is stored in the TXT heap.
+ * Fetch needed values here in the early init code for later use in SMP
+ * startup.
+ *
+ * Also get the TPM event log values are in the SLRT and have to be fetched.
+ * They will be put on the memblock reserve list later.
+ */
+static void __init slaunch_fetch_values(void __iomem *txt)
+{
+	struct txt_os_mle_data *os_mle_data;
+	struct slr_entry_log_info *log_info;
+	struct slr_table *slrt;
+	u8 *jmp_offset;
+	u32 size;
+
+	os_mle_data = txt_early_get_heap_table(txt, TXT_OS_MLE_DATA_TABLE,
+					       sizeof(*os_mle_data));
+
+	ap_wake_info.ap_wake_block = os_mle_data->ap_wake_block;
+	ap_wake_info.ap_wake_block_size = os_mle_data->ap_wake_block_size;
+
+	jmp_offset = os_mle_data->mle_scratch + SL_SCRATCH_AP_JMP_OFFSET;
+	ap_wake_info.ap_jmp_offset = *((u32 *)jmp_offset);
+
+	slrt = (struct slr_table *)early_memremap(os_mle_data->slrt, sizeof(*slrt));
+	if (!slrt)
+		slaunch_txt_reset(txt,
+			"Error early_memremap of SLRT failed\n",
+			SL_ERROR_SLRT_MAP);
+
+	size = slrt->size;
+	early_memunmap(slrt, sizeof(*slrt));
+
+	slrt = (struct slr_table *)early_memremap(os_mle_data->slrt, size);
+	if (!slrt)
+		slaunch_txt_reset(txt,
+			"Error early_memremap of SLRT failed\n",
+			SL_ERROR_SLRT_MAP);
+
+	log_info = (struct slr_entry_log_info *)
+		slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
+
+	if (!log_info)
+		slaunch_txt_reset(txt,
+				  "SLRT missing logging info entry\n",
+				  SL_ERROR_SLRT_MISSING_ENTRY);
+
+	evtlog_addr = log_info->addr;
+	evtlog_size = log_info->size;
+
+	early_memunmap(slrt, size);
+
+	txt_early_put_heap_table(os_mle_data, sizeof(*os_mle_data));
+}
+
+/*
+ * Intel TXT specific late stub setup and validation.
+ */
+void __init slaunch_setup_txt(void)
+{
+	u64 one = TXT_REGVALUE_ONE, val;
+	void __iomem *txt;
+
+	if (!boot_cpu_has(X86_FEATURE_SMX))
+		return;
+
+	/*
+	 * If booted through secure launch entry point, the loadflags
+	 * option will be set.
+	 */
+	if (!(boot_params.hdr.loadflags & SLAUNCH_FLAG))
+		return;
+
+	/*
+	 * See if SENTER was done by reading the status register in the
+	 * public space. If the public register space cannot be read, TXT may
+	 * be disabled.
+	 */
+	txt = early_ioremap(TXT_PUB_CONFIG_REGS_BASE,
+			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+	if (!txt)
+		return;
+
+	memcpy_fromio(&val, txt + TXT_CR_STS, sizeof(val));
+	early_iounmap(txt, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+
+	/* SENTER should have been done */
+	if (!(val & TXT_SENTER_DONE_STS))
+		panic("Error TXT.STS SENTER_DONE not set\n");
+
+	/* SEXIT should have been cleared */
+	if (val & TXT_SEXIT_DONE_STS)
+		panic("Error TXT.STS SEXIT_DONE set\n");
+
+	/* Now we want to use the private register space */
+	txt = early_ioremap(TXT_PRIV_CONFIG_REGS_BASE,
+			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+	if (!txt) {
+		/* This is really bad, no where to go from here */
+		panic("Error early_ioremap of TXT priv registers\n");
+	}
+
+	/*
+	 * Try to read the Intel VID from the TXT private registers to see if
+	 * TXT measured launch happened properly and the private space is
+	 * available.
+	 */
+	memcpy_fromio(&val, txt + TXT_CR_DIDVID, sizeof(val));
+	if ((val & 0xffff) != 0x8086) {
+		/*
+		 * Can't do a proper TXT reset since it appears something is
+		 * wrong even though SENTER happened and it should be in SMX
+		 * mode.
+		 */
+		panic("Invalid TXT vendor ID, not in SMX mode\n");
+	}
+
+	/* Set flags so subsequent code knows the status of the launch */
+	sl_flags |= (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT);
+
+	/*
+	 * Reading the proper DIDVID from the private register space means we
+	 * are in SMX mode and private registers are open for read/write.
+	 */
+
+	/* On Intel, have to handle TPM localities via TXT */
+	memcpy_toio(txt + TXT_CR_CMD_SECRETS, &one, sizeof(one));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+	memcpy_toio(txt + TXT_CR_CMD_OPEN_LOCALITY1, &one, sizeof(one));
+	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
+
+	slaunch_fetch_values(txt);
+
+	slaunch_verify_pmrs(txt);
+
+	slaunch_txt_reserve(txt);
+
+	slaunch_copy_dmar_table(txt);
+
+	early_iounmap(txt, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
+
+	pr_info("Intel TXT setup complete\n");
+}
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index a3414af..5d1ac8d 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -28,6 +28,7 @@
 #include <linux/iommu.h>
 #include <linux/numa.h>
 #include <linux/limits.h>
+#include <linux/slaunch.h>
 #include <asm/irq_remapping.h>
 
 #include "iommu.h"
@@ -660,6 +661,9 @@ static inline int dmar_walk_dmar_table(struct acpi_table_dmar *dmar,
 	 */
 	dmar_tbl = tboot_get_dmar_table(dmar_tbl);
 
+	/* If Secure Launch is active, it has similar logic */
+	dmar_tbl = slaunch_get_dmar_table(dmar_tbl);
+
 	dmar = (struct acpi_table_dmar *)dmar_tbl;
 	if (!dmar)
 		return -ENODEV;
-- 
1.8.3.1

