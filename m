Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5EE6F6E06
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjEDOvS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjEDOvL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:51:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB6D7;
        Thu,  4 May 2023 07:51:09 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DTVNL023329;
        Thu, 4 May 2023 14:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=QBU9YNZubc8zqVNWB/PTENoA1AhZaoYQ7Vs7k4/xXEc=;
 b=hu17v+TFksF9w/TAfsnQept10B8RyD4jwChc76R6vLdi/a+m2cqRWCDjvo0Ebce/Pbor
 lu1mW1qFttr7PSn8h4LWJ2hCicLdk5nMXTA8xH3lY9VF7pLV6x8IP6P5OFRS8l9HBs2T
 e9dLiW3KYD0rMzeSJLqhUfLf7Ue1kadyo5qQvlSihP+tARIlu4l8ULr7aqgXYLosgkGD
 XvSOyUhXxA6utLSYhF7GGOipZrBcyWtbijSy5taM83+v6Wf7AizfM+5HGwWU7+D99IwX
 MjLOJcgTxR3nyBlYuEKlVr8bd/Um5EG2lbRi8Hc6XNiRux/1QzYUjF9cX9twBgFdw5U7 sQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4aswha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:50:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344ECLSI027573;
        Thu, 4 May 2023 14:50:29 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spevry0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:50:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoCIrlGKbWheSVX6QwU1PAwDybZz3e+17zfVKnR/myloptxexRykSvUZtJTBd/cBi85QcvgjJGu04SUqnoXfIFwrkvvCEw/85TemJfuhEemP7+jZqrTUDaxhMJmYwl5u1T9uFMpdx9IChHfFhqzYl4k0cvEpE7n8dd/kaA49JFdJKjbZz730fz21wUsx6Z4sqs+MgjlhApNY2UIugYb0Z+0XSqZkGbivn0Gk1BIvP1vrHSY43Kg+6UjXbCZYgR1nO5VTk+g3kinvGux0WSk4D8d2dcggPf5zyWrwub4ln5BDFvJX7RrjZevtf1y4naBJMbExTtgLma2yRzhWV3D7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBU9YNZubc8zqVNWB/PTENoA1AhZaoYQ7Vs7k4/xXEc=;
 b=UmT/YPj0DAPVsnOOxBqkJrQDJ1iql8Of5VxUg1Z49Ad006ze6yOw7V/JhuL4vpemr4fkfPW/5fluJXe8qNo9bBSN7oGfEbWxLtmD2E3EhorUIz9CTD0nvs/wuirx/6Ej9E3hONky1GcnO8ewE/heW1nEobEFHWE9y4XjCySrr3tsxzzuXwJJOsu1szkKpcoYlHXTfs2KHogXaAOWMBBtmmPmuxT01R4E8nXFKi5NE4PtsYVDXY+EojEnm65UUDjgI678C3KDCNnZdcQkSiw6u3Qwa1rm69igpX9AeXIavGx5oMw9XPJ8B2X4ZHSCzEw5Bfo5OXzx+Zg3+6KB4w+sZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBU9YNZubc8zqVNWB/PTENoA1AhZaoYQ7Vs7k4/xXEc=;
 b=puw7Ka1cu8Om/dk1/fpEUNzcyZ6z8fRYxPrwmJ/ZgEkilSiVCuASvvnjnbHmzuSkeJJ+2ablPZSCxT7tZefYLuzIwGwB8MShBPd1ocQgPcaX98i0Vnl0ZWsGe6oyjHY+56mtJILipoPwEAXs9uLOqHOPslcHFgn1z9ks2ymf4lc=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:50:26 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:50:26 +0000
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
Subject: [PATCH v6 00/14] x86: Trenchboot secure dynamic launch Linux kernel support
Date:   Thu,  4 May 2023 14:50:09 +0000
Message-Id: <20230504145023.835096-1-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::35) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|DM4PR10MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: c817b1f9-a272-4a80-de65-08db4caee575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OiARhmCkF+J20V8klbl5xiEs5FcHBfZlHBPFM7+YgTjFp7fC/+dzdpEVe7WbqCG+0wYFImPwWNxn9m95OeqgbkxBlBzIfXb4LvOB48ZQIeqHvUpCSqWED6txB+sVvSAHHtjl72iXSeZFncpF0ysFdf59ZVAbI7nqPliq2EE7BBhELhtbrwKgkSbWsajZtvW/crnTxnXYyBraj6rph6m74eXh7tQusuF95EqBU//7RNRioFEgQlSns9tNiHU9wO90pR61LoLPKt2xYrAJWxod+0TCPv8ac0Qv+IIOcP8NN5bLa+JvI94KHPSxN32z741UltQ4EduH6+vWNmNS4uybYWNj1EiDPVX6pdDoXTfOszac/6yKkhBYEi5aFUhH3+We7lpZ7KM1c9Jm3K0Dc6QCH8PQwCJyI72xMOnYgYyG3Ii3xBVIiu1ku/uBr2psfMA5zqsffgsVZoCERFOnAAU8JbhLKkEf8HZMg7UEFynkoDqvtJYdWn6KBSPl9+9UuML1rGkPkAESAuCeRddGGhX46DX77oxGNjCpWmm8W3heo0bZcwpluvILLNjRoYWJdmpDe4VxiVmfWPKOnxvZ4FNC0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(83380400001)(6486002)(2906002)(478600001)(316002)(5660300002)(8936002)(41300700001)(8676002)(44832011)(66946007)(66476007)(66556008)(4326008)(38100700002)(7416002)(86362001)(36756003)(6666004)(186003)(1076003)(26005)(6512007)(6506007)(966005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q3cnr7Bsldtxbj1ij2Sjqf41LDA08Q9Gyq64p4t3o+r4MY58xSB+Wca1OgtC?=
 =?us-ascii?Q?DIyVsAdxGv20k3PscXiry+QgPKVptuLgJtue5zT9O4Y9ejGhF+j/HwsKh/W5?=
 =?us-ascii?Q?6UB6YhtBkeriVuPzpl9fpPl19O75qGwJednQNRqXbiALNTBGnANjTfJZ8n/P?=
 =?us-ascii?Q?E15C7emYqVdGOY9zgzTgCEcVOkP8MxJv63wVIInhq7j4GfeJPxjDf5q4qB9D?=
 =?us-ascii?Q?7XmG4cwtgdi9C+7aFx9srPyzgiHQlveOzPx/1AJRJcWLr+fsjbdZlS4GD83O?=
 =?us-ascii?Q?goKq78vwe6L0evw/mK7kZmUTGwY75Ggzb8Vp8HW0oRzwBRe8yPpIUzrasPwM?=
 =?us-ascii?Q?aLKil3Bqks6w1Bp1LnXq9gVUtp8zXslUoI89p6hmRZst/onbFTWAKq6o3wnp?=
 =?us-ascii?Q?NIrZQb3K6bJ85OVGJxRi0gzVrJwfr/O1JynjaMffxj2AFVvmRMFW/jPE3bgh?=
 =?us-ascii?Q?I4G0z/XR3D0IDTV/fDAeXdraQSem0ioje4KbCEP1Aipsk16wkJjyHl18GQfA?=
 =?us-ascii?Q?e1yHx2rQxpI60a+77qVa/6ygs3cmnl7n8TJ0AlstNEoQT+BAK1zifp5wAPEV?=
 =?us-ascii?Q?CwylIcz2I5gkUU2zdsy3iqwd6HyA6tnlKNUFi3JlA+iWgAP2uApSM4Q3gkvG?=
 =?us-ascii?Q?xl60anyMPzGKYgCb19/pWLrX7jz796BCv4v6ZC0LfmPOiPR/PHGG9PRgRHsW?=
 =?us-ascii?Q?ZMMllcaoScFIEgC++OM/ecKDqVT6Wzxfk3NhEE6bWTrLQ/lB5oogWycBvw43?=
 =?us-ascii?Q?GeoYIYFUesIb1LTm2f1s9V/nCghWljl0vXZndlY6uh1f0Okvf0RfUTBfT4rz?=
 =?us-ascii?Q?XpGTiBA762t2ARoxU3lis23jtntyMmj86x7w0qPKsopRmS2KS1JkwRRL8VGP?=
 =?us-ascii?Q?9NIEa+Hmrbl8g5MV4b4WBGdjZhXTxia00PKp9ne7eD7CmDoiNB0HI9dadCgj?=
 =?us-ascii?Q?vrw2hoJBCAA7QOEUm82S878SEwbO2iOz49qI7cmAsbrmrAA/6UrSYM1FjD8U?=
 =?us-ascii?Q?FWGkT9EXjN8sKsAm//elOu7jP0xuSVcuIkx5jZRE5fIxI6yyt4sPZr0cuQFv?=
 =?us-ascii?Q?86dk/byZHprWMZbeziFIxE8JGeWJxaFhZ6NQ7qMQcwNxese+zpULh9EBac38?=
 =?us-ascii?Q?rlXDvyBC17ju3V5o9lGA4PowzPcBZ4brG5nbjJX6TLvXaQ/Ts4CXTeH4OxBm?=
 =?us-ascii?Q?E8IM0q+e/Nw2KVBSC2pZehkFgAHM/1PeJseFdHgNIgd/a56nhaadWsCE4hTt?=
 =?us-ascii?Q?y4loYV/u4tT0MGj2EMsLThBtmwkxJ3aziMBXv6c3heTzKndHxP5UuTnhR4xL?=
 =?us-ascii?Q?PwME85S1vABl2j6mS35Gt9ZKxr7RloIPBqeGLgHmN1TUSh887HOJ+5dHmafm?=
 =?us-ascii?Q?691N2m+x5Y4rGNJmpeo7p5s5TUm9mAmzj2j2CpSHI9pz2i09wHkZ2DIBfs46?=
 =?us-ascii?Q?hlK1LxEzub0mapiWa++QC3qSJHlZPqoGKfN6rHMfT+pFV63Bx1m3bYJOBRbc?=
 =?us-ascii?Q?uFo28mOytZhJKdZB5uERuYXBYadt7R2kXEImKhYVrL8knJCpTrnPQUnqEBqF?=
 =?us-ascii?Q?y7mx/xRb++ao+xRvtiQJuLnwq2rTN8lTyzkdwgNt50Z2l0BvrMfRlyz7k3nP?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?K6HYzu1CNM6b+p003/73BhXJ3ogYdjyM/YEm6WTnJvtuXCxMVCYxwMJl1m0P?=
 =?us-ascii?Q?C1xYg+4FUKRFdArHeX29AqAtJ296us5l6IlBuB4t28oYVbC+nU+cbXOkPOSW?=
 =?us-ascii?Q?xYK4+tCrijHwDVB31bLBUSuI8sFX4XIXQK7CpUj0lghRHEAlRNGLVjQhE4ld?=
 =?us-ascii?Q?4wVVM9tAuxtkzsI+utsZx/uEeYjtRt8CqePcx4S+SGaCzMaTfsYZ+0RxoR9F?=
 =?us-ascii?Q?VqY0qsgDbKu7ivcZfwSSTkzyHzmRolCRZFKB4isfi1fu+tgJt7Bln9+s4enT?=
 =?us-ascii?Q?i80ifKfoo0D4kJ6oin5qNiSrYN9NMzMn5XClIPpxEW4F3vzLTixsrTCzAjf/?=
 =?us-ascii?Q?ADke4sbDOjrlCfgk4cR+XqnoP6mDrUrNRsLNsPsjW8WLh5G1qPBncqIPj22K?=
 =?us-ascii?Q?3t4KaJxaHcnztE7Kbl9kWHdk3bV4z6OzCWrD8m30M+S8MQVF9jf1/aecn8wn?=
 =?us-ascii?Q?XKy2uI0iy4b9laB3SHU8pKC1ezFn81kHkn1e+hIzcs7ITf0a7NApu7kZHNIB?=
 =?us-ascii?Q?74Ty2Hvd+s7kDrlppHOgxQHGddadvzfqcHLf6r2mg145Intj7dDEQjibnh4l?=
 =?us-ascii?Q?vCgkYl0ZZcuKHB9UmudrY7XJR7TgBOrmXGw/fUNOhbs06TY/ybAFNQEx1S7M?=
 =?us-ascii?Q?FHU/at4TOIoILME2+B6SOjiR9afW0/EcGDTHr6nQ8jZVKAyUt8aUj8k9/Tf0?=
 =?us-ascii?Q?A6MFWbYy0MUIgQWEOrZtWblZPoHpYTzBlB/FHd0gL318CjSQaBEgMXCZaBlx?=
 =?us-ascii?Q?heE9GdLRifIREL88O0xUjzS9faYqVr9tZKLlSZenav072Ic2gVXXlQzw8e+T?=
 =?us-ascii?Q?p3A6rh7F5ENy51idm8j1Okm0MemxuNHlWCKYl0zcBrYDigGLlEe5ooNeXFTI?=
 =?us-ascii?Q?LT93/LglxGZSjzPLIpBi426dLyAwWphf25cvNHaG7p2lpQ/lTG+g4nq8pTAU?=
 =?us-ascii?Q?WgmsFUoEJ/l3T0JmuhaonNcJhj54OE7AaWKAWy4Wpk5HvMzfjizEz20hCFeg?=
 =?us-ascii?Q?EXNklVQOgDmvHtZ5TAt8sD5AtWf7i6RJ2Td2+bNiwwRWn5FKKZdiKpk7Facp?=
 =?us-ascii?Q?m8kKNL44e9McIBUnZBl41N4P2oXKKy+nCJM9lpKfqG1hM8gFeBPiT2+5pnar?=
 =?us-ascii?Q?Daz+ASRztjKUXux0Cmtj2UwcLGF6CHrDUkPx1EcrHTS+jfvQsI3OrZeHMN4r?=
 =?us-ascii?Q?f+HO4qXBdcexZtU0ypvlMBYiMMpTqaxoD0NiLji7ZdCd62Ck7LadvWR0C6jX?=
 =?us-ascii?Q?SvwXI/lepTz5Mg0JcxnBZNzp4veQHps6mA70WsSWfCBKc9YS54dJ4zq9KWWX?=
 =?us-ascii?Q?jKE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c817b1f9-a272-4a80-de65-08db4caee575
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:50:26.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHQxA+FcIt1F0RPe/1GDR45cSty1Mr3Rlf9UyJ9wQjj2Gg3CWUmjJywJx3B+7AdONaXcw+JUknqeZdh3QemtP3JQoBdTPQVSYsCoc8uHqbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7505
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040122
X-Proofpoint-GUID: YEDdriiYXV8eUfdAbuX75ZfJF5do7bf5
X-Proofpoint-ORIG-GUID: YEDdriiYXV8eUfdAbuX75ZfJF5do7bf5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The larger focus of the TrenchBoot project (https://github.com/TrenchBoot) is to
enhance the boot security and integrity in a unified manner. The first area of
focus has been on the Trusted Computing Group's Dynamic Launch for establishing
a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
Trust for Measurement). The project has been and continues to work on providing
a unified means to Dynamic Launch that is a cross-platform (Intel and AMD) and
cross-architecture (x86 and Arm), with our recent involvment in the upcoming
Arm DRTM specification. The order of introducing DRTM to the Linux kernel
follows the maturity of DRTM in the architectures. Intel's Trusted eXecution
Technology (TXT) is present today and only requires a preamble loader, e.g. a
boot loader, and an OS kernel that is TXT-aware. AMD DRTM implementation has
been present since the introduction of AMD-V but requires an additional
component that is AMD specific and referred to in the specification as the
Secure Loader, which the TrenchBoot project has an active prototype in
development. Finally Arm's implementation is in specification development stage
and the project is looking to support it when it becomes available.

This patchset provides detailed documentation of DRTM, the approach used for
adding the capbility, and relevant API/ABI documentation. In addition to the
documentation the patch set introduces Intel TXT support as the first platform
for Linux Secure Launch.

A quick note on terminology. The larger open source project itself is called
TrenchBoot, which is hosted on Github (links below). The kernel feature enabling
the use of Dynamic Launch technology is referred to as "Secure Launch" within
the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will be seen
in the code. The stub code discussed above is referred to as the SL stub.

The Secure Launch feature starts with patch #2. Patch #1 was authored by Arvind
Sankar. There is no further status on this patch at this point but
Secure Launch depends on it so it is included with the set.

Links:

The TrenchBoot project including documentation:

https://trenchboot.org

The TrenchBoot project on Github:

https://github.com/trenchboot

Intel TXT is documented in its own specification and in the SDM Instruction Set volume:

https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
https://software.intel.com/en-us/articles/intel-sdm

AMD SKINIT is documented in the System Programming manual:

https://www.amd.com/system/files/TechDocs/24593.pdf

GRUB2 pre-launch support branch (WIP):

https://github.com/TrenchBoot/grub/tree/grub-sl-fc-38-dlstub

Thanks
Ross Philipson and Daniel P. Smith

Changes in v2:

 - Modified 32b entry code to prevent causing relocations in the compressed
   kernel.
 - Dropped patches for compressed kernel TPM PCR extender.
 - Modified event log code to insert log delimiter events and not rely
   on TPM access.
 - Stop extending PCRs in the early Secure Launch stub code.
 - Removed Kconfig options for hash algorithms and use the algorithms the
   ACM used.
 - Match Secure Launch measurement algorithm use to those reported in the
   TPM 2.0 event log.
 - Read the TPM events out of the TPM and extend them into the PCRs using
   the mainline TPM driver. This is done in the late initcall module.
 - Allow use of alternate PCR 19 and 20 for post ACM measurements.
 - Add Kconfig constraints needed by Secure Launch (disable KASLR
   and add x2apic dependency).
 - Fix testing of SL_FLAGS when determining if Secure Launch is active
   and the architecture is TXT.
 - Use SYM_DATA_START_LOCAL macros in early entry point code.
 - Security audit changes:
   - Validate buffers passed to MLE do not overlap the MLE and are
     properly laid out.
   - Validate buffers and memory regions used by the MLE are
     protected by IOMMU PMRs.
 - Force IOMMU to not use passthrough mode during a Secure Launch.
 - Prevent KASLR use during a Secure Launch.

Changes in v3:

 - Introduce x86 documentation patch to provide background, overview
   and configuration/ABI information for the Secure Launch kernel
   feature.
 - Remove the IOMMU patch with special cases for disabling IOMMU
   passthrough. Configuring the IOMMU is now a documentation matter
   in the previously mentioned new patch.
 - Remove special case KASLR disabling code. Configuring KASLR is now
   a documentation matter in the previously mentioned new patch.
 - Fix incorrect panic on TXT public register read.
 - Properly handle and measure setup_indirect bootparams in the early
   launch code.
 - Use correct compressed kernel image base address when testing buffers
   in the early launch stub code. This bug was introduced by the changes
   to avoid relocation in the compressed kernel.
 - Use CPUID feature bits instead of CPUID vendor strings to determine
   if SMX mode is supported and the system is Intel.
 - Remove early NMI re-enable on the BSP. This can be safely done later
   on the BSP after an IDT is setup.

Changes in v4:
 - Expand the cover letter to provide more context to the order that DRTM
   support will be added.
 - Removed debug tracing in TPM request locality funciton and fixed
   local variable declarations.
 - Fixed missing break in default case in slmodule.c.
 - Reworded commit messages in patches 1 and 2 per suggestions.

Changes in v5:
 - Comprehensive documentation rewrite.
 - Use boot param loadflags to communicate Secure Launch status to
   kernel proper.
 - Fix incorrect check of X86_FEATURE_BIT_SMX bit.
 - Rename the alternate details and authorities PCR support.
 - Refactor the securityfs directory and file setup in slmodule.c.
 - Misc. cleanup from internal code reviews.
 - Use reverse fir tree format for variables.

Changes in v6:
 - Support for the new Secure Launch Resourse Table that standardizes
   the information passed and forms the ABI between the pre and post
   launch code.
 - Support for booting Linux through the EFI stub entry point and
   then being able to do a Secure Launch once EFI stub is done and EBS
   is called.
 - Updates to the documentation to reflect the previous two items listed.

Arvind Sankar (1):
  x86/boot: Place kernel_info at a fixed offset

Daniel P. Smith (2):
  x86: Add early SHA support for Secure Launch early measurements
  x86: Secure Launch late initcall platform module

Ross Philipson (11):
  Documentation/x86: Secure Launch kernel documentation
  x86: Secure Launch Kconfig
  x86: Secure Launch Resource Table header file
  x86: Secure Launch main header file
  x86: Secure Launch kernel early boot stub
  x86: Secure Launch kernel late boot stub
  x86: Secure Launch SMP bringup support
  kexec: Secure Launch kexec SEXIT support
  reboot: Secure Launch SEXIT support on reboot paths
  tpm: Allow locality 2 to be set when initializing the TPM for Secure
    Launch
  x86: EFI stub DRTM launch support for Secure Launch

 Documentation/arch/x86/boot.rst                    |  21 +
 Documentation/security/index.rst                   |   1 +
 Documentation/security/launch-integrity/index.rst  |  10 +
 .../security/launch-integrity/principles.rst       | 313 ++++++++++
 .../launch-integrity/secure_launch_details.rst     | 564 +++++++++++++++++
 .../launch-integrity/secure_launch_overview.rst    | 220 +++++++
 arch/x86/Kconfig                                   |  12 +
 arch/x86/boot/compressed/Makefile                  |   3 +
 arch/x86/boot/compressed/early_sha1.c              |  97 +++
 arch/x86/boot/compressed/early_sha1.h              |  17 +
 arch/x86/boot/compressed/early_sha256.c            |   7 +
 arch/x86/boot/compressed/head_64.S                 |  37 ++
 arch/x86/boot/compressed/kernel_info.S             |  53 +-
 arch/x86/boot/compressed/kernel_info.h             |  12 +
 arch/x86/boot/compressed/sl_main.c                 | 599 ++++++++++++++++++
 arch/x86/boot/compressed/sl_stub.S                 | 690 +++++++++++++++++++++
 arch/x86/boot/compressed/vmlinux.lds.S             |   6 +
 arch/x86/include/asm/realmode.h                    |   3 +
 arch/x86/include/uapi/asm/bootparam.h              |   1 +
 arch/x86/kernel/Makefile                           |   2 +
 arch/x86/kernel/asm-offsets.c                      |  20 +
 arch/x86/kernel/reboot.c                           |  10 +
 arch/x86/kernel/setup.c                            |   3 +
 arch/x86/kernel/slaunch.c                          | 566 +++++++++++++++++
 arch/x86/kernel/slmodule.c                         | 520 ++++++++++++++++
 arch/x86/kernel/smpboot.c                          |  86 +++
 arch/x86/realmode/rm/header.S                      |   3 +
 arch/x86/realmode/rm/trampoline_64.S               |  37 ++
 drivers/char/tpm/tpm-chip.c                        |   9 +-
 drivers/firmware/efi/libstub/x86-stub.c            |  55 ++
 drivers/iommu/intel/dmar.c                         |   4 +
 include/linux/slaunch.h                            | 513 +++++++++++++++
 include/linux/slr_table.h                          | 270 ++++++++
 kernel/kexec_core.c                                |   4 +
 lib/crypto/sha1.c                                  |   4 +
 lib/crypto/sha256.c                                |   8 +
 36 files changed, 4775 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/security/launch-integrity/index.rst
 create mode 100644 Documentation/security/launch-integrity/principles.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
 create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
 create mode 100644 arch/x86/boot/compressed/early_sha1.c
 create mode 100644 arch/x86/boot/compressed/early_sha1.h
 create mode 100644 arch/x86/boot/compressed/early_sha256.c
 create mode 100644 arch/x86/boot/compressed/kernel_info.h
 create mode 100644 arch/x86/boot/compressed/sl_main.c
 create mode 100644 arch/x86/boot/compressed/sl_stub.S
 create mode 100644 arch/x86/kernel/slaunch.c
 create mode 100644 arch/x86/kernel/slmodule.c
 create mode 100644 include/linux/slaunch.h
 create mode 100644 include/linux/slr_table.h

-- 
1.8.3.1

