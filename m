Return-Path: <linux-efi+bounces-1157-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9148FBE49
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 23:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8FF1F24BE8
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 21:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D46514D428;
	Tue,  4 Jun 2024 21:48:21 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB714D2B2;
	Tue,  4 Jun 2024 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537700; cv=fail; b=nD8uN70vLUFVk9oXuWnBu8nXqmSFK3MqRGz2fvxfr5I/hrk1ZqiqnZUD9+NMt4mzVxhdaOQkXDwJWtrBnf6t2lh8lqQccynw3x1m4LPj56Kt7b9oaenoCqeIfEft0EGuw5ZVjtyCfM78qbOUXct1pW4iyDXngS3BY0Mj0KpVj2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537700; c=relaxed/simple;
	bh=qVCOCY6puH+7MYn9K10GlRaQ0ZJlpLvTwkkzq/xuRjc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qa3h8BqXc1SU/hK88YM+uLgumeyHYPshw0w7I9LXDo+S8XP56m/DNIh/2CwGzybFrihMF8SNtvFx3NwXOfETSo3g+VjGHHWNk2DhiBbH9GViIrCB3/GqR7nYMxJz7JFMG7TipM14X8sTXZcIYL0copWTa7c+Uci/UHJf0324lFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454JCq79032521;
	Tue, 4 Jun 2024 21:47:39 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DVa6hus7nyy5Y2yxtdHY6ILpSZbAHUORHxMlwj2tIPRE=3D;_b?=
 =?UTF-8?Q?=3DAYwJ9LxfTG7VRDo3yfFdeRyGB5mQMzb2oesyHctsCp0f0tpZSg3Qz3Hg84Js?=
 =?UTF-8?Q?WsLCEX6D_5/VPMXy19ECrlDyRyjxQmfVynGWReKBc5Tfr0yGyyRATAqXI4sZJgh?=
 =?UTF-8?Q?5miOntDmNo+z6O_HRsPVNKnVkEFbjs2nDTmOqJDxCvKJap/AgNEFoXrfbdXJd1r?=
 =?UTF-8?Q?TFU3n1Y7LbE1h06c/DkM_7fWCHcLz1J7SI8uO13V+FlLAvsdI7Q0yhPHaLFKAk6?=
 =?UTF-8?Q?lEwaJR57357Guts7O0axMITZgE_0FUP2VLQLxbZhiOEbzD72gfdWR+kTWMzGgMU?=
 =?UTF-8?Q?XE8Tu3znq9m8J5qP2Cgclx8BgSiMWFEw_8g=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv6u605e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 21:47:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454LGlYV016562;
	Tue, 4 Jun 2024 21:47:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsaq2f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 21:47:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPixRPwqDln2ryXacVapZgXkdqR4S7eaZ/cSONUl2wUYRjyZlgCUmElImMrESsomE0NQa4DmIjC0etB2hpGpTQ4F7wMDlDWtLAkJiTy26n4+BqvtIIwMu5nlI5DTcePg6SdE1Z29NCfKNu6meQb3j/Jg7A6R8wukdYXufUYs97J22l69O7EYAjFq5evrjmtbAToqgMOVAoozYsIaWGY6IKhFoGwb7s/tcBLjP5oD/ZAt82//RgVfWSpREyFQGlQaMnVoVCjbpfhCUIDgiRl84qET0u1YIV/gIgwSPOr0DcilcLizi7jAx2uYEEZ2NvTnXwY89CVYgjkbz27aPjgt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Va6hus7nyy5Y2yxtdHY6ILpSZbAHUORHxMlwj2tIPRE=;
 b=PVMv4hWWR3i7iJl6Xg3/cpnjXgPB26vVWDToKbkX4q1kgtyCJy1kCVYXRsNlYUXKFlie2sYNQ7yCYr818XWsWC/cQTDeDYhPWMKhvfkBzaGi4+ZHANX4Ty+Z19szSggkT6Lp1cfjcZTTYXbQc7oLqQVZ0wcTP76mXzc3j5PiW2RhImR0DEBUx3Z4BmAodvpaaaK1+WGeyV/Gk6dTYnKxhL7lp6VDIgn5XZN8fFXzWQRsjMU01sop2qNy4WlwUzefMh3a+pKscOOp1MU+ruVE13QIwjmQjJvBYHiqyXH9NEV0TOF0naZDSqk2f029Y28cCjSpEnOe+HXRlsBWEiqjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va6hus7nyy5Y2yxtdHY6ILpSZbAHUORHxMlwj2tIPRE=;
 b=DRSRGQJAJF2vg028ZARYX1wFFPeCqO7rPBwccB7Kl0DpXTtIz9jciX3W0O6LGc36wHEdat46KU6ymsrJ0veZxfglmB0LLQk4ZNV8nBgJlImlpJfeB8n38sXjj8H3O5+uggFIh4FY4n5lVIj+SG7PX2YhhFQ56vPvJQXfWxaZbYA=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CH2PR10MB4183.namprd10.prod.outlook.com (2603:10b6:610:7e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Tue, 4 Jun 2024 21:47:34 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 21:47:34 +0000
Message-ID: <d95d73d2-c728-4da2-b68e-d2e39a518ae6@oracle.com>
Date: Tue, 4 Jun 2024 14:47:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/19] x86: Secure Launch SMP bringup support
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com, ross.philipson@oracle.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-11-ross.philipson@oracle.com>
 <D1RI46IG5GSA.17H7M0DIQGRQ0@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D1RI46IG5GSA.17H7M0DIQGRQ0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0301.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::6) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CH2PR10MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 5989da17-c904-452d-6cfb-08dc84dff136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U2hzOG9QNUpaSVhqQ3o3a2l0VCtXNUpjdjBkZjZ4OU4raE50amtNQmtjdGxX?=
 =?utf-8?B?enlkNEF3dWhmVFBPbnF4cnRuRVNaVCtJaHYwcUxyUEhGTVBDNjVHOGIvY1ZJ?=
 =?utf-8?B?dUhLSVhPZmkyM3FIUTFUWmRYajNBdWQ2QjNpYURhQjNBbWJKai9rUzNkWWlM?=
 =?utf-8?B?T0tLOVZQY1BWQmNGYUkvNE1wVklvVUJscEg2OGdvQUJ6TGxGL2pDTnZYWFFB?=
 =?utf-8?B?RFVCdWQxY3luSnVBeUFzeEcrQzk0ckhFcTYxZVFMVjRnTHF5M1VkQUJJSzU3?=
 =?utf-8?B?NDdxaGIwZ1R5QXBDTU5mMnB1Q0VKRjJqU3BBdVlTUjBZbEFRS3c1NTJTbFRV?=
 =?utf-8?B?bmRObG5SUUlWSC9WL2VjU283T0xXMzE1RnNNbEFwTHJSUWx4cUJUT1lHRjlm?=
 =?utf-8?B?cERPeXZsOHl4OGpzTWZqNUNMa2x1UnpmZTZrREQwWWp5VFRId1N4eWNXT1Nl?=
 =?utf-8?B?cStRY0ZJUGp6YUFaMk02QWVpQlFjWGs4UWdKSE9hQXhGUFdKcUpXZ0Z3WGg2?=
 =?utf-8?B?OURvOGpNemYzU1NNL1ovcFgxaW1NbDZCa1pPT0xZK0NJejgvZXA5TWc4M1kr?=
 =?utf-8?B?SWtnQURjWjRtai9oNzFoYVQ2aHZ5Yjd4UUluc0ZVQUlmN3hZN2NjTXFQNHg1?=
 =?utf-8?B?MXErMHRVYTI2WVBxWEVOS1JPTDdteHYzR0lyVE9WY0E1d1lRR0J1LzUvUkNm?=
 =?utf-8?B?S3BmeERmT0VDTUlCUTdJcnZVZnZhc0hZYms2WG5yQlFvVnh6NGF0MzNqODk4?=
 =?utf-8?B?d2FZY0FaYk54bVZ3aXhZYmIzblZYZG5uaTI4QlhBeEc4eGRvaTJyTWNZWXJl?=
 =?utf-8?B?Wk1YdU9IRDFMd3puS2pTZUNVb2R1MS9mSVFPVWQ2LzBNV3dSVE1DSlNOWStE?=
 =?utf-8?B?UkhoMlQvZnZNRHpoVWh2aW8zdHRQQms2Q2tTNkJEOFNhaktWb1hpTWZRZTZp?=
 =?utf-8?B?RHdleTNDM0IwU24ydDgvNEVuMk1mRFJOVndKakhJdjNTZW8rYkdOMldtT0Jy?=
 =?utf-8?B?YlRMaG53ZmJvWlU3R0crMzNGNUNCTGl2QVJtdG9Pc1BIWE11THBNRWxUckRU?=
 =?utf-8?B?WHA0dld6SjBYajB0dklaMU1SRTRuc0QwQmhKWkVBUEVXZmJZQzlvSWxOdGto?=
 =?utf-8?B?VXVTVG9FVEtxTzF6eUo4TmpMOCtKajc0ektOaE5NQU5XVzd6QlBTbmdPL1lu?=
 =?utf-8?B?Q3VYT0JDaDRaL2xObkRPcUFrUGlqQUdGOTRneFV5MTY5WW5halkxUVVBbGFl?=
 =?utf-8?B?MUg1TmZrdVB2cXRMdEVwczRJU3F5SnpkeDJCWWJRbXlEWEpMbUNMa2l0Uk12?=
 =?utf-8?B?YS9xam05L3JiZS9oaFV5VXF0Q2hPOFMzSHlkaWt0NmlRazhJVGJOdFJ3N0xn?=
 =?utf-8?B?N1JSQ0xOQjgwTzBUNnAvMmdkUVhQQ1EraVBDc2FIcEw2WFBPSjJkQ3U3WDh2?=
 =?utf-8?B?ZW84bUhNaGF0RlA2SjRvdVFldkcvQzUzWUR4dVV4QTlWd1VCUnRBS0FRY1Zr?=
 =?utf-8?B?VC83OG9aMGowWEtYSU1kdzRyQ1VzNkR0anNLdUdpZnBKRXd1YjRUZ0NxcnVY?=
 =?utf-8?B?MzFIZ1JmcTlUUk5mdDNiOUxiTWRSZ0UzOElTQ3pwTUlLVzNzbVNhRk5mUVJw?=
 =?utf-8?B?VThlRWNSdmJQNlRXT1VKRHRtKy95aENSWVYyTFFJVGFabEF4aFJrSTVzS1Qv?=
 =?utf-8?B?V0JqcjVkcy9qK3hwcjJCWWtrUVZhM2QwMDQ5ZTU1V25ybmtIblJBYXVnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WnJiMjNBSy9SS294TklvVmdkbXJEenozY3N0YlZ2ZnI3MXU0U3IwMXYxRWJp?=
 =?utf-8?B?OUJ0S1BiQ21pMzhPOUlWWG9ueENNVFAzMElPNGxHOGp6NDBkRTBxWVZKSGZ5?=
 =?utf-8?B?SHorYTRVSGxWSnY3T1ZLVk5kenBtT3l1QlVZczZ1bnBnMkNwazNCc3doQzd3?=
 =?utf-8?B?YTJZRndKYjh1U3gwY08zNVp5elhWUFhTRmplQXo5WkVsN3BXWGs3TXdxUXg0?=
 =?utf-8?B?RlY2RGNmaUFrYWZOZlY5VzJjTWNVRXJkd3FBVkdZZG9NOS9nRDU2RUdxZjZR?=
 =?utf-8?B?aCtwdkFxYWpTVDJOZEFwM3I3L0pIN3lIM3U5Y084UUZnZjhxN2FicW9taUdP?=
 =?utf-8?B?NGkvdWdEeVNhNkwzN013VWdROXRYdkhodHhEUEIzM29yV01DcHZDVFp3QlZZ?=
 =?utf-8?B?MVQ4eHZGUjNXUHZvTTVUZVU1YUxIdnppSGZFRGFVMWl6d0dVd0ViUENYSE5v?=
 =?utf-8?B?Tjl4RDZWOEFmVG5CdU5WZXEySWp3Y2ZtWkF0UTI4Mk5LbHB3bHZ1Z1g3VFMr?=
 =?utf-8?B?SnJ6V1VZQm1vNjNTTG9ZV1hwTTh0dk5iRjdYbXo3bzBhdThDNE9uTWhxbGh4?=
 =?utf-8?B?V3NGb2dNVzg5dHpNbWJHMEtlU3ppUVdNN2k0bnZIK1BOc2hYUUMvVXI5dEQ5?=
 =?utf-8?B?WVhPdkFRWElSZkdzQjdjN2tYRWRvZHhZYktPR09XK0pKNFl6L0pmWS9Vbm5t?=
 =?utf-8?B?bWFNYWhiVEFwZCtkWUxIdmtnamg1VmRZUURmYUd1dFhBVTloTCtHM3NQOHVQ?=
 =?utf-8?B?WU5MWTlTTURtSHRWZ3pjUWNpbkdDNm53MnBuMWlOTS9TOS9GVktVa1hLNUo2?=
 =?utf-8?B?eFIyZERvWC85RFdObGtoNTBQblM5aW1rOGRQdUk2b1FyQXJoRys1Mi8ydDRl?=
 =?utf-8?B?UkRuT1dpNk5Pa1VLdlpZSVBLQUZrUWlXMnlnWDFVY3lRL0pFaHpJM2NmNzlx?=
 =?utf-8?B?Z0J6R1VGWHFvRWk1Q0pDOW5VN01UR0I1VUw3SktVRjBKT2puR1R0UURTNXgy?=
 =?utf-8?B?bFNPLzA0encvTURXQXAyLzNwT3JWdkpkWFJoTW5FLzBZOHBaU0IzblcwZEtO?=
 =?utf-8?B?Zk9wTHkzQ0NtYzdxNTFNUWJjUWR2azBCNm1xMUVxZmJJT2RJUFFSQjVKeXZW?=
 =?utf-8?B?ZnJmZXozaUhyYmJVN3lneTFVSVdCVEdCTkxvdVBKWGkwQ2EyNHJSemVGVmRU?=
 =?utf-8?B?eWZzRzNrWG5iRUJwTWhFdFNnTHV4SlZHalhXOWk2UDl5Ky9iNkN6SXFkSktp?=
 =?utf-8?B?SDNhUWZCY1V4MGZsTncwK1FLZnd1TFFMY3VnS0ZiL28yOHNCZ0FtU1R1OGxE?=
 =?utf-8?B?UmFtN2N5WCtGZnZXWmg5NGcrMEl3K0Y5R2RrZUJLMVFoNVF5RGJPRUNsN3hq?=
 =?utf-8?B?S3MxQ2dBc0dINnllVWpJRXhSN1BCWXB6MHpEK2ZLSWl6ancya3ZQVmVidCtD?=
 =?utf-8?B?dW9vWFhKSSs3Ykp2U0ZoZ05NL2NaTjhabnBRbzZQMEhZNXZSL0gyWlBxeEtJ?=
 =?utf-8?B?bUdac3hDQXdvWFRSRTRMU2liTExTZlZ0STZWN2NKcmw4SjJXUXpMZDBLVkZh?=
 =?utf-8?B?a2VPZmtNME15MjRWcGJIY1UvMFQremJqOCtGSTVoM1NHT2lGelRFRDFlcmdB?=
 =?utf-8?B?ck1ZUW1QV1JUdW9FZmJodHdrTTVmRGF1MUk2Y1ZCbkx2cXRSL1RJSVFTekVX?=
 =?utf-8?B?eEVxTitIR0NycHhQSU1qV1pZQVZsMUtrSUpaR2FyVzQwTkJWU0ZWbmFDTDZQ?=
 =?utf-8?B?SDJ4ZUsvekFIZWFZUXFKVFh4QUg1Q0x1YjhlcUdYdkxFdjJmWnJ2WE0zcHYx?=
 =?utf-8?B?S2Jja3BuZ0tMYjhoUUI0cUhjMW5URTRrbWZXYStUYnRzRkVVYmVOV3gyOXdO?=
 =?utf-8?B?VXRoWlB3NStGYmRCS2NJb2dnWGtZSG1Yc0xiT1FPVyt0NitXdEpudDhvcWpq?=
 =?utf-8?B?REc1WVkyemMzVGhFL1hTVmU5ZnFWUEkwTGllQW5lSlpvLzhRVmFtYTRCKzVU?=
 =?utf-8?B?Vk0ycmlheXg4NWJzOXE1L1Bvcjg3WlRmN1Zvek1lQ1BXRFhkTXI2SXl6WURy?=
 =?utf-8?B?WDBsdE56S3lHOVh5OWlFQWg3dkNkd21zRndCUSt6NGx1RlFxb0RpLzFqQ0pV?=
 =?utf-8?B?cjA4eWpzQWhzelFVOEZ2Y2FFbEU1eExCVkxKajdjYXd0TTZzck1qUnEwOHZR?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cClLsQyAGgkOYXzomJwuPL7pW7cMqm9blNuEY8ypoowlHbVjia8n0NVadJ7drxf8wDv3TVRLqqP1F9huSzJXoSqiRv1J+X17D19Zl/ti63/r7SuoG+sprrPBNIEqEVVFUjvJ1DXcAFmJOnDm059O5b5nyk/tO+HOFuuBbf35tYWF9mnr/OLjYNjg798zjaYakoTAri4YUicW3uHCpiwiFHPWrAOpHv1RBeJfo40tss7wPPgficX/xXUfNCbEbvLyGNTGq44XRFeCt+NjtN4EcAJo8wny7WShUuvYj92Wa7LK3SXS99hRd/1vn3t2WIZWKzOBpRDLsVNMOfV9vya28D56gfYatCb8bkVwEOeqCO7G0UlOL5DbPGb+FMlw1m6aw5kJF5JYR8pi8UD4mQ8mXvXPQeSl3X0tKhsbt5UdQqYKc35kFyFpgx46g+HzraHaobufVEgXKKsZN5LNCHiHfF9OPqDFWN6cS/44YmVzVRyBxXJ/zHTLDZh8KlimW4LBcsilXmcgy8oFHohtimOe3oUiHGZU4eG4hqq7TbVwWkY4QHzo/BTm9EAGZoxaAHxH3BwBZ+FWywkWv2v5qCt851DBmM9RxxkRhGS8SLsHtBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5989da17-c904-452d-6cfb-08dc84dff136
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 21:47:34.0974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Og0TDfYNGhWhc09KJInkG224Yr5FEK0yOgnAmXT05aJR3ILOT+O7m7ahPdznT6GUrR06++QMegjVkf8j9FXp4w1Xo6k+RFC8YRkNIGZHf2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040175
X-Proofpoint-ORIG-GUID: J5WPSzH-kcvCWoa7VGBswKltqcWqX7WF
X-Proofpoint-GUID: J5WPSzH-kcvCWoa7VGBswKltqcWqX7WF

On 6/4/24 1:05 PM, Jarkko Sakkinen wrote:
> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
>> On Intel, the APs are left in a well documented state after TXT performs
>> the late launch. Specifically they cannot have #INIT asserted on them so
>> a standard startup via INIT/SIPI/SIPI cannot be performed. Instead the
>> early SL stub code uses MONITOR and MWAIT to park the APs. The realmode/init.c
>> code updates the jump address for the waiting APs with the location of the
>> Secure Launch entry point in the RM piggy after it is loaded and fixed up.
>> As the APs are woken up by writing the monitor, the APs jump to the Secure
>> Launch entry point in the RM piggy which mimics what the real mode code would
>> do then jumps to the standard RM piggy protected mode entry point.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   arch/x86/include/asm/realmode.h      |  3 ++
>>   arch/x86/kernel/smpboot.c            | 58 +++++++++++++++++++++++++++-
>>   arch/x86/realmode/init.c             |  3 ++
>>   arch/x86/realmode/rm/header.S        |  3 ++
>>   arch/x86/realmode/rm/trampoline_64.S | 32 +++++++++++++++
>>   5 files changed, 97 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
>> index 87e5482acd0d..339b48e2543d 100644
>> --- a/arch/x86/include/asm/realmode.h
>> +++ b/arch/x86/include/asm/realmode.h
>> @@ -38,6 +38,9 @@ struct real_mode_header {
>>   #ifdef CONFIG_X86_64
>>   	u32	machine_real_restart_seg;
>>   #endif
>> +#ifdef CONFIG_SECURE_LAUNCH
>> +	u32	sl_trampoline_start32;
>> +#endif
>>   };
>>   
>>   /* This must match data at realmode/rm/trampoline_{32,64}.S */
>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>> index 0c35207320cb..adb521221d6c 100644
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -60,6 +60,7 @@
>>   #include <linux/stackprotector.h>
>>   #include <linux/cpuhotplug.h>
>>   #include <linux/mc146818rtc.h>
>> +#include <linux/slaunch.h>
>>   
>>   #include <asm/acpi.h>
>>   #include <asm/cacheinfo.h>
>> @@ -868,6 +869,56 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
>>   	return 0;
>>   }
>>   
>> +#ifdef CONFIG_SECURE_LAUNCH
>> +
>> +static bool slaunch_is_txt_launch(void)
>> +{
>> +	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) ==
>> +	    (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT))
>> +		return true;
>> +
>> +	return false;
>> +}
> 
> static inline bool slaunch_is_txt_launch(void)
> {
> 	u32 mask =  SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT;
> 
> 	return slaunch_get_flags() & mask == mask;
> }

Actually I think I can take your suggested change and move this function 
to the main header files since this check is done elsewhere. And later I 
can make others like slaunch_is_skinit_launch(). Thanks.

> 
> 
>> +
>> +/*
>> + * TXT AP startup is quite different than normal. The APs cannot have #INIT
>> + * asserted on them or receive SIPIs. The early Secure Launch code has parked
>> + * the APs using monitor/mwait. This will wake the APs by writing the monitor
>> + * and have them jump to the protected mode code in the rmpiggy where the rest
>> + * of the SMP boot of the AP will proceed normally.
>> + */
>> +static void slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
>> +{
>> +	struct sl_ap_wake_info *ap_wake_info;
>> +	struct sl_ap_stack_and_monitor *stack_monitor = NULL;
> 
> struct sl_ap_stack_and_monitor *stack_monitor; /* note: no initialization */
> struct sl_ap_wake_info *ap_wake_info;

Will fix.

> 
> 
>> +
>> +	ap_wake_info = slaunch_get_ap_wake_info();
>> +
>> +	stack_monitor = (struct sl_ap_stack_and_monitor *)__va(ap_wake_info->ap_wake_block +
>> +							       ap_wake_info->ap_stacks_offset);
>> +
>> +	for (unsigned int i = TXT_MAX_CPUS - 1; i >= 0; i--) {
>> +		if (stack_monitor[i].apicid == apicid) {
>> +			/* Write the monitor */
> 
> I'd remove this comment.

Sure.

Ross

> 
>> +			stack_monitor[i].monitor = 1;
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +#else
>> +
>> +static inline bool slaunch_is_txt_launch(void)
>> +{
>> +	return false;
>> +}
>> +
>> +static inline void slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
>> +{
>> +}
>> +
>> +#endif  /* !CONFIG_SECURE_LAUNCH */
>> +
>>   /*
>>    * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
>>    * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
>> @@ -877,7 +928,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
>>   static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
>>   {
>>   	unsigned long start_ip = real_mode_header->trampoline_start;
>> -	int ret;
>> +	int ret = 0;
>>   
>>   #ifdef CONFIG_X86_64
>>   	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
>> @@ -922,12 +973,15 @@ static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
>>   
>>   	/*
>>   	 * Wake up a CPU in difference cases:
>> +	 * - Intel TXT DRTM launch uses its own method to wake the APs
>>   	 * - Use a method from the APIC driver if one defined, with wakeup
>>   	 *   straight to 64-bit mode preferred over wakeup to RM.
>>   	 * Otherwise,
>>   	 * - Use an INIT boot APIC message
>>   	 */
>> -	if (apic->wakeup_secondary_cpu_64)
>> +	if (slaunch_is_txt_launch())
>> +		slaunch_wakeup_cpu_from_txt(cpu, apicid);
>> +	else if (apic->wakeup_secondary_cpu_64)
>>   		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip);
>>   	else if (apic->wakeup_secondary_cpu)
>>   		ret = apic->wakeup_secondary_cpu(apicid, start_ip);
>> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
>> index f9bc444a3064..d95776cb30d3 100644
>> --- a/arch/x86/realmode/init.c
>> +++ b/arch/x86/realmode/init.c
>> @@ -4,6 +4,7 @@
>>   #include <linux/memblock.h>
>>   #include <linux/cc_platform.h>
>>   #include <linux/pgtable.h>
>> +#include <linux/slaunch.h>
>>   
>>   #include <asm/set_memory.h>
>>   #include <asm/realmode.h>
>> @@ -210,6 +211,8 @@ void __init init_real_mode(void)
>>   
>>   	setup_real_mode();
>>   	set_real_mode_permissions();
>> +
>> +	slaunch_fixup_jump_vector();
>>   }
>>   
>>   static int __init do_init_real_mode(void)
>> diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
>> index 2eb62be6d256..3b5cbcbbfc90 100644
>> --- a/arch/x86/realmode/rm/header.S
>> +++ b/arch/x86/realmode/rm/header.S
>> @@ -37,6 +37,9 @@ SYM_DATA_START(real_mode_header)
>>   #ifdef CONFIG_X86_64
>>   	.long	__KERNEL32_CS
>>   #endif
>> +#ifdef CONFIG_SECURE_LAUNCH
>> +	.long	pa_sl_trampoline_start32
>> +#endif
>>   SYM_DATA_END(real_mode_header)
>>   
>>   	/* End signature, used to verify integrity */
>> diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
>> index 14d9c7daf90f..b0ce6205d7ea 100644
>> --- a/arch/x86/realmode/rm/trampoline_64.S
>> +++ b/arch/x86/realmode/rm/trampoline_64.S
>> @@ -122,6 +122,38 @@ SYM_CODE_END(sev_es_trampoline_start)
>>   
>>   	.section ".text32","ax"
>>   	.code32
>> +#ifdef CONFIG_SECURE_LAUNCH
>> +	.balign 4
>> +SYM_CODE_START(sl_trampoline_start32)
>> +	/*
>> +	 * The early secure launch stub AP wakeup code has taken care of all
>> +	 * the vagaries of launching out of TXT. This bit just mimics what the
>> +	 * 16b entry code does and jumps off to the real startup_32.
>> +	 */
>> +	cli
>> +	wbinvd
>> +
>> +	/*
>> +	 * The %ebx provided is not terribly useful since it is the physical
>> +	 * address of tb_trampoline_start and not the base of the image.
>> +	 * Use pa_real_mode_base, which is fixed up, to get a run time
>> +	 * base register to use for offsets to location that do not have
>> +	 * pa_ symbols.
>> +	 */
>> +	movl    $pa_real_mode_base, %ebx
>> +
>> +	LOCK_AND_LOAD_REALMODE_ESP lock_pa=1
>> +
>> +	lgdt    tr_gdt(%ebx)
>> +	lidt    tr_idt(%ebx)
>> +
>> +	movw	$__KERNEL_DS, %dx	# Data segment descriptor
>> +
>> +	/* Jump to where the 16b code would have jumped */
>> +	ljmpl	$__KERNEL32_CS, $pa_startup_32
>> +SYM_CODE_END(sl_trampoline_start32)
>> +#endif
>> +
>>   	.balign 4
>>   SYM_CODE_START(startup_32)
>>   	movl	%edx, %ss
> 
> BR, Jarkko
> 


