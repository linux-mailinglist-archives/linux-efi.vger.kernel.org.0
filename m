Return-Path: <linux-efi+bounces-3419-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8EAA9759C
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 21:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAA717DF08
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 19:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9497E1F2365;
	Tue, 22 Apr 2025 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MTHgJmbB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ipo6kWn6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A86298995;
	Tue, 22 Apr 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745350781; cv=fail; b=MVBKPIme7+twpSqvqOwQX4ycV312skyC0pBcLeg4ruNjmJiKKqs982Qql68gmxuvDX99TlKaU4tO/gSxVSBrSkfYbkryPTdPrKp8my2lrGc3QjWMqJi/+nrSs2OTWdmy2mXcChMxgSWpK2x2UI6xn0xuu27iHj6qgA7REmElx6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745350781; c=relaxed/simple;
	bh=oBNJNXznvmvjbw6QEHYeVPuAtC+oft/IhKsIEUWztqE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bWidNTVHmusjRaFtXM+VxerJG9PjVgkrygvlYCN7x1LXW0hjzY6ijkDgmhEje6w3MMNUpTU+10r7UpP1tWBsFLPo8pvem7o0L7dTOaNm+axrOEWVRZWf8+kRy9Y918l7f04CqYD6yJ13kB3Z9b0tT69/56UjRNoly6XUtl5D9HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MTHgJmbB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ipo6kWn6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MFtgk3024527;
	Tue, 22 Apr 2025 19:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=R1FxifV5RgIqzeh3qrOtFxsESxXoSXM0BwMS6TooJ+E=; b=
	MTHgJmbBkBes/Gu0mhsHnmm/s/u1ODApRuojRxyMjmb9Haqmr7N332wbW/24TwJv
	gRUojwf5apRmSlEs4DlUhhJ5K5XJaBapKYe8hwzjUNrxiP/cv2gm9JUcAY0hVRhe
	IahL5tsWhmAtdOWaeqW5HArPJKDofB9FNUJNwY0L1hnah43kyJ8sDOTRCMn217N4
	bg5VV/KuNhzOZtGEm4Ru32nrolyZj/aOF+GVHpWZH7JnTcqLkL6VxBvyZ1jGGKcU
	FICFZQx03/duNxTvsShOWpmee0+NI/gkaqVMmh+X9/jkzGSkrmggNLXZ3y4AYl9t
	Xmr/2wYp0ajZYfFlznQRQw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4643q8wbp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 19:39:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MI59cW005891;
	Tue, 22 Apr 2025 19:39:01 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010003.outbound.protection.outlook.com [40.93.13.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 465dek25k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 19:39:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uS/+rZWKCdWHv1RI38NFvbht2rd2AVHJ9a+WiWBqTGniLcQgGRZC3/K2YfajyYpvv3XLVAtGe7UQuX0EdZnUwypcXD163XD63R4esF1ewg9BSuz2Ferl4WzwLN+fheGYO2Jix3GD0Hpc7EVMagbZkI7sTG2rL/NVKJQzo1GsIsoYl4a7WKyTQLPpMMADwfySCY5zhbF51WXYNDPXulbiYpO94uUeT8Y97a2TG1frSClyzVMZ3Ivs5wm2KX4RGetfbCxfpi3KFrwLVfTxKIpacQEPDgx9H/WWWSCkRzTvnSsrLC3XQfqeq1W5+0NDvAaudIiTuBuVBdVtucluGzjFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1FxifV5RgIqzeh3qrOtFxsESxXoSXM0BwMS6TooJ+E=;
 b=GS+ECzJRW54Xxa+JoFeUzcqAZ814HJoqC/DGShPk8Axrka6jv5UDMXrcErFAVku+qlz3enIoJboLLyYR3dJ8bYeiHJdozJEqIgF0iv0+0E/CIAS76p+wvMVnhl9tq28QCl73Jpu+B6Ve5Vx1cR+EZMcA9MlU37rQq1Ua2KgddEH39UNCxidM8ZSMfS0Xh0OKLTS4t015KBu6M/ftvoWG4guc8w7p7IYPyZSoSfDPWUabAuun2vhLoNOQ3DgkRygN/1qnRCmWYbHXC/I4ngFy0MXaKpL9RxMfQAAPRiNxsHuLwr1pfSjUxsjAFxQzQqkFi4slHp8ydFxg5fLg47w3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1FxifV5RgIqzeh3qrOtFxsESxXoSXM0BwMS6TooJ+E=;
 b=ipo6kWn6O/K0QOXwZBcZ12mdDSKY8smRvlo2AcwSuFVtaD9eKfSUNgDBdX3ag6DF1oHjWYIaHOB3XZYnIrMCudxZRj698QEXSEBbcDNE+aif4Oqn/q1VhGisclK3075KSeyVD6xlmaJokVRx+njS9r7Qj0aK/gtoYqzzk26yVCA=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 SA1PR10MB6414.namprd10.prod.outlook.com (2603:10b6:806:259::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Tue, 22 Apr 2025 19:38:58 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 19:38:58 +0000
Message-ID: <bbc8126a-ec48-4b8e-a8dd-3cab7a60a6a7@oracle.com>
Date: Tue, 22 Apr 2025 12:38:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 09/19] x86: Secure Launch kernel early boot stub
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
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
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-10-ross.philipson@oracle.com>
 <07132e5a-d334-43b6-8905-4e1ca991b3fa@intel.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <07132e5a-d334-43b6-8905-4e1ca991b3fa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:408:ee::22) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|SA1PR10MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a7e1e3-05c0-408f-9014-08dd81d55318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWJrS28yalUwaVQ4VUNnMzJhc1NsN2JXMmw3NkU0V2dFa1RtU2xXMkRGdHpM?=
 =?utf-8?B?RzRIakZEN2I5VmVheGdZVk9WSmcwKzBHMTBnSkE5NHZaTDdSY1pCbSs3NUJE?=
 =?utf-8?B?VWthalJZS0JpZXg2OUZaZ2pMazhSSDR4RjI2ODNVVWJHOE9kVVVJT243TlJr?=
 =?utf-8?B?aEd4SEJCeXpHUkgrSG83YXp1bmloWEJXaFQvQ0V0MUdRZVkydEdvRGhIU0NV?=
 =?utf-8?B?cUU0Mk1tMno1WVU3VkJMTmtJVGdMUTIrL2xaQU1iVEhSdXBZb2E1MG9KVW8y?=
 =?utf-8?B?WXJockhWOUFPN3hiQUR2bXdNNStHczRqYm5WZ0RpMGRXQ29pczllMEkvUzR5?=
 =?utf-8?B?UEo2OWk5SWVwSGFCYTBGRGhWU2FLRTJkbWVWL1dzais1Z3F3eUFmSmVGNzAv?=
 =?utf-8?B?R2FkQWFDWEtVR1RaM1JFYjUrd2ZZUkpKa1R2WGZNMHNkS1ZNR0h4U2Q4RFhl?=
 =?utf-8?B?NjhlTG80ZUJ6a1NZQyt6REhBTzhrZFVrRGk3STVMYXpBbzJpdE5qTjJiYngr?=
 =?utf-8?B?MjVjVGtjRjhuQ1A5dW1xLzBVWE9oelVISkNsNmpTWU0vOG1qUWJsN0F1STJ3?=
 =?utf-8?B?NGRDQ1V5Y0J2ZFhyY3VWeFhCR0V1V2VkNEdFZGViRGxudGp4WERoTU9zbkFa?=
 =?utf-8?B?UnhSb24zTzBoeDROenFyVjlmVU9FUEZRMnZScFZMbnZnN2pSYTgwMjJWcThH?=
 =?utf-8?B?SHhWTHVhOXBGK1ZCT3hMcjZqSjh1MlhYMXFjejQ5Nzh4RVJvdTlObWEzV201?=
 =?utf-8?B?bUE3RnZaUmVVdUo3V29WeCszTHdqZVlyTzU1MjRabWNEMG0rTWpuRnc0YWxw?=
 =?utf-8?B?aytQUFVqUVRpMmY3NGlkUnVrQ2U0QVpFWFFpWjNJNSt6WUVsZHduQUxiOXhY?=
 =?utf-8?B?Si9Sc3o4T3ZDLzcxcm9tR09qS2c5YmZpM0gvYUlMUTJBT09reVJRRHpId1Rj?=
 =?utf-8?B?aDJXNXJMZnIvejFMNUNCemZObDdVejcrdTluRStwTnZaOVZIZzczMGl0L1g0?=
 =?utf-8?B?TFMyVGVpcWg5TE9jeGN4NHRRYjIwaVNPZ3JvQkJKSDczRCtXT0JyVVVhUXpV?=
 =?utf-8?B?LzNDQ0lLNDRzWGw0L2RoUGV6eWRTVXY1UXFqRFJCK0Jkay9WWHdwMU1NOUFt?=
 =?utf-8?B?WituSmkxSE9nVVdWZVBMVHVqM3NGdGhVSXIxQWRjMFdZTHQ2VlVta1dxMVhH?=
 =?utf-8?B?QW9VNlpHUHF2QWUyd241QW9GSDBkbTlEcUtMOWZZQ1dkRW01SEpuRkFrVG5u?=
 =?utf-8?B?UFZpb2xtK201UllhbzR6ZWNXT0lwa2ZCZkU0c0plV0pNbzUwa0hlMkNVMU1j?=
 =?utf-8?B?ZXA1eE9hZHd3anVnZDJHSUNvWk1BYlZIaUViU3k4c0lVZ2drc20xSGdLUnRO?=
 =?utf-8?B?dXRLeUdqZnphL0NlMEpTdVduNld0TCtKSjI5ZkVzZDZiWCtSVmZiaC8zSUF1?=
 =?utf-8?B?VGtXUmlZa0t0THBOajlpUDRJR0k3bC9IVjg0VnB3cnRDcFlhS0tVejRJMXVQ?=
 =?utf-8?B?M2ltS3ltcU1ObnBGQVFXL29CZVdSMW54WEJacHMzWDdHSnZyN3JkalVCUXlX?=
 =?utf-8?B?K2ZBYUVzZUhFWmxHaGxNTHlFMnROMHc3Wkhmam5acVo2U2p2cHZNSTdXMmJr?=
 =?utf-8?B?MHlHdmxBNFRIR2w2STFvSkRITGpoUUZibmxXU1NyYWRQSEhCN2pXbGRLMEVn?=
 =?utf-8?B?c0Qyc2xyOE1ob3BWZVpQek1yVU1IVmpNQmZxMi9uYkIzV1BhU05OWWNJOWE3?=
 =?utf-8?B?TFF2MnVwQUhnckpBYis5c2FWZmlBNlNrUmNnMzZURytzS3BnNkp5Z1BvNVNV?=
 =?utf-8?B?SlNtY1pjT3ZpUXlVUUd0cnUrRi8vN0svSXZBV1pla2xFbGxIbjgwMllxYmkv?=
 =?utf-8?B?MUVyakZPSFRFWXQ2MTZiSU81Sm1HK1pxWTFtblJkc1hKV3Rma0pXSFhwdXBH?=
 =?utf-8?Q?itKDqaRo2EM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDFNMVpXUGc1YVpodUg0WEJIYWU2THhIeG9QUWQ1RTNQMjNyeDFkOTg1Tks2?=
 =?utf-8?B?MHV5Q0QzMS9TSzEzSUhJWW45SWRiM0R5MUJ2RUtGNXRHbTFCTEg1bGo3OVlP?=
 =?utf-8?B?K3dpdTh2bEhoWjNweTZ5YlhCZ05vMkY3dFdvc2JyY3pNaWJJSUlaK2JOcnhn?=
 =?utf-8?B?eWJVRFBUTHNtM3VYWW51QTloMW0yWDF1K3FsR0VIMDJVamNvQU9xaWVMMlNn?=
 =?utf-8?B?cDFxUEJLTXlWTU1GUGtkQTR3dDArMnVUT3piRStqdURhcWx2SVROTTd5R1Q0?=
 =?utf-8?B?L2thSi9wSGR0K2Qrb2tQeDRWNkYxZ1RsRTYyN1VWSnFDSVVLSnBYYStTOUE4?=
 =?utf-8?B?RitGVmtucFk1T0EwQVNueVZzczVORGpVZ2t5SFJUUm1iQU16a1RsUjYrNTFC?=
 =?utf-8?B?N1RJd2FRYVFEYllZam9acG5IcGxib2hzVjJ6Qm9RL3pxQjN3R05vN29JQzFX?=
 =?utf-8?B?RUVPZENhUWdBQnBvUnNJU3I0Sk9oeHYxcFRFaFhmdnBlMkZhK2pVWWVWSW9U?=
 =?utf-8?B?R3BpMEtmS0t0a3NvVTFKY0diVktGZUNDTnRJelFRS3FKRmo5NkM3N3lvcVpp?=
 =?utf-8?B?NHhOY3h1TEdmd0plNWZ5MEs2WlJWTW5MWFJ2V3dQbEFYNlFQRk5BQ2dLa0RC?=
 =?utf-8?B?TkxzMUlqQlRqUncxR3QyNTY0RXlSa0VFemI2QTdwV1JaTktLTVdtb284cC83?=
 =?utf-8?B?VjdnVW50d2JhYi9DbXhFcnByZ0RKWnloZXVNekJPdittMjlJVU94M3VPcDRP?=
 =?utf-8?B?ZXdyWG1lZkVUa2EyOVZRaXZYaThMSENtTmFWQVFhU2hMdXMvRmh4U2dxQ2cw?=
 =?utf-8?B?MWlqdGFZbEFXZ2dhcVBzdHFSeklqT2x3akpzeGUvK3Y3YmltYWI0RWJEMGhq?=
 =?utf-8?B?RzAxbXlMTjRzRm5BZTF1QUVMMTMxWXljWG9udm1ZZjh2bGR1VGg5QzJEWTlK?=
 =?utf-8?B?U3BHTWFkNFhqdmR1QXRvb0ZQaHhlWHpwT2pTQjVsNVlab0t0THhuVlRDZmFz?=
 =?utf-8?B?NnhJaWdWZXRWaWRudGJJVEI3NWhqdWIvSWpjOFdCa3pudzlPTmdzY3Ivb3c0?=
 =?utf-8?B?ZUZBSzcwTVd0RHNjTTBBTll6OEpadGw4UERzNjJUbmx2cHEyVDNhTnNRS3Rn?=
 =?utf-8?B?dHBUMnptT21TcWRLLzVtQTI5akdCQVB2KzhXWnkrZFl0Zk5XWlNjVG4xM053?=
 =?utf-8?B?K2FrZ2h4amVMeGp3VGdqVUFSVXJxVnlQOFZXWTdKdFpqTWFZbTNoS0RVc0Ur?=
 =?utf-8?B?QUpDU2MwVEFzQTRvQy80djc1czFRdmkvejNrU1BIR2NiZXZGWE4wREZ6TktE?=
 =?utf-8?B?eDAvc3JIcDhRaCtYU29JOWhYenU1ZGlWeTgvZnBlcjdyc0FUV2Jxczl3akU5?=
 =?utf-8?B?QUV0M2JCRlhieFR5TDRCMVZCMHRwSmljQ01kaS9nVG15Y09XTWJWVU9CQ1JE?=
 =?utf-8?B?SmczNXgyVTlqU0lZbm0zV2h1bXZVM0tFaU01em9McVRGcGRTSzA0eDV5cUVV?=
 =?utf-8?B?Q2ZYWC9QMjgxVmhmZDlRSHRvRzlPaGNyY09WYkhEUUZDNW5TZmZkMncwV0JD?=
 =?utf-8?B?NG1vTkRrSmd6NU1VS0lUT1hKS1lVcVE4OVZGdVVZRlJzZ1h1T0QxNUpVZ3Jn?=
 =?utf-8?B?SWFOVmJ4c3phTmE2ZEtOSUl1NnhxRSs2dmpDTytYdVlFYjB3djZjcURaOHZE?=
 =?utf-8?B?R2RobXNaZ3RHV20zVUlBV2dKVmxOYS9PdFc0Qit2SWY5ZGQyVWlMK2tVYmVi?=
 =?utf-8?B?MG9uTk9JTjlueTd1N2hxWG9WUW1TcmJwa3lnV3IwZDFnY1BqMUw4TElwRWZQ?=
 =?utf-8?B?c0prSHhHUTZDWWhmRkIya244QXE1WlNOOEJZejMyb3hMQmxBOC9PZG91Qndw?=
 =?utf-8?B?M0Rjd0QvTVZ2alpQK21SdmhUeStsNkY2d3orRmYxYmF2UnR2ZWhJV2FwdGc1?=
 =?utf-8?B?T2UvL2ZwVHNaWFg1NUJMbzRRaXhrdENvREdiR0U3VUEwLzZQc3NuaE5PaFlB?=
 =?utf-8?B?NXBoWFB4UlhtbCtFby9CakJFMGdqd3dzNnRsTVUzNmM4enhZNkxnZFJxUVFi?=
 =?utf-8?B?clNnSVh6UXViMVdhWWRucWs5WXR0RDZTSjZOZllHZERNQVo4QTBOR0kvb2oy?=
 =?utf-8?B?TGlEc3V1S0Zic2xrYmlWbDc2cTlRd05wWnpESVJPNjRMT1lBd1dqb29vb2Rq?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eUUlM0YC17h3fwOxhziF/t0af44HoASoPTJOA3hxZMu6CpGAOv4yYymFRXcWoMxbyF6Pq1tROBNmUXh0xK0kCLVd1hH8+78TqrfyhCnZcclaiZV4HvxsMTo0u7eTU0JWr2xMYAJ1nsMDcgIi2ZdcbE8d4yvIli/wyMgNNIAI3Q6OadCCl7qX4H3vo/8EN2D2tFxri5MNXotfguJgaMwt+CVi9G2xomxANcPTBgy3UCIi/UtW40NF6mw7c1zqLiEZphi04yFkz5mE+E9k2YdF8h5lX7JFXb/du5+xKMTK/U+HYsIfN/sGFkGD8ggO59jeTP6C2NdbQkY9B3E4n9W+yvFn0X8GZchzRNgMFEFkTt8XbybTdtNW4p9v50cUi8vTFRJO0gnuuQErQG6fbPDPRoIw5ce50zveoaE3WZ8XdZyAka+7me2PyIbAdsTlBmVpXjo1uSJPBdkgic4rpuU68Hf3Ew23B6kgfXCJDYkFUhpUGu4/hE+0njLQdPiFHtImamWvtJuqv4FUFjO5aZj5447FZp1DOCYES6wu85fWjp7JK7FnpwsvjziN65RCj5SuqFv4m67B9tEDjLJMcZeQ6UPa+7QFVH0tqKWz9PDBCpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a7e1e3-05c0-408f-9014-08dd81d55318
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 19:38:58.2362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fs483iOaarFFPdIE1eZil0cAQWH0YRPZGaEfDvVUJiigBgK8JK30eS/GivijHPbZvb54923t8LkEtoGNFzmFYKSf77WfekEeaL5K+Qbwy3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_09,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220148
X-Proofpoint-GUID: iXIJM1iIW-22pz-pDOgJZICyqhQ-8mtq
X-Proofpoint-ORIG-GUID: iXIJM1iIW-22pz-pDOgJZICyqhQ-8mtq

On 4/21/25 6:18 PM, Dave Hansen wrote:
> On 4/21/25 09:27, Ross Philipson wrote:
>> +static u64 sl_rdmsr(u32 reg)
>> +{
>> +	u64 lo, hi;
>> +
>> +	asm volatile ("rdmsr" : "=a" (lo), "=d" (hi) : "c" (reg));
>> +
>> +	return (hi << 32) | lo;
>> +}
> 
> Is there a reason this code doesn't just use boot_rdmsr()?

No I just didn't know those functions were there. I will fix it.

Thanks
Ross

> 
> 


