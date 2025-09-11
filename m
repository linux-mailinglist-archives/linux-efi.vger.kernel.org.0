Return-Path: <linux-efi+bounces-4739-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A591B53DCB
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 23:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A86016C8AB
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F418E27A91F;
	Thu, 11 Sep 2025 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xdo15rLc"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1D23A9AE;
	Thu, 11 Sep 2025 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626533; cv=fail; b=mkAvhhZJBnRwOa58Wve+uH1MWp41Y5z3ohm3sE23eMrEJt4VDp0qEopXCdxHnrqM42KJvtdt9J1cfmwxTUmYWpeZytqSGnU9CvqFe8s/IVbpxHpcjTvfUcSxo+eUlU8B2KYKTLUd1OE0TxslIUF/IYQEraHW7WWpemIErEjCeBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626533; c=relaxed/simple;
	bh=w1KgsLKbXKQgFTAVwCKQcjMnxQkmGmOd1DDczSXJphg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ThJxfmShPntk0cpBE9q/+5WA180sEIiIcy36fqCWBAWQ0yHQBmj/BPTsgxGZr0wmRkL4lmqTBffsORAfUOHuF8IBYHc7Z7QcKnxMIKhmvqbSqBsYqBTVsqCtEXHjUgWkrADj1c3eab0hJunRhYn8w0rWLPywr5hkw40G2BL2I3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xdo15rLc; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVVTe3JdatDzj86EGGoqP/OoeMg8wLxHJcaMtSKiEKEOGkeNnRyXD1djUq2EWPZKXpYwBLXxtSdSUBQ1xqhqzY89ELlmb7oLOqEOd+5Qax2M2fEaVkJ4c2Fss2upKuwBPnBTN1+n+YozDJKwpHL3nX152CA2VMSQ4MySwe7rGSe3DW67bqiXBT9Y+5ISe48rGX3x7TcMGxCzYv4rQxd9dlF4Y0qu5Qg5vq3zigdvxZxeRPhuyl/3BejJQNYR+OncQjmrgVYDXnrOqLQa6lIx/WMGOm9g+M2TStykxQGdWdWPJGeYFSh9pFpR5Jvc2XaaKqCSPcwubG0b8DVSVHsgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfsqE8zALV6woIS7h4Qzk9PLbEg4ljiKaD2MFjW7NUs=;
 b=PO56SI/qLWfiI3JzHoAZbI2vWdwyxfULCXjFVcSTDRpwKhpWC4M9MKvEoGEt0AiGXFNrj291e8lVLQFHV+K7VvqhpBFXNrvggPydw7ks9pD54l80fK6YKFYNw8+9+UjaPTtzxMvpq01cg77fi6WNzjh59CdsBCrPa8U8N/Dda0AAcEkbliFxPxp2Lf1nCJ1zz4AMhfLzul8S6j40SNQlv2u7WaArET2dSFN8BSIolQ7/fEWz9jBTycre5uyf/KwXfmEMnyeQBed8jBvAsq5fP3l0JWxeR+j/tqIIktsRMU0p3u1VpF3smayAAe9uylkylTZ2Bvgue8zdGnTUoOne2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfsqE8zALV6woIS7h4Qzk9PLbEg4ljiKaD2MFjW7NUs=;
 b=Xdo15rLcQXg1W8K8KOPYb+CTJg3A+vPRcTgG2sjArIXjwqmyNBZ8Vf+8aMdnPqMuIYy4785vsXtwRKRSOqndMMN9r/JASqQ80jqArO2fQrW2a8TkiAkqwhIPTdqxdcRBMXHOkIp/waaqIWxIPbGmp+4ijafEKLMjVf5nMG8Bofg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 21:35:30 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 21:35:30 +0000
Message-ID: <2c500636-ba5a-4266-8be2-a13529aa7704@amd.com>
Date: Thu, 11 Sep 2025 16:35:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] x86/boot: Drop unused sev_enable() fallback
To: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
References: <20250909080631.2867579-5-ardb+git@google.com>
 <20250909080631.2867579-6-ardb+git@google.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20250909080631.2867579-6-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::17) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b0a48d-44b8-4856-5c92-08ddf17b219c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkFoaUdIdm9rOHVMTlVQZkplV0dhV3BaVytFWXlSMEtuMlNoS095QWp1V2dp?=
 =?utf-8?B?ZnozNmlKNU5KYUdrblMzNXBFUlh4bzMyRHFRb2R6WVM1VWphTDJWNzhBUkpF?=
 =?utf-8?B?UVZBYXZhYkVMNjU4M1dCSHNpWGRyOWpOYlJ6YUtTMFgwSk52S3plRWRVNWU2?=
 =?utf-8?B?MEMzbW4xeUlVakVvblFrbHcwWHlRSjVYNlk4NDcwU2dtWlI3UUNKZklncmJu?=
 =?utf-8?B?VTlmellYclJvU0owQWp6azhycGJBV0RDNnQrY0ZIcUlBK2Uzcm4wVGF0aCtq?=
 =?utf-8?B?OWlmWTdSVHV3VFJGWUxkNEQ4MjR4S0E0aWhGZmhzM2poY3ZGTEF5Y28ySFpq?=
 =?utf-8?B?Z0tJNkx3dFJxcHNtUnRiNEtWTlJCTVRhWWtqM3p6S3I2NlRhdFl6bkJ6cHhs?=
 =?utf-8?B?dUVja0JIQ3hUeVA1T3o0UlJ3V05XTDEzK21UM2dWTDVxWUlNR3ZRQW5PVzFq?=
 =?utf-8?B?TDNXbTdxdkM4NXB4Ni9PTEI1OVJibmVmRVFEa0R2VjJqRmlRNnpLbUR5cWc5?=
 =?utf-8?B?YW9OUGg4aVhIY3o4YVpBYWxHYUhuWFRkMkFiZ3VkbDBOZkI4TEcyb3VQbGNp?=
 =?utf-8?B?L0VzallBTnhqTXU2RDNZUXVVb0JNQ09xVXJONU5BQlZ0MXlibDNhcVNRbXhq?=
 =?utf-8?B?QkVFanM3QXoreGFCR0NESnNTa29LcVZOTTI3dDZFUjBsb0dVQXlTVXgzN3lL?=
 =?utf-8?B?bzdsaHgzeFBjaE9MKzJWdXFpMmZOWlhJb25FckJiZkRjOWlESno4elFHRmpR?=
 =?utf-8?B?dEp4c2JMVTIrbDlwN3ZNbkY5MXpLL0c5TGp5Und1RzFZY0ZMMzFJdWRlbFov?=
 =?utf-8?B?SE5UcEFYN1FTZW1sVXFQY0x6U3R0emxUMW9nWU5MUE9YN0FiaDh3cjg5OXdO?=
 =?utf-8?B?Z2s3R3BHUmI4WXdsWVN5QzBPNktOQk0yaWlDYmtia05ZWlZNZHhOZUF1VlFV?=
 =?utf-8?B?bVhxOGpwayt5Sy9kK2Y3RmF2TGxuazJvdG1BZnM2QVhocC90V2V6U2dEVWJZ?=
 =?utf-8?B?VHRMUGZLK1lnQ3MxRHBCS0kxY2xHcXRLM2tSU1FlczJTbzZmVkhnWk1EaWZi?=
 =?utf-8?B?a0N6Q0g2RVpVajlVZSsyYzBXaVhxam1oRGNMc2hXc3B0UmszdkhFSTlqSisx?=
 =?utf-8?B?d2xxcUIreW54UzU2NlpmeFVhK3M1ci9vYTJBRWx4OUpTUzQvWm9wQ3NnL2th?=
 =?utf-8?B?emRIYmxUWU95dm1aOUt0NmZzNHF3NDh5UUpnZ0tOY1IrVVFXWkVPRVdSSmdJ?=
 =?utf-8?B?aWRjL2NDTXg0WnJlMS8vYkNlY2tiNkxVcGZxMVlIL2I3aWRCaVhIU2lnbHc0?=
 =?utf-8?B?RU9oQVZGcWd4ZVA2bEc5dy9BMlk1QlB0dk9yNmZwbVpGL3hRTm13RUZFOE11?=
 =?utf-8?B?OGxGbVJSS1gyeE9yZ0o3KzljN1U4Yi9GSUNKbnVWRlhabDVNWDlJQmN1TGJC?=
 =?utf-8?B?aUhJamdjOXJvWjh5OUZXTFdFWXZrQUM0bnhEKys1WGZrNmRadjd5UDB2Z0JL?=
 =?utf-8?B?TVlUZVZrNTZPR216NEdSNUpjVFZsZDlncGhOYiszbEVoa1dPOWdjWVNTb1Y5?=
 =?utf-8?B?NUtHUW5TM1p0RHhrVW92aXAvbXB3UWFaRU5Gc3ZoVG5tdlFoelZZNUQwdkVC?=
 =?utf-8?B?WEJ4aExmNG04U25yYnZYMVhuY0lEcUJpQyswVS92ZkNFdVZjZkluK1F5TG1Y?=
 =?utf-8?B?M09XaXZyWVdXOTBiOWxSdFppeC9Qd1BIV2tBOG9VUkd2NElhc2pwcmFZOUx3?=
 =?utf-8?B?YS9xb3pyeloyakRpVGh1S1JIWGhRL3Rhd3lCVVIrWGplUnAzT2d2MW9TallY?=
 =?utf-8?B?dUVQL3YxYlFqK1dBSjVUNVcxbGhSUHA4Q25CZFBRd2hiVHYyUTJxUWc2RU95?=
 =?utf-8?B?T01pQkxaSHRQRnQwQWZPWXV0d0ZIKzI1QmxGZlRDcFBLK1Y5MUdnekttRXVZ?=
 =?utf-8?Q?7HRI7ZgNOtQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXA5STlaVi95US9XTkdmUzBHc1g2N3Y1dDdrcXRmWTd6Sks3U0pQZnJ6cXNF?=
 =?utf-8?B?QTMzejFPeGVsblUxK0NsM1RsN3lxVlduSzNoMm5BbFdMejVnUmtVYTZMbEZD?=
 =?utf-8?B?SlRCdURVS1BsbVU3MThoY3pIc1prd3Q5K2J5MFlma1J1anN5cFJEY3Zxakxz?=
 =?utf-8?B?ZHdCMW95dlZhLzdvbDFEdG1ydjVQMnJ4Um9oN3FQY0JGTk83eHJENjFySEp0?=
 =?utf-8?B?NzExd084YU1ycTIwTUNpWEdQQm9NdTVzM29LTk16ZkRkS1hyK3haaWJBS0RY?=
 =?utf-8?B?ektSZDZoMEc4aDJvNUxURmdsNlUzWUgvRHdyUUxCbFdBK3RXMm9Fa3RCUUdG?=
 =?utf-8?B?ZkViaHk5OWNUdGV6dGxGK2N2V1RJcVhvUFo4V0h2TmdsMlA2eHl5Y3cxQnFT?=
 =?utf-8?B?NkFIZlpVckNmRFVvRVlPb2lENjN4WVFYQko3aTMzcmZYT1pJc2xRZ3A2dTVH?=
 =?utf-8?B?OGgzUStDZUhGODBUNmUrL2did1RDdStkZzRiVlBDNjNsZk5HbnBZVVhuYTFF?=
 =?utf-8?B?VjFOZ2pFc3laeURTVkJ2QTl0eFQzZUlmVERubkNjbDhwdm0vNjhWdnBLY1NP?=
 =?utf-8?B?MHNOWFdGZklBRGxOZ0J2QjZWOUtoL2tqM2hYUGowUjVKVm9PQ0JMTFVmNm84?=
 =?utf-8?B?Sk1IcHR5d3Jtb1RKQlhYMVpwUkN6SlcwazhQdFZBdndyekxaSGVUaXRpMlEr?=
 =?utf-8?B?bGJDcXArUzY1NWNTZWczSllYWjdIOG1BajdldytIS0RvMkFWK0JaS2ljME9Z?=
 =?utf-8?B?dDBtZWh6WWxmK0hQT25oTUJ0bllYNWEyaFNSbUFXa2JnbWlGR0t2T3Q2c2Ez?=
 =?utf-8?B?Tm00R2tXemZpZHk2T1ZQT0w0SjNMa3F1ak0xSkVvdU5Gdm9JQUI5R2FvQW9R?=
 =?utf-8?B?aWNWb0ZMRGUwSC9OTHord0pQZkF5bW10eml6RXFJOGM0V01sT05XanEzN3Iy?=
 =?utf-8?B?Mm1maU5mSTZNK1grQTRxMXFPS0xjVVBlVWYwdGY5cTUyR3VkV1pxUVNVbnIx?=
 =?utf-8?B?eDBEbTdnZ3JMalNRVElvYkZhbW5mTS9Hem9VWjRNcmpoakxneDBhTURKZE9X?=
 =?utf-8?B?RUVSVmlUNFk5K2dnVllYNmJNOVVwblNhWEVvcTVZRnkrNHoyZ2JKNTVvWWdx?=
 =?utf-8?B?RDFFZysxVlR3a2U5eWRXeUlLUTVBcmpnVUpwZDZWYStSdWVtOXA1S0NRdjVP?=
 =?utf-8?B?Tm9Cc0xnQytMTlZNR25xdkVqQ0F5N0NDRzh1ODh3amtkZGNBUlJLQmJ6K2g1?=
 =?utf-8?B?cjVxQllGcGZoNGI5a1lVRS9ZZ1NxeXNva0pkeGxIQmR0ZVp0am9WdjM2K1Vr?=
 =?utf-8?B?VHZaUnllNlplZ3lrUisrVFQwWlNjcTlPKzRZd0d0TmdvelJETjNId1FoQ0hz?=
 =?utf-8?B?eHd0dUkrVnB4clFuMTI4K1RGam9TZkFId1FCR1NvNXFDZVcydG9tK3YrSk1M?=
 =?utf-8?B?MktEbnV5dHJjL25GSkZvUmIwRkRUSm1aZnc4VzFvakRFenpWUEYwcTIwQys4?=
 =?utf-8?B?M091MHBwYXA1dU92MlkwcnVDUU8zUjdzbDR4c3U2YldjYyt1bnhNbnRiazZX?=
 =?utf-8?B?d0Zhc0lmZ1luVmRhbjI0T25FNDJ3SEpTMGdLaEVFdUZmSjRJNTd4MlFlanZL?=
 =?utf-8?B?WmFGMFpya1RmSWtlMklYMk5sQlpWQXpWRXNSa2U0cko2RTErMTdXQW5kRDZv?=
 =?utf-8?B?YlFYdFlwMXhPcHVvRWZtRFdYdHNLeEc3Z2JxbXN4emx0L0MyNmVoaEpRc3Fu?=
 =?utf-8?B?ZGk5bkhwVjZCY2RLMzU2RGc0MFVPWVZMZlVzamxQTGVjS1NHT3liUHFkVjFp?=
 =?utf-8?B?QUVNZ2VUNi9nN09UbEZyUlhOUlpvL3VldDU0NytESVIzMlQ4QXFTM2x6bU9X?=
 =?utf-8?B?SjIvR2UxSS9aeUFhTEtaSHRoWVpnVDV4V0YyOFdYdFgrNE43U3llSFV5MDJq?=
 =?utf-8?B?MU5jVU5YN2U4VFJ3M1k2YkFqaHRweDMvSkhFZElzTXZNeC9oQVNRTERjbzRW?=
 =?utf-8?B?R2tCN0NXa3hGOU9BM0ZEcHBnZTk2d2p2dWpoYi93SHdiLzFPbHpqRzdVVjg4?=
 =?utf-8?B?KzVueDJXL3lhWVYxcTdaMFBHN0FST3NLTzhEcUpyKzcyMTNWSmJ6eFloSndZ?=
 =?utf-8?Q?GzM6cMvUJIIiKSoMazVLQWAg+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b0a48d-44b8-4856-5c92-08ddf17b219c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 21:35:30.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCMov1/g5GXpm4ghfrJu7TnKiN5A5X0rNqLcIBQF2PcPz292LOzXtASmGR914X8w1AeHj2Kqne5CrIeByKYYiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428

On 9/9/25 03:06, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The misc.h header is not included by the EFI stub, which is the only C
> caller of sev_enable(). This means the fallback for cases where
> CONFIG_AMD_MEM_ENCRYPT is not set is never used, so it can be dropped.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/boot/compressed/misc.h | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index db1048621ea2..fd855e32c9b9 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -152,17 +152,6 @@ bool insn_has_rep_prefix(struct insn *insn);
>  void sev_insn_decode_init(void);
>  bool early_setup_ghcb(void);
>  #else
> -static inline void sev_enable(struct boot_params *bp)
> -{
> -	/*
> -	 * bp->cc_blob_address should only be set by boot/compressed kernel.
> -	 * Initialize it to 0 unconditionally (thus here in this stub too) to
> -	 * ensure that uninitialized values from buggy bootloaders aren't
> -	 * propagated.
> -	 */
> -	if (bp)
> -		bp->cc_blob_address = 0;
> -}
>  static inline void snp_check_features(void) { }
>  static inline void sev_es_shutdown_ghcb(void) { }
>  static inline bool sev_es_check_ghcb_fault(unsigned long address)


