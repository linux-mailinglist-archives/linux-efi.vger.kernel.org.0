Return-Path: <linux-efi+bounces-799-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6595878532
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 17:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B210281EA7
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197B15D908;
	Mon, 11 Mar 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SLiZ+SwV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mkRnDoCB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D953C5D729;
	Mon, 11 Mar 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173993; cv=fail; b=qs8y1viNkZ/2XUx+SzN89WM6c6XqmQ/Kn15xFVpPC/FvFtSngDOejVe7oTJKPNcgo/lWBSaVR0dqs5I9RZNQIBybd/5VZ+623knDtHonhVPodXafL53ua5r2+XErThLpE97cjW9dLB5xLXsIcyw80hrC7P7x18+U8bpB8zNyQiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173993; c=relaxed/simple;
	bh=yxnMWaSE5m/nl8S70GUCtImWexpWp7WL7svZEgHNGSk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=j/xe0+5N6XMXE/ut8bAfwC+1HTgvpkiYpPh8Au2rownNbf0ATdzcqRpIhf1TF5WBNB9ZD8W7BkZ9HjbO/i4yI47FZTsphneP2XG2gHfsIfKC124mR/jYTSq1aAvTtC3yUtf/ikk272Kr1LqpQUnFIu1LO0DvG+cMwSJAOS0pxMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SLiZ+SwV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mkRnDoCB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BG3qGi020986;
	Mon, 11 Mar 2024 16:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=LFtntaSnTfuCo9yFppeHceVxSonv8Alnena0GKd0yyI=;
 b=SLiZ+SwVOe6Sw1v36f87kbCezgY/+bmU3iF52FDsFjFOUPpb+P1OefvQ0cd7n8jp54ii
 6Y7fZKRF0j4peQIiNj1oVSSFfeyiWsfbRdx9XxBAxaOm90ex9w39iLLtLtRzBhIsL+yE
 tUHm86m0LNHivgeF3o+3BJ45H9fkfZ/Xrs11ddDf7EGevb0/PcdbjWmbW06iJ39hOhax
 /A4n1bdgKiwRsyQQHVeZeiJMcbAuX38R67p8CckPhZj7KWYcO54HYBC+kxuOWz/YtWcB
 oI8GwgH8/QObxgxf9qDfenBWyvSM6VQzn0d8gyk+HRwRGWNfpZSF3o0xvY8GyBGmf4FY gA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfcubsnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BGBkVc033806;
	Mon, 11 Mar 2024 16:19:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75qx2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xr+HyfVTDH0U9SFh2R4Pc5V5ed5VPmDawJhyrnJngfsCYD845cNcOxWl8EzoG8BFKSDY2u5m6R0Lgx6oN2jENZXrqliyerI3pjp4Acw5dA+8b4+Hz2wstXkxY0oDHoLDrXCcA7FT1fiYRAE7Ju0gMd/tSCcGTFV/NgmHv0K5X4QsPQ3dcXbK4vgywU6WLC4od0tNzKV5mdDonUxYC3ho4MM+C82Kk3LYZ0WUrOnsSbd92eeYw28D6W7LdSkto8Hu28Ynj3diQebAwJkPAAlWw9m7cSKjPWsucezxbtAUyh3JT+ycrUsDp3UxLsDHBu1OyNCNNUYiJuGzIjJQleu51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFtntaSnTfuCo9yFppeHceVxSonv8Alnena0GKd0yyI=;
 b=nynu3VQeydGG1V6WMP1QLbvq9cdpv3M0ZC0ybvvx30ruI9QLDdA5uTnXnopea/T/S2KY8AO90QuF0SUmK5+enfvrV9kCbb+h12HYyBS0r1M8NUBEDskkKe194RQvcCuuPRVQq41pczOrhUs/XJ3DVFccr0mWr0xFpS6Di7G1up3S4DFAZANisZDR9G829dnXOZPjm62Jduc2/ZTbb/1Tq6Xm6QAtELPbH9khRPC3+dX1wOqypwSwzmpfJmXQSGSu28LZqE9Mgpx8ORpM4PWNRU58jHk5Bm0rKIpZzvV6bIbfTXjl1Dq0APHvMb3yrPVshLQ1qSVkcCTLI4XhtXzIKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFtntaSnTfuCo9yFppeHceVxSonv8Alnena0GKd0yyI=;
 b=mkRnDoCB4pYy3+DoPB4C2MCv0p1w07HUtWvtVA+W1ryOS1KRyEV5YxsfNzz5agEYjK9cpX5sH4d2efzXCYVEJUyLUJHI4WukWxai1oxYmlguC/2ZS/4p/4QlX9+bCH/dHKyQj3dw+igAWfYLmkKHXXrHozRHlkC8+nZ3vn+2MrU=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5119.namprd10.prod.outlook.com (2603:10b6:5:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:19:02 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:19:02 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, mic@digikod.net, casey@schaufler-ca.com,
        stefanb@linux.ibm.com, eric.snowberg@oracle.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: [PATCH RFC 0/8] Clavis LSM
Date: Mon, 11 Mar 2024 12:11:03 -0400
Message-Id: <20240311161111.3268190-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0126.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 051fb2e3-c40e-48ff-8c71-08dc41e6f6c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	t7XTgH0mcl7lLtFeojdElSEDOHxmKMdEIjRyUXRl8HFRFDsxIjSapzVBsnDjCoAamw3mckic6dkyA1ZYKR2FOz4G5r+Oc1XnFJn6a/j5aoQSb9VhXRcf6Wnim1/8H4SPqRfyZpTM9YWnzFgFLhAphewuIzFCkl21ZlrqEFc/B8KbNIRig1dDWww3Uxcn+37SJpScme8qGdtEECSAnqVddzRh9VSLJIRl8SFACAObVt2m8w8Z2+kzOXK1ZJ2DAkYNqoMISV7YkpF4oCGXLteZOByedhXEIA7ZnNildWTgaen0Lx2x8vnAXQnjybiAhAPNTnAtEBcSR7lpkMPNbl8qdTq4YesMmRQPJTsRk0qo++iAMPPpfCRHNw0SYUEyr/z/QHbSmzwszq193bHpcgdH5yzd2oJnLQ+2pUN6/x5BxgfY3kjv8yOMbSr6J2mp7UThBd1QuKflW3bdvyHinf0I71Gct6Mh8YyKqAROWNj2v/oObaVag+SKk9s9MAalZoFeLLnmRQt+DdjUcKU6FTvXOqcBpZhqH4HllCcJehzfwI7hazX0bl2iVy9D0lmf/eiE5PXg+rjjDKwZ9jL4vvgBvw6zW41eKWxPDm2/VEHUBUb0EN+Sh9XOjTVaOQK6uqrxQl6Uuf8VAhPyeXBM+GfeLZtaFVgEpZ9spuQiFWqxODE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qCnAA8nL4RqCsu3Nq2cIs+oF/sGJqS5yS8RDO6Os3QofwKZ00tP7zqs1DG47?=
 =?us-ascii?Q?zjCUcMBXOrMdLle6oKJeGB7f6TgE66Lyw4sEI8pSHLw78msbuTtVY5NTnMNO?=
 =?us-ascii?Q?XvVcd7jLqSF0HWHa7EHg8d2pxOGs9J6OJ67z1d9LUBcHYqoD+cIEZRWTI7ZX?=
 =?us-ascii?Q?afhhwGiwF6vuvHByOxwZF/hv5mVdWtdZwvRwcOvjtEeteS6dF8qLD2tFy2qU?=
 =?us-ascii?Q?cnCwQpew0krgjC+aypcw3vEEQkgX4tbG76BmGN3ZIsKG42lhDKwsypxva9KV?=
 =?us-ascii?Q?PzP66b5fGxTQl39fdtLk0r7lO1F4hh2RaMi2YfVfgkNAE11073uofwFeu4/F?=
 =?us-ascii?Q?l9FUSumsvbs+IjX2KZ6RSQ5GhGsXkzozkd5M2/bPHM5Yz/YDad1K9j5Z5g4o?=
 =?us-ascii?Q?EddmtnhcagnX9NtTWHjA8/bKU5YHuEp2/t+x06o5bk31eRT/cr2V0alIVLoL?=
 =?us-ascii?Q?MlzM/uZQpA4ARdaK8h/Cikh/CI/fZAVAha9GI+NZ3GyTsON6cbGLYw2t1x7s?=
 =?us-ascii?Q?1YfMEzrGUWnh+zk+rv8SKg8f0iG0UiJHWFiIkrkwC4d5Cho4BBusO/R0uTRC?=
 =?us-ascii?Q?unRBjCCdw3BmnSctlAL4PzGq69k91eVPr7Du0yF8/w+uzGqUxC18bBQs1mjC?=
 =?us-ascii?Q?CTMq9bSOKc84feixf4XM1LmnDuCjjjgWd6LTHfAkH9YPF0i3yJePQIwGEQVI?=
 =?us-ascii?Q?EiybU3qvNqeW4dZmk2SPpC/MfhMkrBMt9W/PEFBfJ1peBgT152TsfqTu0RBT?=
 =?us-ascii?Q?rgMzxXBMjSPatlg96LTk/uxEDlz++0Ov/8tgUyYFq1RxwyiEdXaicC484KnS?=
 =?us-ascii?Q?jE5x4K1HbScWe9WCRbscNK7cd2F+xILWfIABQdHDzQul7G4nC0qruUxOPKcC?=
 =?us-ascii?Q?CTVQ9mCkoDriL4KKrhHmbwD+GRLhZrlnd1/f+GYNcz+EMYuMjyXndUupfHIp?=
 =?us-ascii?Q?WQ4RSqy09sumpp0yPXOfBfBk099bF6lB3iYD54RJmHz0TNZox6xxSm2OX8/4?=
 =?us-ascii?Q?8DufgnIrwco0bAGA5T7GvgVuNGZ88n0IuC0SSQNIvZ2VMsqdMkaRHQeIjtm2?=
 =?us-ascii?Q?Aqt11EcOIU/JCTTdR7ywUx0N2snaB+YiCbpmQ7VguTEcquSXpthlVZieQXyd?=
 =?us-ascii?Q?vTzITdRVTG9mhcC6r4TMqzf3wj0z3WAb3CtModazFfpys9J/lr5r+iJp4eAi?=
 =?us-ascii?Q?fOLR1qPsahp4ZVtgfbfqHS+PZ3eJiLyFpz2uIzBsKcwb0KhmtzD5UU0vzJnA?=
 =?us-ascii?Q?2UPaX0rUZnVANP2o0iUkkccOofSFDTo9sEXtR4O9nM+tDUC4KFd2rP7GaZCR?=
 =?us-ascii?Q?PohFay77Ec1nSQMxpWURIQP+abJfc3xFjgp6nNEtKYq8BUt5R+qoOzDkgCvF?=
 =?us-ascii?Q?plm4oIO+/fTHG1AT1EZdudJpy63EhIONohSWo3lw2dDVh38ukJy6ts7l67U4?=
 =?us-ascii?Q?eNQ1rGbctttmRQDQNbLEj5Hh/D2lMeJ4Ar1gy1CKTCAvBxYLdTMY6mf7ImyV?=
 =?us-ascii?Q?O19G7XheuiXl2i6tXcbY6jU825FEjaPejUwFu70gnYBR1bP3eD3vlfUbo9XC?=
 =?us-ascii?Q?BuOlXtm54Oa7ArEi+GFG0pwLVwq6SCDQlwe0ABc2w/XTGFgYfS956VEBh1cC?=
 =?us-ascii?Q?NE79//Tho9t80Qd+nZpl+uM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/3E//jkMk87K3xO62szcroogeJLyllyAvdwNaP3FjrQgMQeT8pHSQJO+lFzHHpk7qpDg6t11NF0i45IoFjSmky7+TbXx3y7YjQKTJ2+8eyC++V/cstZf5PZEDs99Oxpmgf1PqQaKfemju6mlMIKt8npP9MVgzmnKxRLe5tM0+o2yFo2UtL49SVyE9IzHY2TGXoSfm3YkVmE1zyJ0J8quWlW7DMJ6Ie7nN5iQYeDJxjS5uUkpoQ5PN9seTfVKOxqP+FEM6SZE4EZZj23qWYpN9vpY7BBKoe73Cmrm3msayuk8lt+dxDQAtPo2WVpoDRm6Ai5A64ruYuZDkArm6CcjH/bZW1iB5oF3/MEXUqEzzcJaT6Raua3360llnQJCrmNxs2n1wpZjIWBMRnsJN5x8bzqhpE+xhSIkTTs0Va2FR2IG6ZoV0/pgG58GM8CDXRxFGY+kywk3P4KzkypaAkrr5ef92ZtVzsnkkkM8tc+KwSKx1XYNZVkGmST3JpJJu6RLikGrqK30I9hcls+K0CHQwZru3WLv37KknX48riCxEPTiUQUIKW+3jk26DHb8SDmylrywEKQToa09N+DfQiHOqU6oDHFcqp/gU6w/8sYeHzQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051fb2e3-c40e-48ff-8c71-08dc41e6f6c3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:19:02.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GDp3XJilN9070autVkRJitd1TeA4QwDqQWbZQESdoXOK/4qrBhAA0654MurfEbJVQT6SCloSWuKsbhgTGo9hoD8hyWCTu3f/K9KSe+PNa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110124
X-Proofpoint-ORIG-GUID: ftMaMqjLpR-_MbyRzJ4hCziGYCEt7oUE
X-Proofpoint-GUID: ftMaMqjLpR-_MbyRzJ4hCziGYCEt7oUE

Introduce a new LSM called Clavis (Latin word meaning key).  The motivation
behind this LSM is to provide access control for system keys.  Before spending
more time on this LSM, I am sending this as an RFC to start a discussion to see
if the current direction taken has a possibility of being accepted in the future.

Today the kernel has the following system keyrings: .builtin_trusted_keyring,
.secondary_trusted_keyring, and the .machine.  It also has the .platform keyring
which has limited capabilities; it can only be used to verify a kernel for kexec.

Today the kernel also tracks key usage for verification done with any of these
keys. Current verification usage includes: VERIFYING_MODULE_SIGNATURE,
VERIFYING_FIRMWARE_SIGNATURE, VERIFYING_KEXEC_PE_SIGNATURE, VERIFYING_KEY_SIGNATURE,
VERIFYING_KEY_SELF_SIGNATURE, and VERIFYING_UNSPECIFIED_SIGNATURE. After these usage
types were originally introduced, most additions have typically used the
VERIFYING_UNSPECIFIED_SIGNATURE.

At the moment, besides the usage enforcement for .platform keys, any key
contained within the system keyrings can be used for any verification
purpose.  For example, a key that was originally created to sign kernel
modules could be used for BPF verification.

This new LSM adds the ability to do access control for all system keys. When
enabled, only the .builtin_trusted_keys are available for loading kernel modules
and doing a kexec.  Until an ACL entry is added for a specific key, no other
system key may be used for any other purpose.

Enabling the LSM is done during initial boot by passing in a single asymmetric
key id within a new "clavis=" boot param. The asymmetric key id must match one
already contained within any of the system keyrings.  If a match is found, a
link is created into the new .clavis keyring.  This key shall be used as the
root of trust for any keyring ACL updates afterwards.

On UEFI systems the "clavis" boot param is mirrored into a new UEFI variable
within the EFI stub code. This variable will persist until the next power on
reset.  This same type of functionality is done within shim. Since this variable
is created before ExitBootServices (EBS) it will not have the NVRAM bit set,
signifying it was created during the Boot Services phase. This is being used
so the "clavis" boot param can not be changed via kexec, thereby preventing
a pivot of the root of trust.

As mentioned earlier, this LSM introduces a new .clavis keyring.  Following
boot, no new asymmetric keys can be added to this keyring and only the key
designated via the initial boot param may be used. This LSM can not be started
at any other point in time.  The .clavis keyring also holds the access control
list for system keys. A new key type called clavis_key_acl is being introduced.
This contains the usage followed by the asymmetric key id. To be added to the
clavis keyring, the clavis_key_acl must be S/MIME signed by the sole asymmetric
key contained within it. New ACL additions to the .clavis keyring may be added
at any time.

Currently this LSM does not require new changes or modifications to any user
space tools.  It also does not have a securityfs interface.  Everything is
done using the existing keyctl tool through the new .clavis keyring. The
S/MIME signing can be done with a simple OpenSSL command. If additions or
updates need to be added in the future, new acl key types could be created.
With this approach, maintainability should not be an issue in the future
if missing items are identified.

For setup and usage instructions, the final patch includes an admin-guide.

Future enhancements to this LSM could include:

1. Subsystems that currently use system keys with
   VERIFYING_UNSPECIFIED_SIGNATURE could be updated with their specific
   usage type.  For example, a usage type for IMA, BPF, etc could be
   added.

2. Currently, each clavis_key_acl must be individually signed.  Add the ability
   to sign multiple clavis_key_acl entries within the same file.

3. Currently, this LSM does not place key usage restrictions on the builtin
   keys for kexec and kernel module verification. This was done to prevent a
   regression that could  prevent the kernel from booting.  This could be
   changed if there was a way at compile time to pre-populate the .clavis
   keyring. This would allow the ephemeral key used to sign the kernel
   modules to be included within the .clavis keyring, allowing the kernel
   to boot.

4. UEFI Secure Boot Advanced Targeting (SBAT) support. Since
   the boot param is mirrored into UEFI before EBS is called,
   this LSM could be enhanced to not only enforce key usage,
   but also SBAT levels across kexec.

5. Having the ability to allow platform keys to be on par with
   all other system keys when using this LSM. This would be useful
   for a user that controls their entire UEFI SB DB key chain and
   doesn't want to use MOK keys.

I would appreciate any feedback on this approach. Thanks.

This series is based off lsm/dev commit commit edc6670233a3 ("cred: Use
KMEM_CACHE() instead of kmem_cache_create()")

Eric Snowberg (8):
  certs: Introduce ability to link to a system key
  clavis: Introduce a new system keyring called clavis
  efi: Make clavis boot param persist across kexec
  clavis: Prevent clavis boot param from changing during kexec
  keys: Add new verification type (VERIFYING_CLAVIS_SIGNATURE)
  keys: Add ability to track intended usage of the public key
  clavis: Introduce a new key type called clavis_key_acl
  clavis: Introduce new LSM called clavis

 Documentation/admin-guide/LSM/clavis.rst      | 190 +++++++++++
 MAINTAINERS                                   |   7 +
 certs/blacklist.c                             |   3 +
 certs/system_keyring.c                        |  29 ++
 crypto/asymmetric_keys/asymmetric_type.c      |   1 +
 crypto/asymmetric_keys/pkcs7_trust.c          |  20 ++
 crypto/asymmetric_keys/pkcs7_verify.c         |   5 +
 crypto/asymmetric_keys/signature.c            |   4 +
 drivers/firmware/efi/Kconfig                  |  12 +
 drivers/firmware/efi/libstub/Makefile         |   1 +
 drivers/firmware/efi/libstub/clavis.c         |  33 ++
 .../firmware/efi/libstub/efi-stub-helper.c    |   2 +
 drivers/firmware/efi/libstub/efi-stub.c       |   2 +
 drivers/firmware/efi/libstub/efistub.h        |   8 +
 drivers/firmware/efi/libstub/x86-stub.c       |   2 +
 include/crypto/pkcs7.h                        |   3 +
 include/crypto/public_key.h                   |   4 +
 include/keys/system_keyring.h                 |   7 +-
 include/linux/efi.h                           |   1 +
 include/linux/lsm_hook_defs.h                 |   2 +
 include/linux/security.h                      |  11 +
 include/linux/verification.h                  |   1 +
 include/uapi/linux/lsm.h                      |   1 +
 security/Kconfig                              |  11 +-
 security/Makefile                             |   1 +
 security/clavis/Kconfig                       |   9 +
 security/clavis/Makefile                      |   7 +
 security/clavis/clavis.c                      |  25 ++
 security/clavis/clavis.h                      |  16 +
 security/clavis/clavis_efi.c                  |  50 +++
 security/clavis/clavis_keyring.c              | 313 ++++++++++++++++++
 security/integrity/iint.c                     |   2 +
 security/security.c                           |  16 +-
 33 files changed, 792 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/clavis.rst
 create mode 100644 drivers/firmware/efi/libstub/clavis.c
 create mode 100644 security/clavis/Kconfig
 create mode 100644 security/clavis/Makefile
 create mode 100644 security/clavis/clavis.c
 create mode 100644 security/clavis/clavis.h
 create mode 100644 security/clavis/clavis_efi.c
 create mode 100644 security/clavis/clavis_keyring.c


base-commit: edc6670233a333ccfd1ec0548f068bd121d209c8
-- 
2.39.3


