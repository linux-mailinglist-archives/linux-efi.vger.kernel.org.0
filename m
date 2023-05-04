Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704806F6E36
	for <lists+linux-efi@lfdr.de>; Thu,  4 May 2023 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjEDOxN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 May 2023 10:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjEDOwd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 May 2023 10:52:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06F259F8;
        Thu,  4 May 2023 07:51:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DWdK1012298;
        Thu, 4 May 2023 14:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=kd4VyTkdmdAPDJ+d8KRWv5cXNJL7wwga8gvLalvkmqc=;
 b=CoNfOHVjkAcchUPo1FaCDdZpWV2QqDAboUNgMYZQhnJfmnmr/cfGqqKoXa/OKJL+9Xf+
 wRlBN/BJqMBCA7jP6muvFrEe24qRPfO72LmamGxilX3qv7sJE2WxBr8VjfbuJAP63WXn
 JwL3H9GrN9LG6mHB3FQj77vUnHX/62UsQKIAYBt7YK2URuBPSNvEb/kXjyFHGk0cPEII
 NKmeOqpYwL4FdCq5jWmZhoIqYfLRBB66R78gqB55HdKrPzNnf/14SXqOtb+sUoqY2FJB
 2nKTqppajfGbG2MLGkfMFKXzvMvM1Ey4YR37ThnOabffABLzydKr4tUa2RbqxeExmdsp AQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8usv1yf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344EcjSa024871;
        Thu, 4 May 2023 14:51:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp8tr7x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 May 2023 14:51:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klp9ejf1cA5sQDA/Lwspg4DnEH41HpN6QFPh0nmsJYT08j70QzXc/o4AR6qBWQDFcRtIC5X7YC7N/ALsijsXLe2vwcBmsKfVMGTbJmmfRjm1LrpffPHGx8ek59y0jaEUXWns/4XjV0u584X9lzS4HmUCs9jOZKNzaWrWnjWDXcyUdG8KTBt1UGe/U3H5jaWpWhn2spPiGy+t25LTWiTbHECpB7KEecW1CU3HL8mQhJ0lJSJ1etq2cDEMjTA5Ly8ioF6E8nCb1K+KliRK71RIqYPJAK8vEH2fkR1tGqyFUI/X5FoOib+jWwMAEOkhcxiYYGUQakmLkanSV2ysyrViPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kd4VyTkdmdAPDJ+d8KRWv5cXNJL7wwga8gvLalvkmqc=;
 b=bjAf0mvalS3QRd7n4zs6+TJNP4PKjKTW4PWK6pZkS43rs0VpnLkgpvVTtraZnLUK0zZXkUK/49v0Lq1XbcilVNhlQFSEeShc3z9HL4vDWRAy9gPQocsaYIU8WBvuGwVD0eR5ECw/nRFHtwJo7978lBYC+HOKRVz5Ki8w1J6x5Ej2ri19eMO1QVczC5XukeYnpS9fRGP/qEPP+4b1HLUz6zvpjSZZs5fFzWHsVsqEfURfb6VflPp9rDR9rfRiYJU4cebaZM5rHY9gJ88Lsxpr0YIzUwbIhkup16jF6f/czk/61nm+IQL0I2Ef0l4CrvMj/Mm/OBCIyGqxrx+UyTjpZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kd4VyTkdmdAPDJ+d8KRWv5cXNJL7wwga8gvLalvkmqc=;
 b=ALLuV6iLrr0QYmih/Ji8gpFX1e1BM82jdWGwWweS8FLrhAmjrGhKxDZyJxseaSL98wP9JzrwFP1zmoJaFduY46KH/ISFsCaGkoaQ3uVuLEJ19Pmig3t1MpGkxSEOGyJ+/iLQGPm+CT54GeBk43Kcw8rfNLP2nzlv/4FcFdU9cbM=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:51:15 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 14:51:15 +0000
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
Subject: [PATCH v6 10/14] kexec: Secure Launch kexec SEXIT support
Date:   Thu,  4 May 2023 14:50:19 +0000
Message-Id: <20230504145023.835096-11-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0316.namprd03.prod.outlook.com
 (2603:10b6:8:2b::17) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 84644b11-833e-49b1-0c86-08db4caf0297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUh7J0ncYAJZM8q9VEStVVQehmU6BknMpeG52QJfjmY7u3J4wYrUU3tYu8gade4ueN/8WTXoNPjBiWHM0gO6tauZmNDjZwqwRHMiMaL2Q1yPGwXAokcpVoY62W8mrZdr9eST4h3CQ9dFPfRrwdMJ26vu6Z6zSjGsU1hnxmilfAYizZeO5sTuul6Oj+xYXXLX+9q4iCTidfGdovyfnqLVIta8TPc56Z65mcVQccSkgMuCLW3K9mTWqJKdniT0fYv+Hpl2vjvyS8Ivu4ocizhkz3LqeY3S9bIt2N5luC3rIuhFe5U0Cu67zOuQD9dTxBagdyIX++cgzUNhEVEhXtxF/UEA2I6Ya9EwGh2GOjjw/1EmExi9I3zUMBBg2Q/a/rDbXXXfdy4BnJTDBn+QOvOHjTeEyTGLKecilYMzLgQqeZxIJP3REWKm5Rgs7sm1OEoTCDYkVHQ62Iy5XJ4K7crwpBRmFpTf0sc06xjgBea7uBE5Y2JmZ6T8C9l9tZzp73MjFvkQ/nOe60jEabnhxqYGysLPDNJSQCryKz4AZ4RPVipWnrcD0JWl0Rme8yjLWxhL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(7416002)(2906002)(44832011)(8936002)(316002)(86362001)(4326008)(66556008)(66476007)(66946007)(8676002)(41300700001)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+r/480AoLanktEYaXl7/4LUvrX5YV99uuXDDj2gszBOC0nKG3ENULcOPNKVu?=
 =?us-ascii?Q?eIRPpWWVZqZbhTnj7VX4MVEepEyWPfCCTEypdy1Kmj1Dh5QtUDvzJSHrhxkQ?=
 =?us-ascii?Q?CGzy1DKHO2RVna7imv0LW0paBCXA7jH/QxJIg87UM/xG/2uelcC8ADEq4Rn/?=
 =?us-ascii?Q?8WC5vZ0VEQZzXhQO9UxO3+ZW02IV887fAACE1uTQHD3OTqAIKgpPvpG3kNhr?=
 =?us-ascii?Q?+8bC8XL1U5RE/8AQdinmvR8L+rNhFfOHgJICLfCHu3iuWnTFnhDdu27otySo?=
 =?us-ascii?Q?PPxUjsX/EuuXDdeEoDvr+o45xHg39t+ox+B9yhJlmDU5WpndD8qC/lg5dAgD?=
 =?us-ascii?Q?IofXsUiAN1EC/6GSCCcWllYTbsVw+/N1eoJpWlNpnUa65cNXl9pW+XorhpGS?=
 =?us-ascii?Q?F6Ss6mseUAWjv0xv6VtfX/U09i4TLn9kMKthIfF+32wT6EZxdHkriPMbShcx?=
 =?us-ascii?Q?UFIvzN0TU5C6wwPs00J4i8mSu4Lu1kZ9GG1ln9TZscdOJBfA9nexGt0jmTKh?=
 =?us-ascii?Q?GNiNmlmN6HQFUUY0P/wZmO+2auP3xUrQ2mi+vMWDRHHciV0m7LVnImJzMBkC?=
 =?us-ascii?Q?JT58etRnJgR6vGuOMHPM1pWOVa3ggAac/J8mymAi9hkDVOEE4K+6TrW6zjxC?=
 =?us-ascii?Q?0NBikZQsKHV93CEELFrm7Ay4a1465mIcRwv9+efHUBf8JweytXqA20lylBiA?=
 =?us-ascii?Q?3ygS7i3Wum/HPuXlZpdkabgDuCkzoaaNmxi1p37f5KTBwjGgABGNTE6ZBQ6C?=
 =?us-ascii?Q?NfjV8WSf4+nbu5it7ylkoNhD8kYnwzXoAAYxO/WyRJPkuCPUdoLtYh/RPGqw?=
 =?us-ascii?Q?eF3EtjbhK3LOYtLWiwWBL+B2vP06OTZuVA2CNOqymEmA/dulZSTIyPO5/zMI?=
 =?us-ascii?Q?3d/sKv3qGBRBRQUoBzoBHePrNB7XlIFjsHZelbewgP/y1C+GC24Uj2txau5O?=
 =?us-ascii?Q?FNyGz15j2KtSOocWhqA2v6ADQDFIayoIH0RXeeSHCEZZD6T8xnIiCNp1jDQe?=
 =?us-ascii?Q?XYY3GryOT4RKVoB5M5WjiqaK2iRVZsxkbL6nlaxW59NWTxR0hRiaeFddtwOX?=
 =?us-ascii?Q?Z9AIZlxcJDxvx07VDSSmjMQLiDJJcBsO41494fuz9n2xvOdgo7bzLhqRNSoY?=
 =?us-ascii?Q?ulcXrtEM6Zg1+/ai6Tof1nU0bbmQZP3uGKyEJh4TfBq2xEjblvZntYBNiAUo?=
 =?us-ascii?Q?eGlhzLeL/RWNM4kIeApFCwzMDpr51R3fioe0IqmdRV9gTfAA70CkscaQvrYP?=
 =?us-ascii?Q?xkD1DSJ07II15NxxH5UrPRm+svyr1kRYptfdNErr58JytUGszIb877DA0Kaq?=
 =?us-ascii?Q?XEreDBt6qk4DhYWSyMyxJBsvKanfF1kyYZqZ516v/285AKvB+18xJaL9y+4z?=
 =?us-ascii?Q?gyYpiKP/NSnCJDcmmGtiw+7ZgNf0RDTB4SSt/yI70i3r3Oizag+Qq3aDvDHT?=
 =?us-ascii?Q?JuR4ocsAShG/mAhA9xMLdPdP6BIXmp5XXtbFq/IYsscQGqxVqUbS2jB+Xfzk?=
 =?us-ascii?Q?SWRwkUlTpFCYFrr9jK1qk+0ZPPsmzEg9YfXvALqVyfPU6VVgOnZB17PGcXG6?=
 =?us-ascii?Q?1q3wtAkoxczQAUJArP5MZRtaQ78tmMlPezqsJ5K+sKW/j+TebFpJXnVHyB3/?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?G0QfPTarvsFzlEntXZjpHLgTIiF4gKb+xGBx6EzLJCTpZdpwG/QXBLibwJ6h?=
 =?us-ascii?Q?rWBa/lqvkEUhYrnLfC83bw2bxoBs5A7VKeg7VNHWUaBMzmOtghAexu/9K9qR?=
 =?us-ascii?Q?L9e7fKrsqYzmIQ5UcQaRuxwIVEn/YsvphixSue2o7yDU2h2AMzmmRr3bax1a?=
 =?us-ascii?Q?A4C9EuAXjLq0DbDbGpyUR+fqiW6vU6+BH8aP7nLZTB9WGlAIMEXMwmWwh8rx?=
 =?us-ascii?Q?cITClg85101vrcV6oWyBR97kSmiI2+stgXeAUJZqOYXTCzD9rEfJps7I0L95?=
 =?us-ascii?Q?2f3+HvK+s/03BxtdXKrhWsWZHBkfopbwfYhtQR0FpAZE+ySgrNM6akQ5GDZB?=
 =?us-ascii?Q?YO9Axpn2ZfNsbA47U3vHpgzggx0HjbGY0owf6b3jhYKo0losbzYGEOV5n5DH?=
 =?us-ascii?Q?sWksgwtux54T58K59EZO3LuHLN4sg6F+4h/QQeCrjmFLBbBrUIIYXe7zGfxc?=
 =?us-ascii?Q?DWW0wy6nxYdAJOC/to2TqWvV+FG+B72YGMTN/gjPAXTcp/CWjE3Ep+oQV+mC?=
 =?us-ascii?Q?VLm4Ve2o8eXz7V0meIqRb5zzelY7PO3CvDIOPjP8kydlraXeromQJq1TZsWj?=
 =?us-ascii?Q?gJIZaXdWVMYbxC2/e/jWeCP8GR+pKybm9ApRpHvYkkblX7WRhTfzEojKzTLK?=
 =?us-ascii?Q?1HKaa4B0OpsLljYqw8VDZB0h/sUA1BbIbYEUqrqdD5WqMjDLqlPVXY73de1J?=
 =?us-ascii?Q?xrBPQfKZZMxK0rFI4B4OJuxDU40GcLxvG3DaGz1NgGpq55UMbuE1pJJJYT2K?=
 =?us-ascii?Q?9aN8IjAKnctb7eFNayoVK/RJqip2OznVVp0syaA2KhkGfVU1NqNReWI58vXG?=
 =?us-ascii?Q?Z0NMyTstkVOrsGP1GUmJvY+FpmDDNYm0za6SZjwju1VRUOxdUITLeGHoazuf?=
 =?us-ascii?Q?vl/8aaJoMJPBQsWY546wkeIYRGen4sMiTFcjm+K9u6JjpbTtPdXBxlxpFSOx?=
 =?us-ascii?Q?suBkYcr/p2rsxlsgJ8EPqhwz3v1yNtmKxiIZHBECOiKpfbocgvAuHTMInix7?=
 =?us-ascii?Q?3pSMLBOZWLpMJ8RSkzkTTmHkIK5ALdaIYK6FEb1vwRiKNB/OpOjmNo5jyYyb?=
 =?us-ascii?Q?6ylwgsJhON43dU9XJPpm0KkcE+T1RS8X0/6c4c4vQlvprlE+Aci6UlZnZNFp?=
 =?us-ascii?Q?ra7upIasfKOR4WhskwdRdhdiya9s4Hp9P2sWU+rGNLJ6FXItmNvkvF5zj68m?=
 =?us-ascii?Q?f74J97BjXXd1laujL7lbGg7HJS6PezpjGLHPFblcLZN4xjpNh5zSPLu2kWW6?=
 =?us-ascii?Q?ScqXI+9G0KnqGorWYeJsEjY4lV3i5A7Qtk54J2XaeVm3IzZhBe5v9fFl8XyG?=
 =?us-ascii?Q?M1Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84644b11-833e-49b1-0c86-08db4caf0297
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:51:15.0752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFF2PsBGiGYq4OwTjobG1AYI1HZ2K20326ukMIvhvt7nAWYGthajipquaUMl52w/X8neehffRoJYksk2YFyXSK8C10007zyIvd0P/hJtdjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040122
X-Proofpoint-ORIG-GUID: _zxZOBZNHVB1E3cyrWAPT_EwGgesoPsZ
X-Proofpoint-GUID: _zxZOBZNHVB1E3cyrWAPT_EwGgesoPsZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Prior to running the next kernel via kexec, the Secure Launch code
closes down private SMX resources and does an SEXIT. This allows the
next kernel to start normally without any issues starting the APs etc.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/slaunch.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c       |  4 +++
 2 files changed, 73 insertions(+)

diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index 7dba088..176c029 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -495,3 +495,72 @@ void __init slaunch_setup_txt(void)
 
 	pr_info("Intel TXT setup complete\n");
 }
+
+static inline void smx_getsec_sexit(void)
+{
+	asm volatile (".byte 0x0f,0x37\n"
+		      : : "a" (SMX_X86_GETSEC_SEXIT));
+}
+
+void slaunch_finalize(int do_sexit)
+{
+	u64 one = TXT_REGVALUE_ONE, val;
+	void __iomem *config;
+
+	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=
+	    (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT))
+		return;
+
+	config = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_emerg("Error SEXIT failed to ioremap TXT private reqs\n");
+		return;
+	}
+
+	/* Clear secrets bit for SEXIT */
+	memcpy_toio(config + TXT_CR_CMD_NO_SECRETS, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/* Unlock memory configurations */
+	memcpy_toio(config + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/* Close the TXT private register space */
+	memcpy_toio(config + TXT_CR_CMD_CLOSE_PRIVATE, &one, sizeof(one));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	/*
+	 * Calls to iounmap are not being done because of the state of the
+	 * system this late in the kexec process. Local IRQs are disabled and
+	 * iounmap causes a TLB flush which in turn causes a warning. Leaving
+	 * thse mappings is not an issue since the next kernel is going to
+	 * completely re-setup memory management.
+	 */
+
+	/* Map public registers and do a final read fence */
+	config = ioremap(TXT_PUB_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_emerg("Error SEXIT failed to ioremap TXT public reqs\n");
+		return;
+	}
+
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(val));
+
+	pr_emerg("TXT clear secrets bit and unlock memory complete.\n");
+
+	if (!do_sexit)
+		return;
+
+	if (smp_processor_id() != 0)
+		panic("Error TXT SEXIT must be called on CPU 0\n");
+
+	/* Disable SMX mode */
+	cr4_set_bits(X86_CR4_SMXE);
+
+	/* Do the SEXIT SMX operation */
+	smx_getsec_sexit();
+
+	pr_info("TXT SEXIT complete.\n");
+}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3d578c6..5d66d68 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -40,6 +40,7 @@
 #include <linux/hugetlb.h>
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
+#include <linux/slaunch.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1275,6 +1276,9 @@ int kernel_kexec(void)
 		cpu_hotplug_enable();
 		pr_notice("Starting new kernel\n");
 		machine_shutdown();
+
+		/* Finalize TXT registers and do SEXIT */
+		slaunch_finalize(1);
 	}
 
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
-- 
1.8.3.1

