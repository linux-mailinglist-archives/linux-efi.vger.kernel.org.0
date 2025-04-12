Return-Path: <linux-efi+bounces-3309-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D1AA86E1B
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 18:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C3719E305E
	for <lists+linux-efi@lfdr.de>; Sat, 12 Apr 2025 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C991FA85A;
	Sat, 12 Apr 2025 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fFQskXlq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ACTLyFSv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E81EA7F8;
	Sat, 12 Apr 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744474818; cv=fail; b=jl1lgATX8Gm5HOQ6ddll/PQrAp8YCs+Ag77e9H9vgvJKZy92VFbtBNKBqhUcLHOj82ygpggkiCszDBRLUimiDWj/vfWnZm9AxTLS0S/EQJaIj2G1Kq1Vcgl/dBDIo/V0OE4qQX/Ziahkp8rKevkWZQrh3dfoghGgX8MrYTahQXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744474818; c=relaxed/simple;
	bh=Zmf8S2KXfPgpXiAdCZuYovxkVC17ovKtSDv2rzax3wU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GVhgjk68uuJXbvUpG3Kr+EouKLKN3HAa+ainSqX1o5z88+bYuSJaksjZAJi/2z5Lb+H7OyV4ALUwh5/bMjHMttfD4xPSXLI0z5g1gHptjJQ5HKu3be++2nrgF0x4n0VxocR471sC1vlhVwipJ1F/8Gxh4A7wyr01Yy8/K7gv1v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fFQskXlq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ACTLyFSv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53CG00ka027742;
	Sat, 12 Apr 2025 16:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lvrazQAY23pQf8ke2oZQz+JLJBvaSD26dIyelrv5vAY=; b=
	fFQskXlqfxuoNZj6oQoZscaWTkpWzXnX9TQkTnF3m+EZs8emQoo1fk1dcZrBFJvi
	UrPYTL7ra4x6AjL4PzzUSY4KJd2ekZluXg/1wc4yZVo3J+gSh71sXtEwHZFCHnHz
	N4WGp7zONhkhV9/0MtuAJzu/AZxMopqFTrBtSaewtq7giADEp8r7c/Z2E4FD4yDS
	CTH9y44H88W5DGYGZf4wVq/TszncehUSWXVD3CPPs0jRsb5lQhxwPU5nukwpXAub
	Lvoc2kGFiqL0l7udpWov7DL0PykDb0kd4xuCst5P2vzAdiZ0fIZra/ZSfYqiTQxu
	ijTAmqVUhnY629B35FRRsA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45yu8wg0bw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 16:19:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53CCNEbB025320;
	Sat, 12 Apr 2025 16:07:58 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010023.outbound.protection.outlook.com [40.93.12.23])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45yemcpq49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 16:07:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZowncegFSCZuzBV0Io92wuBmY00QLrfOPwIsYcwG4oNdnaeGO6p4HUwPgaI189rlunyoqUM1zKBgS3Jec5dApCvMZMYMALw/tN8iPZh9XeoWfqUUXeFPNokTpmPz6gIFy4YjFhcUh4sbsXX5jPmmD0IzTvztlAXy1hdacYsDiHOKjZT7YzaNeH8rQNUTD+WowrsHeFSXcGil2iQgPsrcfLj0RYOYkCG7LOOdjtRA4oQB3obCuCGX4nPWGBUfSs+UaiI8ejSTbSYjuZ5akXXFLuJqUKPjVVHK0aKKa6pXR9S3LVehxm49L80TSCPwIpY30hRSRUcsbfuwsGX7FKHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvrazQAY23pQf8ke2oZQz+JLJBvaSD26dIyelrv5vAY=;
 b=t/3nzxkmDYmauQe/qY28EB+hMaxsi+Uqz31kk/ctz1gUNizp8tjeH+GqdZCBzdJBtIUTfAYiu/iazY0Mr+R7uMCN1VqS7Jwew2boECy7+OwkW3+5GAzVcAC6eht4MI2ObN0cnPEKV68CU0i1FgOYzF9iLW1ASq1hcXilPwNIV2iA4mYHBwEwuPPDkMNNkWxlECKJmLJ9O4Uw/BmP4SFj0eyrhzeF1XKolTMjfR9sCmyW4LzTX+kL9TCSwaaV3RA5v+phmUDCVTDARy9RRuam9uaMQ6HZQVwZPYxqaLzWXL/eTAeBOrB/kGsW1w6He/0Ejg/fIfd3vxjhC0Vgl8dBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvrazQAY23pQf8ke2oZQz+JLJBvaSD26dIyelrv5vAY=;
 b=ACTLyFSvXejKvaJ5PFBy3otsEA/vBr4p/wrAIYYrx8Tq1NYtUv38dkNRNk/Oz0whD8TmhmR6nebhhZD7T7D7qKTQM0lBY+Rzjw+7Evy+7IIeoXVUVEvZR5su7g54CrAus11DVzG+K0qFRO71G/xU72x63+Fi48iEMt/LI2iCgMg=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SJ2PR10MB6962.namprd10.prod.outlook.com (2603:10b6:a03:4d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.37; Sat, 12 Apr
 2025 16:07:55 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.030; Sat, 12 Apr 2025
 16:07:54 +0000
Message-ID: <dbcc870f-123b-4505-831c-bc779bec231d@oracle.com>
Date: Sat, 12 Apr 2025 21:37:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/19] Documentation/x86: Secure Launch kernel
 documentation
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
 <20250410204149.2576104-2-ross.philipson@oracle.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250410204149.2576104-2-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::22) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SJ2PR10MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb56e38-bb09-413a-3cd0-08dd79dc2eb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azRXNnArTEY3SzF2Wll5S2hwQWkzbUQwVnQ4WDFNcnBnQ3g5SU82RVpDMXBR?=
 =?utf-8?B?WER6OFpWOGx3YnBLNGVDajI2aWNnSlh6TXAzbGQ1dEEweFpoR2lqdldiY1BO?=
 =?utf-8?B?UDBTYVVMRkNqWENZYnFpeTNzc2dpc2JzY0EvWHFaSUJMWTBHaWlPclhEL3Mx?=
 =?utf-8?B?eUNoeXZUakd1VU5yYmc2QnhsT0NhVUFZVHUvU0pYakFlQTN2SHJGVUk3Ulhu?=
 =?utf-8?B?NmpCcHpHOTduWUtGQnhaU1pvS002NGhtQzVSbURxWktTNThsVWlJWTh6a08x?=
 =?utf-8?B?dk1SWTRyakRvc2lOam50czdOZzQ3U2JzVWpidG01eHJJVHVNZEs2dTNOMHkz?=
 =?utf-8?B?c1ZnRFI5TUR5Q0hhcVdJYkVjaTRYQUs1Q3VLbDJLL1JRbzB1SzNqRTE1dHB3?=
 =?utf-8?B?VkFMcmllaUxzQ2NwVDVMQ3hER1FTdURCdnoyY3QvTzhZeTlJTTVvcnZwMnBj?=
 =?utf-8?B?U1BxNmhmbnFTOStKZW5NVG9QVnVDS1IzaHdFQmNVckp1bjlDczhRUTBCL1FG?=
 =?utf-8?B?QS9uQm9tK2FydXJBanZmaDY4eEovOG9LNzdhSDVhTWFoYW40cUFyT1BhU1dD?=
 =?utf-8?B?a2txR3hnb2xwY3FVNDNPZ0c5dlN2RklTV3pWenVmZjlZbFJhclIwdkt5RjRt?=
 =?utf-8?B?ZmZScEdFZ3JaRWFXbmd4dXBLYXZiL1pYdnk5aG1KZnJQVXc4aVdncjdGdmQv?=
 =?utf-8?B?c2MwMkxuR1pFRWllQ2FzdTJxenVDbldJem1BRG5JOXQxNiszQXYyb1JTcDZw?=
 =?utf-8?B?eHVZZmdVeGVqTStha083U1dVT08zWFN1clNETG9tNjNqZ1RJS1UzU0tOazBh?=
 =?utf-8?B?d3hoYy9yOHhjL1MxcTEra3Rtd0dEQkE0VDRidldjQ2QwMW1Oc3pBZWF4cjFo?=
 =?utf-8?B?LzFQUkp4bnBWRXk1d2tVamdQd3hOSWFzYnoxdDhTWDVsd0ZGVVR4Ty9wTTBt?=
 =?utf-8?B?RVhybVVXQjBFdEc5Sm5KaDBzZjhsSGZ0aVMyNkJHR3d6L3lYZHg4UzR3bmFH?=
 =?utf-8?B?bmlaRkFkVzBWM1ZaVzljbE1XQ09MUzNoT1JscmN0VldTdy9tcTZoTmtic1BJ?=
 =?utf-8?B?ak9qbnVSTTRvak1wTk1pWEw0NFZQVmhFWVVvQ2tFMHVFQXZmcEprRlFUdFJ6?=
 =?utf-8?B?MWt6MVpJZjVYbWliR2gxRHo1SU93NXlqUllqMGp0NGQwQks5blE3ZjcraXdk?=
 =?utf-8?B?Y0phdWpuMk5vUTM1dE4xdFFWbUg2b084Q1k0TExOVWtoMDBlR2dyWjArVTN3?=
 =?utf-8?B?RVJvWW45YnVYb1lBQmFUeFRxVk55NWppUlhLZUMyYW0rdlNZQUIveVhrQUxk?=
 =?utf-8?B?U3MxUEEzR3ZQMURZVHVGQUgzNUZYSURJbjVlT3Bobmh6TWpyUDNtUDg5RkZJ?=
 =?utf-8?B?aVpMYzJ4VVZoSGV1Ulh5WVB6S3lMc2hrdkJFRjIrUEozd25QRStCUVR3UGZl?=
 =?utf-8?B?MlROUEw5MmdIUGpmZXdZTzVadVV2b2VkV3Mxa1k2Wkl5cUVqUDVoVC9zci9l?=
 =?utf-8?B?NUVqK2dLeWVPYU1VMXp5UktUYXU1Y1h5aXdFZW50eUwxZlE4OHZTZWMrR2ZZ?=
 =?utf-8?B?OXQvclAvcEVjLzIrZ01qZ3kyL0hxb003cDBZTWc3RkZwZjJJWm5RcDFKTmNy?=
 =?utf-8?B?T3lNbGRYS2pydE15dEkwRkhCbUdqcytoTzZTQWw0YWUrOENLajQyV1JQWlFm?=
 =?utf-8?B?amI5WUhkeTlNd05vclZLYjJKR0RPYVhzckRSR1I2TnZadUV0N1dwTFZBZ0N6?=
 =?utf-8?B?WFZUTXQybzRkTWhhNjk3OEJPTHVDRzNsTE95V2J1Ym5saEJqMHk5a1UzWUtL?=
 =?utf-8?B?a0JSajIrUnRpS1JSRTR5QTVTcGlkV0t6bkgyelFMdm1iQVB5TFhYMmhXNjNX?=
 =?utf-8?B?WW1SOC8xYkZaNm1qMHR2ZG5HeTRhRzAwVU8rYzc5WVhwNklTVFFaQUpyQTB2?=
 =?utf-8?Q?4oeSxK3RVMc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkRuNk1oN0Q4bzVVVVpUR3ZLTUxLaG5Va0hnWkQ4WFpBZlZZdENuNDVDbDY2?=
 =?utf-8?B?MS9JOUcvekNYK1ZORVZsSzNGaUtqSE5WN0dubE1ldm4vMzZTTzA3SlVVSTk2?=
 =?utf-8?B?Y2crMGx4VmhLcm9rZUw2RzJ0VS9ERlVUL0VyOVAvZFZhTDhLR2xIRjBUejFv?=
 =?utf-8?B?ZjdaMkhCVTdVODJ0MkQyY0xjSFdRbnhFWGZrdkd2YzRXYTZlc0Nra0pEdjlM?=
 =?utf-8?B?cUdnNzE3OXprRldLMy82TVNadDFmZzZ2L3VuVDhnL25wTzdkNlZseVA0dnhK?=
 =?utf-8?B?Z2QwYmI0TWVRd0pabVJqYWpzUVlqeXIvcjN1NlZCLzZQdUxsQ1hUeUExTDk0?=
 =?utf-8?B?cjg3YlhvR2xKZERCVkJQT0tMNHBCbWtSTGo3SU1DTDJPaFlKSk53bXhtc1l5?=
 =?utf-8?B?UHA5cUdJa3kxWm9vRm5KUVJSWEV4cjNudjlxaWY1TCtlRkdKWDRFbDBhSG56?=
 =?utf-8?B?Nm83R21STzdsM2FBR2pMaXQ2c3g5NWxKTTNpUjVmVkxTaTF6eEZYR0RXMFBl?=
 =?utf-8?B?VkRoRjVici8xYkMzVzV1c3BMT2pyMWtyNGZ1eXY5RmFGYzJ4YmUrMmlsOEcr?=
 =?utf-8?B?Sm5qVlV4OTlzQ0xickV6aWs5ZmMyaWRDbXZjZ1A1MGdsTUxqMDFtS01zbEt5?=
 =?utf-8?B?a21RaDdwMDNvTjlVc01IVkdUYmFkanU0eEhtb2JON3dveHkvbGxrOFM3WUVr?=
 =?utf-8?B?cEQ4Uk80MkZTbkJhMm1JeHlKODdTVFc1ZXA4OEp0MTBQL3VwSEEwQjNsWG0y?=
 =?utf-8?B?QjRzWEhPMEQySFZUZVl2dk44U01UMk5IUEJJbGwzU3Y2M2lNYzFTWUhLMEUw?=
 =?utf-8?B?R0VjRDBiZHJFRlp1Mmw4S3ZIQmYwazZxS21xdUk4akdZNWtEZTZiVzdvRWJS?=
 =?utf-8?B?S0d5TVBIZTlYd1JVNCtvL2EzRDNXY0pLSkFZTHJMQWIzSkI2VjRTOUpkVG1p?=
 =?utf-8?B?ZFJjTWZ4dU9BRm91bFBuc3pHT0E0VzhTemNnbkg0R2QrNGxvV0hrZXMwajFI?=
 =?utf-8?B?S1cvYkpQNEJrdzlvdXcrUkYvMDdjaVBwNXNhVXdiR015b2VPU2pwbmI0Q3Uy?=
 =?utf-8?B?enFuR3YvZFBFdFZyby9rbkxiU2RZQ0k0ZnljUldNcExDekJNVW5wYUdJZ1Zt?=
 =?utf-8?B?eFVFSVhxQ0tOVStMQmRsTkdvMWRmcStDL2RLeXp0aXlNSXRKOXVTTU5xYUJx?=
 =?utf-8?B?VUJ6SXlPSWg1cmNTTWc2YVJnN0J4WHVkWFd4NU1QTDdHUmxHMG1FcXlxRWwy?=
 =?utf-8?B?dW5nVTBxTElXTjlPQWZLcE5SR3RPbDJ5SmlJcHYyVGlUVWRNd2JCWlV1ZGJG?=
 =?utf-8?B?Unh5cUdoWWkvU2JBcERQQW1PeFQyY3dlOU1TdnhrYjhDUEJVcVpKcytadVdW?=
 =?utf-8?B?aC92NmZSOHNxYk1lQldWdm1EaGJoUEllcEtteGZQSEVuNVAwaVpLcmtCOG4x?=
 =?utf-8?B?TnkvNnFtdGpVL0hQMjI4cHdPd0M5a0Jpb3IzTTNIUVFKM0tGZXJpdThUR2JS?=
 =?utf-8?B?ZTJHUzVsRFJjdU1adi9qNFA3UE9tWHppdmszeEVJWGJRVzlWcFhjK1l2V3ow?=
 =?utf-8?B?Qkp3RGM2d0dhbGlXQXJBRUJRQkkzNnVxdGJENEtUQWhxZnVRc0hqREVMRXpp?=
 =?utf-8?B?SkU3K2Q4TzhmTmRtZWM5am5tMTB6aVZyVW9PbUNXdDB5bS8vaHBZOGg5QmNE?=
 =?utf-8?B?R0Fnalo2SEVpS28zWVdDdzROaGFsSXZPVjk0ZjVrUTE3UHBjd2tiTnFhTlIw?=
 =?utf-8?B?RlJrNDRCSkp6QkpCMlVNVFEzQlJyWDRJN2cwVTVDd1pLVFZSNTQ3MjhrVXpo?=
 =?utf-8?B?NnhPU2Y2RmV6TDhGUXJ1SVVkazJNRFdMMnFzTmh2dGdDNzdBTkk2TmdvL2Ru?=
 =?utf-8?B?WjFKeHo3bUwvUElnaVN3LzZXaUVORnRSRS9IeVIwY3NMMXZkbEpHQ2p1cEd5?=
 =?utf-8?B?bUtsTGpTcE5GQi96ZDNobFR0b2FHSlk4UGJQV3hoUHZvV3N4d3Y5YVNodDIx?=
 =?utf-8?B?eGxtNzhlNXh3WDU1WUFCUGd0cGtFbm9FWDZ1U0RpRENKZmF6eEszaDNQWENn?=
 =?utf-8?B?dlBwSTNLeld1S0xSREVsMmpmdzdUMzZaeVVYRWJ1NTBiRGs1Q0FucktIZ1JX?=
 =?utf-8?B?NTcvYzVqK2luMHNvV0ZvRFJqOVJEei92dkVNS2QxQjVrQXRtaXppaGI0U3R6?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WMEhQHIixOPdIEkI96MY8LyNW/vDPi1IFVJv9MxvWLzCIr9N5sOpEyl9zhnJn41rILFriMTTW44vyAmWuLu9B7bV0gXyZXnmnDYidNk2bbRC0qNxMdovqpTCPbyhiZzccnw0NFmQWTVgSZkJJIb8mDoqGwIxi1txJpTfipMMHCdlkjgO0smigQ+STirIdB09f5mf0QiYeWTn5ba69aPIfmq0O3F3Is+9ojNVZbg2hD6C7m6wWEJydvGId8pP2RIFIV4uhc3uEAF6cR5E/524KfCwEJBN1pX5YKJPUkQTbwHaNZbjyaYHjCgDtEfVYGoWoP6RgDnm8GCCxx9IPUI9onHZOc/zjenZSF6bkPWmyLFuprPZRwKIjKSjY6ii+GCOQTZ3SNfhBwH1ZP4wiXYjzefNrqVi+FlBMS+LTiQWaX9mP1+dikdn7SG1G73Y29Ivx9Pw0yolzX9PCjfcMkdEzdja59lDEBgUN8ONV8OTig83EuM+UvL9LK1ECUy1zqTBo2IQ0d3LTrEu/y7Z0xeARywvqL3DXJ3cOCwBVNsN//KiLq8zT+v9/sqwF5WiuoHXfaxqSX6kVLfdc31gnAKp4NEnjOQNQ3v8NJ7HLS1HXHs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb56e38-bb09-413a-3cd0-08dd79dc2eb1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 16:07:54.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GJEDpEd4QguK/9eRJEcXGrQh9fKcVuDu0ixEag46gznwVPUaf1KzNF5r2xQ1PKMrH+8jkx1HicBecWyW5sSUVBz6Geeg+l69NNK4DMiLVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504120122
X-Proofpoint-GUID: OmVo-qQWeDb5cBcR-54RxC_HFmtvOLZ2
X-Proofpoint-ORIG-GUID: OmVo-qQWeDb5cBcR-54RxC_HFmtvOLZ2



On 11-04-2025 02:11, Ross Philipson wrote:
> +.. note::
> +    Intel TXT pre-dates the TCG Dynamic Launch specification. In the Intel TXT
> +    documentation, Dynamic Root of Trust for Measurement was abbreviated as DRTM.
> +    When Dynamic Launch was codified in the TCG specification, it was given
> +    the acronym D-RTM. There is a similar situation with Static Root of Trust for
> +    Measuremnt. In TCG documentation it will be given the acronym S-RTM but it is not

typo Measuremnt -> Measurement

> +    uncommon to see it as SRTM. For the purposes of the launch integrity documents,
> +    DRTM and SRTM will be the preferred acronym.

Thanks,
Alok

