Return-Path: <linux-efi+bounces-3454-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7822AA9B0D4
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 16:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68001921456
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FD519F11E;
	Thu, 24 Apr 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XX/mP9vb"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1F1A83E2;
	Thu, 24 Apr 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504329; cv=fail; b=n8ScEqk7ULecTNlL0oReIgpoY6J3kYUhCJMH9cxCS3eq/yXV/esxm6nai+/fECTs3Z8TiKT0o2hPQzob/msvQAeegEc9cWMUTXiYkIh9vdkmX+ahNwG1lOQy58kNzu1xvLLU9ZUF5rC2WPQ2Co941bcAeDgyo1GZXnupPUbyj+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504329; c=relaxed/simple;
	bh=uWpwOj96XjQO8lTsIvRu80mVV8hnzyH/OGqvsG/DYbQ=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=ja+zkTdNU26d9pBDZgsYyTqWDIo8EAOjg1RwGX/TKvLsjoR9FePyxe5t0KRG8n95Bn0A9gziGahVP1apBlgtpOBxW2bJ3uaGoXW+5WsYjes5z1PSir+SjX28Hr0A9Sz8HqhUmPXRHyLKPkTP3+epLun/F16ia4/CWBLcUgMOztY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XX/mP9vb; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyqFxzEDxwQ8FZj7PaV2zaRaV2vGvNjZDSw8D25MYOHuJMnr4J54nMeOWNHTvVPa8zYTvw5dFfO6+hWvTjGsLhNQULpggdT+2mP9DKpyF0zzN/V0jUX2X/OGYJo6eunR1LDK7qv+SdOxxBUJ6SQmKAV3DUJwbMil9XXpbQXJVHQIcoXrYsiOVfHBxqpuBqMYL6vK4Hii6QXogcbexo8HvO5XNcTrR1mC53rkESnmHOt4X7r2G8LvwPbCMojqDgBQFTZGwZ0qmL/iYOgMAUARAWZmJvCzeCwsh4+qDCUnI8ox4IPYHLQAGgV1pZmrqTR3HNtiIizlgYu1O+a2MfqYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFQTLKOdkPGUYyOALkRojY3/osF39Iwi/4faoU56YDI=;
 b=y9EQNAJwIAv67CAeTaktIYuSBy6oVzrYlMpADve5KgzL0r67cZpLyyROMQGqk/MNR5TdeZqrkX1zd3YIGeYgw9A7j7nicOs5WBZ9D5T+9L43yNWbbgEbXZvZHFf2HvVmPCaZoMJgOQHuO+tSytprcDOLSroxarJl4d31s9t30dj0wgSw8QU/QX/cO183xh9LFrClMDJzHr2zDwHRHhVerQu06RhM3OorZvL0mtZo5mwfHarARqPP7Shw1PfQo45tXbagtjfcVpikpF05QHsMLu27tD4tk0YuZzx4Pdm5hE9z037CnT9YYp8QKmo/aku9apCRgVOjpC7lzdE8qu3GOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFQTLKOdkPGUYyOALkRojY3/osF39Iwi/4faoU56YDI=;
 b=XX/mP9vbTOVlI5GLwvcOXpsin0RHXXliyOP6iI/+jcyyLm2sYhsuyvTBrvoCO28ozoAuYqMrYP2x9pWi/srphnCGooTnxRoyW+yRyowSrjuUfayQs8jQw4sj2dPGyH0Fgg+CINKmC5lp467eB5RmLVsZly75D34NlE/rQyyOw1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Thu, 24 Apr
 2025 14:18:45 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8678.023; Thu, 24 Apr 2025
 14:18:45 +0000
Message-ID: <2294bbdf-7860-f6c8-0162-992ee79f4817@amd.com>
Date: Thu, 24 Apr 2025 09:18:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb@google.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
 Borislav Petkov <bp@alien8.de>, Dionna Amalie Glaze
 <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>
References: <20250422100728.208479-7-ardb+git@google.com>
 <d00c9119-5e8b-2615-8e4b-2d25732ff71a@amd.com>
 <CAGnOC3b2XBFw+xdMhTtpfDYG480BG-KwfkPMWOiOP+13XeHFfg@mail.gmail.com>
 <CAMj1kXFCqLnWDw7hJVL9FShF9V=YZ_Ucf6jSSeq0E=BeuENdkQ@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 0/5] efi: Don't initalize SEV-SNP from the EFI stub
In-Reply-To: <CAMj1kXFCqLnWDw7hJVL9FShF9V=YZ_Ucf6jSSeq0E=BeuENdkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:806:120::33) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ccbd9a-904c-4ef1-d3b4-08dd833aebe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0VwdGswR1BYUms2Wm5zSUpWalFKSEJCYStDeFcrdzRiWDNhY2JiRUJERjdF?=
 =?utf-8?B?THpJQXhlVFpsdVJFckV6cE8yVkxYRHgyR1NMaHRuK056cVkxSDZjQWttM3do?=
 =?utf-8?B?TE15bkpUdFVSMFhUZzZrMmtlc0VJUWtmWXN4c2FvL0RlNkovNElEMzNnUUUy?=
 =?utf-8?B?OERqRGxDQ2t4bEdISExBSnp0TmtFRlBXMlBtU3JzM2RmcE41ZHFxQU9Hclh5?=
 =?utf-8?B?NnpvV3laNzhkVnJEM01vdVdQdGhVQ0IvZEQrb3VxMnRhSkVOTDYwVXNzRisr?=
 =?utf-8?B?ODFFNVpoWE8zenRqQTJZNHdxMCt6bVNkVno4T1Y2b2RZNERqMWh0M09YZVF2?=
 =?utf-8?B?cVRGUmxERlJjQ29JZGFLaU9TYjc4YVQraGVLTmRJOGJLZG1sTXNNdktCOEZW?=
 =?utf-8?B?QVhFckl6ZjRSQ0RpRVBGc2dSYkUzZ3ZrbnVCR3FIUzJwV1dVNHNyVkhTUlhu?=
 =?utf-8?B?emdWK3ZadmVyNVNPaXIyNXhhWExCUXZlekl3eU9ZZi91VFZsMkNHdmNOM05s?=
 =?utf-8?B?UnpIRXNlWGMwajA0WlM3NXZPSC9ERFNtb29vL1ZmcVpDVVhPWVFEaWp0UCt3?=
 =?utf-8?B?Tkd6Nmtva2hpdWM1TEUyZ2lHVVJmR0pFNlhlSW9oanRMV0JwZm9oaG9td0FH?=
 =?utf-8?B?NEU2SVRKeGVEbXNGcVY0eVBMVWxSOFFnbEUySVZwdExidUlBbHV0NDE0b2JN?=
 =?utf-8?B?YnRNaUJHLzk5WjF6QTFsSjNGUzV0Vk9rYVZrQ0ZKcW8rOGUwSGZBODBnV0Jj?=
 =?utf-8?B?emJUbEZHSGhmdFlTTlJJMzVxT2ZlMVdaTGhXVGhvNGUwZlAwNXlMZjVKOUFy?=
 =?utf-8?B?c2dMVTZ4ZTNZWWQ5WmJxTGdiV2lGTXRXTlZaVGlLMVFJU1hWRGE3bDVncHNx?=
 =?utf-8?B?V1JtbDNhV1U2UXdHSFAvcGtUV3FxempaU0tsekZ6eDlSa0hqYUJBc0JxbXl0?=
 =?utf-8?B?NzR3OW1aQ1d1VUcxbnVsS2VyQlczR3AwYnJsUDJXRmFnbmkxQjZHWnppS2pk?=
 =?utf-8?B?MUY3ZW5OUHpzbDdVOGRHTi9POXM3SjE1WlpBeXNYZnY3WmtXRjArcmxCcDZQ?=
 =?utf-8?B?M0xjQXA2U0ZKVEh5WlZveTRzeVlRK1ViY1pMNnhrWERteHRhaTJQYVlNbHg3?=
 =?utf-8?B?S3ZWb0xlbGpPbndSME9vQTFVZlFiYUN6ZWJjMDgwdXlQajUwZm9WbDZPcHdM?=
 =?utf-8?B?Y1Jva2FHajRtZ29DVU9nQ1gxRkNuc3BMclEvQWpHckxzVlA2ckRONWV6VTk1?=
 =?utf-8?B?VTVielJZR3dYdU1HeVNudkhxRUVYYi9neTRSUEhPVXl6Zzlxai9kTURKekNW?=
 =?utf-8?B?SkZxSUM3YVMyL1FtVHVwWXE5QlBYNjAzUWd0a1ExZ00wcnNnQXhNUVVPZ282?=
 =?utf-8?B?V1JNajZHQTF2bVpVSi9WYWRBZmZ3TzJpUU10TUxVcGgwZHYxMEZ0RExTNmxO?=
 =?utf-8?B?cjdFMlM5cXVrNkIyNWVjWFlEcUk1QXpidVlvMDR6Zk1kUzVoRVpsL1dYV1E5?=
 =?utf-8?B?clZWOWlTQmtxMi9CQ0lWRytldmdqaTc4L3FwT1hHTmdqQjNnWHZxbmNZTFBt?=
 =?utf-8?B?MndCZ0VHaENUdGNJRGFYNGVnOVcwZ29hcE9TZjBmNlV4VW12R2Y5RUtFemlB?=
 =?utf-8?B?NXlyazlJTFpiMUtkNThOVTRsbVV1NHgzOWRFWCtZQXA1TEpwK3FPZExSQmpm?=
 =?utf-8?B?VmlDMEF4a0FuQlNGVmFrWGphTjNuTmEra25LdEplUjlXNW9QZEhnRTRLZnBm?=
 =?utf-8?B?UHd4OUpMQjRSR052bVBqbzRtaENCZWpoak1VV2tXMGZ3UjVrOSt5WXU0NHhQ?=
 =?utf-8?B?WU5CQjFkb01KZ2x6bnNuMXU5Qk9xd2hyZVdNZ1ZnZTk2c2NCKzVHWjRURjlJ?=
 =?utf-8?B?MVhPbHh3ZXo3SWpKajBqcWNuUXAxSmlzMVRRYTVrMW1PQlJia3JCV0ZGUDRp?=
 =?utf-8?Q?VWyb4TM9Z20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGppK3VMQXhBbjlJVmh1ZFlxTi9kRVAwWEpwQjgzalBSZ3Bnd3pCR2NLb0xG?=
 =?utf-8?B?YStHSGVSbzByU2wzZnY1aXNra2FwY2RNM3l5ZmZmOWlrS2ZUT21NUTJ2UVRX?=
 =?utf-8?B?M2xSTUtISmExZy9xWjBKSkVxSU9LY1k4eDhMRlY5NXJSMzFDYUJUS2ZvUGNY?=
 =?utf-8?B?bk9yakoyTFBPbWtVbGlHdmV4M1grdjR0YkJvOHgzcE9DcWhreTc2WkFsZDJ4?=
 =?utf-8?B?QmsrR2JjazdkbjlDMlBVZjVuMTZoMVVGTkswUXVtd0t4eUl6MU53am9yQ0Zi?=
 =?utf-8?B?ZGxBdWpGU2tuOFlqTWZZNHFFR2hiNHArSVNIQUp4SE9tR0RrME83dUQ4dC9X?=
 =?utf-8?B?WW1NNEFQdkw3V2lhV3I2OXdndmNnaW1qKzVmT25kTFRxRXNWMTV3Zk55Z28z?=
 =?utf-8?B?R2ZLMGkzMFJvU1Q3bHgrUUM2MndYeXZKK3JQbHNwS0JqTmVCbCsxcmZxZk5X?=
 =?utf-8?B?NXBZQXhHV0RaWTR6MmpjZzJETndHMExsTU9lWG1ZbW01alk3bnd2OFB6bTRC?=
 =?utf-8?B?R0RpS1RWQnBha0pYVGxhM0RTK0JPRU1YMmhmWmFwanlaZDBmMkZLK1lSQjRQ?=
 =?utf-8?B?U0NVbnlPNzJlbnZSZm9MRy82WkZjTmYvRGpleU1rZklxOUphVlRieGJZOWl3?=
 =?utf-8?B?c1ljemc5cFloUDZYQmNqbHRvbFNmNjI4V3dUa1FYRHRHMXFhQWwzanBKWTht?=
 =?utf-8?B?OEo3YnljYXRhakV4VU8yc2MvK0tZYnN3R3lXQTUzcFNoaGhhTnBuYnhGNUhr?=
 =?utf-8?B?aS9tOEZQcWJpVmtHUC9weWxpWTBKci9mZHh4SEJaWnFtamt4bWt5bDFaSGp1?=
 =?utf-8?B?SDBKSzdYcDZyZ3Y5bWNRa3EvMllhZk1ydXJkT3hoYzE2R1hBZGpHdVY5NFNT?=
 =?utf-8?B?RTk1M1VYRXUzTFZGem5mZGNweHhJUWtVRXcyWWJvclNpR0FvRFJZSVBBWW1i?=
 =?utf-8?B?aW85K0VLMjBYcCtEU3lPUTZscHgyek9tcTdqbDJQbE9TaWxhZk45dENxQmNS?=
 =?utf-8?B?cEpoVE9EVXJZOS9FYll6Um1yVWtObmZKTnBJaGpjRWhUTTNxTkllam1XSW1D?=
 =?utf-8?B?S1VhOThmbjk1NXFBTXVaN1BQbUYrZHVvbUc4azN1SHdxVG10OEtmSkZ2TTNT?=
 =?utf-8?B?b1BsSW1nMjFzNkw0NnNtV09rT2pGZExLT1hoeUZQUDhYQXB1eUYxRjJoVE5Y?=
 =?utf-8?B?NW5nUjBSSTgvWkZyMXRJMTZMR0tONnJQQ204MXFqRGwzRzNZdW85RWVqZVBz?=
 =?utf-8?B?dk8wS2lmWHJsSk83TzAyRnIxNy9HNm1icFBneHZCNEh2UUNITGl5VlNTa1pp?=
 =?utf-8?B?TkR5ZFlKUzJnOG10TU5rd0p2TVgxbmYwMGJPUytXVEdkSGJKWnUxbmUvQml3?=
 =?utf-8?B?bEFMRXVqeitXUlhNOXNVc3ZzVTJ3MjR2ZG9pK0p0cDhWZmhtMXh5YVEwNGN5?=
 =?utf-8?B?cTY5TmZQYU0xQVozaVJHM29MUnVDdW1nNCsxQzdWTkhneHNyU2dsRUtSNUsz?=
 =?utf-8?B?WXBObnRML0pvRjFnbGhzNUxrY1czOHZlSytkLzkyQUtFZDN0WG5oMDh0VXV5?=
 =?utf-8?B?ZnlOV29oT0xZejFBTUNvaks1YWw2Rk5YSHdXUmxPTzdwTzlqSWRFN1JFM2pz?=
 =?utf-8?B?UEFlOE1jMHB3MDdRZGEzdFQ0TWtIK3NJUnBnbDExSTVEQXVUbkEzYkc2ZnRu?=
 =?utf-8?B?VmNkZDBMdHo5REdSclg4T2orQmpLTitqREwzWkNKTjMzV0dBWjN5bko0c0F4?=
 =?utf-8?B?WEJqeHpjWFJocXNHWXJKMnlQaE1xUURjR1R6MC9kWW42aUtSQTVoNCtMMnFV?=
 =?utf-8?B?TGxIRStWZDhCZDNrSXdaVzlDempUZHZ4WEZEVHB4aVpnT3Arb0l0eXdFQlhy?=
 =?utf-8?B?cXNOT2FyTWVrZHFteFlpbzcvdHFNMnRTMkRxb2U3eWNjMkZlV0JCeUdGSm4y?=
 =?utf-8?B?dkVzazk4SmM1R0dtRE1KdklWS1dYQ2ZWQU5nM3owc3lOeFVXT1ZPanA4WmFN?=
 =?utf-8?B?eFdhSnFCNjlYZ0phSXpnSzNJbDVLdW4zWDN6RUhTZnBmbzVudlUvakI3SGEw?=
 =?utf-8?B?OStpNXhXaEFlcnd5bm1Cc214cmhoNzVKeCtYc2VTTkJCMVl5aGYrK0V6eGdj?=
 =?utf-8?Q?kRZAgLEmUo2Cf7HqUyVo62mKn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ccbd9a-904c-4ef1-d3b4-08dd833aebe7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 14:18:44.8553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nc51ib1ZJw5eKq9aL7E20r4mODkVMn4T/DMi7Zv78SJPBCZ2+ozxlXOdwc7qYd8QlyMriAwL2e13ejqvHDNHKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242

On 4/24/25 02:22, Ard Biesheuvel wrote:
> On Tue, 22 Apr 2025 at 18:40, Ard Biesheuvel <ardb@google.com> wrote:
>>
>> On Tue, Apr 22, 2025 at 5:51 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>
>>> On 4/22/25 05:07, Ard Biesheuvel wrote:
>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>
>>>
>>> Hi Ard,
>>>
>>> I'll try to get to reviewing and testing this series very soon.
>>
>> Thanks.
>>
>>> But one
>>> thing I can see is that we never set the snp_vmpl level anymore in the
>>> EFI stub and so PVALIDATE will fail when running under an SVSM.
>>>
>>> But I don't think this series is completely at fault. This goes back to
>>> fixing memory acceptance before sev_enable() was called and I missed the
>>> SVSM situation. So I don't think we can completely remove all SNP
>>> initialization and might have to do svsm_setup_ca() which has a pre-req
>>> on setup_cpuid_table()...  sigh.
>>>
> 
> Why is that, though? The EFI stub never replaces the #VC and #PF
> handlers, and so cpuid instructions will be handled as before, right?
> And the SVSM setup code will run again when the core kernel boots and
> this time, it will need to update the cpuid tables to record the SVSM
> presence.

It's more of a statement about the CPUID table modifications made by
svsm_setup_ca() that need to be skipped if setup_cpuid_table() isn't
called, not the use of CPUID itself.

But taking a closer look, snp_cpuid_get_table() is actually returning
the address of cpuid_table_copy, which is a static in the file. So maybe
it isn't an issue because the loop at the end of svsm_setup_ca() will
not crash, which was the main concern.

I think we can use CPUID 0x8000001f_EAX[28] to detect an SVSM and read
MSR 0xc001f000 to get the CAA. OVMF has that support, just would need to
figure out where to check for it, then we can probably skip the
svsm_setup_ca() and do everything in the snp_accept_memory() path.

Let me take a look...

Thanks,
Tom

