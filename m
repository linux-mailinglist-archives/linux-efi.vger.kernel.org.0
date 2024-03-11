Return-Path: <linux-efi+bounces-795-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236B6878518
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 17:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72C32B215D8
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 16:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B174D9F0;
	Mon, 11 Mar 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gA26kRDw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oCFAaND3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8304AEC7;
	Mon, 11 Mar 2024 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173985; cv=fail; b=RkLHkagxoHhF65vRak/nbCaCdrplFNZ0Ug0rQEEtPHEa+Unb7Y/REsOcNrhm+1uA/y4t/fFc2Ergv28qEY4FYLZW3nWQKenxgESrpW8f1IXsXwQUt+r4W2J54d47hrj2bUbzIkE7mQVFOLoltwJ/kFwOTUJtElx96XdidQAgaEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173985; c=relaxed/simple;
	bh=dgyBi1qU7z9jakUewdQbxjV6RI6Ul3ldbTo0WeLTtNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fKdMOB+Fx/0fjpcMOGCAUY6jAQtS8sIXR26woCrNK9YtrjXUTtXIdly9D7z/4MgteLqAddXHloH8JGuLd2yEDIVAHXPadV/yg7ih2ZUAzaJSW0iShM0/ZHGsIv3UwQUHgIvYSd4kaMWdLJT1cIjxvy7l9ogXapmb3Se7wvG95os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gA26kRDw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oCFAaND3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BG0wAS017842;
	Mon, 11 Mar 2024 16:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=soMIWdaWi3eATjfCgd7NVkvKCLBiQju94PVQkd3/AAs=;
 b=gA26kRDw5b7AnPic/hfvNZS4XoQr+dlxuBM4eLBB5r5SDsWi1jHAXy4XhPoe4XZT70Fh
 PwvDbozPFp2Y6fDNL/Z4pjVPzBXeSKcbVBq7bPS1DtSmGk97EvJbqwhaKtuID3JaXUu6
 FMDJ5Bbk9CDsg0iV7UOFDMATLMunLC+4PqctRlKLU8rMCunbfzMOqZ2tpKiIyfckw+VI
 VCpjvHZqNZUxL8nAbgwQ2KDvLOznxuOyTqmp1W0wxRQ1ylaxyoe3R2PXC83hnO7xKaPP
 cEQp3cpQlxum3I7H4juigA1AuaPeSt5PqHPcywd82Rm/8h5VUp+LlRP3XEmvHotChVfD ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepcusf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BGCjSP019715;
	Mon, 11 Mar 2024 16:19:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75yvk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7ORBgLo5zszju29bhjH9QvsqzvFp5rVbeYPImBbNws8tmNGC2TjhuxvlHjsT3IrwMcp5lnWs//Ney/Y9rpWnPWpD3rnTp1aQw6/wc+RR/siplzggYRElwABWJVRtdcRAGTOdtkYlAEj8XpFvtIlGrSsyDusFeDWfvb5W/45vKNGyQT7wOke0L4+0jK/o1CDgpZbrzVEuu4Alar+jZHyfZpZPxz2zUXve3idxZnQlzapJGYOTBv5V6encJl5H1aHedo6pH4moF8myuVwtO1gIsb5ZMVDNYPPPqnjmIdzS8pKJkxOBTjYUEjbtr2ZfG/Wae+XsFuH5XxVOK/VJDxT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soMIWdaWi3eATjfCgd7NVkvKCLBiQju94PVQkd3/AAs=;
 b=WIau/ogrFcvzojaU1nk40iIv0kCVfQbsyB92YPu80WIySYrMRDA6xXlRPagB0CnkymIBcgOCYzO6/3LFn/1Fb8SJAd1be56vPp6/K3kNJIjpfRYAeL+fClP6gYplx3r6iwbURuV8G5kpsgDMBwnEquoXsU6QdgL+oot+x/1lIvGoia2s2go+HX7Jcx87MfEO3VH1c0lCUdQKskuBxfMGt106UgLsc4CARQ4UnPBq2puX3y/n892aYx/HORkgUCpj47t/XNBIrIxZlKBeDF7a4pT2c14PXFsi5rz1oQuC1xwIwvhvyGb79K0f0OuY/vbiouRV6jzZDYUGSpKAt46eKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soMIWdaWi3eATjfCgd7NVkvKCLBiQju94PVQkd3/AAs=;
 b=oCFAaND3h2UJeObnkMKDyg9qXyUTVHYcxnyoPTNultqQVCNTRCrhdQgpmgwPzslKvAPQIdazH76nx8VHi489/N3xMkIXT6NiyP3QgDGVEX/05zStfAMXJrPA3TBE/04mn9W6dR6fnVTZWfPbIO5TQ7Rf+uLM9mk8iZMnHjH1u2A=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5119.namprd10.prod.outlook.com (2603:10b6:5:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:19:06 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:19:06 +0000
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
Subject: [PATCH RFC 1/8] certs: Introduce ability to link to a system key
Date: Mon, 11 Mar 2024 12:11:04 -0400
Message-Id: <20240311161111.3268190-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240311161111.3268190-1-eric.snowberg@oracle.com>
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0057.prod.exchangelabs.com (2603:10b6:208:23f::26)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c2d175-7772-45ac-8704-08dc41e6f92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SPVtJcLcUOEMs0Fwta7v+3bbmO6PmJ/j0s/GkaUmSK+O9YivqHsPdHa5ICyh0iwQ3S5CJXdIX7Vk7RfvGHBPe+3+Yyk+dcQsp65EoGqzw20wi0Hv73AmbEWo5UtJBSlTvdQr29taBrb59sJjNmKbwEIDea8Ivi3v/VwH/OcdpK/SJF27b1t3ok2AkPZBRj3QMCtibWp+JcpFYn5yqbGD8w9g3xeZhv9pOeeGPe60KG3BdmiL1eTwrufV1WyqKcRmVaki/Go7UcBudI0H36BGGcKVdtYlIM/6ldBBbDKzcr7PH2JMiR0JdSvyBZ/1jbQWu7kpZWx7TYax6v0jLE+tKkHW0iTkChaGHAaswBHxYGvUrtdAzVsdYW76WlfI+kR0uMfK6FdOHuQ/0bwqFiqyPvS9Ewk/BgUdAw7LaKKoghDANfSJw674hOWEpX4Yy/+g+t6pc9pWgfrbvvIpqCT5muwe3+CU+3q0hQKKuKDzD3kzZK070IlG5kKkjR6IGrsPMwY7CSa2fwxh5lJlqpXZ43QJ7PcjAT63CTG7+4t2wIhbwajh2wd2T+E2A+k7/+cIArdmxbg0+STexvR5Xm91vO2xwT4YWmXsou3KUIxQShgsfS1pRymmAwGBavMldZKIX1pOddLfXpjLTL+p4lL9wMH5T2VUovncverBaO9ut5M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qYyu1wHpVUxVrrxGZEz+jEQ9H1uab/WikCLXZh4EL9as5jbjKFKk5C9ih/jD?=
 =?us-ascii?Q?g9njR2eneMhMlAruYVhGOpLG9F6NSsN99VN/lE/CmdlXn7oP9GV2VSHsvE2u?=
 =?us-ascii?Q?Txb98CtVqz9ytIVgekXw5rOl9PtU1H3v+QtMYu8JZFS0yyk6TcDkeu9ZmSHk?=
 =?us-ascii?Q?Nvx1HGfB44r3P2Uss9gvcJ3xZFTi3MBmZZLoceALKaM2Y8orYb5vOmlVWzIz?=
 =?us-ascii?Q?X/dXhcTnzaUAJGzKCzygOqocNig/HqugspNi8R2OjskfwcU8bCcXHaXj7EEl?=
 =?us-ascii?Q?v1XLMN5iVu7F5O5dPLwVP1irUKWI2FyRUeJ136JcC2slfVK6BgK21VcZ2S93?=
 =?us-ascii?Q?IbGtpHBKoOU4ZEzY7O7DfjALWncdy5v1lPr/cmiLUUh6hBXWKZvWK1bGURRw?=
 =?us-ascii?Q?+KnKcX/9iZjRaBQNl1oVF7IBVpApUmmi/HUEldbYOSzKzoc3lzwvCXG7kyY5?=
 =?us-ascii?Q?5mMDyePvbZeZ8hFEsdi3z8XE7J9YjL//j1XsgR40EBV6Sn7ZwZ+uE3RJJO2Y?=
 =?us-ascii?Q?eG13x+i09ql0tg34Lb/GNzeRJbA8UprOV3lsGrnV8fd9me1GjhZMgw/i0tjz?=
 =?us-ascii?Q?vdb4C0XVdDSBhUpkMrdFOAk8EaTfkeHx0tIj19C1l/bPCASU88MI09SID42Y?=
 =?us-ascii?Q?OZemas/+0uV89nnqtQ8JrEb6N/W5Zt5erCYcDQ5AZkDdkSnabAEIE1klbUHl?=
 =?us-ascii?Q?Aqg0NXUYPN+ZOEPn49TQDLL8crbaxnZU8i4b662mNwTUS10hU3T8BPOoIZGn?=
 =?us-ascii?Q?MIVqQv1rs7Rtqg89wfia43zQ7OOWoMNmNbNo4V0MwuGo/57+704yEZKDkI+b?=
 =?us-ascii?Q?LPviSjUi/MKyYMMGncuNhQt6SXTW9q7HiSLIQWMJI1rEaIXimwfO5eiBDrPk?=
 =?us-ascii?Q?PbiHJABdAe3x703slyAGkGziTSA1Fk17jHCAFHXRIUFM5YKtel2fWFhj+IP7?=
 =?us-ascii?Q?EQoNp5/XD07OvJQO4VIAqe4TlYkLCpnWkNWLba6rpDBzDvl9y5tWl1xoUDau?=
 =?us-ascii?Q?9rFZbft1RvdqFrlxsPNysAI4IMG6eka2yqE1kNcgkmNPNR+Hu6+enh67XlY+?=
 =?us-ascii?Q?6v4Pb5AyqsmDMfwwykqSGjfxocC8oM9dm+JKN5O42WjinyqZL5IjzFzEqH+L?=
 =?us-ascii?Q?jTTo7e+28BhUsu5XG5fypVt84RzAxM1DaKF33mJEYge67toNj23/uOuOvT65?=
 =?us-ascii?Q?edDt9pdK8oaDHRe9b5OGBbw6rS7CUOE3xognW2vWtuuyja4yoVq3E3q0W3gu?=
 =?us-ascii?Q?ovTvhvdoI/c6CmauUMhgvkbxDjDiFNIc7HMLFpO8Exp8t7z8fvVJGo3/Vz6g?=
 =?us-ascii?Q?I4yBrU+2cCZmT+42kwASwKMF/YNp8Y6iOejERwkdYrop4Km2dE5t5UCkvdY6?=
 =?us-ascii?Q?VpSYxIU9+7eEfWYCxQgmpNyN7i9xHKY+1foybfzEs6p3SW2LCg9xy2zq1OM9?=
 =?us-ascii?Q?e88isPpT5Ar1D6KMMyYGn5GYyBchIQhxGRFhhcp2gzEn4tnZyln3sr81JbtX?=
 =?us-ascii?Q?WV7aEFeAS8bv2gcfltJLxIoX1RgxkVW7c3WisC5oCyqE+D9PUHduhR9P5KOV?=
 =?us-ascii?Q?uHhRTKp49bRdFFiK59m26Wp5F5hx1KC1N/bKnKk3pPNtQoFxf/6NnG4UgHzq?=
 =?us-ascii?Q?qkOMyujkctREAew6o81XRcA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WrgeNq+91v0vK+F35zxMq/F8g1q6Tv8Pranyh718jLOXxPb8Xcxs6tc4zRlnQca68LDUuYiSHUBvZyrin+FQiKT8uLDZG1j5nAPAqPBbxmHR/LfrC0+/QOPTYH3YjHqlyv5b5FL2+pXqy5fFeNqBKrKdA+Ro3+nMfPk7G8+3KPLR313zm0gI5wiIKkxHGJrQMbWzqJLChksvID/CM9KHhxB1krDAfxotDmCjoPnvsJ58l/q3BQzZr7aQnIAZF7bmx6tnSvdVchztt2FQtcsC8zWAR3OevZYY8VOPu1F2gOn77doayUGnANGWDtWG0SN070IIT5sEqc+gZm1rAHTcpbkr5I1rrFSuaVzheLezn1tiZ5Xrjl8HHeBPBlQuIjSFiKSvWyg3BqD+7JX4T6+C4ObRG+WeFvp+5LojUHd/ZUGQpteB7f0VS8P673UyaDWXFtUvZ/8gNqVy3YRKNKKGeakQ7TbTit2uHdnasAecQ95YUxwMQT8yFvBfGOQRoVbwvSn3Ry14jV1xcK6Vl/1XSya6efHIkPZOUF3ZB1aw0KAFIrU/Dv3yN6Qgbj07wQUFGMSimbOLTKu1VrJQX5tx7mKUKqr6GXv6s9sxVJz2hYQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c2d175-7772-45ac-8704-08dc41e6f92a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:19:06.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Rjt10SPNusHNgB8sD8FAwbBmnhbVXYGRuf1X3qUhMsop+oVAc1u5V2zPlChYcYYOK5vCAHFy6k9T42f52ceGj0Sdnigbx9aTA5A8wN0q/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110124
X-Proofpoint-ORIG-GUID: petUOOvSs8CXjtihdtNeuzSIqKO4o7RO
X-Proofpoint-GUID: petUOOvSs8CXjtihdtNeuzSIqKO4o7RO

Introduce a new function to allow a keyring to link to a key contained
within one of the system keyrings (builtin, secondary, or platform).
Depending on how the kernel is built, if the machine keyring is
available, it will be checked as well, since it is linked to the secondary
keyring. If the asymmetric key id matches a key within one of these
system keyrings, the matching key is linked into the passed in
keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/system_keyring.c        | 29 +++++++++++++++++++++++++++++
 include/keys/system_keyring.h |  7 ++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 9de610bf1f4b..b647be49f6e0 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -426,3 +426,32 @@ void __init set_platform_trusted_keys(struct key *keyring)
 	platform_trusted_keys = keyring;
 }
 #endif
+
+/**
+ * system_key_link - Link to a system key
+ * @keyring: The keyring to link into
+ * @id: The asymmetric key id to look for in the system keyring
+ */
+int system_key_link(struct key *keyring, struct asymmetric_key_id *id)
+{
+	struct key *tkey;
+
+#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
+	tkey = find_asymmetric_key(secondary_trusted_keys, id, NULL, NULL, false);
+#else
+	tkey = find_asymmetric_key(builtin_trusted_keys, id, NULL, NULL, false);
+#endif
+	if (!IS_ERR(tkey))
+		goto found;
+
+	tkey = find_asymmetric_key(platform_trusted_keys, id, NULL, NULL, false);
+
+	if (!IS_ERR(tkey))
+		goto found;
+
+	return -1;
+
+found:
+	key_link(keyring, tkey);
+	return 0;
+}
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 8365adf842ef..b47ac8e2001a 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -9,6 +9,7 @@
 #define _KEYS_SYSTEM_KEYRING_H
 
 #include <linux/key.h>
+struct asymmetric_key_id;
 
 enum blacklist_hash_type {
 	/* TBSCertificate hash */
@@ -28,7 +29,7 @@ int restrict_link_by_digsig_builtin(struct key *dest_keyring,
 				    const union key_payload *payload,
 				    struct key *restriction_key);
 extern __init int load_module_cert(struct key *keyring);
-
+extern int system_key_link(struct key *keyring, struct asymmetric_key_id *id);
 #else
 #define restrict_link_by_builtin_trusted restrict_link_reject
 #define restrict_link_by_digsig_builtin restrict_link_reject
@@ -38,6 +39,10 @@ static inline __init int load_module_cert(struct key *keyring)
 	return 0;
 }
 
+static inline int system_key_link(struct key *keyring, struct asymmetric_key_id *id)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
-- 
2.39.3


