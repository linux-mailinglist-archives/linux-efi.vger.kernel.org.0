Return-Path: <linux-efi+bounces-1988-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B414A9A2791
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 17:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7490F282C7F
	for <lists+linux-efi@lfdr.de>; Thu, 17 Oct 2024 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A980F1DEFD0;
	Thu, 17 Oct 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eUW6PVtx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tls3s0Eh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811FE1DF251;
	Thu, 17 Oct 2024 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180611; cv=fail; b=l+aToIzbLtj842nKBrJ2RXD5zLZoAVZdiZ9ezFs7J1EDygIsDZ97xTmzWXyg0QoCsL41LLFQQlEM5Os49b2pZsn/fgU5ppMQeCkRm8DTF6b6wOTQ9R3E+LdAwhekoVirpRQXYJJ/626ktGGGzrCTCqT9gY+cvnuZyZrxwVYvAYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180611; c=relaxed/simple;
	bh=RmnD2G6Y1vNgNLB/DgX+55tjS7v/TdfMghYaSgpZ1F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GWFuo/8JxZ4k2GSgbtN3cDAvJiB9tFmWRkQQGNtjtzmEusLJ09m7ta36mVkrl8zo+6JPb0nSZgkyJftY0Ik4+KMoB3AxTg70ax9tUhaFtFt+gFJZpDOfz/tTuyQm3C+ozFRvrtude05p/2Wrq8oCxETHVkkidnJW0ckmkENvzxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eUW6PVtx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tls3s0Eh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBnQX019235;
	Thu, 17 Oct 2024 15:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tc7hZu2Z4+2wzb/Pm9x77jBTd9wvgLAb5D8nVUp0oKU=; b=
	eUW6PVtx/uVASTchC23nMM60dJT7XAT9/fzo0qyhS3YUmk4EAuicds4DueSI3QR0
	Dwi7TwCGU+9LoMmdHaKiM860cfLP6ZaLnrxLUAgjxThaVlNx/yIoaNf/v+gveh7J
	u5bG8OWb2KfWvP9sh9ALcmjribXcFagQwUQcwgjui7TNL8WYFB+/uXGQQfP2K46i
	bgE6atskImFPhOX3AqtYbOSqQNufZERiPoTgefLt7bFVFZhkqsQ48oeTe55xyPCX
	CIxeRIAV6bEMz3YnMvp8/2+Y5mmAzwK9HAjzBFdbcVweMwKvTUfpgreBFnF6LcJi
	ugTWHIBDDKnVaSA8twmkrg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cq6qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFPSY5026291;
	Thu, 17 Oct 2024 15:56:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjaej31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 15:56:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPxR2TaKCwR/RxW7tgJzrKeKGnatkqU2Um0MTYOM9RA+7NQQ2phPcYtqzcnpBioXvKZn3Hq+nZ6OMS7Ljww9+hH17nhcoDxCwx+2O27X4t5ijRH9Swubwq+nZNNUEE9kLSqD4LInujMP8OgVMFC+vzEk+L55KSLkdvx5aWZmyaHhJXHH+42TsRAMWhsAR6wC5ip/xrCIP64Xp57sE2Oas6XpMeBx20PRxVcgfNW+7UviGOcWWICVTgtuX798d065JKTIEWvkMtX3rici+Jm7dbkdmdC8YBncOucSABJ+IvlyQEfioS7s4iBwsEAVSmwZko4Fl7+oARnbbrplPgB7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tc7hZu2Z4+2wzb/Pm9x77jBTd9wvgLAb5D8nVUp0oKU=;
 b=t1Lp0bxzQnumgMocIzaLH0YzKoEpktZbaDkJFmlb74fvIRsezgor9pYSOu1ljb+TuRsigJO1rkVMDYZ5RbiEDeXLtc8NA9SEhQkH3FNIfCq+BSB0TuHWNXjPF21KLAaCvhZtcc8FbRoMII0ucDbIBS2mMmVFUihIQ7OPUcmcucgmwJaZYYhY6DnK8tYaA6pFxCUQOtfYbEruDZdR0sozXsGcnY9FlOlyJ11mHyZfo2CT1id7AUgKs3fGbdnT0/tIE3zHp9j278nyPnzYoE/QzH1ryC2zO7PWxiX/scrDxFNAnYp12qLdgCUqppy8yQmkxnE5YcqB0cEAZTEdQmnr6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tc7hZu2Z4+2wzb/Pm9x77jBTd9wvgLAb5D8nVUp0oKU=;
 b=Tls3s0Ehn49vlGn1CjFrBwMNepij+e5hFKPr7Y9fHubefWmbVz00hDwf67DW53eiT2yZdXcremLyYVavbcHfNwoiows7NOHTvNO75uKP/nZAWV1XGR6MSYrnOSAbvjRiJCqjTesinMFreiUccIyFpagUs4xmrMadiS/DSAHdv7k=
Received: from PH7PR10MB7730.namprd10.prod.outlook.com (2603:10b6:510:308::13)
 by LV8PR10MB7967.namprd10.prod.outlook.com (2603:10b6:408:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Thu, 17 Oct
 2024 15:56:03 +0000
Received: from PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411]) by PH7PR10MB7730.namprd10.prod.outlook.com
 ([fe80::7ac6:2653:966f:9411%5]) with mapi id 15.20.8048.017; Thu, 17 Oct 2024
 15:56:03 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: linux-security-module@vger.kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, ardb@kernel.org, jarkko@kernel.org,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, mic@digikod.net, casey@schaufler-ca.com,
        stefanb@linux.ibm.com, eric.snowberg@oracle.com, ebiggers@kernel.org,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: [RFC PATCH v3 05/13] clavis: Introduce a new key type called clavis_key_acl
Date: Thu, 17 Oct 2024 09:55:08 -0600
Message-ID: <20241017155516.2582369-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241017155516.2582369-1-eric.snowberg@oracle.com>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:32b::26) To PH7PR10MB7730.namprd10.prod.outlook.com
 (2603:10b6:510:308::13)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7730:EE_|LV8PR10MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 561adca1-2e0f-4d1d-4814-08dceec42dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jy/pQp395PJexdwz5+rWcbjA7VCBJO/OCJCq5d0+BE3zVL6mqrtfnYWiLyEv?=
 =?us-ascii?Q?585+8KkOH6A8JuydNysdVuwDgnE7ww+j+2v3tyxyF+KgaDsgdHIpJRcmd3IJ?=
 =?us-ascii?Q?JFE07NsooC4DfEhTELxpFcUP2vAQw5z62wTviFat9odn/JakJpVfYj8/R+uo?=
 =?us-ascii?Q?oGrLacY6dwn+P0kjJBiPBdNHxoCDpBb7p/D5UIA0xREWiv2EiK86rkO+9770?=
 =?us-ascii?Q?4q+lv08N6ZE+/xL/0D49Knj6RcLkHNqkEKkb1iZeFInCa8B3iQtk8JXwZ1O7?=
 =?us-ascii?Q?1SleY/6HMwrmycPkGga/PUKB+TbNdFy221viaxmnKSRrmxjHVE3mQKQG5Oic?=
 =?us-ascii?Q?kr6jEwtMSWHAA5l59Mu4ISmatkcYGmFydKjMijF60tKrZSKRncDTum6JxDNQ?=
 =?us-ascii?Q?1j8peVANOBjbCPsfCdStpUtOg/b6u+RS03BDjKaS2wLgeueBYRiTElLHNip6?=
 =?us-ascii?Q?YFcyyqc+C+iCu9k82jFVdl51FbjjM65G0LAvvaJVdUJGtMxJ24H9NNRl6nq2?=
 =?us-ascii?Q?TbLLVTQLayhz3G7KMOwf1w8kUttleYjkCSEyIs6s1y4S/XoL5nsPXkNkNewO?=
 =?us-ascii?Q?Xcwisy4jbMCJTA5c9TSQYv54JDhYmRJpIg2ws1/kbdI6f/YXr6jFCUB/Xx29?=
 =?us-ascii?Q?ZPIOG1J2fjh7arQrXS6/zOLl80xif9cpOFg3Jg4f6qOXKxmf6uvg+2ma0K3z?=
 =?us-ascii?Q?ZLdMTsbd+X8JN4lcIEqI92h+GNYNkPoASqFqBVqJuivmDhQ+u01Px3lfkMX9?=
 =?us-ascii?Q?Bs695fxL5h3Ho/LPYGmuCdkTs8oXYM8U/93N/VEZd5gkLWk5Kcf3CAbBabKN?=
 =?us-ascii?Q?0ou7ZZypcPh/w1xRmLCNRb31/0EqGWK39aUPB/fimv0VXHQuNz2uEJqQwxWZ?=
 =?us-ascii?Q?RH4DyPnXLkEMFsPUeEz7uGPbyAm0HY7VuTVhtzGpl17YvGzztTKolR/mhHDz?=
 =?us-ascii?Q?rqJwwnj833ky1bk8Qekqj7K6GNJA1hb6GTTGaxCuhKoWziHYRbqTuJ6cLHcz?=
 =?us-ascii?Q?tYQVSfbXe3X6VanVC9kauqEEaBwWFH9DuRCePI2AB/1+RGH3S8DTqWkk5JeF?=
 =?us-ascii?Q?36UOaOXCHpysiH3yC2NpzqCs74akK9UPCIgipTvjcX4pB/Rvqj1XcamxPTLE?=
 =?us-ascii?Q?mQsoFqMncr/rWtrYqETkA3U89w5QsXQ6Fp++jMT1edhvcvgliL4kWVzBSojU?=
 =?us-ascii?Q?otQgBsZYO3wURKi2ejrAo1z9uYIUj+c67ZSS4GFYvplO/zTNEsnALMKURBei?=
 =?us-ascii?Q?uC1fIUWt4QWLm+ugk4i92nxtUqj9Kltzt7uom1Ga8MCNpxpL4DaZ/9vu3+9M?=
 =?us-ascii?Q?7PrhYZ742RE1kjFe+wI68bdx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7730.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vWrMOA+mQweI+uRZ9n2zWz5ZbWnfjT+chN/WsOQ7mqlg0NLQs1tUMR6NvVoz?=
 =?us-ascii?Q?eeBNUuzU+7hacBqWtTYFNu+68NJeS/XjdqqUjFJ2rdVZxHd1cIMSPNKX7QQH?=
 =?us-ascii?Q?FGQTDs1WXSHAmgIql1qPQNDsStyXJY62zboHUkoVbC07D4w65RtcMP5OKi2X?=
 =?us-ascii?Q?jHGZt1xJR67EtBOdTNhmjVTIRH1q5wifSUXtid9zlVyg21pQ22+LmHi4kdwE?=
 =?us-ascii?Q?lAyp2WGdh2+bX/MgfkYQs55M1Q2oEizyDlM6/3Ptx4u8iHpm8tnmtS0NxN6k?=
 =?us-ascii?Q?VnWq33+sGOxQ6/j+K+nfD9qOT3WB24SMzqkQ9hvspu7G1GxeWKvgutmS5RO1?=
 =?us-ascii?Q?K88Xh7WOVhWR5t6+U/A5IRjVkNs8dvlC5XhBsd2/bXwk5uDZrjQEc9I/Y7M1?=
 =?us-ascii?Q?ncC3U1wx559l7CBk0mpYqXEVMPvbfBibe8CT0iF+uXTCvwycorRVaknKr519?=
 =?us-ascii?Q?URxOORG+pFj6ptwAzYgunW8olpsU2hfyRXy8c/JO9EX2mmpUeorPDSxkWrf4?=
 =?us-ascii?Q?MEJujzxgZI51EZR+gmAJoSjcmGH+86qhRbgogC2yqUb+ol7snSRcFTEba6Ui?=
 =?us-ascii?Q?3ZhlvexWUCcqtHmRRmjrMC88wUgxIZiEO7zxVwW0ltC+z+CmrfNcDClbO3CL?=
 =?us-ascii?Q?kWSiqkC5dY5Ch0EFqBnEdGBJAKDiyTErWeDHNhe85lVMb4XVfhgD+2B9H8ot?=
 =?us-ascii?Q?U8fUQBeS8VTFosn7KphcvFbGm7xeasKR51HlKKtvOBPlCTc2w2/Z5AAUSPNA?=
 =?us-ascii?Q?kBsm7GInUuM6pYdY+deQ0FdLdLt8jkeu3FGyOF0+5gh7NIdNc+QEKqEOz13r?=
 =?us-ascii?Q?aj9FFAS8jwOMosSa062VaZTVaWWrZF1uusUGMPKcbZjy3QDjffYcxinwv7rU?=
 =?us-ascii?Q?el3l/MzQo2Swbygae2rLTuHZR5yra2qOH4dxGK9W1z3nYzi6zBC998JxVows?=
 =?us-ascii?Q?rWK1wGBehP70fCbttNg58+0Sg5B3ds+eDXx+FkF8+KoxV9FfdISjFivtSUUh?=
 =?us-ascii?Q?CFq7UW1WHwACO56Awl/5r+Ap7WtODQJtdyqw7Ha8lGHJ3S2+fpnxGBwCh7h9?=
 =?us-ascii?Q?VyI7cJGNEBWFu1EFo888L9TK73sZqvH2lm1OfXaj4czMorUFiEgnfqyYR73V?=
 =?us-ascii?Q?CdiIM+gNbEZNw2OU6FDNK0xJAy+0HSZwRKYtygMAvTiTB9OCR+UQULoCKYYl?=
 =?us-ascii?Q?IUE+cYKgeSxtDL4pwI3h7HVC5Q6CCfJ8EhidjBvI+3jFkcWVJ6tyU9YvL4ku?=
 =?us-ascii?Q?Q7GowfYCyYUuS2cIf9u7GAkiqTvhbUOisFuMN9uFQFlWozRr+lc2RoYxssVh?=
 =?us-ascii?Q?pCz2f4O6ts2FmyYkYyDzaP0NvAJi3unWoeUJjzIPauxP7HZ1fSCv6hQBqTVn?=
 =?us-ascii?Q?DdVjf1uGhlJNXQACjDxo4vOt1rYvRQD3NSRqbU1C90aubwVNX5cCST9bNbW1?=
 =?us-ascii?Q?EFl/nPa+cwMmvLEEGu3/fUlrIqufwMSeuEhUeDW5G7oOhbrTZaOX2GOP8yw0?=
 =?us-ascii?Q?7MuE2Ie2ZhhiujdX9gGXhEmS5iQwTyCmYIYcJEf03YSTwZ3ltBfjhdzIK0LL?=
 =?us-ascii?Q?YkMvaa0vY18zDzj+idE34yuVP1Q5Xyt29xInUq5vtxw8wBt0Itihc5xI9Fty?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wk9tTXYdjlMJo2YZ5eqGcCs4UNDRDU5no9JQlpj8y52pznQBFJ9ibRfI/CfhQ/zJyJpMYI64eFjPzf32D6SGREhWJKYUwKpkgaqJKRv6dLzrhktaMG5psdb2fdIf2w3MSDh3JUUrw/Nzbm9jo+doIftxi4qHunXIRyDG3XanpUeWHBF9zwwZ2bDyMNk+nqKpKGrztaoQBKUts4/rFtrMusAXjGfNIFm9h76gTaFUMQ25mctP3rGcuJ/qZ9XAAuB2WfYsjeRX4ZqqqFALK5FImBTltuID9rECfpFHqpyMQoTzgTkbESOm7Z1xHZ9PjhaXVpDaV5UU1OYGh2TFbTgClu0oVos0QUkw99kEg+XjVptQhYkuESbxdTfjheHhIoHTAlkODNV/7aGYwi7i9eD63bOJNbJP39cIlPg5X5nKACcAFpQU7sx4a6dQ7Os3ZRRluvypyy5cKkcNJd0fAeXB26KCjrHTrAT+i+rRfNulS9h2v69/6bXvPvco7qdYbvFnEzw0ykqEWT+ypGoIMW34MEPPD2H2x+vFNAtV3oXVW8G23GTI2pnAzKO8wo8KnaSvN+5yWNDHYbhmXrsbltzYhQnpsCWnWoaNB+Q2Nrgc+58=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561adca1-2e0f-4d1d-4814-08dceec42dba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB7730.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:55:53.0050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgtCMgFh8rxw+kBUh9ZOOgjjwPI+1axjLJictRsV7NR3SFW9ykKXR3K/XYodqTkWIqVqCtBTop5ed8AuY0uV1L34kzDfphpZsBbGGEGcIBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170110
X-Proofpoint-ORIG-GUID: up7HkfDC9HDLAgReCueMol3zl_R-T7Tb
X-Proofpoint-GUID: up7HkfDC9HDLAgReCueMol3zl_R-T7Tb

Introduce a new key type for keyring access control.  The new key type
is called clavis_key_acl.  The clavis_key_acl contains the subject key
identifier along with the allowed usage type for the key.

The format is as follows:

XX:YYYYYYYYYYY

XX - Single byte of the key type
	VERIFYING_MODULE_SIGNATURE            00
	VERIFYING_FIRMWARE_SIGNATURE          01
	VERIFYING_KEXEC_PE_SIGNATURE          02
	VERIFYING_KEY_SIGNATURE               03
	VERIFYING_KEY_SELF_SIGNATURE          04
	VERIFYING_UNSPECIFIED_SIGNATURE       05
:  - ASCII colon
YY - Even number of hexadecimal characters representing the key id

This key type will be used in the clavis keyring for access control. To
be added to the clavis keyring, the clavis_key_acl must be S/MIME signed
by the sole asymmetric key contained within it.

Below is an example of how this could be used. Within the example, the
key (b360d113c848ace3f1e6a80060b43d1206f0487d) is already in the machine
keyring. The intended usage for this key is to validate a signed kernel
for kexec:

echo "02:b360d113c848ace3f1e6a80060b43d1206f0487d" > kernel-acl.txt

The next step is to sign it:

openssl smime -sign -signer clavis-lsm.x509 -inkey clavis-lsm.priv -in \
	kernel-acl.txt  -out kernel-acl.pkcs7 -binary -outform DER \
	-nodetach -noattr

The final step is how to add the acl to the .clavis keyring:

keyctl padd clavis_key_acl "" %:.clavis < kernel-acl.pkcs7

Afterwards the new clavis_key_acl can be seen in the .clavis keyring:

keyctl show %:.clavis
Keyring
  keyring: .clavis
   \_ asymmetric: Clavis LSM key: 4a00ab9f35c9dc3aed7c225d22bafcbd9285e1e8
   \_ clavis_key_acl: 02:b360d113c848ace3f1e6a80060b43d1206f0487d

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/clavis/clavis.h         |   1 +
 security/clavis/clavis_keyring.c | 173 +++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

diff --git a/security/clavis/clavis.h b/security/clavis/clavis.h
index 5e397b55a60a..7b55a6050440 100644
--- a/security/clavis/clavis.h
+++ b/security/clavis/clavis.h
@@ -5,6 +5,7 @@
 
 /* Max length for the asymmetric key id contained on the boot param */
 #define CLAVIS_BIN_KID_MAX   32
+#define CLAVIS_ASCII_KID_MAX 64
 
 struct asymmetric_setup_kid {
 	struct asymmetric_key_id id;
diff --git a/security/clavis/clavis_keyring.c b/security/clavis/clavis_keyring.c
index 400ed455a3a2..00163e7f0fe9 100644
--- a/security/clavis/clavis_keyring.c
+++ b/security/clavis/clavis_keyring.c
@@ -2,8 +2,12 @@
 
 #include <linux/security.h>
 #include <linux/integrity.h>
+#include <linux/ctype.h>
 #include <keys/asymmetric-type.h>
+#include <keys/asymmetric-subtype.h>
 #include <keys/system_keyring.h>
+#include <keys/user-type.h>
+#include <crypto/pkcs7.h>
 #include "clavis.h"
 
 static struct key *clavis_keyring;
@@ -11,10 +15,173 @@ static struct asymmetric_key_id *clavis_boot_akid;
 static struct asymmetric_setup_kid clavis_setup_akid;
 static bool clavis_enforced;
 
+static int pkcs7_preparse_content(void *ctx, const void *data, size_t len, size_t asn1hdrlen)
+{
+	struct key_preparsed_payload *prep = ctx;
+	const void *saved_prep_data;
+	size_t saved_prep_datalen;
+	char *desc;
+	int ret, i;
+
+	/* key_acl_free_preparse will free this */
+	desc = kmemdup(data, len, GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	/* Copy the user supplied contents and remove any white space. */
+	for (i = 0; i < len; i++) {
+		desc[i] = tolower(desc[i]);
+		if (isspace(desc[i]))
+			desc[i] = 0;
+	}
+
+	prep->description = desc;
+	saved_prep_data = prep->data;
+	saved_prep_datalen = prep->datalen;
+	prep->data = desc;
+	prep->datalen = len;
+	ret = user_preparse(prep);
+	prep->data = saved_prep_data;
+	prep->datalen = saved_prep_datalen;
+	return ret;
+}
+
+static void key_acl_free_preparse(struct key_preparsed_payload *prep)
+{
+	kfree(prep->description);
+	user_free_preparse(prep);
+}
+
+static struct key *clavis_keyring_get(void)
+{
+	return clavis_keyring;
+}
+
 static bool clavis_acl_enforced(void)
 {
 	return clavis_enforced;
 }
+
+static int key_acl_preparse(struct key_preparsed_payload *prep)
+{
+	/*
+	 * Only allow the description to be set via the pkcs7 data contents.
+	 * The exception to this rule is if the entry was builtin, it will have
+	 * the original_description set.  Since we don't have access to the key
+	 * within the preparse step to determine if the entity is builtin, let
+	 * it through now and this will be checked in the instantiate step.
+	 */
+	if (prep->orig_description)
+		return 0;
+
+	return verify_pkcs7_signature(NULL, 0, prep->data, prep->datalen, clavis_keyring_get(),
+				      VERIFYING_CLAVIS_SIGNATURE, pkcs7_preparse_content,
+				      prep);
+}
+
+static int key_acl_instantiate(struct key *key, struct key_preparsed_payload *prep)
+{
+	/*
+	 * The orig_description may only be used for builtin entities.  All
+	 * other entries must have been validated through the pkcs7 signature
+	 * within the preparse stage.
+	 */
+	if (prep->orig_description && !(key->flags & (1 << KEY_FLAG_BUILTIN)))
+		return -EINVAL;
+
+	key->perm = KEY_POS_SEARCH | KEY_POS_VIEW | KEY_USR_SEARCH |
+		    KEY_USR_VIEW;
+	set_bit(KEY_FLAG_KEEP, &key->flags);
+	return generic_key_instantiate(key, prep);
+}
+
+static void key_acl_destroy(struct key *key)
+{
+	/* It should not be possible to get here */
+	pr_info("destroy clavis_key_acl denied\n");
+}
+
+static void key_acl_revoke(struct key *key)
+{
+	/* It should not be possible to get here */
+	pr_info("revoke clavis_key_acl denied\n");
+}
+
+static int key_acl_update(struct key *key, struct key_preparsed_payload *prep)
+{
+	return -EPERM;
+}
+
+static int key_acl_vet_description(const char *desc)
+{
+	int i, desc_len;
+	s16 ktype;
+
+	if (!desc)
+		goto invalid;
+
+	desc_len = sizeof(desc);
+
+	/*
+	 * clavis_acl format:
+	 *    xx:yyyy...
+	 *
+	 *    xx     - Single byte of the key type
+	 *    :      - Ascii colon
+	 *    yyyy.. - Even number of hexadecimal characters representing the keyid
+	 */
+
+	/* The min clavis acl is 7 characters. */
+	if (desc_len < 7)
+		goto invalid;
+
+	/* Check the first byte is a valid key type. */
+	if (sscanf(desc, "%2hx", &ktype) != 1)
+		goto invalid;
+
+	if (ktype >= VERIFYING_CLAVIS_SIGNATURE)
+		goto invalid;
+
+	/* Check that there is a colon following the key type */
+	if (desc[2] != ':')
+		goto invalid;
+
+	/* Move past the colon. */
+	desc += 3;
+
+	for (i = 0; *desc && i < CLAVIS_ASCII_KID_MAX; desc++, i++) {
+		/* Check if lowercase hex number */
+		if (!isxdigit(*desc) || isupper(*desc))
+			goto invalid;
+	}
+
+	/* Check if the has is greater than CLAVIS_ASCII_KID_MAX. */
+	if (*desc)
+		goto invalid;
+
+	/* Check for even number of hex characters. */
+	if (i == 0 || i & 1)
+		goto invalid;
+
+	return 0;
+
+invalid:
+	pr_err("Unparsable clavis key id: %s\n", desc);
+	return -EINVAL;
+}
+
+static struct key_type clavis_key_acl = {
+	.name			= "clavis_key_acl",
+	.preparse		= key_acl_preparse,
+	.free_preparse		= key_acl_free_preparse,
+	.instantiate		= key_acl_instantiate,
+	.update			= key_acl_update,
+	.revoke			= key_acl_revoke,
+	.destroy		= key_acl_destroy,
+	.vet_description	= key_acl_vet_description,
+	.read			= user_read,
+};
+
 static int restrict_link_for_clavis(struct key *dest_keyring, const struct key_type *type,
 				    const union key_payload *payload, struct key *restrict_key)
 {
@@ -28,6 +195,9 @@ static int restrict_link_for_clavis(struct key *dest_keyring, const struct key_t
 		return 0;
 	}
 
+	if (type == &clavis_key_acl)
+		return 0;
+
 	return -EOPNOTSUPP;
 }
 
@@ -93,6 +263,9 @@ static int __init clavis_keyring_init(void)
 {
 	struct key_restriction *restriction;
 
+	if (register_key_type(&clavis_key_acl) < 0)
+		panic("Can't allocate clavis key type\n");
+
 	restriction = clavis_restriction_alloc(restrict_link_for_clavis);
 	if (!restriction)
 		panic("Can't allocate clavis keyring restriction\n");
-- 
2.45.0


