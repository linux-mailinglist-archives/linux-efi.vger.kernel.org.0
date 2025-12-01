Return-Path: <linux-efi+bounces-5734-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B76C98743
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 18:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3902344703
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF00337111;
	Mon,  1 Dec 2025 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LESbYmG8"
X-Original-To: linux-efi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25632335BAC;
	Mon,  1 Dec 2025 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609326; cv=fail; b=cruVd2LbqYTi2cM9BCnYf7e22TN5bAyIkXJMJdxtTsPTwGS/JpGiDsKA7qdT9e/jnHxSTjx9kYgNbhcS48qHZq7dWV9IsdDTepukF7bV8860VBQnln9u02wImDTYrCdrHF/O8oF+uaErqnwxKchfBGEoRqiL2XMiVNAyyCyyEww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609326; c=relaxed/simple;
	bh=WoA+AbuiEX9HhmY3JdFuibaR8cuygdkuBfrvg5yDzWQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HJWFxqbG+3JKXvJAfsRqDADMazkgub7dxIphEUjdrnxkgqTjwM2nycvgLg+sa/M+FupweGpWPXwf75EmICq4mZz2IudSAYPQhAMoFWX1XRudS+CvJoqNo0baYLnHRqDWJTCjYMUrGXMx9CnHRJVZ7UdT0EDKF1YWLme/x+IQDyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LESbYmG8; arc=fail smtp.client-ip=52.101.52.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIMLyztyJ4sAl4B566KDjpFSfjlZKY+eFyufhVJOnyR7rXussX4Kw5VVJi8awEmuMXZoY1jMG+zgNrs7q3w1q5dYFiRAxR77LogrBEjQhZ8n1KN7wcdBo/ish5Y/wmothLpf353RfkFZzmq3LPMkV7gdt1Vyd41xvojO8cJ6tK36Y+ZDCJISfdB10S3+5Y3b4ZgrIReAAXr/LExR2cei77+z6ZI/TL9teytt040ih0b43VTsjoLvYaKaxHSgsGxWJ0+WtpGAh20+i5XksXuMfxvgJdDyOLUmXM53yM+ZB81Cyx7BF1BS7y9W6EDPBU9PtMwdIqpm+eJixR3+LXRDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmoRHhS3RIga3C30pZlSIlgjuKkczu+uNOBA8gX8r/E=;
 b=fenmFBrEwMAknt9CeOn7arpDXiQE1TUQ/+qs9j8i+D9ffUTAtwDmWJ5ouv2TW2ZCR13UdW0/sp8JkJLC8nqJcvQik/ap0Qp6l08m1KCkSRaPTEkMMlXSEm1L0ej92BESHRPB/HwmklPSL90C517jutu0Wm9QWSWte3tN9xmWc806N6vGB/Szq9nonUDULPTB7DNh89iYO/DFz94sRiegEsL7f59ePKeocysJQlZsgWzrVA2FQAZZWocyykEdyprDal+s46HuJLWnS93dNPi2k8kegOfnPPWKqJFFKgvKHSRBxAK5+QuWsnKJLsuBwsXDVAOkz5xCMYIfBj0+L2A/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmoRHhS3RIga3C30pZlSIlgjuKkczu+uNOBA8gX8r/E=;
 b=LESbYmG8JVeDs9KzoEAgZfBvEGii1HfoBaR5JaBhHoEcsl819PUtxhIb60tHLBnMxKNlKaDqP+r+CnAcvtp4UXPcucGoeXRwwIac+P7SDGrobEy7zweWGak98t+yMyknqnkIOu5gP/NGloS+uzT/l0s3r1XTWD/+VzQ5WHUke6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 17:15:16 +0000
Received: from CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404]) by CH3PR12MB8660.namprd12.prod.outlook.com
 ([fe80::222c:662:e585:3404%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 17:15:16 +0000
Message-ID: <f60d968e-6be3-4bad-8bf4-8500ad039817@amd.com>
Date: Mon, 1 Dec 2025 11:15:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] mm: Add support for unaccepted memory hotplug
To: Kiryl Shutsemau <kas@kernel.org>
Cc: linux-mm@kvack.org, linux-coco@lists.linux.dev,
 linux-efi@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, ardb@kernel.org, akpm@linux-foundation.org,
 david@redhat.com, osalvador@suse.de, thomas.lendacky@amd.com,
 michael.roth@amd.com
References: <20251125175753.1428857-1-prsampat@amd.com>
 <20251125175753.1428857-3-prsampat@amd.com>
 <66ylzwknm4ftd6utn3nqr63jmhl2ccvcdvyi5fechfnvmfxivu@37pckhjixayh>
 <14df1d99-7df0-4982-8029-e66dfb140399@amd.com>
 <dy65eupwalp5wsljetlto27l6tjjvoygeotjd3n7mk7zjc4dma@jf4hzsy6rtcd>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <dy65eupwalp5wsljetlto27l6tjjvoygeotjd3n7mk7zjc4dma@jf4hzsy6rtcd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0163.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::22) To CH3PR12MB8660.namprd12.prod.outlook.com
 (2603:10b6:610:177::5)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8660:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 046894c8-6693-4b1c-4dcc-08de30fd325a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eENsSXZwektQL1pqb2pEa212QW00WXROcVNyc1QvUGp5cVExamtVWGFsN3BU?=
 =?utf-8?B?VjQ0dVMvNXBsSUxlVGpWTkhCbmdVWnl0aFU2blRtaHV5YWdtSVJENWh2NXNh?=
 =?utf-8?B?OHdPYllEbzB4V2N1a0cwSUhhMWJjTFJlSVkvcVAwRlRvc3MzODhkSGtPV3ZS?=
 =?utf-8?B?NjJONlJ2MUxSMmU2b1plWGVnaXhkK1lhMDRLcnNDbHIrVUEza0pCUG1EdWR6?=
 =?utf-8?B?cDhlVkdObDV6M2hYSUFQempEWmM0K0tIVDBrRW8xVmpxc3BLNG9TNjY0eEF4?=
 =?utf-8?B?U1VuM2V2MnRXZkcza3QyTWNlNjUydUUrbmcydFNqcU1WQ3laVkJEVHhreUt6?=
 =?utf-8?B?SEZzdDh4eXBVNWJUdXFPM2F4cWUwSTFWOG5qUEFOU0tjMWVOZlllajNoWnJ1?=
 =?utf-8?B?c3VjbE5tR3hwcVZ0K3RkL0F1VVQ1a0ZYRVA1cEZNMFlJU0FWdER3WlRnYVBM?=
 =?utf-8?B?SFBXVjJxOUZlSWhCWmFkOU1XcG9pM0ZmUUZJQUxiV0xsL1JRL05pUmFBK1NP?=
 =?utf-8?B?aVdUcXRBVUhuMnRZenkyVlBJbkFxL2w4S0hrdXAxNlMyOHVZcXZQYTBpZloy?=
 =?utf-8?B?YTl5bWFBZ1I0NmNqT2ZkV1RNUmtUbEo3ZTdpeHhKT2dQY3hwVGMyVkMybWZJ?=
 =?utf-8?B?OUd3dXN2UzZyVzBLdGhaUXhQRzNMMU8rQk9NaG14dkRCOW9XZzg4RHJ4Ry8w?=
 =?utf-8?B?UzUrRjRHYXlFb000WFgwZktLRW85VkNpTHRCU1I3SEQ3aXVHeXRXTEw2eTI0?=
 =?utf-8?B?Q25XeHJzRWxGUHkvbE5LLzI2UDRva0hMai9HNmRaUk8wYXZPTUVWNWxRZU5I?=
 =?utf-8?B?dDI5bnZseW9jTi9UcmlCczlYMEdIblkzc3pOZE9sSldKNFJNWFhicSs5dlg0?=
 =?utf-8?B?TWRjU1ZjVWJ1Wkp2ejEwV2ZTS3NhUEpWR3NjL0VITTdUc0pPZGs0dVNKTUky?=
 =?utf-8?B?MnVmcjgyNTdwaVZ3aTJUNTkwZmVKMlFRaVltWURWbjRIb1YzNEN3QjN3Nm9m?=
 =?utf-8?B?TzN5N1daOTFuT0lHQUZrNlBCTjZpbGdqOHIzem1oZGs1OFVFd1UremVBOGsy?=
 =?utf-8?B?ZWNMUiswdUFxWFhnTjRwa1drL1pJU0lSRXlXNWgrK0czVUtEd2VoSlJVUDEz?=
 =?utf-8?B?YUdaWVMzWEo3QU9iNTM5a1hhNmZSL0QxNzJaS0FDOW83b09Fdy9OdDJjeWsx?=
 =?utf-8?B?b0VJeVJ2RDZVdk91ZWttSTFvVGZLSUNrcWZqY1VwaWlOMmxqUW1EY1hpb3Bl?=
 =?utf-8?B?QVlZWWpOY2k2U3R6QU04NUFYbWdOWmQ5UVdTK0hXdXVmODhxUHpXTWhDeDdG?=
 =?utf-8?B?TzZzWFBjUExZZE1rMzVDN2xVeEhyKzB1R0c0MVlCUTFSVm1IcUl2THhoQzBv?=
 =?utf-8?B?MXJ4WjRzaCtpVDB6NnVNT3lOY2JUbm9IaFhibzg2cXNGdXAxVDFDNEQ1bzRX?=
 =?utf-8?B?ZmJZN0M1d2JCRy84T2VSb3Z2RHFwdDlmVFc0TFkwU1g3Mm5NUERKZmxIYzBx?=
 =?utf-8?B?Y0UyNmF2WVFSR25WSHFQVS9VN0JuQVZBc0RPN1NZK1NuSnpRcEdmSk42L0Rt?=
 =?utf-8?B?VFB2QmxKTy81SzZyS2FtOG5BaldnQzBNSmZrQnd5RmJmRXMzaU5EeDBrbG8y?=
 =?utf-8?B?R3dVNW5ybHJqcXhxKzVpb1hFemtCdjBPWEFMck1obFN4QmFSckFHNjd0RTVJ?=
 =?utf-8?B?Sk5TS21qR2FhMkVLL1dWR0N5RVpZbjdwUlNodjRJV1RyZUprTEVIZy9lRTVV?=
 =?utf-8?B?TEl5Y2tXWEtTZkw0M0plTTRVMGFNSkxHWjBJVkNIc1NMMWZEZnNqU0VXUHZV?=
 =?utf-8?B?WFRsZ0RhaDlFVUlNOEZuV1AvN2RHWHY0QW9naVBXeVhVNXprd3Yxa0VRbUo5?=
 =?utf-8?B?UDJxbi9zMFdkUGE3Q3V2by8xYzl1c0FKYTRyRUQ4U1BUa2VwdFFia2dxUmlt?=
 =?utf-8?Q?D7pGjAhIlmHcLqBaM6P5rGQam1nfPNFk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTlrYWt5VVMvYlV5cUtmdy9hSUlrOUp2ZGIyejVvSG8yckk4ZmlkcjUwaUpk?=
 =?utf-8?B?eVE0Rlk1YUJSTjdpbk1HVnF1eHRmZjdNOW90ckw3c3pxNG4wQTRwVVZFb1Nt?=
 =?utf-8?B?cDJwaWJDOXlEQ0YvUTdIcXR0d0JuRGUzWGZkV3BpVE15NUpBSGZzSENucDN0?=
 =?utf-8?B?aFN4V20vZ3dTVEZvVmEyWVNSakFScWdiQjlVenA5UzBpZ25qWHhxTVlDY3Ft?=
 =?utf-8?B?Vk5KYVRxSlJMcnhRRUhtYXI4a3JsemUwTXkvVEdjdDdnMjJFUTNrdzBwaTB6?=
 =?utf-8?B?anpTamZ4b2VaRnVrbS9Wd1oxcUZuWEFMOEh2TnZXYzExTndicHNkUWs5djh1?=
 =?utf-8?B?cGN2akE2QUgxL3lsNjFxTVhySnl5K3p2cDR2Sk4wQ09vcWh6V001QlJPbUhz?=
 =?utf-8?B?N3VmcFo3K1RMMkVNZkwrTlFlYXIrUDYxRWNUNHB5RERvSWdjOHpwTWZmNTR3?=
 =?utf-8?B?WWJQSzVpcFFIangxUEJKU00zOHUrWEFZVWg5dzF3NWhMSU01eEpnVHJuYnNF?=
 =?utf-8?B?QTFLbGd5RkZLcHR1VGJpNEljV1FRc3ZWWXZ0UWFEdzJPSW02WmMxbEpoWWJY?=
 =?utf-8?B?ZDA3WXNBcW10SUh4dDdNOUVPQnVYRjlLTy9mMU0rbVlVM0lwTFYyM2hSVFky?=
 =?utf-8?B?QkgydExiai93aThKaXhLOWZ4ZWxjeU8valN1MlhBeFF6RVpyOE1qSzRGcFRa?=
 =?utf-8?B?V09BTUdqRDI2SE1sN1VaMm1CZnltbDdnS3dQYWpoTnNZRUNTRE9BOVNnWkpy?=
 =?utf-8?B?MXdHVEsrS3p0Q21xdTBoV2FqaTBCV3BHZW00TGQ2TFNOcXh6b25kTGxHampm?=
 =?utf-8?B?a2ZDaWtPZ3lnWmVMenl5VW9UaExLZzZjM0UyYXVjOFNJdXVBdm1DR3FlblNs?=
 =?utf-8?B?bGdidFVGU2EyTjRqZVlUWG41emtXYzZuQmxFUWZaMUJDVFJjWTNBeFpUTjgr?=
 =?utf-8?B?dTNmcXlRQWRoalZFaTZoS2JzT0pubjF2aUZUb3g3MmE3cXFaWU9SckZRVElW?=
 =?utf-8?B?dzVaL2dNWmp6MER2K2F4K3B5MzQ3VlhiNzFUakZPWGFZQTh3WXRDK0xRdVZT?=
 =?utf-8?B?M1NXVitJL3prVUgveUVQZ2w3QlBsdVZnZzZaYy9wZTJlZzI4ZVA4emQyeE1F?=
 =?utf-8?B?T0dmeGp1NlBFcTdlS0YzQmQ3S0liR001cTBKRDNGWjR6K2s4b2c2SVVWZ2h1?=
 =?utf-8?B?dVpsaC94bmo4SVhudStUMVFLVkUvQ3hsOUlKYmdUY2hJWFNjNDNrVGhmRlRq?=
 =?utf-8?B?TEhhOUZCQW00UEZwbEp6eFE2S3J2aGNNdUZFdjc3MkFoYmtwcUd2WWRRZERw?=
 =?utf-8?B?VkNndHhvQTI1Smx0MEFCZWZrVHhrTFBuUENOTDRjVnI4TVYzeks4TTRJNjV5?=
 =?utf-8?B?ZUlZbWxtNGVxS1F5bldRdWpxd1F2Q1JqVGRqSzd4bkNIeGtPMDBLM3VITmcx?=
 =?utf-8?B?RGNUbzhRUXNzbEptK1NCUjh6ekVmK1ZqWmxxUFRFTFljNW5pM0dSK1lVd3FB?=
 =?utf-8?B?MGRLQUNSbjZqQjNDbWxFKzNZQWEwM2M5S1ZKL1pFSFRnOWlocVBkYi9vVVd4?=
 =?utf-8?B?NkQ4MktXMFBRaVhVSnJRV1d0dW5lemRiWVlDbFFhZmVRSGVqSDMwUTlTUnVm?=
 =?utf-8?B?WDlNR3BPeHJuL3lNWDJEZ1ROWmZKWEJLa0Rpa2xzaUp6WTR4RTlhUlVoMmVv?=
 =?utf-8?B?R2VVS2MyWTZZRlZYSTc0TkNjK250aTlUQS9CV0FYeW1mVG9Nc00rdGRUUFdx?=
 =?utf-8?B?cTRPNFpvQVY5MVo1b0RoN3FobG5JZGNDaDQrdEtPaW9VclBNc1kvYTJ6eitL?=
 =?utf-8?B?ZHJyRFE5M3RpcTBPMVo4eDNyWWdaTFhNZURiY2dTK1BzWFo5Yi9DbnpkSEVD?=
 =?utf-8?B?VDhYUmxkWWdvSWFXR2REL1Z3VDU3dWFXQThPSXBYeC9pTWE3MXdpZE1NelEy?=
 =?utf-8?B?VkxabVZYOGlEU2FON3lYNUZnZjAyeUxZbnlRYUJlR0dRSzRpd2ZCREFVYk1H?=
 =?utf-8?B?QkxhRmNKT2hmc3Q0UER3SHVOcXdUdGliS2xVRFpoY3NFeVZDL3lGUDZ3N0NL?=
 =?utf-8?B?UW12K1lwUGpuRkZ3NlVVak90Y3Vlbjk2UHhoQ3RyNDdLdENLY0QyY01EbEFT?=
 =?utf-8?Q?vE2YnrhT6oqedkABVDXZTm6jo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046894c8-6693-4b1c-4dcc-08de30fd325a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 17:15:16.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWEptR521DAr14Rh9ekXsgE+qy5SeA4MmOZX78f7yw2iLZDgiG2+s1nPwUIMVc3sgsVG26wJJz/GZGkHbMpRiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972



On 11/27/25 11:40 AM, Kiryl Shutsemau wrote:
> On Wed, Nov 26, 2025 at 04:27:29PM -0600, Pratik R. Sampat wrote:
>>
>>
>> On 11/26/25 5:12 AM, Kiryl Shutsemau wrote:
>>> On Tue, Nov 25, 2025 at 11:57:51AM -0600, Pratik R. Sampat wrote:
>>>> The unaccepted memory structure currently only supports accepting memory
>>>> present at boot time. The unaccepted table uses a fixed-size bitmap
>>>> reserved in memblock based on the initial memory layout, preventing
>>>> dynamic addition of memory ranges after boot. This causes guest
>>>> termination when memory is hot-added in a secure virtual machine due to
>>>> accessing pages that have not transitioned to private before use.
>>>
>>> How does the hot-pluggable memory look in EFI memory map? I thought
>>> hot-pluggable ranges suppose to be declared thare. The cleanest solution
>>> would be to have hot-pluggable and unaccepted indicated in EFI memory,
>>> so we can size bitmap accordingly upfront.
>>>
>>
>> I'm not quite sure if I fully understand. Do you mean to refer to the
>> EFI_MEMORY_HOT_PLUGGABLE attribute that is used for cold plugged boot
>> memory? If so, wouldn't it still be desirable to increase the size of
>> the bitmap to what was marked as hotpluggable initially?
> 
> I just don't understand how hotpluggable memory presented in EFI memory
> map in presence of unaccepted memory. If not-yet-plugged memory marked
> as unaccepted we can preallocate bitmap upfront and make unaccepted
> memory transparent wrt hotplug.

If memory that hasn't been plugged yet never gets plugged in or is only
partially plugged in, wouldn't we be wasting space by preallocating
the bitmap upfront? Or would that not be a concern in favor of
transparency?

--Pratik

