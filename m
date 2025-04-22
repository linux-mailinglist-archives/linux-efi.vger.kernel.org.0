Return-Path: <linux-efi+bounces-3418-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6215A97580
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 21:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC93179F33
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 19:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95952857C4;
	Tue, 22 Apr 2025 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZoKD5RE9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xb8lBfhm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C742820C6;
	Tue, 22 Apr 2025 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745350482; cv=fail; b=tHKb+1tQuzkj4sZWNqRFwseWxjePhPorKWT1LFKxTubFf1jMV9e1Fhq12tlE7OoPN30HAABCfy2DJaZn4oFW78wYSPljk1WmQ12fYBKUXNv2bxBRNS2LCuwWBFHEPTtIv+zO0717c3S7IdzCsocWRgGfxc87XFxtrQwaNsJ4/1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745350482; c=relaxed/simple;
	bh=WPld60KEXHIm8rqdpzSfhuPQF8z0c6Nap0LPOTnn96E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nUxhhemUmiv/30VFHH37t52+wSAHLcLagOOs9x+hn5GpmuY5m+gI4KPnwP9mt24TxDBlX7pLzhNbtz6HlHXaBKfa3/uzXFq6avtlvxRfR3BdEo7JF+83kPkPnhz2H/VfMy1zhN7i1oS8htlK85YW7lwLjCc3iLyGeYQwNeOKd8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZoKD5RE9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xb8lBfhm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MFsoeM007683;
	Tue, 22 Apr 2025 19:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SXo0qkSKqdAjOPErRKorS4tlFthtHfgayyE87UR8HWs=; b=
	ZoKD5RE90bOsy+BD7NBYbn789zbb2Rn7dPcWrDmuFhf2zJ8ws6i+KkgVVBpDdFVA
	HTfA9CMIIp2FkM7U79JGKqtZoBy9FI3LKEtVl+PGviOhlkmr18tve8Lbpr7DC9zg
	LxuWul411Tqcj1tBdE2REK8AxuLNBoiUbBlxBJqrYEznMtCgH+KXsjfZgxGk0M92
	EUL0g5j/nsRr+fGM23nQpWyrWArEHwc2zBQkCUB4T7+5ythr9WVmRqHpSjl7f4FT
	FFo0HXhPjtXO+RAtV+zGIkusvqs/oU1IbpFOeITrUrLFJx5aIVvzgB/OHmyr3SQt
	VJBby2YcVuSIj2vbw7Jisg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4644cswbyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 19:34:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MHlZVV033591;
	Tue, 22 Apr 2025 19:34:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464299uenb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 19:34:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBV7omXPwIyCbj/P1l5xkC9HXqcOZHF63CZ7GVH/SHl3dFjYeEigkvh+MPfw4CgNUxOMeDhlZqn60Yuasc2aPqtU1f3poliKyC6VzRbNSnyOdpiyH92s6FfDEFpZhTut6PqrCX/vyHZroZWfx2wb4p7taO0RwK3mjiwBb8efN9fbTGFNlgnto7UqJzEYObL5MpAR21GZ9Ft0bq0b2Z58PQK41ZoawIwRVS/8UjaErNFGEInXqUQBNrJP+chB0N3Utfvl/bD3VZr7ZybcjUXJax4KDHbb/3wnBtcn5jqngGYwrIqXtWirUeD44KUImQ5JBTf/S9b58G30yhA6w3S4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXo0qkSKqdAjOPErRKorS4tlFthtHfgayyE87UR8HWs=;
 b=VcPpyP2lSqdmY0Nz49arTVdsiVcPCrhOvRowV5QczBc37HUqyuHRjz8pwQNNVqLCkZb/6IDf/yCTjnAvj5ooDLzRXQdzOw7z4VecmuqqYtC4hxqPCWRPZ/9QZD5PN20tI6jSDU7wp2SUHcq+yhzyJ0FAkSJKAN+M9fApjPZZ8ia2BhCfaDTUMbYxoZwg5vPiuLomP/fLnZWpBZDGzUPAef6hrqMSDyJmSBvItRfC/A/QjDP9aLivR2aDy1hbb/PrrXSZzDkHHfjmg+O3ryetnFomW0xCO7z1fqGUMdnKwE2LKbsV74zJH1NDstv8BKslhaue0C0TwFFOQLP690YbhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXo0qkSKqdAjOPErRKorS4tlFthtHfgayyE87UR8HWs=;
 b=xb8lBfhmOU9YXpshHfSo3VpTlq86kvQql428uFoPhHJxxNaFh4jC0eft9VrNhT4iDbGn7CBEoqLrkYryZQq87vxl0p6xMQhrbSr1G477GhUqnE5YZ6traJVoD+OXmwu3Pj2/ep850mjbIT73snDaCZQcoHoFkyfxhaf0KJPmgqE=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DS0PR10MB8127.namprd10.prod.outlook.com (2603:10b6:8:203::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Tue, 22 Apr 2025 19:33:52 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 19:33:52 +0000
Message-ID: <c377320d-d13a-4630-8418-baa02d2bfba6@oracle.com>
Date: Tue, 22 Apr 2025 12:33:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/19] x86: Secure Launch Resource Table header file
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org,
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
 <20250421162712.77452-4-ross.philipson@oracle.com>
 <66cd5c81-9797-4610-93d2-de111b36ce87@oracle.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <66cd5c81-9797-4610-93d2-de111b36ce87@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH2PEPF00003854.namprd17.prod.outlook.com
 (2603:10b6:518:1::74) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DS0PR10MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dfa2cdb-577b-4827-fdb3-08dd81d49cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXNGMzllNVQ5M1ZyYVNjRDBZSEZ4ZFZCTHN5QXd3YjBaL1EvOWs3MEt0Ym5n?=
 =?utf-8?B?N2lNT3k3aFY4S2tyVFZOaUVpcmc1ZU9BSzU5c2dKSnhEWWtIY3UxY3pYSkNZ?=
 =?utf-8?B?Z2ZoY1oyVmlxejBsQ0RDWDhYOUw4SDFJNysxenY2YUNvSFJvMmtxdUlYRjNH?=
 =?utf-8?B?R1ZsOUh1Y0ovNDRzdnVTUDd6U1BwODR3NmprMHJLRUdzUGQyNkZTUVY5WVVo?=
 =?utf-8?B?WVFJK01LUFhJVnV4WFJBSjJ1ejEzcDRxNm8zbUVvNjUzcFJnNHNTSWViSE5E?=
 =?utf-8?B?RnlHUHc0dkFaaW44M3pqN1JyVE4rSzZLU0tyTHo2TDd4WjJ3SXhyK2VZbzJF?=
 =?utf-8?B?eHN6QWZJSXp4blBaU29jK2FpY1M4VHB0N00vVkVZWkUxazUzV1l4OHE4K0dq?=
 =?utf-8?B?eC9lNTRaNHJqYUZvS0pJbENIY2pFSzNBdkhjdzhacjdLVmVVOS9mbXprVUlh?=
 =?utf-8?B?RnZZb2lzSUx2dFlTYm5KeEhPdEpsUUJBVDBQdnRxbGRRZCs4eStRc0FpbHlH?=
 =?utf-8?B?SDR4Yk9BWmkvQzdBZ0dQYkpXaEpsMjYxcWFCdXpabW04bWwzTmFyaFNNc2hp?=
 =?utf-8?B?VzVINlk2a25TdXkxTFV3dnVSeEJYWTRsdlhpREhQYnc3NndZZmhleGFOM3M3?=
 =?utf-8?B?YXRDU2FBaWlhOW1sTFJReWJ1NFRmRTJRRFFoOVVqZ2hhODQ0cG9WMXZTazdK?=
 =?utf-8?B?TTFpSkcyU2FxZGNQZVFiUlZBRUd2bGtsMEdtR3JIK0N2UWVjUE1rUzh4SDFl?=
 =?utf-8?B?MTZybUFEUW1laHE3YmVuOVdDdURPVHRXNXpwRTRLTHFveGVLZE9vNFdQeEx4?=
 =?utf-8?B?YlR5NldNNU5DeGhoRFQvWHFvRnNWYWdSeEEzV084dkZDbHlDQm5OOU5JUWJk?=
 =?utf-8?B?TFR3djhHeDgzSXNJL3BPZFNCeGxYa3VrbEFaQldlMjdyTEt3M1I5eW5FRUFS?=
 =?utf-8?B?Y1JMcE5Vczc2S1BYZWJvbnlaM0ErU3hhWldDYmcrcjBoOEdPS1psK3JjR0Q0?=
 =?utf-8?B?dm9lL0pENjJPYTZYSWY3Z205eXpPbW1iT1F4VDI4UDMrWmY2Tmg4Z2RIMTNu?=
 =?utf-8?B?TDJkTFBGenpwYUpIRi8xRE1oRWJyQWJDNGJtZU1nTEZ3SHRRS0dZSG80T01k?=
 =?utf-8?B?Qml1VHE5STIvWk94eUVVeXFkQklmaDdTaThpU0xENy9HQUFoRWxYUDhKdi9P?=
 =?utf-8?B?NTR4R0lvWmxDWGdKT1BFSXFsY0h6OGFpZkZaZXZxM1hqSUdPNVUvRkFhazFH?=
 =?utf-8?B?MXN1R0hnZmNCN21ndjBabjVxTUZURjFZWjZzV2lILzBublNZby96MzBzS1g5?=
 =?utf-8?B?emdtTlp4RzAzZXRaV2VHc1FrcnJVZytTOTFPZ2EyMlFxMkhNazg3YkJvQVAy?=
 =?utf-8?B?QTFuM2VQdS8zcVB2Q2ViSEZncjRDMkZsMG9jSS90M3lwUVpJcis0WUgwbDlM?=
 =?utf-8?B?YnNibDBUOTdRd0ZWamZlMGovZnNsdkk3SktXcklUdVdwOHUwRCthbXVSYUZi?=
 =?utf-8?B?aGdtOHd3UHJGcWdvRFpnMUt0TW9HWDQrSzh0SEJ4a2FIYldOTjdXOVJydmJj?=
 =?utf-8?B?cUhjVjYzNUNyUy9oTkYxVExtYm0wcHNDd2FUQ1FDSGVkYUM1NEVJUVlDTFYx?=
 =?utf-8?B?ZnN5YkdySFJ2dHFvUldVWnJHbTBZOVN3WldNK2M2ZW9ucDJSbzV2STV6bk5Q?=
 =?utf-8?B?allvem1WOWN6UzNnYUhRL3c4cmpiMkEva3BiR2I5ZjhTcVpNN29MTjhFeXNv?=
 =?utf-8?B?S2pialVMamlJeXRwcjdERnRCLzA3WjRsUzVyUXN3eG9tZENRTXQ2RXZSdTE5?=
 =?utf-8?B?ODB2L3VrbjZIWW9DOGNtS05lNXJ2OWlleHoyd3p4MFZDaURqcXlJV3VmTkJJ?=
 =?utf-8?B?UmhleXRvVVBodnM2Yk1WQlJuVDV4RnI3MlVoWmdmR3o1RHBOQ3F0WjlYRzda?=
 =?utf-8?Q?RnXASDiDdvI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mi9YMjhYcUhrN3RpanJuQW9ZcitIcjdUQkE1QUdQMXFQeGR1OXVHZUtPSzda?=
 =?utf-8?B?b2RTa3pQVm1XaWh3ckNaaldZdnozQnhOTWdPeVN3VDAvbExoMHNlY3lXS3dR?=
 =?utf-8?B?MHc4NDVJVjVKVG5sY0pneklSV0J3eUFXalhlQWJtSkV0bVczNExMVnFCMkdn?=
 =?utf-8?B?Y0NBQmNkRUlTRU1kSGdDN0VzRmdIdER6djhSQnVBQTNheXJmaWprQ1ZkWjI5?=
 =?utf-8?B?ZGsrV2dpd1BUWUh3eUsxa09NdEF4OS9QWmpRYzVDR2I4VnpqR3JTQ1FibDAr?=
 =?utf-8?B?VE1LUnFGNnZzTTVhNmluVFdPQStEUGNEUTM5M3VxMUs2ZmFFc3hCZ21mK1VT?=
 =?utf-8?B?KzBNZUdvUy82Tm1sQXFBenZLem5aMitGSmc5bzkwbjdFbU56S3dFRjkzV3ND?=
 =?utf-8?B?aHBxa2F6SjlRRHQzUFI3NnR3TlBVQjhGSkJiMStCdGRTbXhRNFpDMXlPbXBa?=
 =?utf-8?B?VkFrbDhiaDNodkVwSTRCYmVsMFk5MngvK3Iwd1c4dGJVcDNnb01JNkEzdFVF?=
 =?utf-8?B?SE15eGdiY2tiWkV5R1doUi82cjkraC9CRTdhNWxzRUc3RU53Z0RWaFA3TGVK?=
 =?utf-8?B?UGVUL3VZVjVOREZ5ZHlDeXc3TkZrRW8zeUVCVTN0Vzh6dkVHY29zaFpIcWNC?=
 =?utf-8?B?eElCODRHeWF4S2pieGtTbHJXSFBwQkd0dkV0eXkwcFUycEZQeit0SHR4MjMr?=
 =?utf-8?B?MmtOeTAvcEJJalhJZjJBTkRwbXZBUmVvdXlRbUQzMmM5S2E3VXVMK0wyODh0?=
 =?utf-8?B?aEFqblpvbnphVlNxYzRPbkREbzhyaVpoUkdROEl4dEZBaDBTTE45bDRiOW9Z?=
 =?utf-8?B?Y3VvN2hiWEhNMmhSYW5RRytneWozQmtrQzBUYURGem4rc05ZRVVhWWkydkJW?=
 =?utf-8?B?dW82eEJPN0hRSURyZlViWXJ1WXAzWmFtSGtWTEpUald3bFhlS2tudEp0VWJM?=
 =?utf-8?B?a1AxVS9kVzh4Wi96bW9iVXNHVWMrM1dzdVlhenBFeTlaTHJaV0ROZ0xXeXFp?=
 =?utf-8?B?QzRiWHBFYzlPTGtYS042MEtEVlFnQnhNSVRTZFVtVDlvdVFFTmZKLzBzY21L?=
 =?utf-8?B?d1k1NHA1SlcyMS83bXRPbVVMY0pPOXZFZEdaanZuT2xtdE9TSUpLNzVTRGxP?=
 =?utf-8?B?SG5ndEpUM2dSbUZJUkNiaURLY1ZmbFpETzdQR2VqNEQwUytvMDAwQlVpM0lF?=
 =?utf-8?B?NXdWQzdPVFZQSkQzWHBoNXppMzg5NW1aYzJhWnNUd0x5cEpaRlg2aVJYdjZR?=
 =?utf-8?B?MnJNRWVEZ2xqZjh6eFhicVBGMWdrcFdxM2pZT210YmtMbkFiTG5xaVZCUUhv?=
 =?utf-8?B?eURnMzR0dC9yT1dkVk5MWVdLTGpiZU1zQUpQQ3hHMW9BejBuMFRsSkJGTU0v?=
 =?utf-8?B?K1VCMkJjcldQd2g2cXZzWEViQjRrTmdkWWdMZTFzVmcrVHlSaERCSUVYVkFt?=
 =?utf-8?B?dXFzZGdXY1NranhMVE5GRndZdFVTSzc4UWpJeVcwU3dYNGNHTitTOXVMNzVq?=
 =?utf-8?B?MVJCVGZNb0xVTFRpNjRueDRaRnM3MThZK1RWb2FSNG8zNS81a0FneDlNOWth?=
 =?utf-8?B?d0xmWVhiajJVVzAzWjl6UDFENXlIaC9sanJqTXRrL09UaWpkdWVpMVBLTmtq?=
 =?utf-8?B?ZHB3c0I5d1hlUS9GYU9HWG9rOGdJcXZ1YThjQ3BCekY5Vk55VVdnanllTjUy?=
 =?utf-8?B?MU9sN3hUU3RuZ3BlTml0dHJXSVpiRDhSUkVHblpWUDdRbW1oTUFiYU9WYVYv?=
 =?utf-8?B?ajh1dlR1STVqb2tIQVhQNFVNM2hoWVc1Sk4ySzdXQ2xtaWJZNnZoOWdNWncv?=
 =?utf-8?B?VFl0cmY4cEJxODhwb0dDeDZ6dGFnaGFnREw4cEE0bS9wSHpUNXpuMWd0UlpN?=
 =?utf-8?B?Z3oyc28zOVFWbzFaZlkzVXJ0TEdvdmlJYVl3M3o1VmlUSWFCTlNCeHc4OEt0?=
 =?utf-8?B?UzBweDVXZVdDRkFsYjFoSThnRG9GTWxDeUF2TytGNGxzN0M3N0xjTWVOVm1D?=
 =?utf-8?B?VEt2QTlBcWZDU1BOekxTTmF4QmNvTUsrWWcxKzBmMTRObTdpSXl0bFcxSldu?=
 =?utf-8?B?ZlA2WFV0QndpOE9JTXpWT25sSTl5STA0cXlBOGNqdVcxY0pGTzZwTEZJc0Zx?=
 =?utf-8?B?a3JJcGhFY0VQUkVCOHFIaEg0Z0Y4Y2ZpTFd3alVycWlrSDZBTzRXeFhvUzVC?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ByCtpbb2lZ7p1J7H2O6Y3Vnh4Xi7fQXbJ6O1GXe8rlOl2W2BeRFc2Oji5hHTjqsP8zf8dg66w2aesh89OBvXIJFCzawexZpQHRZaDuNXZ/alBhS9xALSZ6bGADzR0qe7hHlN36byzb9VqHUx/typNRBAWZAr+8OFYhCCsC1mviACTcpxlwLwCGs4ceRNNHkw+4VC6ana6sLiqS+/IUKV+9YIwKHgyUHKTSg0y0YkzYRATvyrD3NsTe+2jwjrkwjrpKGwps1QsqzAet8eugUpZQ0dV2l2ElmHqqzsiKe9fIuQRGRXhtaVsx3YdRL8VgtUWhHK0tb3d1MhV61zv3srilZTO/O1+JN9XWV31pr08+ulI7Rvo6K5VWViJDrZ9HJxRIEy2/R4hwJzddrOYH1rvXs2d8H4X/jKezCbYGsoyFb1Cx/f90U73y4BJgCgR/W+YdE4IblnDpo7QygYjTgSt57CpMyoQW3PinrsBCrw51uJYY00cQqk7dOrh8Rm6CdDRokY61Ckoemf9w9oL0swy8cgBPIHzq8AcnhsIFMIK86OJmxb4r2P954vkDCva39ewMYpK5m24DaxfhmbHBeEq7f1Q1AhDJ+aVba1yPrg/MA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfa2cdb-577b-4827-fdb3-08dd81d49cbb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 19:33:52.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sm7W1Nm1kflzmoMpo5lMSQsfZ915NnF0lIYSOpqnQT0xLwyyeWpHpM4ZpabJ6GC22hAvpjHsHl17ZX9st/UQLn2qsHeADkuc6MYxTYe6B+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8127
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_09,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504220147
X-Proofpoint-ORIG-GUID: 7aIJblcPpHf2Bf3FVThBtbJJI2pILH0m
X-Proofpoint-GUID: 7aIJblcPpHf2Bf3FVThBtbJJI2pILH0m

On 4/21/25 12:18 PM, ALOK TIWARI wrote:
> 
> 
> On 21-04-2025 21:56, Ross Philipson wrote:
>> The Secure Launch Specification is an architectural agnostic, software 
>> neutral
>> API/ABI maintainted by the TrenchBoot project. It's function is to 
>> allow any
> 
> typo maintainted
> 
>> compliant boot loader to communicate the pre-launch configuration to any
>> compliant post-launch kernel. This API/ABI is referred to as the 
>> Secure Launch
>> Resource Table by the specification.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
> 
>> +/*
>> + * Return the next entry with the given tag in the SLRT starting at the
>> + * currenty entry. If entry is NULL, the search begins at the 
>> beginning of
> 
> typo currenty

We will fix them, thanks.
Ross

> 
>> + * table.
>> + */
>> +static inline void *
>> +slr_next_entry_by_tag(struct slr_table *table,
>> +              struct slr_entry_hdr *entry,
>> +              u16 tag)
> 
> 
> Thanks
> Alok


