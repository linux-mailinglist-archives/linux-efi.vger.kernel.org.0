Return-Path: <linux-efi+bounces-1148-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D08FBD93
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 22:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7D11C247E8
	for <lists+linux-efi@lfdr.de>; Tue,  4 Jun 2024 20:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2603514C586;
	Tue,  4 Jun 2024 20:53:49 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6937314658E;
	Tue,  4 Jun 2024 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534429; cv=fail; b=DZTw0+8ABydLMtATCvkXr8Nn/zCr2FT8Xz/UZLnpwIskhzm+AcaJjrXd7kwUSTxRUD0nTlg8hxbgj/N8bXZydlvUgEewY9H33VwT1DTSrqNh44wGfnfUnGO+zriKa6jW3bmhOGmB+FDeldY/qwJa5tXALctAfeEsxcWylIDtDgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534429; c=relaxed/simple;
	bh=JFQCwuI3w1E4QamodBiqBzSyVfzgmpYcBtPIo/fzH9c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T97t72zT2s9UKY6rhFqTNEwnBYp4ATzIWwnX6ha3wP5Jf3OiS2UeJurpEmmf9a41nzMp/yL+AS7DpLiklCCKEEE3WrCIco9aA3J0maUVkLgBm66ChIPYenXyF4tvMU/wynXWyEcHPFxIKeg4eylR6HLXDePUX9reetzhGC05E/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454JDTJW028053;
	Tue, 4 Jun 2024 20:53:05 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DFSKs8WeMluH48z6q6RrHBxlRhCwBbsFznMZLnbfoYoo=3D;_b?=
 =?UTF-8?Q?=3DC12IH6szRJOZ1ZYyQOwUrp6iNBqBXteSrhIT6phZZCNkhB98RCSWupJ7Kgn/?=
 =?UTF-8?Q?DySaVvOi_HGeAayuy7gLR0Y7qkKru16MRjqAMJ81Ej2WT1cD1PHRsGnA/ftGiXH?=
 =?UTF-8?Q?7gxnwdBCU+ut4z_cUPPpXkQrLnoylsh7c4HD4hcGM9S4dswaSnEOW9F3b6WQ8ZM?=
 =?UTF-8?Q?VDJsHG07c5iRZxtxaC1P_2lJFob2GvdmONzFAMsUHPFqmdwJ/It09yTSeyPlGJr?=
 =?UTF-8?Q?mTjtkCQtzfZgtzjTrIu2VmhbPe_6Xhdcr+75BgAeO9Nq17TqgDVZWJFeOOzdjSc?=
 =?UTF-8?Q?v1iIBL3idM/kD5vL3ljOwXtycRd11a3Y_7w=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv58dwb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 20:53:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454JW1Mj015646;
	Tue, 4 Jun 2024 20:53:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjcuygj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 20:53:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD+0SsxWgvQw2t9Ynrpgtyp9k1NsDeEtQ1rVcAE1AtUBFcwTRXyc92Ww9LAfW7krXL2hlO3UqRiVqBo+BqwVhC2QDKXqvXnKvAnuABQVjS/oTHbP5+SNf62XwlEQ5byBm+sCqfXPt73UpKWxfoJwA+S1sOQO5otUlFCwvAmlDRBwPSW0FFMY5KZfHXBhQQPtmUn92oWys2TeD0rqglSNiVc2chrm1KBbgn0jAfk/R4j5TqaMV3n6fS8oMiKmpoQ4XFZ7440iiZVMEC5llN5keekZxPkfetcYD/CXMbOLKSLjP5hBFOIgIZNHvFMtMBG05woF2+ugZQFP42vkc0OM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSKs8WeMluH48z6q6RrHBxlRhCwBbsFznMZLnbfoYoo=;
 b=PnL080oKuRwTllpZwiDP8C1xYc4xJtP+9zfgvt+UIDiA0/89NOypFQK1lqDQUoDjsyuZadTdjG/m/GP+hKlM92+rwkoiqm3Os49Qvult7Y9zTtrGbXNjocaEdZRUi3qov3obIIEzL/uW6InCBGUchWxD7xCECOZX9j5zuXbiX1v3wWAPNC/hUbpQoIzgwMI6zhGTUSPka7xKrDygetqUJL6FFnQsHheEdovbKTn++Z4OK0ANDkjQxEyDKNAB3T83WIgBBH74qjxqo3d5fkBoeWg159aU3+kiMGjAhdxgQ8kufDZn8ksmiPM4zZKUq0hNOTbKkLBKLV7cArVDg/o9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSKs8WeMluH48z6q6RrHBxlRhCwBbsFznMZLnbfoYoo=;
 b=rwwRUDqtbUi4uDnp2X0Kcz6iA/bbnDgVFrrFPZVaaqnj8bRTN25nfqN//CIQSMemGbm345qmFFwwSpxLh5Pu7YVg9gbgB6Q6zeVuH3bS/PYTpEl/0PvFJaUrylODDLzPfYS03Ft+fK8pN/BsnHO/wD08jHAsNigtJ0+z2uMcPus=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CH0PR10MB4937.namprd10.prod.outlook.com (2603:10b6:610:c5::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Tue, 4 Jun 2024 20:53:01 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 20:53:01 +0000
Message-ID: <2bc7aa8a-5b1f-4753-834d-1e31140d6fe2@oracle.com>
Date: Tue, 4 Jun 2024 13:52:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/19] x86: Secure Launch main header file
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
 <20240531010331.134441-6-ross.philipson@oracle.com>
 <D1RFYH41E4ZN.2D7LJBAZP71CB@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <D1RFYH41E4ZN.2D7LJBAZP71CB@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CH0PR10MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a126eb5-5159-4339-4afd-08dc84d85240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SHlGRm5lTjVtWlNKSTllcXd6R2JmKzV4Mi84WmFmbGczOGJKZENFUmdyWjdU?=
 =?utf-8?B?OC9lT0JDNyszYnNzZHlmNFRMbElWY2d2UHJUT01nUGJTQjd1NVlsQ3ZjTFRp?=
 =?utf-8?B?eUs2K3RyMDNoR1FORjQ1QzFMZVF5aHhrYnVKOE5BemhTRmpBeUxuN1FDUGNN?=
 =?utf-8?B?RkJpV3BSdk9LZUNzUmZyM3dwalF1YWVWcHQybWdGdDloeU1yeTdQdXRCVG1w?=
 =?utf-8?B?bGtzLzdweXUzS3BzL3FkbzA5eWVmcGZ2WTJ3MUx2MkJwQ3BmWFgwa2RsSW8z?=
 =?utf-8?B?bElTSlBlZHFmYVpvaVE4bnQvV0tYWXB3MEJ1bjgzeDZ2dERYVXJJRHJDVVpl?=
 =?utf-8?B?NVlsZzlkeDFoUHFOZjlkSmtISXdPOXdvQUdtWENPWFQ4R25HbDFPWWlJV3Vu?=
 =?utf-8?B?N0M0M0MyZWxtTmhGaFU1cHhTdjh0dEhLU2NrMlJBS3NZZWJSM1JNSHF4UWhv?=
 =?utf-8?B?dktQK0RtR1UzY3Z6cFJkRUpTTmxyMkxRaVp1M2pib2tORUdOTFhTbGtnNkRr?=
 =?utf-8?B?d1RzQ2o2Qlc3NGFJZFR5KzhEYmw5ZHdkRVJETXZwNjdBeGJnSlVmZ3ZIUkhD?=
 =?utf-8?B?TUg3bVRiNkFLRWpNZVVNdWxUR0srOFlWcnZGZlM0cEFnOTk0SjU0TUJXSkZy?=
 =?utf-8?B?OHlJOEo2OXp6eVE2UTRvNDRWRGYxQ0RBdEcwVkl1ckVneXRYeTFkMWcxdEcw?=
 =?utf-8?B?TXhhYkgvRVR4dm5kWlhWcFN1ZnBpcDhCL291RmU1aEsvWE9JdVR3OWxRbHA3?=
 =?utf-8?B?amFBRmJPUWQzdmVpbXBFRkdsQ1ovUDBTRFVSclBZZDNRRnBnWlZudTNpdjF2?=
 =?utf-8?B?YU5lSVZDMzF1eUxUemdQNTVmSkJtYy9BdkhVSjFFdUdhSXFRcHBoTWxyckhL?=
 =?utf-8?B?QUdKenRoK1FDY2FJRzNoTTJyLzExam9hd01XbDV1dnBNTG4yYVo2NVluNDJF?=
 =?utf-8?B?ZkFQNlc1Y0VVak1jSi9pWmJKQTNLOXkzazhkVW9CT3k0WXlrd1dqMVZtbzhT?=
 =?utf-8?B?Q2JzU1c2cFZES3dMRHRhNkY2K0lNYVM4T0JmemRsMVc5ZDNMVWIyWVBVSy9h?=
 =?utf-8?B?Sm1Oa2ZuaXVDOE1mdWQwREc5TzJJSll3VkxFVVZOK29jOEF1QXdGeFpvUzc3?=
 =?utf-8?B?NVUvbUh1bVpuVWhWcWZ5MGcwaWM3anhNR2RFbjA3TGhiTVhJUG1KeFhHN0x5?=
 =?utf-8?B?M1V0QzN4aWpKbVp3dTY3bkxuc1FrNzBsUElZNVVTb0ZhcVNLTTEva3daelho?=
 =?utf-8?B?eTdjSmFwWW5yZjVzZVVFVE4wa3VQQXNPcmV0TlZnZDU2cEgzb3RxenFoTFFr?=
 =?utf-8?B?cTgzbmdtaFd5RlJGUnJSbjRnVGR1cDBGemdCczQxUFRZWnZMcURHc0tyWURp?=
 =?utf-8?B?Y3kvR0ZyK3p1WFhkYnI3SFM3MEcvMTNKMW9RVnR6Q3pIRVhFRWc0TTdqdytX?=
 =?utf-8?B?ZEhmYnNpYU5hV2gwcW1mMXpldmxYYW5oRS9uUm9LNUlIL3pHaTgzaGZ0Ykhq?=
 =?utf-8?B?UTQ5QkVqejFkNkVYWUIxYWJkZEpMUWFhTzQvT0xObE9hU0hIbjNsZUJlRVQr?=
 =?utf-8?B?MW1KWU45czA4WHRac0tBN2NESlF2RklMdi9UcTBXNHFLRU02bnZtd2JPYkE1?=
 =?utf-8?B?Q2hmOURlSTF6bVE0VEJaelBDMUh4MVBHWTd4TFJiaWxPMGNaVGRZN2FEWkhV?=
 =?utf-8?B?YVNVWWZ3MjZOMDJWZy92bUJsWGpXOFBmbGNYaWYvTDJabk0zNWlUMldnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2tyVTJIYzFoVFZsM3pSK3dZNy9EVytWVUdqcnlEc08vRFlsVVJlc3JQc2pP?=
 =?utf-8?B?U0lmOFNraThaUHQ4bjkxV3FsUElsZ1BIcDBTeGc1dEJyYVh0WW1TQUtCeGs1?=
 =?utf-8?B?ZWYraHBxZVBkS2ZDQis1eUFtSzRlTENHRGZvSjBkN0NRaDZIRTQ4ZERSaXZX?=
 =?utf-8?B?ejZwMHhSV0hwQ1ByRjRmc2J5SWFIV2ZpbnFSRGhMaklYTUdndU1KeXVTR3M2?=
 =?utf-8?B?aFJLc0Urc2dBSk41ejc4MkgrL3B1YS9zYS8ySkRvakM5Q2dHK3lPTUhORzYx?=
 =?utf-8?B?bmcrVXovcG9IL2pUN0h2VExYb0VCa1ZTcDVXRTNMcEhvR0NMNEFYeTM4Tit3?=
 =?utf-8?B?OTFRVnNPempMUUZzdkduTHArUFhWQURndThlcWs4dzM3eUl1TG9YY0ZpZUNQ?=
 =?utf-8?B?RGkvTkpSYkNXZmtCdk51SHk5amdMVEI0VFpWOHhnejhBaVJ6VTJCbHVyb1cw?=
 =?utf-8?B?L0t3QmkrK0J5aklFVE1tL0x5cnNiQnE2WlJlWGIvMEdOZ0R5MXlGUUl6b2Zh?=
 =?utf-8?B?YkNqRzN3eW9sRGFUWHdZSHJwTlRENG9SSGptTGxtV0pnNTdVQkRkZSt2ZExq?=
 =?utf-8?B?eXVQNFA2SzhyQVFzWENObHhGMzVlZFJrc2RibU9NSVA3TklwbWJLUHRuVTRB?=
 =?utf-8?B?T0p6MDRXSk1oTnhtQWtDQTYzc1FrcTV6OWhmQVUvMzNjeXh6NTh4aXYyNEdJ?=
 =?utf-8?B?VEREdTNqZUR4L0V3aXFaY3RZMlovQlZ4SkNYd2toK1E5Q2xXYXk0VUZXN1VT?=
 =?utf-8?B?ejZoZVFvM0V3cFB0ekd0eGExdjZPbXRWU3FTd3VTZlBKQTltODlSTzBFMUk1?=
 =?utf-8?B?bGRnWElUNTVkMzhCVDlKZzBLNkVEN20yU01kNzQyalNhV1BBbGJPbHQ5U2JB?=
 =?utf-8?B?YVp3d2tMeldCVU1UdWtsYjRzZHVtQlNQNTdLa3hmelZ6T042UlVWRUFiUVdH?=
 =?utf-8?B?eUdEZCtBRzVmdmxQY0VCUGNFTUlIelVyUTZYdGY2M3hoN25tMW5vR1N1THJu?=
 =?utf-8?B?YTFHZlA1dStzbFpOcTVsWmg3bC9Hd3BIamo1b0ttRkdwenQ4YVRUcmYyRGNE?=
 =?utf-8?B?Y2p4NzhDNEVqWW94bGpOcE8yNnQvZkpVL2FwelFHc0YySHplRnRROEF1T0Mw?=
 =?utf-8?B?dExkN2FVTFd6MFZHZE82dWZ2SVRYU0FPTmdXMDdwNGVrM2xUOW9rMS8vWTFa?=
 =?utf-8?B?Q2lDNmZ4UTFHSDdDVmlRSndUZFhlUHJlUGFGLzI1eDV3T3RvVUZkQ0JhSkQ0?=
 =?utf-8?B?MWRtVjVPc0p5ZTNldGNHL21lVmVTNjhyaGJJNTFZSTRod1I0cHpWYTJPZTl4?=
 =?utf-8?B?Z2E0VVRKMG5OdEJwTFVKMGpxeFZPQ0EyWlU5UHlYeGlKUkdGVmtOamdiNE9K?=
 =?utf-8?B?YVVTd2ZENHNvbkhOYlZiRGo4V2xpN0lkZEpVeSsvU0VFZGdVUEdFZ3k4U2VT?=
 =?utf-8?B?NE9Sb25wY1V5RzdpOWErZ1pZbGU1MkZTQS9QV3VKbFJGS09adFVBWndZRk16?=
 =?utf-8?B?Um5xcFdxTjlJMmdRVE85V1JTbllaR055UTJNa3IyQ1NkbU13UkZYVEU2NU1n?=
 =?utf-8?B?bXZQY3NaVjhYengxcDVybXVITmR3L2YyQXJZak9oWEpxSHR2OWtwaTdPbkdF?=
 =?utf-8?B?MkwyV0Z3b09TREQ0dE11YjhsZXNZSVdJb3pqWE9maDllbXFCTDEyNWVvNHlE?=
 =?utf-8?B?K2pEZW40RW42TlNtSjZMaHNXRHg0ZzJ2Q21rL2RzNHFTV3VFWDF5cjRFcU9v?=
 =?utf-8?B?eiswN3VqZ0ZJSUlEamM1MWNhejdQTGErSExYUHV2TTVGeEJuYlM3amlXY3Qz?=
 =?utf-8?B?OW9OWEtud1RtTGFSZjZCSjRTNGoySC9Rc1l1Q0hxc1czeUFuUXFnTFZYV2p3?=
 =?utf-8?B?S0ZvQklPa2tPcjloVXFxVXZtc2pTVE1XenNhVmg2bnJuRmJZdm5DLzJXYXdl?=
 =?utf-8?B?N0VWTVRNRTdJWW1GQmdWZFVQY29zem9IT1lFdUdRK0doSDZBeDRETWZuWFhN?=
 =?utf-8?B?ZWg2MzZoUmpkaVkzTTIyYjV1U2J5N2E5aTg5SWViSEVBL1BSVkpXTmFLTERt?=
 =?utf-8?B?dlBJazYxeVYzYUhScVpxMzJaaWUxMG15L29PTFdnZXJMeTVpV1ZqNEozN0VM?=
 =?utf-8?B?MmM1ZGRkcThoazJLbkx4a3EyZ2RKbEljdmdpUkRmKy8zQ0I3aEhsemZ3aDRp?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GBpSHe8A4IE0WeNj5I8aRiA16wB+Mfi0lgu1Oj8Yx2RhJymwbhqllw+t8Nto1zTm64X6BquqjJ1ykdOudKyil4Uy5k+3/IMMeVYgMdXiB+XxLHQkLCW6Vjl5sak4OZCJLJqt2F3c8SQ+a6oQNUH9suh9PIrohek/Fagy3tbQjLcIN/QxuWJXisOKHLUUVj52V/F/jB/mKQGWSU9ZFvqG4kBnGpYfVHLu2iBHXdOw3uetM3oOMVRLsS8ShhvM6zpY6D3ZQnJR/Na49y8fQ7aBIYFik1UIPyft5UJIJq7XIWL/sOAJf29o08T8k3rDJG/tdtJDqaPZ6B/9trvAFlU1PIt7rsvvtwkmdOiDwZbMPoJD8Lx2Zfg9rMHfAv3PI8jizc+EO9zUQ68O2gpcbACA/1bGl7uQ5zM6b+krymwOx1voMYjmZh05fcSTvHLm5Ox+LKntzVo3ion8uQuKL8VcZB5pT0x43GQkbOm8NBLQ4HuLy5yABb5yjgfTns7xEw9ihQgSNWxj5ZW03oI+m+2Xj9dGTscWHTEYtihx/7cn3GK9esbNLQ8aKFAEEM8FtgvCRS+NWcXjC+bYOXogAmhEwoz/eEKF/zfC9Gh0Mmc0uXQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a126eb5-5159-4339-4afd-08dc84d85240
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 20:53:00.9185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1AIc26IE0pxSQxsgo1ojo+KxHqDafXAtnr/6x+VNG+8620CcllnQH5tJVal0ih+c4znMUiedXdVCkOXpfh826S1u8zgW7ZGiG1aijLMoNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040168
X-Proofpoint-ORIG-GUID: BJ-iJVnaGAW56UwMw1vcptIbzgdObSdQ
X-Proofpoint-GUID: BJ-iJVnaGAW56UwMw1vcptIbzgdObSdQ

On 6/4/24 11:24 AM, Jarkko Sakkinen wrote:
> On Fri May 31, 2024 at 4:03 AM EEST, Ross Philipson wrote:
>> Introduce the main Secure Launch header file used in the early SL stub
>> and the early setup code.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> Right and anything AMD specific should also have legit references. I
> actually always compare to the spec when I review, so not just
> nitpicking really.
> 
> I'm actually bit confused, is this usable both Intel and AMD in the
> current state? Might be just that have not had time follow this for some
> time.

This header file mostly has TXT/Intel specific definitions in it right 
now but that is just because TXT is the first target architecture. I am 
working on the AMD side of things as we speak and yes, AMD specific 
definitions will go in here and later ARM specific definitions too.

If you would like to see say a comment block with links to relevant 
specifications in this header file, that can be done and they will be 
added as new support is added.

Thanks
Ross

> 
> BR, Jarkko
> 


