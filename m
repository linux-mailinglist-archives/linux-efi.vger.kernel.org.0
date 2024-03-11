Return-Path: <linux-efi+bounces-796-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3B287851F
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 17:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA011F269A7
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95AE50A65;
	Mon, 11 Mar 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V/W4mzV9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bw/Wj4Ty"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11534D10A;
	Mon, 11 Mar 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173986; cv=fail; b=aLNwbxdsY0A1A7ijRVSA0rCDVvkCAdAUKLONQGpxJYv1rtTlatwArDkqwRdVfg4Uw/ERLTtPJay0Gg7ftkLSoACU28Beu3HhEwXU4bv7plEI+7cKjpn2V8z/QDn+aUQLJO36sPKA5+5A4pWIn/wc4AqnqOru895GwNeZq7lkTfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173986; c=relaxed/simple;
	bh=7yDR4kIqUtPxFlAloY3NRS8HnfjiYCbj9OGKZxdRijI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tRktBa5IQL/q/k9yJya35PjfP9GWsbPDCqOIEx4yqiIbPH2boZEdM77YjyCr9wN3AS3Fm13687osc4HrBHZusVwMPnIVcti0UHreImuUwX/M9Oh6KtK5JnJJ/twDfGZNWjhLpnTSucLZEoemfkWVl92NOlHvqp8R8+CKPWOjWhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V/W4mzV9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bw/Wj4Ty; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BG0gYj005172;
	Mon, 11 Mar 2024 16:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=9QYlN0NIWhhEn6A0LkCZV5HX1RvYaYaF3wMy3E9zogM=;
 b=V/W4mzV9vM7IwtlzVp1yJx7KyCnLtiaQfwuSprhxduo44GfJ4uLWKS70i9xud8C/y9/l
 KjRkOKIRsTjCIIXo+SJ4Si+k9D50Eoscqwvm2o/RPqrf/qV4OeOQC1+MNaAH4xRJcaNE
 jFsLf0ZfL4Ae/tAJ9A0dw7zhsea6NbNDrqYMRVY2HQSQyx4qyOWbrJkO0DWzVutwSewU
 5I6PcbifrhVsNx0olAkEI68Xu7IfEjoYb0/t1JvytqWc2B+Duk0Op78y+jSni+3gNmv8
 brYkb9Dat4enJUqOtbHXEaw/JNslzBIrvp61S23JgVMl3gu5jKpXNuSk7ZYo0mbBGI9y Dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfnbkqb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BGA49l009105;
	Mon, 11 Mar 2024 16:19:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7c6kba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 16:19:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB4hfiMxZJl4Fr5KbM/O/VeG7Ak/WgP0g6vucBfzy3ljMVoCX3N2cEGt5DzwC8aWFJTJN6D7zITYXNxXaf+YUgb5hY2HauDdpXlXOYGR7mfMP6dkt/Ax2D4ETnEEvqCwz/wEdp5tb9wXSS4MQinj9oHf8fig5u8rwaGrD6y/4guFyBNOmNdxPE6ssoP06B+FvDGWBa2AEy6X0MHWnTEst/Cl0FuN4JVKJ6eKuXuVyn9eWLtaFqRnXDEtkPB1f+0wTVvXj2c0PesuS+pJ4ncpV4unhA/GnM5VknFX+D/J1+/8SnM+DBIsEN1gCHCQH5B04psJI6+bocBsWSAJ+kOtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QYlN0NIWhhEn6A0LkCZV5HX1RvYaYaF3wMy3E9zogM=;
 b=TttzanU7PjgNiCoER35/XYEKqt9uCS3UxWTNvUylPRMcInRqrOQgeJtiL+okasEIetibSMetW4KwZgqyZ6+p7I3dqfGUfUculE9ap05msMvagN7HubCh70iRqqaGPMMyf+TWn9z/lqpo5fGbUDACd+gVUtnZ8iIt2kFYdZYX00R51WKBAA3AgTDadvH9UcBsLOARbALb+E/0Vk5dkjC4Z5WdrE5+cdqShpCBEoq5XfkndLaJXxGUNdp+npyiHNtYAh0x4eJUj5AKPi/xVFNRtlCboIXSW499zy7Ja61DajMShwEH8sj0JM0+s9ic1QRrTfcpn0aIei/x1WSBb0fitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QYlN0NIWhhEn6A0LkCZV5HX1RvYaYaF3wMy3E9zogM=;
 b=bw/Wj4TyhaVrk/zktqyz88vwUlPKntYnbu8fPy4OsmPgXtJqq0tfVtk9W75DaipOK17al94AI5hEoUq+n5Cw41QaeUXuurFGBU0IWM4hAyOy2fQuh8HnEDBgR41smBjRC1x7PrEX4qRhOSXkAf1uqNfedaX0+yBrzBAIumNRUss=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5119.namprd10.prod.outlook.com (2603:10b6:5:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:19:09 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:19:09 +0000
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
Subject: [PATCH RFC 2/8] clavis: Introduce a new system keyring called clavis
Date: Mon, 11 Mar 2024 12:11:05 -0400
Message-Id: <20240311161111.3268190-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240311161111.3268190-1-eric.snowberg@oracle.com>
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0060.prod.exchangelabs.com (2603:10b6:208:23f::29)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d2e8c0-3d46-4bd0-31dc-08dc41e6fb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MM8YaDhFiDmWv6x/W4DgSEIbrOBN71dyRq6Kqix+rumtQ04Y/JNMn7v+XzgQGssLPEMksyN+/RaXPeDxD8Beg5azRiSzC+RLjP8m4S08YfAJ7UqiIxkgZi0ejJpIgO7snq3EBJw+k6sulX8/hVUHnohGN21dF6fBam7gEwzyg6997b7+NmT8/uRwE71xu4ABbfxBufadOWiqj0ItFyqurJdRlRwQu6VjqJgjWJ6/SR56Uyk6bLOIU5q1BUl8lAKxGQR04PABiARWb3VXm2E38sn9xEithPpcJ4bn6tYjifLV736V11+1hqeIKlK/I4g+n5sG0jkBFmgh21enxYMLw/I0Zfm1XVB20xsTpJNbS9dkAezZvxcSVG40SQCSpXbWvwFZ8uPeWcEFvyDaTB63T6bpAdG0HBHIm/m3lwr935ZtezYypofVvv7JaxDojMoH1yjil393weBns7+dmwuO+ESpiylaOcwohZ5EilW8oMDZCZMYu5fXHVkxulpLZ76XIfywgNiIa/PBY7N33C7SSk8diPISmMFNke590V59l2Zekk0BwVhVKWC7xJBCRqqp5dLJOhz/WKWu/gqpu+LQjs1H3HqL3d9wH7Algup2OvPoEBIBglox9PfUWFMCsUlEu/wjvsHoRj4cNHl1U6iwX0M4SKOaYqcjD27OTMSNCSU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WFQIFk9sHzm+rsvJXM3AOC92Cmud2uI5kVdZDHiY517N+g6xlP21ZnII1eRj?=
 =?us-ascii?Q?IGnJPdOgzW6JnSWTnmoDMcMDJMxP4krSPSm74mSTNJ+C9QdXiv9HSnFoPeVT?=
 =?us-ascii?Q?aJ08J+vEu6NeAaotB9Fd0kfxcxTJl6xS7KzeRPjWfvUk1xRmuQH6CZP7w1sL?=
 =?us-ascii?Q?3KYPxvuC1/l5XOkp06jWHzwsNogcIvEqGcPVNFThS/h2vPstuQ95wBE69Kzj?=
 =?us-ascii?Q?cKEXUE4avsc8XjOouoZZT378rj/G4LxTBvrP5uxsXPt7HyKGHVc0xr1RUj7Z?=
 =?us-ascii?Q?znvEgAvO9KO61fxNZROVAG7vFlT18009iXEZI8Cke4t24KWVG/g+nN9AN9qZ?=
 =?us-ascii?Q?x2P5piBCKqH3wUT+yWk4drO8BkKGa/fEpbRApH2M/b5PQwDbDy08KwYRHIkC?=
 =?us-ascii?Q?CfDb0Cy1pHJYsvEoJXS4LKKeKAoBSWG0tfQp4HBZ3ZsvVLlO+26V6Jr17fGQ?=
 =?us-ascii?Q?UoUVeIIR0NIep5bW6L/vRiXGqJMvRPfBDZnj73raSJdCndzqEID0V+9qSzLd?=
 =?us-ascii?Q?U8qEz22Ca3t8KRvLpSA80kXX/Sx/YmvPWWXtfl2hbe+A7t93/3GRwiunsVrB?=
 =?us-ascii?Q?3Uc0Ph5H1FkTKhvhBZIPFp3+yr2s60T6Qbiq0qdCWXWxceUhS4m8EsUYajl9?=
 =?us-ascii?Q?ERG+bByLrxqxlXehsiLo524PR6GnAEO5cgfHRd44oMdio/vOO+ikCZQ5YAnO?=
 =?us-ascii?Q?prxAtxCnF+5V5RY4uVaA8mVHbmrWelh2Q14bn2r8eq5qmhPG0te09SuRYcIx?=
 =?us-ascii?Q?KL25f1Q17ICVBdTE5hDf5pPRpFBhGOPmv61GJttSzIFJ71CWeAYS9KEUUfpw?=
 =?us-ascii?Q?8y6tImh2a8YzwTHgtBQZ6ZPrw0HmhvJol1aZDOkHBD7TlzJuBXhzTMLLDKXA?=
 =?us-ascii?Q?zIgGyHO8v8wzJw5+J19r+XkBFU1Spsyt/0Z4ihD4cDn8e6xK+O/5/+TvZTQM?=
 =?us-ascii?Q?jsvPTGxloci3jSHXcQyY9wmxIisOzLZUtnJQnxyaHlTKZyB1pf7qNLHNdvIb?=
 =?us-ascii?Q?vAIbKm6zt8hmx67BIti/tyawgbx2mXa2FXuS+yfpwtykKktYgcrXLS76W5g4?=
 =?us-ascii?Q?f1j0Tl6LobBetTDdPjg0iVGWqHYprAwZNm8LKAOEM5MSsbXAO5J5OtbGLiHk?=
 =?us-ascii?Q?GH6bgfSmB21glQDiRM5kcrFPTRWdwHS974Wn4Djbum5/3/Qpr+q96y8uhWuL?=
 =?us-ascii?Q?qGzw6XAvYkN26+mL60aA53qSFDnz2HZWoMOndxc3eCI8j6ngPmEwEvoQWeTE?=
 =?us-ascii?Q?lKXSTqoLXmmRyyGkGQBxDVjU/VKF8iKE8/PJeRopfMPglb7K19IAf+tL6TU/?=
 =?us-ascii?Q?HjDykoaZviSIAndyNokb1jWRCbu0W8U9omxri7hQ0tat9+M1FjTp5Sh0uEOH?=
 =?us-ascii?Q?374g4Q2CTBGHA8QGK41zNKZ6klkUcwsPefXZ7XK4rfxqqtYS7pLP97+yjD06?=
 =?us-ascii?Q?k2MIIQ5KgOnPgFX/vUNougDxlIuARA7yZpgMxOWUoA0Kks+PZDrVevlK9V9W?=
 =?us-ascii?Q?HJjZor3nviygTVMUc4W8vTdROO0VnzX391YTrIIuk38W2kwM6TiQu+UjRp09?=
 =?us-ascii?Q?vRqyraDAleswEj0TF5crS0AJ8vUN/ZwDKEOEX7HYyJVku8mtf4Yrc2YWW3Bn?=
 =?us-ascii?Q?ZUDgk2GhnM1324Dyj4ycvs8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UTg7lLaPpjtuIsmYNBXohJFHL/B0gYYbXM8naF50xRaSVnqgMT196fgKYpBEHZHIRmKOfBVjjbNr/qnjyR5lbPQxJF7OEyrqzbYIyhR2L5opNO01/+03jXRuh0SqHSUemiOOQq8lruSCDPh5sC+BCLjXzFF8o65KnCk0aWPgI1X1Ux23Ug8oXC/jUNvWcyCiArhwEvJio19BBvRmhsuNiS9X5i+Q/bjQflec0CKOFxb+zRgWDJ597rL3kZdn+CbivCvbbyzYL+IBocDO3IisK4y1FV2SjrMTGvWprd4K1/MeGU9NJO5hC22XVqbWs9hw0SUGo3ZOst5rVZESkGu9AQBkm0wt6+yn7bqLCEDpHPorHplh+zerklf6hOFYxjiKXqVEQhHsa47EevBwn6Q+vBsgYdriBxhd2ST3nrgzZoli7/l89ILyWmR7z+OLsWssnc0Ow/Bax2jZgYVa9PX88oopjXXDkG7kT5hIe7O7fl0foMwbS81ivKtxzIf+HuKeZffpRkriIq8YXqjxEr1qe6QIN6eJBKwMeSNiI3Nsmb2368THiP60HyLf4g4ngZKPx+HMRTtzzn9OLuk1xG2edVTRaXQuQCmcR5xuAfdosqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d2e8c0-3d46-4bd0-31dc-08dc41e6fb58
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:19:09.7421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybpA38uXAKhbdfQYiEDEA2TDKeTWynhUwIZUpG4vIjlZkMnwdqk52qABmoD2TLp2Z+ely3NLM1a8eM2i+vMHNDsh85RwP2CvCSILbZwGdrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110124
X-Proofpoint-GUID: OKtTK_d_CSPB7W7TppEGT2_C9mdb5RjE
X-Proofpoint-ORIG-GUID: OKtTK_d_CSPB7W7TppEGT2_C9mdb5RjE

Introduce a new system keyring called clavis.  This keyring shall contain a
single asymmetric key. This key shall be a linked to a key already
contained in one of the system keyrings (builtin, secondary, or platform).
The only way to add this key is during boot by passing in the asymmetric
key id within the new "clavis=" boot param.  If a matching key is found in
one of the system keyrings, a link shall be created. This keyring will be
used in the future by the new Clavis LSM.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 include/linux/security.h         |  4 ++
 security/Kconfig                 |  1 +
 security/Makefile                |  1 +
 security/clavis/Kconfig          |  9 ++++
 security/clavis/Makefile         |  3 ++
 security/clavis/clavis_keyring.c | 90 ++++++++++++++++++++++++++++++++
 security/integrity/iint.c        |  2 +
 7 files changed, 110 insertions(+)
 create mode 100644 security/clavis/Kconfig
 create mode 100644 security/clavis/Makefile
 create mode 100644 security/clavis/clavis_keyring.c

diff --git a/include/linux/security.h b/include/linux/security.h
index 8436f9abf43d..94661398708a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -508,6 +508,7 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 int security_locked_down(enum lockdown_reason what);
 int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
 		      void *val, size_t val_len, u64 id, u64 flags);
+void late_init_clavis_setup(void);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -2223,6 +2224,9 @@ static inline int security_uring_cmd(struct io_uring_cmd *ioucmd)
 {
 	return 0;
 }
+static inline void late_init_clavis_setup(void)
+{
+}
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_IO_URING */
 
diff --git a/security/Kconfig b/security/Kconfig
index 52c9af08ad35..7f5a52b7cefd 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -194,6 +194,7 @@ source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
+source "security/clavis/Kconfig"
 
 source "security/integrity/Kconfig"
 
diff --git a/security/Makefile b/security/Makefile
index 59f238490665..01eb82bdd74f 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
+obj-$(CONFIG_SECURITY_CLAVIS_KEYRING)	+= clavis/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/clavis/Kconfig b/security/clavis/Kconfig
new file mode 100644
index 000000000000..ca72a9e43089
--- /dev/null
+++ b/security/clavis/Kconfig
@@ -0,0 +1,9 @@
+config SECURITY_CLAVIS_KEYRING
+	bool "Clavis keyring"
+	depends on SECURITY
+	help
+	  Enable the clavis keyring. This keyring shall contain a single asymmetric key.
+	  This key shall be linked to a key already contained in one of the system
+	  keyrings (builtin, secondary, or platform).  The only way to add this key
+	  is during boot by passing in the asymmetric key id within the "clavis=" boot
+	  param.  This keyring is used by the Clavis LSM.
diff --git a/security/clavis/Makefile b/security/clavis/Makefile
new file mode 100644
index 000000000000..ff19c1e240fd
--- /dev/null
+++ b/security/clavis/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SECURITY_CLAVIS_KEYRING) += clavis_keyring.o
diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
new file mode 100644
index 000000000000..9f1aede81992
--- /dev/null
+++ b/security/clavis/clavis_keyring.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/security.h>
+#include <keys/asymmetric-type.h>
+#include <keys/system_keyring.h>
+
+static struct key *clavis_keyring;
+static struct asymmetric_key_id *setup_keyid;
+
+#define MAX_BIN_KID   32
+
+static struct {
+	struct asymmetric_key_id id;
+	unsigned char data[MAX_BIN_KID];
+} setup_key;
+
+static int restrict_link_for_clavis(struct key *dest_keyring,
+		const struct key_type *type, const union key_payload *payload,
+		struct key *restrict_key)
+{
+	static bool first_pass = true;
+
+	/*
+	 * Allow a single asymmetric key into this keyring. This key is used as the
+	 * root of trust for anything added afterwards.
+	 */
+	if (type == &key_type_asymmetric && dest_keyring == clavis_keyring && first_pass) {
+		first_pass = false;
+		return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int __init clavis_param(char *kid)
+{
+	struct asymmetric_key_id *p = &setup_key.id;
+	int error, hex_len, ascii_len = strlen(kid);
+
+	if (!kid)
+		return 1;
+
+	hex_len = ascii_len / 2;
+
+	if (hex_len > sizeof(setup_key.data))
+		return 1;
+
+	p->len = hex_len;
+	error = hex2bin(p->data, kid, p->len);
+
+	if (error < 0)
+		pr_err("Unparsable clavis key id\n");
+	else {
+		setup_keyid = p;
+		pr_info("clavis key id: %s\n", kid);
+	}
+
+	return 1;
+}
+__setup("clavis=", clavis_param);
+
+static int __init clavis_keyring_init(void)
+{
+	struct key_restriction *restriction;
+
+	restriction = kzalloc(sizeof(*restriction), GFP_KERNEL);
+	if (!restriction)
+		panic("Can't allocate clavis keyring restriction\n");
+	restriction->check = restrict_link_for_clavis;
+	clavis_keyring = keyring_alloc(".clavis",
+			      GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, current_cred(), KEY_POS_VIEW |
+			      KEY_POS_READ | KEY_POS_SEARCH | KEY_POS_WRITE | KEY_USR_VIEW |
+			      KEY_USR_READ | KEY_USR_SEARCH | KEY_USR_WRITE,
+			      KEY_ALLOC_NOT_IN_QUOTA | KEY_ALLOC_SET_KEEP,
+			      restriction, NULL);
+
+	if (IS_ERR(clavis_keyring))
+		panic("Can't allocate clavis keyring\n");
+
+	return 0;
+}
+
+void __init late_init_clavis_setup(void)
+{
+	if (!setup_keyid)
+		return;
+
+	clavis_keyring_init();
+	system_key_link(clavis_keyring, setup_keyid);
+}
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 068ac6c2ae1e..87a8bfc0662f 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -36,6 +36,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
  */
 void __init integrity_load_keys(void)
 {
+	late_init_clavis_setup();
+
 	ima_load_x509();
 
 	if (!IS_ENABLED(CONFIG_IMA_LOAD_X509))
-- 
2.39.3


