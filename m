Return-Path: <linux-efi+bounces-4261-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77573AFF0D5
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 20:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C142317D5FC
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 18:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB2F23816A;
	Wed,  9 Jul 2025 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ciTTNl56"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA88F40;
	Wed,  9 Jul 2025 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085474; cv=fail; b=K9p6A5FBlcfrQun9PuDWH4nvTT6sXyrgKTUe+TjSMo6fuESsrb2qtp+eEbNNsA2QGhcZpgrPmE8I477nGTcpXl8zGF/yrlb33eTzjwOBThv8oGi5eMpjClbWrUmAbp5INj76yHbJhR1WM7aWvOMHMETfSoRubraaE78X6sb5q0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085474; c=relaxed/simple;
	bh=7PxJez8qC/HDeS9BaZopumOCizlccUj4LOIvQi6fOkY=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=owpvNjBVrdjBeh35lZFgNiChrGL+kgbK/GJuEOVibKaowWtjyMF8g22WeuN5XZeui0JxL27qBgsAbDcqTt/gT2k1ddtJnKNzSWaBsPBbvtbxFoBZEywhB4LkwU2ebWnR5Rd+0Krw6ezH1RNIw9qWpE5tLsIb6qMpUaN7sDj5o8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ciTTNl56; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxnIJD7UoQdwp+wEnqV0ThvOIlA3sXgUbknZAXZHMUyXJ+ca8rWIoEft/WGNBsPQ1MGjyUQI7d4OTblmdlk4gmnZjShGhMmz3JU3yl0GRmsiTM2rV9VBqXXbovoa1H7rN0FuXlAmYG6JH1AQJL/opRbuy3EtqlPOYv6zdD3/XCM4fIIUVHh3Tp/wHimVWo/769FkFKv76Ydkizhg7u0k7pBOkr/g7u7mZ1OQQER4wdJ4T5AI8suD4zJDKAoB9U2nrDMF6TtFqjgE2Ypuj0r77PfTlyLyA8bcKeJ7OCFdXl6zZkfYTGttT21xI13+TvxMksLOObieXU7SlBs2kX8ECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHELHlKA4B0m66xvmBM0Q8Yn6RqXp6nd42aeA7OAbcI=;
 b=H3KAW7aQllIInQ061nCjybL+ka2UkERpK34cxc32uqQ3sTjtvpNsd+F5UwtThFGKDYOPPK7ZTCcx3Yroi8YiI3Y0ha3mWmDIGQYem/SgW5e3MG+N4TzJmibzTTzcbdBk8KZ72atm5pHEZHs5fTg7lGYlFVZKdKH+HUAliREDaYyJpVRenkpVRLtQQXBzj8AFE0Pmq50man4hl206vyA3W/k8pcbRETPUjDq6lJZhqhkF71YyTDXoQRubZvaH3Dt20z5XxwV9SiqlcYEO1IQPlyM3UIyLNEmeVNmAMP4CCI627fGfJ6zCTryYlZI/Fw23uJLRgJx+Xi2DgshbfIeVPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHELHlKA4B0m66xvmBM0Q8Yn6RqXp6nd42aeA7OAbcI=;
 b=ciTTNl568KCOCod2DdWvkBimbIEivL5iAOOE9UKY2tBhObUwEUPpMBpQtaJJvHDH7H4hq/ax0C8Z2cRuTmNqqBaRprO/CwMtdhnHpwkPARGhRulptP535i21uzFHUtTYfuSWi3c2IjHHAEN/gdQLj8mjwh8jMBJVPBiep/9CImk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 18:24:28 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 18:24:28 +0000
Message-ID: <d872728a-e223-8bcd-7652-7dbe38d93802@amd.com>
Date: Wed, 9 Jul 2025 13:24:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <20250709080840.2233208-26-ardb+git@google.com>
 <20250709080840.2233208-34-ardb+git@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v4 08/24] x86/sev: Share implementation of MSR-based page
 state change
In-Reply-To: <20250709080840.2233208-34-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::34) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 29825a5e-6259-4549-3499-08ddbf15d6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDFCem5Uamt5WnRyWi90bDhLek5BYlhYODgyTnRHQnlSSGNRcGZwSEhsY1Js?=
 =?utf-8?B?aHJMd1NvZlY1YmdaN1lmZVhMSVJJTUZYdWt4N3M2Mm9odm1YVU9FTWJhVUdh?=
 =?utf-8?B?QTFFU3hDTmVLRDFmS3pKajZNOTMxS0VOWkRoMWVLK1lraXVwZUtRTDNIVkU3?=
 =?utf-8?B?RFhCRGhIUUVkMkp5MjlOS01MNlhETUloTFB1dkZPM0pWVUhNMDdrQXJJT2N1?=
 =?utf-8?B?WVQ0TkRMRERqQ0E1ZEI4WHVSZDdXZGFaZWg0Mk9zZk9RTm1meE9GY0l6dWl2?=
 =?utf-8?B?alZvdEEzMlFwa0RiL1QrU1hUN3YzZmU0ZGp6U0FYM0tnZkRndXpLSUpCNUdh?=
 =?utf-8?B?QTc3ejVaeG53NDN5cnNIWmxrQ0owYUZxRHY2RnY2bm50dlA1TXBNNllFd2hJ?=
 =?utf-8?B?dnR0eXk2aFV2NjdvT3BVZjN0SWhyQU9vM05GdDZMbmo2REFKZjYxUXl0aTZI?=
 =?utf-8?B?MTNHU3ZJdmRkanNvUzJxWVprYzc0VXhTNTJkZS9pZmJ4R3ZNUGxRY2hrTFRw?=
 =?utf-8?B?SGxqYnMybnU5WlZOQWpiWWdLaFlxdmNmdml5YnBKZlF5ZkNQeE4xREJIUWZJ?=
 =?utf-8?B?SE9qVmtyTVVtZ1ZQd1A5Y2YwaTlxTGVUbk1BdDB6ZWRTYUYyL0NEZ2VnS21y?=
 =?utf-8?B?cGxCekFIMHJCTWZNSEkxKzVoa0tGcU5YWUdmaTBWNUVjaitaMFJreHRBazZm?=
 =?utf-8?B?YUQxTElPeGZQQndvbk9DM2VtUFdIWmNKNkhqSUFiM3d6bml1eW0zWmQ0bnpY?=
 =?utf-8?B?bStyY3RUcU95Z3hJU2pvMlNHMTkvRkhBMGpRWkltSU95RlpBdG5BSzUzbHgx?=
 =?utf-8?B?S0tBRHdUbWZQSDYvR053RDdJQkhTemsydzlvYi96a2FLZ2VOMGNNeFlXZ2Zy?=
 =?utf-8?B?TlZmcGFtQVZxT0RxOExWdzJKeGdTQWtwMTFXMHRRZk44MHlESDROSnFLK2hK?=
 =?utf-8?B?cDRlY0JudDZnaEs0RzI4enNWWkg3UlpCTGk1aVlzYXJBR0FBaDZHSmVhS1Ba?=
 =?utf-8?B?RStob244Z2Urc1E4dDZMUkgxZC9WVVBpTnBxT1M4ditvMWtyK3prWVk5R05p?=
 =?utf-8?B?a3d1bTZ5WDFDMFdFdkxPTnRZTzhXQ3hTUUoxc1l3Sm5aR0dzZlpGTDk0RzZO?=
 =?utf-8?B?RURyWFczTENSNGxNUm45R25Yei9RN2d0TzRoeGNtZWEwVUNmSmo1c1NGbVVE?=
 =?utf-8?B?Tk5nY2NsV3ErQkNRWGRvQnR0K3hhWGZ5dTR6OUR3MzFJY3BLUTNTMCtQZERS?=
 =?utf-8?B?SlA2WksvMVpxNmFrMXJiM251ODF3V3lFOHg4RW9mNHY4TDU3RGFWN2pab1Nk?=
 =?utf-8?B?NktwTFVlUll1T1A4ejVGMWtLWWl3V1d4c0kwRm50SkZXK2t6ZDNxdCtxb3pY?=
 =?utf-8?B?M1laR0ZZbndYYVNrUUR6Q09DaUszNlRkUFk1NlJ0SG5EaWZFRlpkQ2JHbXdn?=
 =?utf-8?B?MHJHRkQraTF2YmloL0NxWUFIcy91QkNPd3p6THRRZHhyVFpvWTYxdXo4THFQ?=
 =?utf-8?B?eFVkdTZMQnJGT3RKUkF2YlZZN0FpK0FlZ21qdy9rTXpraGI2UVBNWG9TK3dF?=
 =?utf-8?B?MnZHanBPSHZ0dnFrQVJSVno4bkM4eE9XcjlTWlEraWJDcWhnUXZFK2cyQTBG?=
 =?utf-8?B?Uks4TTNna3hQWkFtTks4eVhzMDBCM0cyYzZNOUNEb2wzV05Vem9kTkU4RFZJ?=
 =?utf-8?B?bCs0dmQvTWx6V0ZEK0c0U2dYRU85aHkrT24rQ0RXeTJCL3BsMnB3V0Q0LzQ4?=
 =?utf-8?B?VGtkUzhvTzBIbTloMTVGUmhTMHlYR2R5MDJxNEVGMG5ucnY0b2MxOVVibHlY?=
 =?utf-8?B?WkRXRUlQYnJWOER3MkJteHRXUnhRamRMWXZvT2sxRDgyd2FBV1o1VjBWbVly?=
 =?utf-8?B?MVhKNDRncTI0OGEvaUZDRTc5QVRoRHhOaTRxeXZQYTB1M2RPc0g4WGxEQldi?=
 =?utf-8?Q?QxT+APH0jTg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3plVGNZRFE1V3dzL1dOOEVQaGZZS25ycW42WVphS1kvendFek5MNUJlcUdo?=
 =?utf-8?B?SkVPSGFuNFBGOUo3OTZ5SlFHQWl1c2FRSlZVbW5ucWFHUjBLVGRiNFdTT1px?=
 =?utf-8?B?WS9Rdzd6Q0xBU2xGUlVjS3lHb3NNeHE2cFZZSmVhV0RXa0tpVnRlMFZieFFa?=
 =?utf-8?B?SWtVektOcHcvN29waGdwcW5qK2R6UkdXWUM0S2UvUWdXUG5HUXh6RmhpdEtD?=
 =?utf-8?B?dzhqMjl0RlYvemdWME9NMXc1QWlFdkkxaWlBSENKN1BZWm9zbjJqV1h3MUNa?=
 =?utf-8?B?UHF6ZzRDU2piblZuNCtwMC85MURsWWFoZC9Xd0J2NTJSRnpud2xIa1FDd2hM?=
 =?utf-8?B?RERSUXNUTFFZQ2d2REMvZkp4Z252VlV0NUdZalRaYjFvYmFPMHh1bUxub1li?=
 =?utf-8?B?a2RlNkJ4d29ueWgzNWF4NHI1TUVySDRZYm0rY2hCWkprNFNTREd6NXZGcVBY?=
 =?utf-8?B?UDZZRnJYT1RqTVdySEw3a0ZHU2krcUlSWWhaTEdEZHJHV2c4NmJrSWdnZ04x?=
 =?utf-8?B?MVBBUHZQSFZ5cFNOODJERFJ5Y3FLTVZZbklTM1FNK0tXaGVJYVRLeWVCYjZH?=
 =?utf-8?B?dTZmRE5nZVRKR3lpR1pHQjQyTkNHRFFUUkRyeXlqcFhHVkFXOStsUFJYdTR1?=
 =?utf-8?B?bzlsajBuTlZYYzZkTW93aXF1U2RzWnVUekJtdGdibWw2cUFTbVlYdXNrcGVX?=
 =?utf-8?B?THZPV09USUxCODh6cUpNT0VuNUR0aFlBa24wN1NxNC9OM1NrbmpwZkI3dWlI?=
 =?utf-8?B?NXVhYmxkSmdpcWR6TTB2ZG5hZ0dHZkF2ZFVZakREVkZaRmR4VTdHT0R6MXVC?=
 =?utf-8?B?YmE0N0xFSWFNa3FxVWk0TTU1Y3EyT2JEamdWM01ORFNaYTNYcEFyZlZ0d201?=
 =?utf-8?B?eGdXZzhYc3ZPZC9jbWdKTlNiVXJOTjZkY052bngvZE95SElNZ2VtTlpDS0NT?=
 =?utf-8?B?YnN1L0wxVHM3VnNjb0RpMG5ROVhNZDI0TGZZSlVKRkgvN1oyNmF6SXJQZk11?=
 =?utf-8?B?Y1Y2SDcxSDJoOHNJTitDaWYyM1RoZ3hwajFHb2F0NDR6TkFXMWZLc1IrUEln?=
 =?utf-8?B?WlM0ekpkN3pzYXIrQ0l2dkFNcjZHWS9mbVJRZ0J1Z1RCSFppZkFsOG4zSUQw?=
 =?utf-8?B?Z00rcE8yeU9uaUE5L2ZVVlJHMDN6OTFiRzJCaWtwOHdzbjB3S3pGVGtCSkI3?=
 =?utf-8?B?bUhSeGNYS29NMnAzTTVBRE9oVVFaZVZkOHo5VWpCM1g3UVhvblVTeW9mVGJV?=
 =?utf-8?B?ZFc2ODJJZWlQdExwSy9zTk1QSEpLNmUyVDhYbXRFWGduVXJRbjMwSjVmVXhL?=
 =?utf-8?B?WHNIRWtEZ1VFM295RFlHNlpUVkRGUk56dE5YRWg2cEhUdksxUHpIZ3Rnc2Mx?=
 =?utf-8?B?Yk5VRmlFdFFyV0VLSm1MTGlKT3dQZEFac0RwRlhSQ0gwaWp5VE1ISGVjalFI?=
 =?utf-8?B?dXM2QzkrNE5rOFJPSys3THFCa1BGWWsrZXJhOHB1U0o1MnFEem01ZDVVazYv?=
 =?utf-8?B?M0tPTFpwOU5zZmZCV29WRW5CVkUwZEFEeXlYamNFaFJSaVk5NnJ6d1BHUkdl?=
 =?utf-8?B?d0RIQi85ZjFCV3Q1bExiTkVicWtxZHdLUHVUSDBuRncvNUZpYkxHV2wyMnA3?=
 =?utf-8?B?cEozUThpMklBWDBlNDBqcjZTeXNNeVVQNTVVTWs2VnNGME5POWx1VDljL0NC?=
 =?utf-8?B?a0FHRk81UFZad2owUVBERnJZUFRjV0NVa1d2TU5XMFlvUThWb0ZLTHdVd2dv?=
 =?utf-8?B?N3dIbzdJVzJSbzNsMXk4Y3ppaklvWTkwQkxxUHAzVzlscHUvalAzM2xpRHlX?=
 =?utf-8?B?dkVuYitOdHVyM21qQU5YcXRTb2NiU3dXTUVVWThNbGYrcWFyZENpbVRIK2Za?=
 =?utf-8?B?MEx2SzF3YlUyVnY2L0NSQS9Ld1lHbkhzN1JYcjVKZE40RU1DK1hDNjJvL2du?=
 =?utf-8?B?V1FnVGE1TVZIVlFVS0xXOUNjeDNIemY2dnYwM0ZhWHQ1aDRnTlpaSlBERlNE?=
 =?utf-8?B?cGxYY3hyem1rNkNEVDVpN2xLTlpPTjB5NkVYRnFHZzJRRElxU3dzalRObEt3?=
 =?utf-8?B?emRmQW52UFg2RUtKVC9TSm9PZ1g5cmtkcjB3OTdRRkxvWTM3SWdPQldHVys0?=
 =?utf-8?Q?EhMDHSVKlLjYTaHoMnE4Kx34R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29825a5e-6259-4549-3499-08ddbf15d6f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 18:24:27.9482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9c4mI6skOz7XYPTxjzgK2kF6kKCQvTRQZtwLgTHiICCGvZ5vr853SuFRMflkHnfHbt4ws0XSLbjVXGuhXIz+kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392

On 7/9/25 03:08, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Both the decompressor and the SEV startup code implement the exact same
> sequence for invoking the MSR based communication protocol to effectuate
> a page state change.
> 
> Before tweaking the internal APIs used in both versions, merge them and
> share them so those tweaks are only needed in a single place.

I think you can keep the save and restore of the MSR in the the combined
code so that you don't need the previous patch and that will keep
everything safe. We should be doing a minimal amount of MSR protocol
page state changes, so it really shouldn't have much effect.

Thanks,
Tom

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/sev.c      | 34 ++------------------
>  arch/x86/boot/startup/sev-shared.c  | 29 +++++++++++++++++
>  arch/x86/boot/startup/sev-startup.c | 29 +----------------
>  3 files changed, 33 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index f00f68175f14..6d3ed7ed03a4 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -60,34 +60,6 @@ static bool sev_snp_enabled(void)
>  	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
>  }
>  
> -static void __page_state_change(unsigned long paddr, enum psc_op op)
> -{
> -	u64 val, msr;
> -
> -	/*
> -	 * If private -> shared then invalidate the page before requesting the
> -	 * state change in the RMP table.
> -	 */
> -	if (op == SNP_PAGE_STATE_SHARED)
> -		pvalidate_4k_page(paddr, paddr, false);
> -
> -	/* Issue VMGEXIT to change the page state in RMP table. */
> -	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
> -	VMGEXIT();
> -
> -	/* Read the response of the VMGEXIT. */
> -	val = sev_es_rd_ghcb_msr();
> -	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
> -		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
> -
> -	/*
> -	 * Now that page state is changed in the RMP table, validate it so that it is
> -	 * consistent with the RMP entry.
> -	 */
> -	if (op == SNP_PAGE_STATE_PRIVATE)
> -		pvalidate_4k_page(paddr, paddr, true);
> -}
> -
>  void snp_set_page_private(unsigned long paddr)
>  {
>  	u64 msr;
> @@ -96,7 +68,7 @@ void snp_set_page_private(unsigned long paddr)
>  		return;
>  
>  	msr = sev_es_rd_ghcb_msr();
> -	__page_state_change(paddr, SNP_PAGE_STATE_PRIVATE);
> +	__page_state_change(paddr, paddr, SNP_PAGE_STATE_PRIVATE);
>  	sev_es_wr_ghcb_msr(msr);
>  }
>  
> @@ -108,7 +80,7 @@ void snp_set_page_shared(unsigned long paddr)
>  		return;
>  
>  	msr = sev_es_rd_ghcb_msr();
> -	__page_state_change(paddr, SNP_PAGE_STATE_SHARED);
> +	__page_state_change(paddr, paddr, SNP_PAGE_STATE_SHARED);
>  	sev_es_wr_ghcb_msr(msr);
>  }
>  
> @@ -137,7 +109,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>  	u64 msr = sev_es_rd_ghcb_msr();
>  
>  	for (phys_addr_t pa = start; pa < end; pa += PAGE_SIZE)
> -		__page_state_change(pa, SNP_PAGE_STATE_PRIVATE);
> +		__page_state_change(pa, pa, SNP_PAGE_STATE_PRIVATE);
>  	sev_es_wr_ghcb_msr(msr);
>  }
>  
> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> index 7ca59038269f..f553268d31d7 100644
> --- a/arch/x86/boot/startup/sev-shared.c
> +++ b/arch/x86/boot/startup/sev-shared.c
> @@ -640,6 +640,35 @@ static void __head pvalidate_4k_page(unsigned long vaddr, unsigned long paddr,
>  	}
>  }
>  
> +static void __head __page_state_change(unsigned long vaddr, unsigned long paddr,
> +				       enum psc_op op)
> +{
> +	u64 val;
> +
> +	/*
> +	 * If private -> shared then invalidate the page before requesting the
> +	 * state change in the RMP table.
> +	 */
> +	if (op == SNP_PAGE_STATE_SHARED)
> +		pvalidate_4k_page(vaddr, paddr, false);
> +
> +	/* Issue VMGEXIT to change the page state in RMP table. */
> +	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
> +	VMGEXIT();
> +
> +	/* Read the response of the VMGEXIT. */
> +	val = sev_es_rd_ghcb_msr();
> +	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
> +
> +	/*
> +	 * Now that page state is changed in the RMP table, validate it so that it is
> +	 * consistent with the RMP entry.
> +	 */
> +	if (op == SNP_PAGE_STATE_PRIVATE)
> +		pvalidate_4k_page(vaddr, paddr, true);
> +}
> +
>  /*
>   * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
>   * services needed when not running in VMPL0.
> diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-startup.c
> index 8edf1ba78a48..2ffd8bf09357 100644
> --- a/arch/x86/boot/startup/sev-startup.c
> +++ b/arch/x86/boot/startup/sev-startup.c
> @@ -135,7 +135,6 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
>  		      unsigned long npages, enum psc_op op)
>  {
>  	unsigned long paddr_end;
> -	u64 val;
>  
>  	vaddr = vaddr & PAGE_MASK;
>  
> @@ -143,37 +142,11 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
>  	paddr_end = paddr + (npages << PAGE_SHIFT);
>  
>  	while (paddr < paddr_end) {
> -		/* Page validation must be rescinded before changing to shared */
> -		if (op == SNP_PAGE_STATE_SHARED)
> -			pvalidate_4k_page(vaddr, paddr, false);
> -
> -		/*
> -		 * Use the MSR protocol because this function can be called before
> -		 * the GHCB is established.
> -		 */
> -		sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
> -		VMGEXIT();
> -
> -		val = sev_es_rd_ghcb_msr();
> -
> -		if (GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP)
> -			goto e_term;
> -
> -		if (GHCB_MSR_PSC_RESP_VAL(val))
> -			goto e_term;
> -
> -		/* Page validation must be performed after changing to private */
> -		if (op == SNP_PAGE_STATE_PRIVATE)
> -			pvalidate_4k_page(vaddr, paddr, true);
> +		__page_state_change(vaddr, paddr, op);
>  
>  		vaddr += PAGE_SIZE;
>  		paddr += PAGE_SIZE;
>  	}
> -
> -	return;
> -
> -e_term:
> -	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
>  }
>  
>  void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,

